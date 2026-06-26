@extends('layouts.admin')
@section('title', 'Detail Pesanan ' . $booking->booking_code)

@section('content')
<div class="admin-header">
    <div>
        <a href="{{ route('admin.bookings.index') }}" style="color:var(--text-secondary); text-decoration:none; font-size:0.875rem; display:inline-flex; align-items:center; gap:6px; margin-bottom:0.5rem;">← Kembali</a>
        <div class="page-title">{{ $booking->booking_code }}</div>
    </div>
    {!! $booking->status_badge !!}
</div>

<div class="grid-2" style="align-items:start; gap:1.5rem;">
    <!-- Left -->
    <div style="display:flex; flex-direction:column; gap:1.5rem;">
        <!-- Booking Info -->
        <div class="card">
            <div class="card-header">📋 Detail Pesanan</div>
            <div class="card-body">
                @php $rows = [
                    ['Pelanggan',    $booking->user->name],
                    ['Email',        $booking->user->email],
                    ['WhatsApp',     $booking->user->phone ?? '-'],
                    ['Konsol',       $booking->console->name . ' (' . $booking->console->type . ')'],
                    ['Tanggal',      $booking->booking_date->format('d F Y')],
                    ['Waktu',        $booking->start_time . ' – ' . $booking->end_time . ' WIB'],
                    ['Durasi',       $booking->duration_hours . ' Jam'],
                    ['Total Bayar',  'Rp ' . number_format($booking->total_price, 0, ',', '.')],
                    ['Dibuat',       $booking->created_at->format('d M Y H:i')],
                ]; @endphp
                @foreach($rows as [$label, $value])
                <div style="display:flex; justify-content:space-between; padding:0.7rem 0; border-bottom:1px solid var(--border); font-size:0.875rem;">
                    <span style="color:var(--text-secondary);">{{ $label }}</span>
                    <span style="font-weight:500; text-align:right;">{{ $value }}</span>
                </div>
                @endforeach
                @if($booking->notes)
                <div style="padding:0.7rem 0; font-size:0.875rem;">
                    <span style="color:var(--text-secondary);">Catatan</span>
                    <p style="margin-top:0.4rem;">{{ $booking->notes }}</p>
                </div>
                @endif
            </div>
        </div>

        <!-- Update Status -->
        <div class="card">
            <div class="card-header">🔄 Update Status Pesanan</div>
            <div class="card-body">
                <form method="POST" action="{{ route('admin.bookings.status', $booking) }}" style="display:flex; gap:1rem; flex-wrap:wrap;">
                    @csrf @method('PATCH')
                    <select name="status" class="form-control" style="flex:1;">
                        @foreach(['pending','confirmed','cancelled','completed'] as $s)
                        <option value="{{ $s }}" {{ $booking->status === $s ? 'selected' : '' }}>
                            {{ ucfirst($s) }}
                        </option>
                        @endforeach
                    </select>
                    <button type="submit" class="btn btn-primary">Update</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Right: Payment -->
    <div>
        @if($booking->payment)
        @php $payment = $booking->payment; @endphp
        <div class="card">
            <div class="card-header" style="display:flex; align-items:center; justify-content:space-between;">
                <span>💳 Pembayaran</span>
                @if($payment->status === 'unpaid') <span class="badge badge-danger">Belum Bayar</span>
                @elseif($payment->status === 'uploaded') <span class="badge badge-warning">Upload Bukti</span>
                @else <span class="badge badge-success">Terverifikasi ✓</span>
                @endif
            </div>
            <div class="card-body">
                <div style="display:flex; justify-content:space-between; margin-bottom:1rem; font-size:0.875rem;">
                    <span style="color:var(--text-secondary);">Jumlah</span>
                    <span style="font-weight:700; color:var(--blue); font-family:'Orbitron',sans-serif;">Rp {{ number_format($payment->amount, 0, ',', '.') }}</span>
                </div>
                <div style="display:flex; justify-content:space-between; margin-bottom:1.5rem; font-size:0.875rem;">
                    <span style="color:var(--text-secondary);">Rekening Tujuan</span>
                    <span>{{ $payment->bank_name }} — {{ $payment->account_number }}</span>
                </div>

                @if($payment->transfer_proof)
                <div style="margin-bottom:1.5rem;">
                    <div style="font-size:0.75rem; color:var(--text-muted); font-weight:600; margin-bottom:0.75rem; text-transform:uppercase; letter-spacing:0.05em;">Bukti Transfer</div>
                    <a href="{{ asset('storage/' . $payment->transfer_proof) }}" target="_blank">
                        <img src="{{ asset('storage/' . $payment->transfer_proof) }}"
                             alt="Bukti Transfer"
                             style="width:100%; border-radius:var(--radius-md); border:1px solid var(--border); cursor:zoom-in;">
                    </a>
                </div>

                @if($payment->status === 'uploaded')
                <form method="POST" action="{{ route('admin.bookings.verify', $booking) }}">
                    @csrf @method('PATCH')
                    <button type="submit" class="btn btn-success" style="width:100%; justify-content:center;"
                            onclick="return confirm('Verifikasi pembayaran dan konfirmasi pesanan?')">
                        ✅ Verifikasi & Konfirmasi Pesanan
                    </button>
                </form>
                @endif
                @else
                <div style="text-align:center; padding:2rem; color:var(--text-muted); font-size:0.875rem;">
                    Bukti transfer belum diupload pelanggan.
                </div>
                @endif

                @if($payment->verified_at)
                <div style="margin-top:1rem; padding:0.75rem; background:rgba(16,185,129,0.1); border-radius:var(--radius-sm); font-size:0.8rem; color:var(--green);">
                    ✅ Diverifikasi pada {{ $payment->verified_at->format('d M Y H:i') }}
                </div>
                @endif
            </div>
        </div>
        @endif
    </div>
</div>
@endsection
