<?php

namespace App\Http\Controllers;

use App\Models\Console;
use App\Models\Booking;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function index()
    {
        $consoles = Console::orderBy('name')->get();
        $now = now()->format('H:i:s');
        $today = now()->format('Y-m-d');

        foreach ($consoles as $console) {
            // Get all relevant bookings for today to calculate true availability
            $todayBookings = Booking::where('console_id', $console->id)
                ->whereDate('booking_date', $today)
                ->where('end_time', '>', $now)
                ->whereIn('status', ['pending', 'confirmed'])
                ->orderBy('start_time')
                ->get();

            $activeBooking = null;
            $availableAt = null;

            if ($todayBookings->count() > 0) {
                // Find if any booking is currently happening or starting within the next hour
                $oneHourFromNow = now()->addHour()->format('H:i:s');
                $activeBooking = $todayBookings->first(function ($b) use ($oneHourFromNow, $now) {
                    return $b->start_time < $oneHourFromNow && $b->end_time > $now;
                });

                if ($activeBooking) {
                    // Traverse consecutive bookings to find the TRUE end time
                    $currentCheckEnd = $activeBooking->end_time;
                    foreach ($todayBookings as $b) {
                        // If there's another booking that starts EXACTLY when the current check ends
                        if ($b->start_time <= $currentCheckEnd && $b->end_time > $currentCheckEnd) {
                            $currentCheckEnd = $b->end_time;
                        }
                    }
                    $availableAt = $currentCheckEnd;
                }
            }

            $console->activeBooking = $activeBooking;
            $console->availableAt = $availableAt;
        }

        $stats = [
            'total_consoles' => Console::count(),
            'total_bookings' => Booking::whereIn('status', ['confirmed', 'completed'])->count(),
        ];

        return view('welcome', compact('consoles', 'stats'));
    }
}
