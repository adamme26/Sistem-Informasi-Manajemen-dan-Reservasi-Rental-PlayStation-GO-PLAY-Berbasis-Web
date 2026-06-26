<?php

namespace App\Http\Controllers;

use App\Models\Console;
use App\Models\Booking;
use Illuminate\Http\Request;

class ConsoleController extends Controller
{
    public function index(Request $request)
    {
        $query = Console::query();

        if ($request->filled('type')) {
            $query->where('type', $request->type);
        }

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        $consoles = $query->orderBy('type')->orderBy('name')->paginate(12);

        return view('consoles.index', compact('consoles'));
    }

    public function show(Console $console)
    {
        // Get bookings for FullCalendar - next 30 days
        $bookedSlots = Booking::where('console_id', $console->id)
            ->whereIn('status', ['pending', 'confirmed'])
            ->where('booking_date', '>=', now()->toDateString())
            ->where('booking_date', '<=', now()->addDays(30)->toDateString())
            ->get(['booking_date', 'start_time', 'end_time', 'status'])
            ->map(function ($b) {
                return [
                    'title'           => 'Booked',
                    'start'           => $b->booking_date->format('Y-m-d') . 'T' . $b->start_time,
                    'end'             => $b->booking_date->format('Y-m-d') . 'T' . $b->end_time,
                    'backgroundColor' => $b->status === 'confirmed' ? '#7C3AED' : '#f59e0b',
                    'borderColor'     => 'transparent',
                ];
            });

        return view('consoles.show', compact('console', 'bookedSlots'));
    }
}
