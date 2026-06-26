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

        return view('admin.bookings.index', compact('bookings'));
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

        return back()->with('success', 'Pembayaran berhasil diverifikasi. Pesanan dikonfirmasi.');
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
}
