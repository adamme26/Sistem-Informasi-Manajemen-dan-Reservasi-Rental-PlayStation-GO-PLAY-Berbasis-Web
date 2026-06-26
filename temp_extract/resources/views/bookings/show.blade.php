@extends('layouts.app')
@section('title', 'Detail Pesanan ' . $booking->booking_code)

@section('content')
<style>
.grid-2 {
    display: grid;
    grid-template-columns: 1fr;
    gap: 1.5rem;
}
@media (min-width: 768px) {
    .grid-2 {
        grid-template-columns: 1.2fr 1fr;
    }
}
.show-container {
    max-width: 1000px;
    margin: 0 auto;
}
</style>
<div class="section">
    <div class="container show-container">
        <a href="{{ route('dashboard') }}" style="color:var(--text-secondary); text-decoration:none; font-size:0.875rem; display:inline-flex; align-items:center; gap:6px; margin-bottom:2rem;">
            ← Kembali ke Pesanan Saya
        </a>

        @if(session('success'))
        <div class="alert alert-success" style="margin-bottom:1.5rem;">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="flex-shrink:0;"><polyline points="20 6 9 17 4 12"/></svg>
            {{ session('success') }}
        </div>
        @endif

        <div class="grid-2" style="align-items:start;">
            <!-- Booking Details -->
            <div>
                <div class="card" style="margin-bottom:1.5rem;">
                    <div class="card-header" style="display:flex; align-items:center; justify-content:space-between;">
                        <span>📋 Detail Pesanan</span>
                        {!! $booking->status_badge !!}
                    </div>
                    <div class="card-body">
                        <div style="margin-bottom:1.5rem; padding:1rem; background:var(--bg-secondary); border-radius:var(--radius-md); text-align:center;">
                            <div style="color:var(--text-muted); font-size:0.75rem; margin-bottom:4px;">KODE BOOKING</div>
                            <div style="font-family:'Orbitron',sans-serif; font-size:1.4rem; font-weight:900; color:var(--blue); letter-spacing:0.1em;">{{ $booking->booking_code }}</div>
                        </div>

                        @php $rows = [
                            ['🕹️ Konsol',   $booking->console->name . ' (' . $booking->console->type . ')'],
                            ['📅 Tanggal',   $booking->booking_date->format('d F Y')],
                            ['⏰ Waktu',     $booking->start_time . ' – ' . $booking->end_time . ' WIB'],
                            ['⌛ Durasi',    $booking->duration_hours . ' Jam'],
                            ['💰 Total',     'Rp ' . number_format($booking->total_price, 0, ',', '.')],
                        ]; @endphp

                        @foreach($rows as [$label, $value])
                        <div style="display:flex; justify-content:space-between; padding:0.75rem 0; border-bottom:1px solid var(--border); font-size:0.875rem;">
                            <span style="color:var(--text-secondary);">{{ $label }}</span>
                            <span style="font-weight:500; text-align:right;">{{ $value }}</span>
                        </div>
                        @endforeach

                        @if($booking->notes)
                        <div style="padding:0.75rem 0; font-size:0.875rem;">
                            <span style="color:var(--text-secondary);">📝 Catatan</span>
                            <p style="margin-top:0.4rem; color:var(--text-primary);">{{ $booking->notes }}</p>
                        </div>
                        @endif
                    </div>
                    @if($booking->status === 'pending')
                    <div class="card-footer">
                        <form method="POST" action="{{ route('bookings.cancel', $booking) }}" onsubmit="return confirm('Yakin ingin membatalkan pesanan ini?')">
                            @csrf
                            <button type="submit" class="btn btn-danger btn-sm">❌ Batalkan Pesanan</button>
                        </form>
                    </div>
                    @endif
                </div>
            </div>

            <!-- Payment Info -->
            <div>
                @if($booking->payment)
                @php $payment = $booking->payment; @endphp
                <div class="card">
                    <div class="card-header" style="display:flex; align-items:center; justify-content:space-between;">
                        <span>💳 Informasi Pembayaran</span>
                        @if($payment->status === 'unpaid')
                        <span class="badge badge-danger">Belum Bayar</span>
                        @elseif($payment->status === 'uploaded')
                        <span class="badge badge-warning">Menunggu Verifikasi</span>
                        @else
                        <span class="badge badge-success">Terverifikasi</span>
                        @endif
                    </div>
                    <div class="card-body">
                        @if($payment->status === 'unpaid')
                        <div class="alert alert-warning" style="margin-bottom:1.5rem;">
                            ⚠️ Segera lakukan transfer dan upload bukti pembayaran untuk konfirmasi.
                        </div>
                        @endif

                        <div style="background:var(--bg-secondary); border-radius:var(--radius-md); padding:1.25rem; margin-bottom:1.5rem;">
                            @if($payment->bank_name === 'QRIS')
                                <div style="font-size:0.75rem; color:var(--text-muted); margin-bottom:0.75rem; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Scan QRIS untuk Membayar</div>
                                <div style="text-align:center; padding: 20px 0;">
                                    <!-- Placeholder QR Code -->
                                    <div style="width: 200px; height: 200px; background: white; margin: 0 auto; display: flex; align-items: center; justify-content: center; border-radius: 12px; padding: 12px;">
                                        <svg width="100%" height="100%" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5">
                                            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                            <rect x="7" y="7" width="3" height="3"></rect>
                                            <rect x="14" y="7" width="3" height="3"></rect>
                                            <rect x="7" y="14" width="3" height="3"></rect>
                                            <rect x="14" y="14" width="3" height="3"></rect>
                                        </svg>
                                    </div>
                                </div>
                                <div style="text-align:center; font-size:0.875rem; color:var(--text-secondary);">a.n. {{ $payment->account_name }}</div>
                            @elseif($payment->bank_name === 'GoPay')
                                <div style="font-size:0.75rem; color:var(--text-muted); margin-bottom:0.75rem; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Transfer ke GoPay</div>
                                <div style="font-size:0.9rem; color:var(--text-secondary); margin-bottom:4px;">{{ $payment->bank_name }}</div>
                                <div style="font-family:'Orbitron',sans-serif; font-size:1.5rem; font-weight:900; letter-spacing:0.1em; color:#00AED6; margin-bottom:4px;">0812-3456-7890</div>
                                <div style="font-size:0.875rem; color:var(--text-secondary);">a.n. {{ $payment->account_name }}</div>
                            @else
                                <div style="font-size:0.75rem; color:var(--text-muted); margin-bottom:0.75rem; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Transfer ke Rekening Bank</div>
                                <div style="font-size:0.9rem; color:var(--text-secondary); margin-bottom:4px;">{{ $payment->bank_name }}</div>
                                <div style="font-family:'Orbitron',sans-serif; font-size:1.5rem; font-weight:900; letter-spacing:0.1em; color:var(--blue); margin-bottom:4px;">{{ $payment->account_number }}</div>
                                <div style="font-size:0.875rem; color:var(--text-secondary);">a.n. {{ $payment->account_name }}</div>
                            @endif

                            <div style="margin-top:1rem; padding-top:1rem; border-top:1px solid var(--border); display:flex; justify-content:space-between; align-items:center;">
                                <span style="font-size:0.875rem; color:var(--text-secondary);">Jumlah Transfer</span>
                                <span style="font-family:'Orbitron',sans-serif; font-weight:700; color:var(--blue);">Rp {{ number_format($payment->amount, 0, ',', '.') }}</span>
                            </div>
                        </div>

                        @if($payment->status === 'unpaid' || $payment->status === 'uploaded')
                        <form method="POST" action="{{ route('bookings.proof', $booking) }}" enctype="multipart/form-data">
                            @csrf
                            <div class="form-group">
                                <label class="form-label">Upload Bukti Transfer</label>
                                <input type="file" name="transfer_proof" class="form-control" accept="image/*" required>
                                <div style="font-size:0.75rem; color:var(--text-muted); margin-top:4px;">Format: JPG/PNG, maks 2MB</div>
                                @error('transfer_proof')<div class="form-error">{{ $message }}</div>@enderror
                            </div>
                            <button type="submit" class="btn btn-purple" style="width:100%; justify-content:center;">
                                📤 Upload Bukti Transfer
                            </button>
                        </form>
                        @endif

                        @if($payment->transfer_proof)
                        <div style="margin-top:1.5rem;">
                            <div style="font-size:0.75rem; color:var(--text-muted); margin-bottom:0.5rem; font-weight:600;">BUKTI TRANSFER</div>
                            <img src="{{ asset('storage/' . $payment->transfer_proof) }}"
                                 alt="Bukti Transfer"
                                 style="width:100%; border-radius:var(--radius-md); border:1px solid var(--border);">
                        </div>
                        @endif
                    </div>
                </div>
                @endif
            </div>
        </div>
    </div>
</div>
@endsection
