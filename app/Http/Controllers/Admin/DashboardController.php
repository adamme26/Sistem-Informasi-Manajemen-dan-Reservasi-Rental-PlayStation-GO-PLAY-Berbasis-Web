<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Console;
use App\Models\User;
use Illuminate\Http\Request;
use Carbon\Carbon;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        $period = $request->query('period', 'today'); // today, week, month, year
        $today = Carbon::today();
        
        $startDate = $today->copy();
        $labelSelesai = "Pesanan Hari Ini";
        $labelPendapatan = "Pendapatan Hari Ini";
        $chartLabel = "Pendapatan 7 Hari Terakhir";
        
        switch ($period) {
            case 'week':
                $startDate = $today->copy()->subDays(6);
                $labelSelesai = "Pesanan 7 Hari Terakhir";
                $labelPendapatan = "Pendapatan 7 Hari Terakhir";
                break;
            case 'month':
                $startDate = $today->copy()->subDays(29);
                $labelSelesai = "Pesanan 30 Hari Terakhir";
                $labelPendapatan = "Pendapatan 30 Hari Terakhir";
                $chartLabel = "Pendapatan 30 Hari Terakhir";
                break;
            case 'year':
                $startDate = $today->copy()->subMonths(11)->startOfMonth();
                $labelSelesai = "Pesanan 1 Tahun Terakhir";
                $labelPendapatan = "Pendapatan 1 Tahun Terakhir";
                $chartLabel = "Pendapatan 1 Tahun Terakhir";
                break;
            default: // today
                $startDate = $today->copy();
                break;
        }

        $stats = [
            'period'           => $period,
            'label_pesanan'    => $labelSelesai,
            'label_pendapatan' => $labelPendapatan,
            'chart_label'      => $chartLabel,
            'today_bookings'   => Booking::whereDate('booking_date', '>=', $startDate)->whereDate('booking_date', '<=', $today)->count(),
            'today_revenue'    => Booking::whereDate('booking_date', '>=', $startDate)->whereDate('booking_date', '<=', $today)
                                         ->whereIn('status', ['confirmed', 'completed'])
                                         ->sum('total_price'),
            'active_consoles'  => Console::where('status', 'available')->count(),
            'total_users'      => User::where('role', 'customer')->count(),
            'pending_bookings' => Booking::where('status', 'pending')->count(),
            'month_revenue'    => Booking::whereMonth('booking_date', $today->month)
                                         ->whereIn('status', ['confirmed', 'completed'])
                                         ->sum('total_price'),
        ];

        $recentBookings = Booking::with(['user', 'console'])
            ->latest()
            ->take(5)
            ->get();

        // Revenue chart dynamic
        $revenueChart = collect();

        if ($period === 'year') {
            // By month for 12 months
            for ($i = 11; $i >= 0; $i--) {
                $date = $today->copy()->subMonths($i);
                $revenueChart->push([
                    'date'    => $date->format('M Y'),
                    'revenue' => Booking::whereMonth('booking_date', $date->month)
                                        ->whereYear('booking_date', $date->year)
                                        ->whereIn('status', ['confirmed', 'completed'])
                                        ->sum('total_price'),
                ]);
            }
        } elseif ($period === 'month') {
            // Group by 5-day intervals or just show 6 points for the month to avoid clutter
            // Let's do 6 points, each representing 5 days
            for ($i = 5; $i >= 0; $i--) {
                $endInterval = $today->copy()->subDays($i * 5);
                $startInterval = $endInterval->copy()->subDays(4);
                
                $revenueChart->push([
                    'date'    => $startInterval->format('d M') . '-' . $endInterval->format('d M'),
                    'revenue' => Booking::whereDate('booking_date', '>=', $startInterval)
                                        ->whereDate('booking_date', '<=', $endInterval)
                                        ->whereIn('status', ['confirmed', 'completed'])
                                        ->sum('total_price'),
                ]);
            }
        } else {
            // By day for 7 days (used for 'today' and 'week')
            for ($i = 6; $i >= 0; $i--) {
                $date = $today->copy()->subDays($i);
                $revenueChart->push([
                    'date'    => $date->format('d M'),
                    'revenue' => Booking::whereDate('booking_date', $date)
                                        ->whereIn('status', ['confirmed', 'completed'])
                                        ->sum('total_price'),
                ]);
            }
        }

        return view('admin.dashboard', compact('stats', 'recentBookings', 'revenueChart'));
    }
}
