@extends('layouts.admin')
@section('title', 'Kelola Pesanan')

@section('content')
<div class="admin-page">
    <div style="margin-bottom:2rem;">
        <div style="font-family:'Orbitron',sans-serif; font-size:1.5rem; font-weight:700;">Kelola Pesanan</div>
    </div>

    <!-- Status Unit Real-time Grid -->
    <div style="margin-bottom: 2rem;">
        <div style="font-size:1.1rem; font-weight:600; margin-bottom:1rem; color:var(--text-secondary);">Status Unit Real-time</div>
        <div style="display:grid; grid-template-columns:repeat(auto-fill, minmax(250px, 1fr)); gap:1rem;">
            @foreach($consoles as $console)
            @php 
                $activeBooking = \App\Models\Booking::where('console_id', $console->id)
                    ->where('status', 'confirmed')
                    ->whereNotNull('started_at')
                    ->first();
                $isMaintenance = $console->status === 'maintenance';
            @endphp
            <div class="card" style="border-left:4px solid {{ $activeBooking ? '#ef4444' : ($isMaintenance ? '#f59e0b' : '#10b981') }};">
                <div class="card-body" style="padding:1rem;">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:0.5rem;">
                        <span style="font-weight:700;">{{ $console->name }}</span>
                        <span class="badge {{ $activeBooking ? 'badge-danger' : ($isMaintenance ? 'badge-warning' : 'badge-success') }}" style="font-size:0.7rem;">
                            {{ $activeBooking ? 'Terisi' : ($isMaintenance ? 'Maintenance' : 'Kosong') }}
                        </span>
                    </div>
                    
                    @if($activeBooking)
                    <div style="font-size:0.8rem; color:var(--text-muted); margin-bottom:1rem;">
                        <div>ID: {{ $activeBooking->booking_code }}</div>
                        <div style="color:#ef4444; font-family:'Orbitron',sans-serif; font-size:1.2rem; font-weight:700; margin-top:5px;">
                            <span class="countdown-timer" data-seconds="{{ $activeBooking->remaining_seconds }}">00:00:00</span>
                        </div>
                    </div>
                    <div style="display:flex; gap:0.5rem;">
                        <button type="button" class="btn btn-outline btn-sm" onclick="openTambahDurasiModal({{ $activeBooking->id }}, '{{ $console->name }}')" style="flex:1;">+ Durasi</button>
                        <form method="POST" action="{{ route('admin.bookings.stop', $activeBooking) }}" style="flex:1; margin:0;" onsubmit="return confirm('Selesaikan sesi ini sekarang?')">
                            @csrf
                            <button type="submit" class="btn btn-danger btn-sm" style="width:100%;">Stop</button>
                        </form>
                    </div>
                    @elseif(!$isMaintenance)
                    <div style="font-size:0.8rem; color:var(--text-muted); margin-bottom:1rem; height:41px; display:flex; align-items:center;">
                        Unit tersedia untuk dimainkan.
                    </div>
                    <button type="button" class="btn btn-primary btn-sm" onclick="openWalkinModal({{ $console->id }}, '{{ $console->name }}')" style="width:100%;">Input Durasi (Walk-in)</button>
                    @endif
                </div>
            </div>
            @endforeach
        </div>
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
                                @if($booking->status === 'confirmed' && !$booking->started_at)
                                <form method="POST" action="{{ route('admin.bookings.start-playing', $booking) }}" style="display:inline;">
                                    @csrf
                                    <button type="submit" class="btn btn-primary btn-sm">▶ Mulai Bermain</button>
                                </form>
                                @endif
                                @if($booking->is_playing)
                                <div class="btn btn-sm" style="background:#071426; border:1px solid #ef4444; color:#ef4444; pointer-events:none; min-width:85px; text-align:center;">
                                    <span class="countdown-timer" data-seconds="{{ $booking->remaining_seconds }}">00:00:00</span>
                                </div>
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

<!-- Walk-in Modal -->
<div id="walkinModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); z-index:9999; align-items:center; justify-content:center;">
    <div class="card" style="width:400px; max-width:90%;">
        <div class="card-header" style="display:flex; justify-content:space-between; align-items:center;">
            <span style="font-weight:700;">Input Durasi Walk-in</span>
            <button onclick="document.getElementById('walkinModal').style.display='none'" style="background:none; border:none; color:white; cursor:pointer; font-size:1.2rem;">&times;</button>
        </div>
        <div class="card-body">
            <form id="walkinForm" method="POST" action="{{ route('admin.bookings.walk-in') }}">
                @csrf
                <input type="hidden" name="console_id" id="walkinConsoleId">
                <div style="margin-bottom:1rem;">
                    <label class="form-label" style="font-size:0.8rem; color:var(--text-secondary);">Konsol Terpilih</label>
                    <input type="text" id="walkinConsoleName" class="form-control" readonly style="background:var(--bg-primary); cursor:not-allowed;">
                </div>
                <div style="margin-bottom:1.5rem;">
                    <label class="form-label" style="font-size:0.8rem; color:var(--text-secondary);">Durasi Sewa (Jam)</label>
                    <input type="number" name="duration" class="form-control" min="1" max="12" value="1" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width:100%;">Mulai Timer</button>
            </form>
        </div>
    </div>
</div>

<!-- Tambah Durasi Modal -->
<div id="tambahDurasiModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); z-index:9999; align-items:center; justify-content:center;">
    <div class="card" style="width:400px; max-width:90%;">
        <div class="card-header" style="display:flex; justify-content:space-between; align-items:center;">
            <span style="font-weight:700;">Tambah Durasi Sesi</span>
            <button onclick="document.getElementById('tambahDurasiModal').style.display='none'" style="background:none; border:none; color:white; cursor:pointer; font-size:1.2rem;">&times;</button>
        </div>
        <div class="card-body">
            <form id="tambahDurasiForm" method="POST" action="">
                @csrf
                <div style="margin-bottom:1rem;">
                    <label class="form-label" style="font-size:0.8rem; color:var(--text-secondary);">Konsol Aktif</label>
                    <input type="text" id="tambahDurasiConsoleName" class="form-control" readonly style="background:var(--bg-primary); cursor:not-allowed;">
                </div>
                <div style="margin-bottom:1.5rem;">
                    <label class="form-label" style="font-size:0.8rem; color:var(--text-secondary);">Tambahan Durasi (Jam)</label>
                    <input type="number" name="extra_duration" class="form-control" min="1" max="12" value="1" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width:100%;">Update Timer</button>
            </form>
        </div>
    </div>
</div>

</div>
@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.countdown-timer').forEach(timer => {
        let seconds = parseInt(timer.getAttribute('data-seconds'), 10);
        setInterval(() => {
            if (seconds <= 0) {
                timer.textContent = "Waktu Habis";
                return;
            }
            seconds--;
            const h = Math.floor(seconds / 3600).toString().padStart(2, '0');
            const m = Math.floor((seconds % 3600) / 60).toString().padStart(2, '0');
            const s = (seconds % 60).toString().padStart(2, '0');
            timer.textContent = `${h}:${m}:${s}`;
        }, 1000);
    });
});

function openWalkinModal(consoleId, consoleName) {
    document.getElementById('walkinConsoleId').value = consoleId;
    document.getElementById('walkinConsoleName').value = consoleName;
    document.getElementById('walkinModal').style.display = 'flex';
}

function openTambahDurasiModal(bookingId, consoleName) {
    document.getElementById('tambahDurasiConsoleName').value = consoleName;
    document.getElementById('tambahDurasiForm').action = "/admin090506/bookings/" + bookingId + "/add-duration";
    document.getElementById('tambahDurasiModal').style.display = 'flex';
}
</script>
@endpush
@endsection
