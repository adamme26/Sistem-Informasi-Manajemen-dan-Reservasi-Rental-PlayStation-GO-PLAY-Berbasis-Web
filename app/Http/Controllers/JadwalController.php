<?php

namespace App\Http\Controllers;

use App\Models\Console;
use App\Models\Booking;
use Carbon\Carbon;
use Illuminate\Http\Request;

class JadwalController extends Controller
{
    public function index(Request $request)
    {
        $date = $request->get('date', Carbon::today()->format('Y-m-d'));

        $consoles = Console::orderBy('name')->get();

        $bookings = Booking::with('user', 'console')
            ->whereDate('booking_date', $date)
            ->whereIn('status', ['confirmed', 'pending', 'completed'])
            ->get();

        return view('jadwal.index', compact('consoles', 'bookings', 'date'));
    }
}
