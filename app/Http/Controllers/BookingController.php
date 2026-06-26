<?php

namespace App\Http\Controllers;

use App\Models\Booking;
use App\Models\Console;
use App\Models\Payment;
use App\Notifications\BookingCreatedNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class BookingController extends Controller
{
    public function bookingIndex(Request $request)
    {
        $consoles = Console::all()->sortBy(function ($c) {
            $name = strtoupper($c->name);
            $order = [
                'PS4 REGULER 1' => 1,  'PS4 REGULER 2' => 2,  'PS4 REGULER 3' => 3,
                'PS5 REGULER 1' => 4,  'PS5 REGULER 2' => 5,  'PS5 REGULER 3' => 6,
                'PS4 ROOM 1'    => 7,  'PS4 ROOM 2'    => 8,  'PS4 ROOM 3'    => 9,
                'PS5 ROOM 1'    => 10, 'PS5 ROOM 2'    => 11, 'PS5 ROOM 3'    => 12,
                'PS5 VIP ROOM 1'=> 13, 'PS5 VIP ROOM 2'=> 14, 'PS5 VIP ROOM 3'=> 15,
            ];
            return $order[$name] ?? 99;
        })->values();

        $defaultConsole = null;
        $defaultTime = null;

        if ($request->has('console_id')) {
            $defaultConsole = $consoles->firstWhere('id', $request->query('console_id'));
            $defaultTime = now()->addHour()->format('H:00:00');
        } elseif ($request->has('type')) {
            $type = strtoupper($request->query('type')); // PS4 or PS5
            // Filter by type
            $filteredConsoles = $consoles->filter(fn($c) => $c->type === $type);
            
            if ($filteredConsoles->isNotEmpty()) {
                // Find first available right now
                $now = now()->format('H:i:s');
                $today = now()->format('Y-m-d');
                
                $availableConsole = $filteredConsoles->first(function ($c) use ($today, $now) {
                    $hasActiveBooking = Booking::where('console_id', $c->id)
                        ->whereDate('booking_date', $today)
                        ->where('start_time', '<=', $now)
                        ->where('end_time', '>', $now)
                        ->whereIn('status', ['pending', 'confirmed'])
                        ->exists();
                    return !$hasActiveBooking;
                });
                
                // If all are booked, fallback to the first one in the type
                $defaultConsole = $availableConsole ?? $filteredConsoles->first();
            }
        }

        $allBookings = Booking::whereIn('status', ['pending', 'confirmed'])
            ->whereDate('booking_date', '>=', today())
            ->get(['console_id', 'booking_date', 'start_time', 'end_time', 'status']);

        return view('bookings.create', compact('consoles', 'defaultConsole', 'defaultTime', 'allBookings'));
    }

    /**
     * AJAX: Return list of booked console_ids for a given date + start_time.
     * Used by booking page to update unit grid in real-time.
     */
    public function availability(Request $request)
    {
        $request->validate([
            'date'       => 'required|date',
            'start_time' => 'required', // e.g. '14:00:00'
        ]);

        $date      = $request->date;
        $startTime = $request->start_time; // e.g. '14:00:00'

        // Find ALL console_ids that have a booking overlapping the given start_time
        // A console is "busy" at start_time if: start_time >= booking.start AND start_time < booking.end
        $busyConsoleIds = Booking::whereDate('booking_date', $date)
            ->whereIn('status', ['pending', 'confirmed'])
            ->where('start_time', '<=', $startTime)
            ->where('end_time',   '>',  $startTime)
            ->pluck('console_id')
            ->unique()
            ->values()
            ->toArray();

        return response()->json(['busy' => $busyConsoleIds]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'console_id'     => 'required|exists:consoles,id',
            'booking_date'   => 'required|date|after_or_equal:today',
            'start_time'     => 'required',
            'duration'       => 'required|integer|min:1|max:12',
            'payment_method' => 'required|in:Bank BCA,GoPay,QRIS',
        ], [
            'console_id.required'     => 'Silakan pilih unit PlayStation.',
            'booking_date.required'   => 'Silakan pilih tanggal.',
            'start_time.required'     => 'Silakan pilih waktu mulai.',
            'duration.required'       => 'Silakan pilih durasi bermain.',
            'payment_method.required' => 'Silakan pilih metode pembayaran.',
            'payment_method.in'       => 'Metode pembayaran tidak valid.',
        ]);

        $console  = Console::findOrFail($validated['console_id']);
        $duration = (int) $validated['duration'];

        // Parse start time — support both H:i and H:i:s
        try {
            $startTime = Carbon::createFromFormat('H:i:s', $validated['start_time']);
        } catch (\Exception $e) {
            $startTime = Carbon::createFromFormat('H:i', substr($validated['start_time'], 0, 5));
        }
        $endTime    = $startTime->copy()->addHours($duration);
        $totalPrice = $console->price_per_hour * $duration;

        // Check for booking conflicts:
        // Conflict if ANY existing booking for same console+date overlaps the requested window
        // Overlap condition: existing.start < new.end AND existing.end > new.start
        $startStr = $startTime->format('H:i:s');
        $endStr   = $endTime->format('H:i:s');

        $conflict = Booking::where('console_id', $console->id)
            ->whereDate('booking_date', $validated['booking_date'])
            ->whereIn('status', ['pending', 'confirmed'])
            ->where('start_time', '<', $endStr)
            ->where('end_time',   '>', $startStr)
            ->exists();

        if ($conflict) {
            return back()
                ->withErrors(['start_time' => 'Slot waktu ini sudah terpesan. Pilih waktu atau unit lain.'])
                ->withInput();
        }

        $booking = null;
        DB::transaction(function () use ($validated, $console, $startTime, $endTime, $totalPrice, $duration, $request, &$booking) {
            $booking = Booking::create([
                'booking_code'   => Booking::generateCode(),
                'user_id'        => auth()->id(),
                'console_id'     => $console->id,
                'booking_date'   => $validated['booking_date'],
                'start_time'     => $startTime->format('H:i:s'),
                'duration_hours' => $duration,
                'end_time'       => $endTime->format('H:i:s'),
                'total_price'    => $totalPrice,
                'status'         => 'pending',
                'notes'          => $request->notes ?? null,
            ]);

            Payment::create([
                'booking_id'     => $booking->id,
                'amount'         => $totalPrice,
                'bank_name'      => $validated['payment_method'],
                'account_number' => config('app.bank_account_number', '1234567890'),
                'account_name'   => config('app.bank_account_name', 'GOPLAY Game Rental'),
                'status'         => 'unpaid',
            ]);
        });

        // Send notification (silently fail if config not set)
        try {
            auth()->user()->notify(new BookingCreatedNotification($booking));
        } catch (\Exception $e) {
            // Log but don't fail
        }

        return redirect()->route('bookings.show', $booking)
            ->with('success', 'Pesanan berhasil dibuat! Silakan lakukan pembayaran.');
    }

    public function show(Booking $booking)
    {
        abort_if($booking->user_id !== auth()->id(), 403);
        $booking->load(['console', 'payment']);

        return view('bookings.show', compact('booking'));
    }

    public function uploadProof(Request $request, Booking $booking)
    {
        abort_if($booking->user_id !== auth()->id(), 403);

        $request->validate([
            'transfer_proof' => 'required|image|max:2048',
        ]);

        $path = $request->file('transfer_proof')->store('proofs', 'public');

        $booking->payment()->update([
            'transfer_proof' => $path,
            'status'         => 'uploaded',
        ]);

        return back()->with('success', 'Bukti transfer berhasil diupload. Menunggu verifikasi admin.');
    }

    public function cancel(Booking $booking)
    {
        abort_if($booking->user_id !== auth()->id(), 403);
        abort_if(!in_array($booking->status, ['pending']), 403, 'Pesanan yang sudah dikonfirmasi tidak dapat dibatalkan.');

        $booking->update(['status' => 'cancelled']);

        return back()->with('success', 'Pesanan berhasil dibatalkan.');
    }

    public function notifyHalfHour(Booking $booking)
    {
        abort_if($booking->user_id !== auth()->id(), 403);

        // We use a simple cache to avoid spamming the notification if JS fires multiple times
        $cacheKey = 'notified_30m_' . $booking->id;
        if (!\Illuminate\Support\Facades\Cache::has($cacheKey)) {
            $booking->user->notify(new \App\Notifications\SimpleMessageNotification(
                'Sisa Waktu 30 Menit',
                'Waktu sewa Anda untuk ' . $booking->console->name . ' tersisa kurang lebih 30 menit lagi!',
                route('bookings.show', $booking)
            ));
            \Illuminate\Support\Facades\Cache::put($cacheKey, true, now()->addHours(2));
            return response()->json(['success' => true]);
        }
        return response()->json(['success' => false, 'message' => 'Already notified']);
    }

    public function dashboard()
    {
        $bookings = Booking::where('user_id', auth()->id())
            ->with(['console', 'payment'])
            ->latest()
            ->paginate(10);

        return view('dashboard', compact('bookings'));
    }

    public function markNotificationsRead()
    {
        auth()->user()->unreadNotifications->markAsRead();
        return back();
    }
}
