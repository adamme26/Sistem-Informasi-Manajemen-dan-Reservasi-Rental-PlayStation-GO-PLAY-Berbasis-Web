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
            $console->activeBooking = Booking::where('console_id', $console->id)
                ->whereDate('booking_date', $today)
                ->where('start_time', '<=', $now)
                ->where('end_time', '>', $now)
                ->whereIn('status', ['pending', 'confirmed'])
                ->first();
        }

        $stats = [
            'total_consoles' => Console::count(),
            'total_bookings' => Booking::whereIn('status', ['confirmed', 'completed'])->count(),
        ];

        return view('welcome', compact('consoles', 'stats'));
    }
}
