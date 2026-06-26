<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Payment;
use Illuminate\Http\Request;
use Carbon\Carbon;

class LaporanController extends Controller
{
    public function index(Request $request)
    {
        $startDate = $request->input('start_date');
        $endDate = $request->input('end_date');

        // Query payments that are verified for the filter
        $query = Payment::where('status', 'verified')->with('booking.user');

        if ($startDate) {
            $query->whereDate('created_at', '>=', $startDate);
        }
        
        if ($endDate) {
            $query->whereDate('created_at', '<=', $endDate);
        }

        $payments = $query->orderBy('created_at', 'desc')->get();
        $totalPendapatan = $payments->sum('amount');

        // Recap calculations (all time verified)
        $hariIni = Payment::where('status', 'verified')->whereDate('created_at', Carbon::today())->sum('amount');
        $bulanIni = Payment::where('status', 'verified')->whereMonth('created_at', Carbon::now()->month)->whereYear('created_at', Carbon::now()->year)->sum('amount');
        $tahunIni = Payment::where('status', 'verified')->whereYear('created_at', Carbon::now()->year)->sum('amount');

        return view('admin.laporan.index', compact('payments', 'totalPendapatan', 'startDate', 'endDate', 'hariIni', 'bulanIni', 'tahunIni'));
    }
}
