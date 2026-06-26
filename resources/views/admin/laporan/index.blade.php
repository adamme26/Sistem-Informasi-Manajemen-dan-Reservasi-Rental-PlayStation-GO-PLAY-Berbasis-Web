@extends('layouts.admin')
@section('title', 'Laporan Pendapatan')

@section('content')
<div class="admin-page">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:2rem;" class="no-print">
        <div style="font-family:'Orbitron',sans-serif; font-size:1.5rem; font-weight:700;">Laporan Pendapatan</div>
        <button onclick="window.print()" class="btn btn-primary" style="background-color: var(--blue);">🖨️ Cetak Laporan</button>
    </div>

    <!-- Filter Form -->
    <div class="card no-print" style="margin-bottom: 2rem;">
        <div class="card-body">
            <form method="GET" action="{{ route('admin.laporan.index') }}" style="display:flex; gap:1rem; align-items:flex-end; flex-wrap:wrap;">
                <div class="form-group" style="margin-bottom:0; flex:1; min-width:200px;">
                    <label class="form-label">Tanggal Mulai</label>
                    <input type="date" name="start_date" class="form-control" value="{{ request('start_date') }}">
                </div>
                <div class="form-group" style="margin-bottom:0; flex:1; min-width:200px;">
                    <label class="form-label">Tanggal Akhir</label>
                    <input type="date" name="end_date" class="form-control" value="{{ request('end_date') }}">
                </div>
                <button type="submit" class="btn btn-primary">Filter</button>
                <a href="{{ route('admin.laporan.index') }}" class="btn btn-outline">Reset</a>
            </form>
        </div>
    </div>

    <!-- Printable Header (Hidden on screen) -->
    <div class="print-only" style="text-align:center; margin-bottom:2rem; display:none;">
        <h2 style="font-family:'Orbitron',sans-serif; font-size:2rem; margin-bottom:0.5rem; color:#fff;">GO<span style="color:var(--primary);">PLAY</span></h2>
        <h3>Laporan Pendapatan</h3>
        <p>Periode: {{ $startDate ? date('d M Y', strtotime($startDate)) : 'Awal' }} - {{ $endDate ? date('d M Y', strtotime($endDate)) : 'Sekarang' }}</p>
        <hr style="border-color: #333;">
    </div>

    <!-- Recap Cards -->
    <div class="no-print" style="display:grid; grid-template-columns:repeat(auto-fit, minmax(250px, 1fr)); gap:1.5rem; margin-bottom:2rem;">
        <div class="card" style="border-left: 4px solid #10b981;">
            <div class="card-body" style="padding:1.5rem;">
                <div style="color:var(--text-secondary); font-size:0.875rem; text-transform:uppercase; letter-spacing:0.05em; font-weight:600; margin-bottom:0.5rem;">Pendapatan Hari Ini</div>
                <div style="font-size:1.5rem; font-weight:700; color:#10b981; font-family:'Orbitron',sans-serif;">Rp {{ number_format($hariIni, 0, ',', '.') }}</div>
            </div>
        </div>
        <div class="card" style="border-left: 4px solid #3b82f6;">
            <div class="card-body" style="padding:1.5rem;">
                <div style="color:var(--text-secondary); font-size:0.875rem; text-transform:uppercase; letter-spacing:0.05em; font-weight:600; margin-bottom:0.5rem;">Pendapatan Bulan Ini</div>
                <div style="font-size:1.5rem; font-weight:700; color:#3b82f6; font-family:'Orbitron',sans-serif;">Rp {{ number_format($bulanIni, 0, ',', '.') }}</div>
            </div>
        </div>
        <div class="card" style="border-left: 4px solid #8b5cf6;">
            <div class="card-body" style="padding:1.5rem;">
                <div style="color:var(--text-secondary); font-size:0.875rem; text-transform:uppercase; letter-spacing:0.05em; font-weight:600; margin-bottom:0.5rem;">Pendapatan Tahun Ini</div>
                <div style="font-size:1.5rem; font-weight:700; color:#8b5cf6; font-family:'Orbitron',sans-serif;">Rp {{ number_format($tahunIni, 0, ',', '.') }}</div>
            </div>
        </div>
    </div>

    <!-- Summary Box (Filter Result) -->
    <div class="card" style="margin-bottom: 2rem; background: linear-gradient(135deg, rgba(245, 158, 11, 0.1) 0%, rgba(245, 158, 11, 0.05) 100%); border-left: 4px solid var(--primary);">
        <div class="card-body" style="display:flex; justify-content:space-between; align-items:center;">
            <div>
                <div style="color:var(--text-secondary); font-size:0.875rem; text-transform:uppercase; letter-spacing:0.05em; font-weight:600; margin-bottom:0.5rem;">Total (Sesuai Filter)</div>
                <div style="font-size:2rem; font-weight:700; color:var(--primary); font-family:'Orbitron',sans-serif;">Rp {{ number_format($totalPendapatan, 0, ',', '.') }}</div>
            </div>
            <div style="text-align:right; color:var(--text-muted); font-size:0.875rem;">
                Total Transaksi: <strong style="color:#fff;">{{ $payments->count() }}</strong>
            </div>
        </div>
    </div>

    <!-- Data Table -->
    <div class="table-card">
        <div style="overflow-x:auto;">
            <table class="gp-table">
                <thead>
                    <tr>
                        <th># ID</th>
                        <th>Tanggal Bayar</th>
                        <th>Member / Pelanggan</th>
                        <th>ID Booking</th>
                        <th style="text-align:right;">Nominal (Rp)</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($payments as $payment)
                    <tr>
                        <td style="color:var(--text-muted); font-size:0.8rem;">PAY-{{ str_pad($payment->id, 4, '0', STR_PAD_LEFT) }}</td>
                        <td>{{ $payment->created_at->format('d M Y H:i') }}</td>
                        <td style="font-weight:500;">{{ $payment->booking->user->name ?? 'User Dihapus' }}</td>
                        <td><span class="badge badge-primary" style="background:rgba(59, 130, 246, 0.1); color:#3b82f6;">BKG-{{ $payment->booking_id }}</span></td>
                        <td style="text-align:right; font-weight:600; color:var(--primary);">{{ number_format($payment->amount, 0, ',', '.') }}</td>
                    </tr>
                    @empty
                    <tr><td colspan="5" style="text-align:center; color:var(--text-secondary); padding:3rem;">Tidak ada data pendapatan untuk periode ini.</td></tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>

<style>
@media print {
    body { background-color: #121212 !important; color: #fff !important; }
    .no-print { display: none !important; }
    .print-only { display: block !important; }
    .sidebar { display: none !important; }
    .admin-main { margin-left: 0 !important; width: 100% !important; padding: 0 !important; }
    .table-card { border: none !important; box-shadow: none !important; }
    .gp-table th, .gp-table td { border-bottom: 1px solid #333 !important; }
}
</style>
@endsection
