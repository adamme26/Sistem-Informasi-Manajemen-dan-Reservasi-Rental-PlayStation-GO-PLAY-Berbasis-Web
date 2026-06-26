<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Notifications\BookingStatusNotification;
use App\Services\WhatsAppService;
use Illuminate\Http\Request;

class BookingAdminController extends Controller
{
    public function index(Request $request)
    {
        $query = Booking::with(['user', 'console', 'payment'])->latest();

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }
        if ($request->filled('date')) {
            $query->whereDate('booking_date', $request->date);
        }
        if ($request->filled('search')) {
            $query->whereHas('user', fn($q) => $q->where('name', 'like', '%' . $request->search . '%'))
                  ->orWhere('booking_code', 'like', '%' . $request->search . '%');
        }

        $bookings = $query->paginate(15);
        $consoles = \App\Models\Console::all();

        return view('admin.bookings.index', compact('bookings', 'consoles'));
    }

    public function show(Booking $booking)
    {
        $booking->load(['user', 'console', 'payment']);
        return view('admin.bookings.show', compact('booking'));
    }

    public function updateStatus(Request $request, Booking $booking)
    {
        $request->validate(['status' => 'required|in:pending,confirmed,cancelled,completed']);

        $booking->update(['status' => $request->status]);

        // Send notification
        try {
            $booking->user->notify(new BookingStatusNotification($booking));
            // WhatsApp notification
            if ($booking->user->phone) {
                WhatsAppService::send(
                    $booking->user->phone,
                    $this->buildWhatsappMessage($booking)
                );
            }
        } catch (\Exception $e) {
            // silent fail
        }

        return back()->with('success', 'Status pesanan berhasil diperbarui.');
    }

    public function verifyPayment(Request $request, Booking $booking)
    {
        $booking->payment()->update([
            'status'      => 'verified',
            'verified_at' => now(),
        ]);

        $booking->update(['status' => 'confirmed']);

        // Send notification
        try {
            $booking->user->notify(new BookingStatusNotification($booking));
            // WhatsApp notification
            if ($booking->user->phone) {
                WhatsAppService::send(
                    $booking->user->phone,
                    $this->buildWhatsappMessage($booking)
                );
            }
        } catch (\Exception $e) {
            // silent fail
        }

        return back()->with('success', 'Pembayaran berhasil diverifikasi. Pesanan dikonfirmasi.');
    }

    public function startPlaying(Booking $booking)
    {
        if ($booking->status !== 'confirmed') {
            return back()->with('error', 'Hanya pesanan yang dikonfirmasi yang bisa dimulai.');
        }

        if ($booking->started_at) {
            return back()->with('error', 'Sesi ini sudah dimulai.');
        }

        $booking->update(['started_at' => now()]);

        // Kirim Notifikasi bahwa sesi sudah dimulai ke lonceng Member
        try {
            $booking->user->notify(new \App\Notifications\SimpleMessageNotification(
                'Sesi Bermain Dimulai',
                'Sesi bermain Anda untuk konsol ' . $booking->console->name . ' baru saja dimulai. Selamat bermain!',
                route('bookings.show', $booking)
            ));
        } catch (\Exception $e) {
            // silent fail
        }

        return back()->with('success', 'Sesi bermain dimulai! Waktu hitung mundur berjalan.');
    }

    public function schedule()
    {
        $events = Booking::with(['console', 'user'])
            ->whereIn('status', ['pending', 'confirmed'])
            ->where('booking_date', '>=', now()->toDateString())
            ->get()
            ->map(function ($b) {
                return [
                    'id'              => $b->id,
                    'title'           => $b->console->name . ' - ' . $b->user->name,
                    'start'           => $b->booking_date->format('Y-m-d') . 'T' . $b->start_time,
                    'end'             => $b->booking_date->format('Y-m-d') . 'T' . $b->end_time,
                    'backgroundColor' => $b->status === 'confirmed' ? '#7C3AED' : '#f59e0b',
                    'borderColor'     => 'transparent',
                    'extendedProps'   => [
                        'booking_code' => $b->booking_code,
                        'status'       => $b->status,
                    ],
                ];
            });

        return view('admin.schedule', compact('events'));
    }

    private function buildWhatsappMessage(Booking $booking): string
    {
        $status = match ($booking->status) {
            'confirmed'  => '✅ *DIKONFIRMASI*',
            'cancelled'  => '❌ *DIBATALKAN*',
            'completed'  => '🎮 *SELESAI*',
            default      => '⏳ *PENDING*',
        };

        return "🎮 *GOPLAY - Update Pesanan*\n\n"
             . "Halo, *{$booking->user->name}*!\n"
             . "Status pesanan Anda: {$status}\n\n"
             . "📋 Kode: *{$booking->booking_code}*\n"
             . "🕹️ Konsol: {$booking->console->name}\n"
             . "📅 Tanggal: " . $booking->booking_date->format('d M Y') . "\n"
             . "⏰ Waktu: {$booking->start_time} - {$booking->end_time}\n"
             . "💰 Total: Rp " . number_format($booking->total_price, 0, ',', '.') . "\n\n"
             . "Terima kasih telah menggunakan GOPLAY! 🕹️";
    }

    public function walkInBooking(Request $request)
    {
        $request->validate([
            'console_id' => 'required|exists:consoles,id',
            'duration' => 'required|integer|min:1'
        ]);

        $console = \App\Models\Console::findOrFail($request->console_id);
        
        // Find or create dummy Walk-in User
        $walkInUser = \App\Models\User::firstOrCreate(
            ['email' => 'walkin@goplay.local'],
            [
                'name' => 'Walk-in Customer',
                'password' => bcrypt('password123'),
                'phone' => '000000000000'
            ]
        );

        $now = now();
        $endTime = $now->copy()->addHours((int) $request->duration);
        $totalPrice = $console->price_per_hour * (int) $request->duration;

        // Cek Double Booking
        $conflict = \App\Models\Booking::where('console_id', $console->id)
            ->whereDate('booking_date', $now->toDateString())
            ->whereIn('status', ['pending', 'confirmed'])
            ->where(function ($q) use ($now, $endTime) {
                $q->whereBetween('start_time', [$now->format('H:i:s'), $endTime->format('H:i:s')])
                  ->orWhereBetween('end_time', [$now->format('H:i:s'), $endTime->format('H:i:s')])
                  ->orWhere(function ($q2) use ($now, $endTime) {
                      $q2->where('start_time', '<=', $now->format('H:i:s'))
                         ->where('end_time', '>=', $endTime->format('H:i:s'));
                  });
            })
            ->exists();

        if ($conflict) {
            return back()->with('error', 'Unit sudah dipesan pada rentang waktu tersebut. Silakan pilih durasi lain atau konsol lain.');
        }

        \Illuminate\Support\Facades\DB::transaction(function () use ($console, $walkInUser, $now, $endTime, $totalPrice, $request) {
            $booking = Booking::create([
                'booking_code' => Booking::generateCode(),
                'user_id' => $walkInUser->id,
                'console_id' => $console->id,
                'booking_date' => $now->toDateString(),
                'start_time' => $now->format('H:i:s'),
                'duration_hours' => $request->duration,
                'end_time' => $endTime->format('H:i:s'),
                'total_price' => $totalPrice,
                'status' => 'confirmed', // directly confirmed
                'started_at' => $now, // immediately start
                'notes' => 'Walk-in booking'
            ]);

            \App\Models\Payment::create([
                'booking_id' => $booking->id,
                'amount' => $totalPrice,
                'bank_name' => 'Cash',
                'account_number' => '-',
                'account_name' => 'Cashier',
                'status' => 'verified',
                'verified_at' => $now
            ]);
        });

        return back()->with('success', 'Sesi Walk-in berhasil dimulai!');
    }

    public function addDuration(Request $request, Booking $booking)
    {
        $request->validate(['extra_duration' => 'required|integer|min:1']);
        
        if (!in_array($booking->status, ['confirmed', 'playing'])) {
            return back()->with('error', 'Hanya sesi aktif yang bisa ditambah durasinya.');
        }

        $extraHours = $request->extra_duration;
        $extraPrice = $booking->console->price_per_hour * $extraHours;

        $currentEndTime = \Carbon\Carbon::parse($booking->end_time);
        $newEndTime = $currentEndTime->copy()->addHours($extraHours);

        // Cek Double Booking untuk tambahan durasi
        $conflict = \App\Models\Booking::where('console_id', $booking->console_id)
            ->where('id', '!=', $booking->id)
            ->whereDate('booking_date', $booking->booking_date->toDateString())
            ->whereIn('status', ['pending', 'confirmed'])
            ->where(function ($q) use ($currentEndTime, $newEndTime) {
                $q->whereBetween('start_time', [$currentEndTime->format('H:i:s'), $newEndTime->format('H:i:s')])
                  ->orWhereBetween('end_time', [$currentEndTime->format('H:i:s'), $newEndTime->format('H:i:s')])
                  ->orWhere(function ($q2) use ($currentEndTime, $newEndTime) {
                      $q2->where('start_time', '<=', $currentEndTime->format('H:i:s'))
                         ->where('end_time', '>=', $newEndTime->format('H:i:s'));
                  });
            })
            ->exists();

        if ($conflict) {
            return back()->with('error', 'Unit sudah dipesan pada jam berikutnya. Tidak bisa menambah durasi.');
        }

        \Illuminate\Support\Facades\DB::transaction(function () use ($booking, $extraHours, $extraPrice, $newEndTime) {
            $booking->update([
                'duration_hours' => $booking->duration_hours + $extraHours,
                'end_time' => $newEndTime->format('H:i:s'),
                'total_price' => $booking->total_price + $extraPrice
            ]);

            if ($booking->payment) {
                $booking->payment->update([
                    'amount' => $booking->payment->amount + $extraPrice
                ]);
            }
        });

        return back()->with('success', 'Durasi berhasil ditambah!');
    }

    public function stopTimer(Booking $booking)
    {
        if ($booking->status === 'completed') {
            return back()->with('error', 'Sesi sudah selesai.');
        }

        $booking->update([
            'status' => 'completed',
            'end_time' => now()->format('H:i:s') // Set end time to actual finish time
        ]);

        return back()->with('success', 'Timer berhasil dihentikan. Sesi selesai.');
    }
}
