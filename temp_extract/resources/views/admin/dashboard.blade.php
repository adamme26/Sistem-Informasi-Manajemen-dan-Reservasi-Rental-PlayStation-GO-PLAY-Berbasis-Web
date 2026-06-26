@extends('layouts.admin')
@section('title', 'Dashboard')

@section('content')
<div class="admin-page">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:2rem; flex-wrap:wrap; gap:1rem;">
        <div>
            <div style="font-family:'Orbitron',sans-serif; font-size:1.5rem; font-weight:700;">Dashboard</div>
            <p style="color:var(--text-secondary); font-size:0.875rem;">{{ now()->format('l, d F Y') }}</p>
        </div>
        <div style="display:flex; gap:1rem; align-items:center;">
            <form method="GET" action="{{ route('admin.dashboard') }}">
                <select name="period" onchange="this.form.submit()" class="form-control" style="padding:8px 16px; font-size:0.875rem; border-radius:var(--radius-md); background:var(--bg-card); cursor:pointer;">
                    <option value="today" {{ $stats['period'] == 'today' ? 'selected' : '' }}>Hari Ini</option>
                    <option value="week" {{ $stats['period'] == 'week' ? 'selected' : '' }}>7 Hari Terakhir</option>
                    <option value="month" {{ $stats['period'] == 'month' ? 'selected' : '' }}>30 Hari Terakhir</option>
                    <option value="year" {{ $stats['period'] == 'year' ? 'selected' : '' }}>1 Tahun Terakhir</option>
                </select>
            </form>
            <a href="{{ route('admin.bookings.index') }}" class="btn btn-primary" style="padding:8px 16px; font-size:0.875rem;">Lihat Semua Pesanan</a>
        </div>
    </div>

    <!-- Stats Grid -->
    <div class="stat-cards-grid">
        <div class="stat-card-item">
            <div class="stat-card-icon" style="background:rgba(59, 130, 246, 0.2); color:#3b82f6;">📋</div>
            <div class="stat-card-val">{{ $stats['today_bookings'] }}</div>
            <div class="stat-card-label">{{ $stats['label_pesanan'] }}</div>
        </div>
        <div class="stat-card-item">
            <div class="stat-card-icon" style="background:rgba(16, 185, 129, 0.2); color:#10b981;">💰</div>
            <div class="stat-card-val" style="font-size:1.4rem;">Rp {{ number_format($stats['today_revenue'], 0, ',', '.') }}</div>
            <div class="stat-card-label">{{ $stats['label_pendapatan'] }}</div>
        </div>
        <div class="stat-card-item">
            <div class="stat-card-icon" style="background:rgba(139, 92, 246, 0.2); color:#8b5cf6;">🎮</div>
            <div class="stat-card-val">{{ $stats['active_consoles'] }}</div>
            <div class="stat-card-label">Unit Aktif</div>
        </div>
        <div class="stat-card-item">
            <div class="stat-card-icon" style="background:rgba(245, 158, 11, 0.2); color:#f59e0b;">⏳</div>
            <div class="stat-card-val" style="background:linear-gradient(135deg, var(--yellow), #D97706); -webkit-background-clip:text; background-clip:text; -webkit-text-fill-color:transparent;">{{ $stats['pending_bookings'] }}</div>
            <div class="stat-card-label">Menunggu Konfirmasi</div>
        </div>
    </div>

    <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap:1.5rem; align-items:start;">
        <!-- Recent Bookings -->
        <div class="table-card">
            <div class="table-card-header" style="display:flex; align-items:center; justify-content:space-between;">
                <span>📋 Pesanan Terbaru</span>
                <a href="{{ route('admin.bookings.index') }}" style="color:var(--blue); font-size:0.8rem; text-decoration:none;">Lihat Semua →</a>
            </div>
            <div>
                @forelse($recentBookings as $booking)
                <div style="display:flex; align-items:center; gap:1rem; padding:1rem 1.5rem; border-bottom:1px solid var(--border);">
                    <div style="flex:1; min-width:0;">
                        <div style="font-size:0.8rem; color:var(--blue); font-family:'Orbitron',sans-serif; font-weight:700;">{{ $booking->booking_code }}</div>
                        <div style="font-size:0.875rem; font-weight:500; margin:2px 0;">{{ $booking->user->name }}</div>
                        <div style="font-size:0.78rem; color:var(--text-secondary);">{{ $booking->console->name }} • {{ $booking->booking_date->format('d M') }}</div>
                    </div>
                    <div style="text-align:right; flex-shrink:0;">
                        {!! $booking->status_badge !!}
                        <div style="font-size:0.8rem; color:var(--text-secondary); margin-top:4px;">Rp {{ number_format($booking->total_price, 0, ',', '.') }}</div>
                    </div>
                </div>
                @empty
                <div style="padding:2rem; text-align:center; color:var(--text-secondary); font-size:0.875rem;">Belum ada pesanan</div>
                @endforelse
            </div>
        </div>

        <!-- Revenue Chart -->
        <div class="table-card">
            <div class="table-card-header">📊 {{ $stats['chart_label'] }}</div>
            <div class="card-body" style="padding:1.5rem;">
                <div style="display:flex; align-items:flex-end; gap:0.5rem; height:180px; margin-bottom:0.75rem;">
                    @php $maxRev = max($revenueChart->pluck('revenue')->toArray() ?: [1]); @endphp
                    @foreach($revenueChart as $day)
                    @php $height = $maxRev > 0 ? max(4, ($day['revenue'] / $maxRev) * 160) : 4; @endphp
                    <div style="flex:1; display:flex; flex-direction:column; align-items:center; justify-content:flex-end; gap:4px; height:100%;">
                        <div style="font-size:0.65rem; color:var(--text-muted);">{{ $day['revenue'] > 0 ? number_format($day['revenue']/1000, 0) . 'K' : '' }}</div>
                        <div style="width:100%; height:{{ $height }}px; background:linear-gradient(180deg, var(--blue), var(--purple)); border-radius:4px 4px 0 0; transition:height 0.5s ease; min-height:4px;"></div>
                        <div style="font-size:0.65rem; color:var(--text-muted); text-align:center; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; width:100%;">{{ $day['date'] }}</div>
                    </div>
                    @endforeach
                </div>
                <div style="display:flex; justify-content:space-between; padding-top:1rem; border-top:1px solid var(--border);">
                    <div>
                        <div style="font-size:0.75rem; color:var(--text-muted);">Total Bulan Ini</div>
                        <div style="font-family:'Orbitron',sans-serif; font-weight:700; color:var(--green);">Rp {{ number_format($stats['month_revenue'], 0, ',', '.') }}</div>
                    </div>
                    <div style="text-align:right;">
                        <div style="font-size:0.75rem; color:var(--text-muted);">Total Pelanggan</div>
                        <div style="font-family:'Orbitron',sans-serif; font-weight:700; color:var(--blue);">{{ $stats['total_users'] }}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
