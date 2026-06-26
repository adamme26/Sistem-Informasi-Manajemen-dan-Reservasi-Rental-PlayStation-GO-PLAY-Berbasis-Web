@extends('layouts.admin')
@section('title', 'Kelola Pesanan')

@section('content')
<div class="admin-page">
    <div style="margin-bottom:2rem;">
        <div style="font-family:'Orbitron',sans-serif; font-size:1.5rem; font-weight:700;">Kelola Pesanan</div>
    </div>

    <!-- Filters -->
    <form method="GET" style="background:var(--bg-card); border:1px solid var(--border); border-radius:var(--radius-lg); padding:1.25rem; margin-bottom:1.5rem; display:flex; gap:1rem; flex-wrap:wrap; align-items:flex-end;">
        <div style="flex:1; min-width:150px;">
            <label class="form-label" style="font-size:0.75rem; margin-bottom:0.5rem; color:var(--text-secondary);">Status</label>
            <select name="status" class="form-control" style="padding:10px 14px; font-size:0.875rem;">
                <option value="">Semua Status</option>
                <option value="pending" {{ request('status')==='pending' ? 'selected' : '' }}>Pending</option>
                <option value="confirmed" {{ request('status')==='confirmed' ? 'selected' : '' }}>Dikonfirmasi</option>
                <option value="cancelled" {{ request('status')==='cancelled' ? 'selected' : '' }}>Dibatalkan</option>
                <option value="completed" {{ request('status')==='completed' ? 'selected' : '' }}>Selesai</option>
            </select>
        </div>
        <div style="flex:1; min-width:150px;">
            <label class="form-label" style="font-size:0.75rem; margin-bottom:0.5rem; color:var(--text-secondary);">Tanggal</label>
            <input type="date" name="date" class="form-control" value="{{ request('date') }}" style="padding:10px 14px; font-size:0.875rem; color-scheme:dark;">
        </div>
        <div style="flex:2; min-width:200px;">
            <label class="form-label" style="font-size:0.75rem; margin-bottom:0.5rem; color:var(--text-secondary);">Cari</label>
            <input type="text" name="search" class="form-control" placeholder="Nama pelanggan / kode booking..." value="{{ request('search') }}" style="padding:10px 14px; font-size:0.875rem;">
        </div>
        <button type="submit" class="btn btn-primary" style="padding:10px 20px; font-size:0.875rem; height:41px;">Filter</button>
        @if(request()->hasAny(['status','date','search']))
        <a href="{{ route('admin.bookings.index') }}" class="btn btn-outline" style="padding:10px 20px; font-size:0.875rem; height:41px;">Reset</a>
        @endif
    </form>

    <!-- Table -->
    <div class="table-card">
        <div style="overflow-x:auto;">
            <table class="gp-table">
                <thead>
                    <tr>
                        <th>Kode</th>
                        <th>Pelanggan</th>
                        <th>Konsol</th>
                        <th>Jadwal</th>
                        <th>Total</th>
                        <th>Pembayaran</th>
                        <th>Status</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($bookings as $booking)
                    <tr>
                        <td><span style="font-family:'Orbitron',sans-serif; font-size:0.8rem; color:var(--blue);">{{ $booking->booking_code }}</span></td>
                        <td>
                            <div style="font-weight:500; font-size:0.875rem;">{{ $booking->user->name }}</div>
                            <div style="font-size:0.75rem; color:var(--text-muted);">{{ $booking->user->phone }}</div>
                        </td>
                        <td>
                            <span class="console-type-badge {{ $booking->console->type === 'PS5' ? 'badge-ps5' : 'badge-ps4' }}" style="margin-bottom:4px; display:inline-block;">{{ $booking->console->type }}</span>
                            <div style="font-size:0.8rem;">{{ $booking->console->name }}</div>
                        </td>
                        <td style="font-size:0.8rem;">
                            <div>{{ $booking->booking_date->format('d M Y') }}</div>
                            <div style="color:var(--text-secondary);">{{ $booking->start_time }} – {{ $booking->end_time }}</div>
                        </td>
                        <td style="font-weight:600; color:var(--blue); font-size:0.875rem;">Rp {{ number_format($booking->total_price, 0, ',', '.') }}</td>
                        <td>
                            @if($booking->payment)
                                @if($booking->payment->status === 'unpaid')
                                <span class="badge badge-danger">Belum Bayar</span>
                                @elseif($booking->payment->status === 'uploaded')
                                <span class="badge badge-warning">Cek Bukti</span>
                                @else
                                <span class="badge badge-success">Terverifikasi</span>
                                @endif
                            @endif
                        </td>
                        <td>{!! $booking->status_badge !!}</td>
                        <td>
                            <div style="display:flex; gap:0.5rem; flex-wrap:wrap;">
                                <a href="{{ route('admin.bookings.show', $booking) }}" class="btn btn-outline btn-sm">Detail</a>
                                @if($booking->status === 'pending')
                                <form method="POST" action="{{ route('admin.bookings.status', $booking) }}" style="display:inline;">
                                    @csrf @method('PATCH')
                                    <input type="hidden" name="status" value="confirmed">
                                    <button type="submit" class="btn btn-success btn-sm">✓ Konfirmasi</button>
                                </form>
                                @endif
                            </div>
                        </td>
                    </tr>
                    @empty
                    <tr><td colspan="8" style="text-align:center; color:var(--text-secondary); padding:3rem;">Tidak ada pesanan</td></tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
    <div style="margin-top:1.5rem;">{{ $bookings->withQueryString()->links() }}</div>
</div>
@endsection
