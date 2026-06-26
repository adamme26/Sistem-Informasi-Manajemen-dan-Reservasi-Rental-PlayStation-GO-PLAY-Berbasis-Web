@extends('layouts.app')
@section('title', 'Pesanan Saya')

@section('content')
<div class="section">
    <div class="container">
        <div style="margin-bottom:2rem; display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:1rem;">
            <div>
                <h1 style="font-size:1.5rem; margin-bottom:0.25rem;">Pesanan Saya</h1>
                <p style="color:var(--text-secondary); font-size:0.875rem;">Halo, <strong>{{ auth()->user()->name }}</strong> 👋</p>
            </div>
            <a href="{{ route('booking.index') }}" class="btn btn-primary">+ Booking Baru</a>
        </div>

        @if($bookings->isEmpty())
        <div class="card" style="text-align:center; padding:4rem 2rem;">
            <div style="font-size:4rem; margin-bottom:1rem;">🎮</div>
            <h3 style="font-size:1.1rem; margin-bottom:0.5rem;">Belum Ada Pesanan</h3>
            <p style="color:var(--text-secondary); margin-bottom:2rem;">Yuk mulai gaming dengan sewa PS favorit kamu!</p>
            <a href="{{ route('booking.index') }}" class="btn btn-primary">Lihat Konsol</a>
        </div>
        @else
        <div style="display:flex; flex-direction:column; gap:1rem;">
            @foreach($bookings as $booking)
            <div class="booking-card">
                <!-- Console icon -->
                <div class="{{ $booking->console->type === 'PS5' ? 'ps5-bg' : 'ps4-bg' }}" style="width:56px; height:56px; border-radius:var(--radius-md); display:flex; align-items:center; justify-content:center; font-size:1.8rem; flex-shrink:0;">
                    {{ $booking->console->type === 'PS5' ? '🎮' : '🕹️' }}
                </div>

                <div style="flex:1; min-width:0;">
                    <div style="display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:0.5rem; margin-bottom:0.4rem;">
                        <div class="booking-code">{{ $booking->booking_code }}</div>
                        {!! $booking->status_badge !!}
                    </div>
                    <div style="font-weight:600; font-size:0.95rem; margin-bottom:0.25rem;">{{ $booking->console->name }}</div>
                    <div style="display:flex; gap:1.5rem; flex-wrap:wrap;">
                        <span style="color:var(--text-secondary); font-size:0.8rem;">📅 {{ $booking->booking_date->format('d M Y') }}</span>
                        <span style="color:var(--text-secondary); font-size:0.8rem;">⏰ {{ $booking->start_time }} – {{ $booking->end_time }}</span>
                        <span style="color:var(--text-secondary); font-size:0.8rem;">⌛ {{ $booking->duration_hours }} Jam</span>
                        <span style="color:var(--blue); font-size:0.8rem; font-weight:600;">💰 Rp {{ number_format($booking->total_price, 0, ',', '.') }}</span>
                    </div>
                    @if($booking->payment && $booking->payment->status === 'unpaid')
                    <div style="margin-top:0.5rem;">
                        <span class="badge badge-danger" style="font-size:0.7rem;">⚠️ Belum Upload Bukti Transfer</span>
                    </div>
                    @endif
                    @if($booking->is_playing)
                    <div style="margin-top:0.8rem; background:rgba(239, 68, 68, 0.1); border:1px solid rgba(239, 68, 68, 0.3); padding:0.75rem; border-radius:var(--radius-md); text-align:center;">
                        <div style="font-size:0.75rem; color:var(--text-secondary); margin-bottom:4px; text-transform:uppercase; letter-spacing:1px;">Sisa Waktu Bermain</div>
                        <div style="font-family:'Orbitron',sans-serif; font-size:1.5rem; font-weight:700; color:#ef4444; text-shadow:0 0 10px rgba(239, 68, 68, 0.4);">
                            <span class="countdown-timer" data-seconds="{{ $booking->remaining_seconds }}">00:00:00</span>
                        </div>
                    </div>
                    @endif
                </div>

                <a href="{{ route('bookings.show', $booking) }}" class="btn btn-outline btn-sm" style="flex-shrink:0;">
                    Detail →
                </a>
            </div>
            @endforeach
        </div>

        <div class="pagination">{{ $bookings->links() }}</div>
        @endif
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
                timer.textContent = "00:00:00";
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
</script>
@endpush
@endsection
