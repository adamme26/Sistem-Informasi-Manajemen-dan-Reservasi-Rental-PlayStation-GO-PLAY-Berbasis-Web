@extends('layouts.app')
@section('title', 'Profil Saya & Riwayat')

@section('content')
<div class="section">
    <div class="container" style="max-width: 1200px; margin: 0 auto;">
        <h1 style="font-size: 32px; font-weight: 800; margin-bottom: 40px;">Profil & Pesanan Aktif</h1>

        <div class="profile-layout" style="display: grid; grid-template-columns: 1fr 1.5fr; gap: 40px; align-items: start;">
            
            {{-- KOLOM KIRI: Form Profil & Password --}}
            <div style="display: flex; flex-direction: column; gap: 32px;">
                
                {{-- Form Info Profil --}}
                <div class="ps-card" style="padding: 32px; display: block;">
                    <h2 style="font-size: 20px; font-weight: 700; margin-bottom: 8px; color: white;">Informasi Profil</h2>
                    <p style="color: var(--text-secondary); font-size: 13px; margin-bottom: 24px;">Perbarui nama dan alamat email akun Anda.</p>

                    <form method="post" action="{{ route('profile.update') }}">
                        @csrf
                        @method('patch')
                        
                        <div class="form-group">
                            <label class="form-label">Nama</label>
                            <input type="text" name="name" class="form-control" value="{{ old('name', $user->name) }}" required>
                            @error('name') <div class="form-error">{{ $message }}</div> @enderror
                        </div>

                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" value="{{ old('email', $user->email) }}" required>
                            @error('email') <div class="form-error">{{ $message }}</div> @enderror
                        </div>

                        <button type="submit" class="btn btn-primary" style="margin-top: 16px;">Simpan Profil</button>
                    </form>
                </div>

                {{-- Form Ubah Password --}}
                <div class="ps-card" style="padding: 32px; display: block;">
                    <h2 style="font-size: 20px; font-weight: 700; margin-bottom: 8px; color: white;">Ubah Password</h2>
                    <p style="color: var(--text-secondary); font-size: 13px; margin-bottom: 24px;">Pastikan akun Anda menggunakan password yang panjang dan acak agar tetap aman.</p>

                    <form method="post" action="{{ route('password.update') }}">
                        @csrf
                        @method('put')
                        
                        <div class="form-group">
                            <label class="form-label">Password Saat Ini</label>
                            <input type="password" name="current_password" class="form-control" required>
                            @error('current_password', 'updatePassword') <div class="form-error">{{ $message }}</div> @enderror
                        </div>

                        <div class="form-group">
                            <label class="form-label">Password Baru</label>
                            <input type="password" name="password" class="form-control" required>
                            @error('password', 'updatePassword') <div class="form-error">{{ $message }}</div> @enderror
                        </div>

                        <div class="form-group">
                            <label class="form-label">Konfirmasi Password</label>
                            <input type="password" name="password_confirmation" class="form-control" required>
                        </div>

                        <button type="submit" class="btn btn-primary" style="margin-top: 16px;">Ubah Password</button>
                    </form>
                </div>

            </div>

            {{-- KOLOM KANAN: Riwayat Pesanan --}}
            <div>
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 24px;">
                    <h2 style="font-size: 24px; font-weight: 800; color: white;">Riwayat & Pesanan Aktif</h2>
                    <a href="{{ route('booking.index') }}" class="btn btn-outline btn-sm" style="border-radius: 8px;">+ Booking Baru</a>
                </div>

                @if(isset($bookings) && $bookings->isEmpty())
                <div class="ps-card" style="text-align:center; padding:60px 20px; display: block;">
                    <div style="font-size:56px; margin-bottom:16px;">🎮</div>
                    <h3 style="font-size:20px; font-weight: 800; color: white; margin-bottom:8px;">Belum Ada Pesanan</h3>
                    <p style="color:var(--text-secondary); margin-bottom:24px;">Yuk mulai gaming dengan sewa PS favorit kamu!</p>
                    <a href="{{ route('booking.index') }}" class="btn btn-primary">Lihat Katalog Unit</a>
                </div>
                @elseif(isset($bookings))
                <div style="display:flex; flex-direction:column; gap:16px;">
                    @foreach($bookings as $booking)
                    <div class="ps-card" style="padding: 24px; display: flex; align-items: center; gap: 24px;">
                        <!-- Console icon -->
                        <div style="width: 72px; height: 72px; border-radius: 16px; background: rgba(123, 47, 247, 0.1); border: 1px solid rgba(123, 47, 247, 0.2); display:flex; align-items:center; justify-content:center; font-size:32px; flex-shrink:0;">
                            {{ $booking->console->type === 'PS5' ? '🎮' : '🕹️' }}
                        </div>

                        <div style="flex:1; min-width:0;">
                            <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom: 8px;">
                                <div style="font-size: 13px; color: var(--purple-light); font-weight: 800; letter-spacing: 1px;">{{ $booking->booking_code }}</div>
                                {!! $booking->status_badge !!}
                            </div>
                            <div style="font-weight:800; font-size: 20px; color: white; margin-bottom: 8px;">{{ $booking->console->name }}</div>
                            <div style="display:flex; gap:16px; flex-wrap:wrap; font-size: 13px;">
                                <span style="color:var(--text-secondary); display:flex; align-items:center; gap:6px;">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                    {{ $booking->booking_date->format('d M Y') }}
                                </span>
                                <span style="color:var(--text-secondary); display:flex; align-items:center; gap:6px;">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                    {{ $booking->start_time }} – {{ $booking->end_time }}
                                </span>
                                <span style="color:var(--text-secondary); display:flex; align-items:center; gap:6px;">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                                    {{ $booking->duration_hours }} Jam
                                </span>
                                <span style="color:var(--blue-light); font-weight:700; display:flex; align-items:center; gap:6px;">
                                    💰 Rp {{ number_format($booking->total_price, 0, ',', '.') }}
                                </span>
                            </div>
                            @if($booking->payment && $booking->payment->status === 'unpaid')
                            <div style="margin-top:12px;">
                                <span style="font-size: 11px; padding: 6px 10px; background: rgba(239, 68, 68, 0.15); color: #ef4444; border-radius: 6px; font-weight: 700; border: 1px solid rgba(239, 68, 68, 0.2);">⚠️ Menunggu Pembayaran & Bukti Transfer</span>
                            </div>
                            @endif
                        </div>

                        <a href="{{ route('bookings.show', $booking) }}" class="btn btn-outline" style="flex-shrink:0;">
                            Detail
                        </a>
                    </div>
                    @endforeach
                </div>

                <div style="margin-top: 24px;">
                    {{ $bookings->links('pagination::bootstrap-4') }}
                </div>
                @endif
            </div>

        </div>
    </div>
</div>

<style>
@media (max-width: 900px) {
    .profile-layout {
        grid-template-columns: 1fr !important;
    }
}
</style>
@endsection
