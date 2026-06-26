@extends('layouts.app')
@section('title', 'Booking Online — GO PLAY')

@push('styles')
<style>
/* ===================================================
   BOOKING PAGE — Exact match from React component
   =================================================== */

.bk-page { min-height: 100vh; background: transparent; }

/* ---- HERO ---- */
.bk-hero {
    background: linear-gradient(105deg, #100B2E 0%, #1a1240 30%, #3A2F6A 60%, #5B5070 80%, #706876 100%);
    padding: 56px 48px;
    position: relative;
    overflow: hidden;
    min-height: 180px;
    display: flex;
    align-items: center;
}
.bk-hero h1 { font-size: 48px; font-weight: 900; letter-spacing: -1px; color: #fff; margin: 0 0 10px; line-height: 1.1; }
.bk-hero h1 span { color: #7C6FFF; }
.bk-hero p { color: #b0a8c8; font-size: 14px; margin: 0; }

/* ---- BODY ---- */
.bk-body {
    display: grid;
    grid-template-columns: 1fr 380px;
    gap: 24px;
    padding: 28px 48px 64px;
    max-width: 1350px;
    margin: 0 auto;
}

/* ============================================
   STEP 1 — PILIH UNIT
   ============================================ */
.bk-unit-outer {
    background: #07101f;
    border-radius: 30px;
    padding: 18px;
    border: 1px solid rgba(255,255,255,0.05);
    position: relative;
}
.bk-unit-title {
    font-size: 32px;
    font-weight: 800;
    color: #fff;
    margin: 0 0 18px 6px;
    line-height: 1;
}
.bk-unit-inner {
    background: #030d1c;
    border: 1px solid rgba(255,255,255,0.04);
    border-radius: 28px;
    padding: 18px 18px 34px;
}
.bk-console-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 14px;
}
.bk-console-card {
    background: #041328;
    border-radius: 22px;
    border: 1.5px solid rgba(255,255,255,0.06);
    overflow: hidden;
    cursor: pointer;
    transition: all 0.2s ease;
    display: flex;
    flex-direction: column;
    position: relative;
}
.bk-console-card:hover { border-color: #3b82f6; }
.bk-console-card.selected {
    border-color: #3b82f6;
    box-shadow: 0 0 0 2px rgba(59,130,246,0.9);
}
.bk-console-card.disabled { cursor: not-allowed; }
.bk-card-inner { padding: 16px 14px; display: flex; flex-direction: column; }
.bk-card-img {
    width: 100%;
    height: 132px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 10px;
}
.bk-card-img img.ps5 { height: 120px; object-fit: contain; }
.bk-card-img img.ps4 { height: 90px; object-fit: contain; }
.bk-card-name {
    font-size: 13px;
    font-weight: 700;
    color: #fff;
    line-height: 1.4;
    min-height: 38px;
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
}
.bk-card-status {
    font-size: 11px;
    text-align: center;
    margin-top: 6px;
    font-weight: 600;
}
.bk-card-status.available { color: #22c55e; }
.bk-card-status.reserved  { color: #facc15; }
.bk-card-price {
    text-align: center;
    margin-top: 14px;
}
.bk-card-price strong {
    font-size: 18px;
    font-weight: 800;
    color: #fff;
}
.bk-card-price span {
    font-size: 11px;
    color: #60a5fa;
    margin-left: 3px;
}

/* ============================================
   STEP 2 — PILIH TANGGAL
   ============================================ */
.bk-date-outer {
    background: #07101f;
    border-radius: 30px;
    border: 1px solid rgba(255,255,255,0.06);
    padding: 28px;
    box-shadow: 0 0 15px rgba(37,99,235,0.08);
}
.bk-step-head {
    display: flex;
    align-items: center;
    gap: 14px;
    margin-bottom: 28px;
}
.bk-step-emoji { font-size: 26px; line-height: 1; }
.bk-step-label { font-size: 30px; font-weight: 800; color: #fff; line-height: 1; }
.bk-date-layout {
    display: grid;
    grid-template-columns: 1fr auto;
    gap: 24px;
}
.bk-date-pills {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 14px;
    align-content: start;
}
.bk-date-pill {
    height: 88px;
    border-radius: 18px;
    border: 1.5px solid rgba(255,255,255,0.08);
    background: #071426;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.2s;
    gap: 4px;
}
.bk-date-pill:hover { border-color: #60a5fa; background: #0b1b31; }
.bk-date-pill.selected {
    border-color: #3b82f6;
    background: #2563eb;
    box-shadow: 0 0 20px rgba(37,99,235,0.28);
}
.bk-dp-day { font-size: 14px; color: rgba(255,255,255,0.72); }
.bk-dp-label { font-size: 16px; font-weight: 700; color: #fff; }
.bk-date-pill.selected .bk-dp-day { color: #fff; }

/* Calendar */
.bk-mini-cal {
    background: #071426;
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 24px;
    padding: 24px;
}
.bk-cal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 22px; }
.bk-cal-nav {
    background: none; border: none; color: #fff;
    font-size: 22px; cursor: pointer; opacity: 0.8; transition: opacity 0.15s;
    padding: 4px 8px;
}
.bk-cal-nav:hover { opacity: 1; }
.bk-cal-title { font-size: 22px; font-weight: 800; color: #fff; }
.bk-cal-weekrow {
    display: grid; grid-template-columns: repeat(7,1fr);
    text-align: center; font-size: 13px; color: rgba(255,255,255,0.4);
    margin-bottom: 16px;
}
.bk-cal-grid { display: grid; grid-template-columns: repeat(7,1fr); gap: 10px; }
.bk-cal-day {
    height: 38px; width: 38px; margin: 0 auto;
    display: flex; align-items: center; justify-content: center;
    border-radius: 50%; font-size: 15px; color: #fff;
    cursor: pointer; transition: all 0.15s;
}
.bk-cal-day:hover { background: rgba(255,255,255,0.15); }
.bk-cal-day.selected {
    background: #2563eb;
    color: #fff;
    font-weight: 700;
    box-shadow: 0 0 14px rgba(37,99,235,0.4);
}
.bk-cal-day.today { background: rgba(255,255,255,0.1); color: #93c5fd; font-weight: 700; }
.bk-cal-day.empty { cursor: default; color: transparent; pointer-events: none; }

/* ============================================
   STEP 3 — PILIH WAKTU & DURASI
   ============================================ */
.bk-time-outer {
    background: #07101f;
    border-radius: 30px;
    border: 1px solid rgba(255,255,255,0.06);
    padding: 28px;
    box-shadow: 0 0 15px rgba(37,99,235,0.08);
}
.bk-sublabel { font-size: 17px; color: rgba(255,255,255,0.72); margin-bottom: 16px; }
.bk-time-grid {
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    gap: 14px;
    margin-bottom: 0;
}
.bk-time-slot {
    height: 58px;
    border-radius: 16px;
    border: 1.5px solid rgba(255,255,255,0.08);
    background: #071426;
    display: flex; align-items: center; justify-content: center;
    font-size: 16px; color: #fff; cursor: pointer;
    transition: all 0.2s;
}
.bk-time-slot:hover { border-color: #60a5fa; background: #0b1b31; }
.bk-time-slot.selected {
    border-color: #3b82f6;
    background: #2563eb;
    box-shadow: 0 0 20px rgba(37,99,235,0.28);
}
.bk-dur-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 16px;
}
.bk-pay-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
}
.bk-pay-btn {
    background: #071426;
    border: 1.5px solid rgba(255,255,255,0.08);
    border-radius: 16px;
    padding: 16px;
    text-align: center;
    color: rgba(255,255,255,0.72);
    font-size: 16px;
    cursor: pointer;
    transition: all 0.2s;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 8px;
    height: 100px;
}
.bk-pay-btn:hover { border-color: #60a5fa; background: #0b1b31; }
.bk-pay-btn.selected {
    border-color: #3b82f6;
    background: #2563eb;
    color: #fff;
    box-shadow: 0 0 20px rgba(37,99,235,0.28);
}
.bk-pay-icon { font-size: 32px; }
.bk-dur-btn {
    height: 92px;
    border-radius: 20px;
    border: 1.5px solid rgba(255,255,255,0.08);
    background: #071426;
    display: flex; align-items: center; justify-content: center;
    font-size: 22px; font-weight: 800; color: #fff;
    cursor: pointer; transition: all 0.2s;
    font-family: inherit;
}
.bk-dur-btn:hover { border-color: #60a5fa; background: #0b1b31; }
.bk-dur-btn.selected {
    border-color: #3b82f6;
    background: #2563eb;
    box-shadow: 0 0 20px rgba(37,99,235,0.28);
}

/* ============================================
   SIDEBAR — RINGKASAN BOOKING
   ============================================ */
.bk-summary {
    background: #07101f;
    border-radius: 24px;
    border: 1px solid rgba(255,255,255,0.08);
    position: sticky;
    top: 72px;
    height: fit-content;
    overflow: hidden;
    box-shadow: 0 0 20px rgba(37,99,235,0.08);
}
.bk-sum-head {
    padding: 20px 22px;
    border-bottom: 1px solid rgba(255,255,255,0.06);
    display: flex; align-items: center; gap: 10px;
    font-size: 16px; font-weight: 800; color: #fff;
}
.bk-sum-head svg { color: rgba(255,255,255,0.5); }
.bk-sum-body { padding: 22px; }
.bk-sum-console {
    display: flex; gap: 14px; align-items: center;
    margin-bottom: 24px; padding-bottom: 24px;
    border-bottom: 1px solid rgba(255,255,255,0.05);
}
.bk-sum-imgbox {
    width: 72px; height: 64px;
    background: #0d1f38;
    border: 1px solid rgba(255,255,255,0.07);
    border-radius: 12px;
    display: flex; align-items: center; justify-content: center; flex-shrink: 0;
}
.bk-sum-imgbox img { width: 56px; height: 52px; object-fit: contain; }
.bk-sum-cname { font-size: 16px; font-weight: 800; color: #fff; margin-bottom: 4px; }
.bk-sum-csub  { font-size: 11px; color: rgba(255,255,255,0.4); }
.bk-sum-row {
    display: flex; justify-content: space-between; align-items: center;
    padding: 9px 0; border-bottom: 1px solid rgba(255,255,255,0.04);
    font-size: 13px;
}
.bk-sum-row:last-child { border-bottom: none; }
.bk-sum-rlbl { display: flex; align-items: center; gap: 8px; color: rgba(255,255,255,0.6); }
.bk-sum-rval { font-weight: 700; color: #fff; font-size: 13px; }
.bk-sum-total-lbl { font-size: 13px; color: rgba(255,255,255,0.5); margin-bottom: 6px; }
.bk-sum-total-price {
    font-size: 36px; font-weight: 900; color: #60a5fa;
    letter-spacing: -1px; margin-bottom: 22px; line-height: 1;
}
.bk-promo-row { display: flex; gap: 8px; margin-bottom: 14px; }
.bk-promo-input {
    flex: 1; background: #071426;
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 10px; padding: 11px 14px;
    color: #fff; font-size: 13px; outline: none;
    font-family: inherit; transition: border 0.15s;
}
.bk-promo-input::placeholder { color: rgba(255,255,255,0.25); }
.bk-promo-input:focus { border-color: #3b82f6; }
.bk-promo-btn {
    padding: 11px 16px; background: #0d1f38;
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 10px; color: #fff;
    font-size: 13px; font-weight: 600;
    cursor: pointer; font-family: inherit;
    white-space: nowrap; transition: all 0.15s;
}
.bk-promo-btn:hover { background: #142f50; }
.bk-confirm-btn {
    width: 100%; padding: 16px;
    background: linear-gradient(90deg, #2563eb 0%, #4f7fff 100%);
    border: none; border-radius: 14px;
    color: #fff; font-size: 15px; font-weight: 800;
    cursor: pointer; font-family: inherit;
    margin-bottom: 16px; transition: all 0.2s;
    box-shadow: 0 4px 20px rgba(37,99,235,0.35);
    letter-spacing: 0.02em;
}
.bk-confirm-btn:hover {
    transform: translateY(-1px);
    box-shadow: 0 6px 28px rgba(37,99,235,0.55);
}
.bk-note {
    display: flex; align-items: start; gap: 8px;
    color: rgba(255,255,255,0.35); font-size: 11px; line-height: 1.5;
    background: rgba(255,255,255,0.03); border-radius: 10px;
    padding: 12px; border: 1px solid rgba(255,255,255,0.05);
}
.bk-note svg { flex-shrink: 0; margin-top: 1px; }

@media (max-width: 1100px) {
    .bk-body { grid-template-columns: 1fr; padding: 20px; }
    .bk-hero { padding: 40px 24px 48px; }
    .bk-console-grid { grid-template-columns: repeat(3,1fr); }
    .bk-summary { position: static; }
    .bk-date-layout { grid-template-columns: 1fr; }
    .bk-date-pills { grid-template-columns: repeat(4,1fr); }
}
@media (max-width: 680px) {
    .bk-console-grid { grid-template-columns: repeat(2,1fr); }
    .bk-time-grid { grid-template-columns: repeat(4,1fr); }
    .bk-dur-grid { grid-template-columns: repeat(3,1fr); }
    .bk-pay-grid { grid-template-columns: repeat(1,1fr); }
}
</style>
@endpush

@section('content')
<div class="bk-page">

    {{-- ===== HERO ===== --}}
    <div class="bk-hero">
        <div style="position:relative;z-index:2;flex:1;">
            <h1>Booking <span>Online</span></h1>
            <p>Pilih unit, tanggal dan waktu bermain favoritmu.</p>
        </div>
    </div>

    <form action="{{ route('bookings.store') }}" method="POST" id="bookingForm">
    @csrf

    {{-- Server-side validation errors --}}
    @if($errors->any())
    <div style="max-width:900px; margin: 0 auto 1.5rem auto; background:rgba(239,68,68,0.12); border:1px solid rgba(239,68,68,0.4); border-radius:12px; padding:1rem 1.5rem;">
        <div style="font-weight:600; color:#ef4444; margin-bottom:0.5rem;">⚠️ Ada kesalahan pada formulir Anda:</div>
        <ul style="margin:0; padding-left:1.2rem; color:#fca5a5; font-size:0.9rem;">
            @foreach($errors->all() as $error)
            <li>{{ $error }}</li>
            @endforeach
        </ul>
    </div>
    @endif

    <div class="bk-body">

        {{-- ======== LEFT COLUMN ======== --}}
        <div style="display:flex;flex-direction:column;gap:20px;">

            {{-- ===== STEP 1: PILIH UNIT ===== --}}
            <div class="bk-unit-outer">
                <div class="bk-unit-title">1. Pilih Unit</div>
                <div class="bk-unit-inner">
                    <div class="bk-console-grid">
                        @foreach($consoles as $console)
                        @php
                            $isMaintenance = strtolower($console->status) === 'maintenance';
                            $price  = $console->price_per_hour;
                            $isPs5  = str_contains(strtolower($console->name), 'ps5');
                            $imgKey = $isPs5 ? 'ps5' : 'ps4';
                        @endphp
                        <div class="bk-console-card {{ $isMaintenance ? 'disabled' : '' }}"
                             data-console-id="{{ $console->id }}"
                             data-console-name="{{ $console->name }}"
                             data-console-price="{{ $price }}"
                             data-console-img="{{ $imgKey }}"
                             data-is-maintenance="{{ $isMaintenance ? 'true' : 'false' }}"
                             onclick="handleConsoleClick({{ $console->id }}, '{{ addslashes($console->name) }}', {{ $price }}, '{{ $imgKey }}', this)">
                            <div class="bk-card-inner">
                                <div class="bk-card-img">
                                    <img src="{{ asset('images/'.$imgKey.'.png?v=5') }}"
                                         alt="{{ $console->name }}"
                                         class="{{ $isPs5 ? 'ps5' : 'ps4' }}">
                                </div>
                                <div class="bk-card-name">{{ $console->name }}</div>
                                <div class="bk-card-status" data-status-label
                                     style="{{ $isMaintenance ? 'color:#ef4444;' : 'color:#22c55e;' }}">
                                    {{ $isMaintenance ? '● Maintenance' : '● Tersedia' }}
                                </div>
                                <div class="bk-card-price">
                                    <strong>Rp {{ number_format($price, 0, ',', '.') }}</strong>
                                    <span>/jam</span>
                                </div>
                            </div>
                        </div>
                        @endforeach
                    </div>
                </div>
                <input type="hidden" name="console_id" id="consoleInput" value="{{ old('console_id') }}">
            </div>

            {{-- ===== STEP 2: PILIH TANGGAL ===== --}}
            <div class="bk-date-outer">
                <div class="bk-step-head">
                    <span class="bk-step-emoji">📅</span>
                    <span class="bk-step-label">2. Pilih Tanggal</span>
                </div>
                <div class="bk-date-layout">
                    {{-- Date pills --}}
                    <div class="bk-date-pills" id="datePills">
                        @php
                            $today    = \Carbon\Carbon::today();
                            $dayNames = ['Min','Sen','Sel','Rab','Kam','Jum','Sab'];
                            $months   = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
                        @endphp
                        @for($i = 0; $i < 7; $i++)
                        @php
                            $d      = $today->copy()->addDays($i);
                            $ds     = $d->format('Y-m-d');
                            $dayLbl = $dayNames[$d->dayOfWeek];
                            $monLbl = $d->day . ' ' . $months[$d->month - 1];
                        @endphp
                        <div class="bk-date-pill {{ $i === 0 ? 'selected' : '' }}"
                             onclick="selectDate('{{ $ds }}', this)"
                             data-date="{{ $ds }}">
                            <span class="bk-dp-day">{{ $dayLbl }}</span>
                            <span class="bk-dp-label">{{ $monLbl }}</span>
                        </div>
                        @endfor
                    </div>

                    {{-- Mini Calendar --}}
                    <div class="bk-mini-cal">
                        <div class="bk-cal-header">
                            <button type="button" class="bk-cal-nav" onclick="changeMonth(-1)">←</button>
                            <span class="bk-cal-title" id="calTitle"></span>
                            <button type="button" class="bk-cal-nav" onclick="changeMonth(1)">→</button>
                        </div>
                        <div class="bk-cal-weekrow">
                            <div>Min</div><div>Sen</div><div>Sel</div><div>Rab</div><div>Kam</div><div>Jum</div><div>Sab</div>
                        </div>
                        <div class="bk-cal-grid" id="calGrid"></div>
                    </div>
                </div>
                <input type="hidden" name="booking_date" id="dateInput" value="{{ old('booking_date', date('Y-m-d')) }}">
            </div>

            {{-- ===== STEP 3: PILIH WAKTU & DURASI ===== --}}
            <div class="bk-time-outer">
                <div class="bk-step-head">
                    <span class="bk-step-emoji">🕒</span>
                    <span class="bk-step-label">3. Pilih Waktu &amp; Durasi</span>
                </div>

                <div class="bk-sublabel">Pilih Waktu Mulai</div>
                <div class="bk-time-grid" style="margin-bottom:28px;">
                    @php $hours = ['01:00','02:00','03:00','04:00','05:00','06:00','07:00','08:00','09:00','10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00','19:00','20:00','21:00','22:00','23:00','00:00']; @endphp
                    @foreach($hours as $hStr)
                    @php $hVal = $hStr . ':00'; @endphp
                    <div class="bk-time-slot {{ old('start_time') == $hVal ? 'selected' : '' }}"
                         data-time="{{ $hVal }}"
                         onclick="selectTime('{{ $hVal }}', '{{ $hStr }}', this)">
                        {{ $hStr }}
                    </div>
                    @endforeach
                </div>

                <div class="bk-sublabel" style="margin-top:16px;">Durasi Bermain</div>
                <div class="bk-dur-grid">
                    @foreach([1,2,3,4,5] as $dur)
                    <div class="bk-dur-btn {{ (old('duration') == $dur) ? 'selected' : '' }}"
                         onclick="selectDuration({{ $dur }}, this)">
                        {{ $dur }} Jam
                    </div>
                    @endforeach
                </div>
                <input type="hidden" name="start_time" id="timeInput" value="{{ old('start_time') }}">
                <input type="hidden" name="duration"   id="durationInput" value="{{ old('duration') }}">
            </div>

            {{-- ===== STEP 4: METODE PEMBAYARAN ===== --}}
            <div class="bk-step-head" style="margin-top: 32px;">
                <span class="bk-step-emoji">💳</span>
                <span class="bk-step-label">4. Metode Pembayaran</span>
            </div>
            <div class="bk-pay-grid" style="margin-bottom:28px;">
                <div class="bk-pay-btn {{ old('payment_method') == 'Bank BCA' ? 'selected' : '' }}" onclick="selectPayment('Bank BCA', this)">
                    <span class="bk-pay-icon">🏦</span>
                    <span>Bank BCA</span>
                </div>
                <div class="bk-pay-btn {{ old('payment_method') == 'GoPay' ? 'selected' : '' }}" onclick="selectPayment('GoPay', this)">
                    <span class="bk-pay-icon">📱</span>
                    <span>GoPay</span>
                </div>
                <div class="bk-pay-btn {{ old('payment_method') == 'QRIS' ? 'selected' : '' }}" onclick="selectPayment('QRIS', this)">
                    <span class="bk-pay-icon">🟩</span>
                    <span>QRIS</span>
                </div>
            </div>
            <input type="hidden" name="payment_method" id="paymentInput" value="{{ old('payment_method') }}">
            @error('payment_method')
            <div class="form-error" style="color:#ef4444; font-size:0.875rem; margin-top:8px;">Silakan pilih metode pembayaran.</div>
            @enderror

        </div>

        {{-- ======== SIDEBAR SUMMARY ======== --}}
        <div>
            <div class="bk-summary">
                <div class="bk-sum-head">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/>
                        <line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/>
                    </svg>
                    Ringkasan Booking
                </div>
                <div class="bk-sum-body">
                    <div class="bk-sum-console">
                        <div class="bk-sum-imgbox">
                            <img src="{{ asset('images/ps5.png?v=5') }}" alt="console" id="summaryImg">
                        </div>
                        <div>
                            <div class="bk-sum-cname" id="summaryName">Pilih Unit Dulu</div>
                            <div class="bk-sum-csub"  id="summaryType">Silakan pilih konsol</div>
                        </div>
                    </div>

                    <div style="margin-bottom:24px;">
                        <div class="bk-sum-row">
                            <span class="bk-sum-rlbl">📅 Tanggal</span>
                            <span class="bk-sum-rval" id="summaryDate">—</span>
                        </div>
                        <div class="bk-sum-row">
                            <span class="bk-sum-rlbl">🕐 Waktu Mulai</span>
                            <span class="bk-sum-rval" id="summaryStart">—</span>
                        </div>
                        <div class="bk-sum-row">
                            <span class="bk-sum-rlbl">⏳ Durasi</span>
                            <span class="bk-sum-rval" id="summaryDur">—</span>
                        </div>
                        <div class="bk-sum-row">
                            <span class="bk-sum-rlbl">💰 Harga Satuan</span>
                            <span class="bk-sum-rval" id="summaryRate">—</span>
                        </div>
                    </div>

                    <div class="bk-sum-total-lbl">Total Harga</div>
                    <div class="bk-sum-total-price" id="summaryTotal">Rp 0</div>

                    <div class="bk-promo-row">
                        <input type="text" name="promo_code" class="bk-promo-input" placeholder="Masukkan kode promo">
                        <button type="button" class="bk-promo-btn">Gunakan</button>
                    </div>

                    <button type="button" class="bk-confirm-btn" onclick="submitBooking()">🎮 Konfirmasi Booking</button>

                    <div class="bk-note">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/>
                        </svg>
                        <span>Unit akan otomatis dibatalkan jika tidak ada konfirmasi dalam 15 menit.</span>
                    </div>
                </div>
            </div>
        </div>

    </div>
    </form>
</div>

@push('scripts')
<script>
let state = {
    consoleId: null, consoleName: null, consolePrice: 0, consoleImg: 'ps5',
    date: '{{ date("Y-m-d") }}', startTime: null, duration: null
};

// busyConsoleIds: list of console IDs that are Reserved at currently selected date+time
// Populated via AJAX when time is selected
let busyConsoleIds = [];

// -------------------------------------------------------
// Fetch availability from server via AJAX
// Called whenever date or time changes
// -------------------------------------------------------
function fetchAvailability(callback) {
    if (!state.date || !state.startTime) {
        busyConsoleIds = [];
        if (callback) callback();
        return;
    }

    fetch(`/booking/availability?date=${state.date}&start_time=${encodeURIComponent(state.startTime)}`, {
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(r => r.json())
    .then(data => {
        busyConsoleIds = data.busy || [];
        if (callback) callback();
    })
    .catch(() => {
        busyConsoleIds = [];
        if (callback) callback();
    });
}

// -------------------------------------------------------
// updateConsoleGrid: update unit card labels based on
// fresh busyConsoleIds from server
// -------------------------------------------------------
function updateConsoleGrid() {
    document.querySelectorAll('.bk-console-card').forEach(card => {
        const cId = parseInt(card.dataset.consoleId);
        const isMaintenance = card.dataset.isMaintenance === 'true';
        const statusLabel = card.querySelector('[data-status-label]');
        if (!statusLabel || isMaintenance) return;

        // No time selected → all Tersedia
        if (!state.startTime) {
            card.classList.remove('disabled');
            statusLabel.textContent = '● Tersedia';
            statusLabel.style.color = '#22c55e';
            return;
        }

        const isReserved = busyConsoleIds.includes(cId);

        if (isReserved) {
            card.classList.add('disabled');
            statusLabel.textContent = '● Reserved';
            statusLabel.style.color = '#facc15';
            // Auto-deselect if this was the chosen unit
            if (card.classList.contains('selected')) {
                card.classList.remove('selected');
                state.consoleId    = null;
                state.consoleName  = null;
                state.consolePrice = 0;
                document.getElementById('consoleInput').value = '';
                document.getElementById('summaryImg').src = '/images/ps5.png?v=5';
                document.getElementById('summaryName').textContent = 'Pilih Unit Dulu';
                document.getElementById('summaryType').textContent = 'Silakan pilih konsol';
                document.getElementById('summaryRate').textContent = '—';
                updateTotal();
            }
        } else {
            card.classList.remove('disabled');
            statusLabel.textContent = '● Tersedia';
            statusLabel.style.color = '#22c55e';
        }
    });
}

// -------------------------------------------------------
// handleConsoleClick: HTML onclick handler on each card
// -------------------------------------------------------
function handleConsoleClick(id, name, price, img, el) {
    if (el.dataset.isMaintenance === 'true') {
        alert('Unit ini sedang Maintenance.');
        return;
    }
    if (busyConsoleIds.includes(id)) {
        const jam = state.startTime ? state.startTime.substring(0, 5) : '';
        alert('Unit ini sudah dipesan pada jam ' + jam + '. Silakan pilih jam atau unit lain.');
        return;
    }
    selectConsole(id, name, price, img, el);
}

// -------------------------------------------------------
// submitBooking: client-side validation before submit
// -------------------------------------------------------
function submitBooking() {
    const errors = [];
    if (!state.consoleId) errors.push('Silakan pilih unit PlayStation.');
    if (!state.date)      errors.push('Silakan pilih tanggal.');
    if (!state.startTime) errors.push('Silakan pilih waktu mulai.');
    if (!state.duration)  errors.push('Silakan pilih durasi bermain.');
    const payment = document.getElementById('paymentInput').value;
    if (!payment)         errors.push('Silakan pilih metode pembayaran.');

    if (errors.length > 0) {
        alert('Lengkapi data berikut:\n\n' + errors.join('\n'));
        return;
    }

    // Final conflict check using busyConsoleIds (fresh from server)
    if (busyConsoleIds.includes(state.consoleId)) {
        alert('Maaf, unit yang Anda pilih sudah dipesan pada jam tersebut.\nSilakan pilih jam atau unit lain.');
        return;
    }

    document.getElementById('bookingForm').submit();
}

// -------------------------------------------------------
// selectConsole
// -------------------------------------------------------
function selectConsole(id, name, price, img, el) {
    state.consoleId = id; state.consoleName = name;
    state.consolePrice = price; state.consoleImg = img;
    document.getElementById('consoleInput').value = id;
    document.querySelectorAll('.bk-console-card').forEach(c => c.classList.remove('selected'));
    el.classList.add('selected');
    document.getElementById('summaryImg').src = `/images/${img}.png?v=5`;
    document.getElementById('summaryName').textContent = name;
    document.getElementById('summaryType').textContent = img === 'ps5' ? 'Next Generation Gaming' : 'The Gaming Experience';
    document.getElementById('summaryRate').textContent = 'Rp ' + price.toLocaleString('id-ID') + ' /jam';
    updateTotal();
}

// -------------------------------------------------------
// selectDate: update date state and refresh slots + grid
// -------------------------------------------------------
function selectDate(dateStr, el) {
    state.date = dateStr;
    document.getElementById('dateInput').value = dateStr;
    document.querySelectorAll('.bk-date-pill').forEach(p => p.classList.remove('selected'));
    if (el) el.classList.add('selected');
    const d = new Date(dateStr + 'T00:00:00');
    const days   = ['Minggu','Senin','Selasa','Rabu','Kamis','Jumat','Sabtu'];
    const months = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
    document.getElementById('summaryDate').textContent =
        `${days[d.getDay()]}, ${d.getDate()} ${months[d.getMonth()]} ${d.getFullYear()}`;
    updateTimeSlots();
    // If a time was already selected, refresh availability for new date
    if (state.startTime) {
        fetchAvailability(updateConsoleGrid);
    } else {
        updateConsoleGrid();
    }
    renderCalendar();
}

// -------------------------------------------------------
// selectTime: called when user clicks a time slot
// → fetch real-time availability from server → update grid
// -------------------------------------------------------
function selectTime(timeVal, timeStr, el) {
    state.startTime = timeVal;
    document.getElementById('timeInput').value = timeVal;
    document.querySelectorAll('.bk-time-slot').forEach(t => t.classList.remove('selected'));
    el.classList.add('selected');
    document.getElementById('summaryStart').textContent = timeStr + ' WIB';

    // Show loading state on cards
    document.querySelectorAll('.bk-console-card').forEach(card => {
        if (card.dataset.isMaintenance === 'true') return;
        const lbl = card.querySelector('[data-status-label]');
        if (lbl) { lbl.textContent = '⏳ Cek...'; lbl.style.color = '#94a3b8'; }
    });

    // Fetch from server and update grid
    fetchAvailability(updateConsoleGrid);
}

// -------------------------------------------------------
// selectDuration
// -------------------------------------------------------
function selectDuration(d, el) {
    document.querySelectorAll('.bk-dur-btn').forEach(btn => btn.classList.remove('selected'));
    if (el) el.classList.add('selected');
    state.duration = d;
    document.getElementById('durationInput').value = d;
    document.getElementById('summaryDur').textContent = d + ' Jam';
    updateTotal();
}

function selectPayment(method, el) {
    document.querySelectorAll('.bk-pay-btn').forEach(btn => btn.classList.remove('selected'));
    if (el) el.classList.add('selected');
    document.getElementById('paymentInput').value = method;
}

function updateTotal() {
    const dur   = state.duration || 0;
    const total = state.consolePrice * dur;
    document.getElementById('summaryTotal').textContent = 'Rp ' + total.toLocaleString('id-ID');
}

// -------------------------------------------------------
// Disable past time slots for TODAY only
// -------------------------------------------------------
function updateTimeSlots() {
    const now = new Date();
    const selectedDate = new Date(state.date + 'T00:00:00');
    const isToday = selectedDate.toDateString() === now.toDateString();
    const currentHour = now.getHours();

    document.querySelectorAll('.bk-time-slot').forEach(slot => {
        const slotHour = parseInt(slot.textContent.trim().split(':')[0], 10);
        // For midnight (00:00), treat as hour 0 = always in "past" when today
        const isPast = isToday && slotHour <= currentHour;

        if (isPast) {
            slot.classList.add('disabled');
            slot.style.opacity = '0.2';
            slot.style.pointerEvents = 'none';
            if (slot.classList.contains('selected')) {
                slot.classList.remove('selected');
                state.startTime = null;
                busyConsoleIds = [];
                document.getElementById('timeInput').value = '';
                document.getElementById('summaryStart').textContent = '—';
                updateConsoleGrid();
            }
        } else {
            slot.classList.remove('disabled');
            slot.style.opacity = '1';
            slot.style.pointerEvents = 'auto';
        }
    });
}

// -------------------------------------------------------
// Mini Calendar
// -------------------------------------------------------
let calYear = new Date().getFullYear(), calMonth = new Date().getMonth();
const mNames = ['Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember'];

function renderCalendar() {
    document.getElementById('calTitle').textContent = mNames[calMonth] + ' ' + calYear;
    const grid = document.getElementById('calGrid');
    grid.innerHTML = '';
    const firstDay    = new Date(calYear, calMonth, 1).getDay();
    const daysInMonth = new Date(calYear, calMonth + 1, 0).getDate();
    const today = new Date();
    for (let i = 0; i < firstDay; i++) {
        const e = document.createElement('div');
        e.className = 'bk-cal-day empty';
        grid.appendChild(e);
    }
    for (let d = 1; d <= daysInMonth; d++) {
        const cell = document.createElement('div');
        cell.className = 'bk-cal-day';
        cell.textContent = d;
        const ds = `${calYear}-${String(calMonth+1).padStart(2,'0')}-${String(d).padStart(2,'0')}`;
        if (d === today.getDate() && calMonth === today.getMonth() && calYear === today.getFullYear())
            cell.classList.add('today');
        if (ds === state.date) cell.classList.add('selected');
        cell.onclick = () => {
            selectDate(ds, null);
            document.querySelectorAll('.bk-date-pill').forEach(p => {
                p.classList.remove('selected');
                if (p.dataset.date === ds) p.classList.add('selected');
            });
        };
        grid.appendChild(cell);
    }
}
function changeMonth(dir) {
    calMonth += dir;
    if (calMonth > 11) { calMonth = 0; calYear++; }
    if (calMonth < 0)  { calMonth = 11; calYear--; }
    renderCalendar();
}
renderCalendar();

// -------------------------------------------------------
// Init on page load
// -------------------------------------------------------
document.addEventListener('DOMContentLoaded', () => {
    const td = new Date();
    const days   = ['Minggu','Senin','Selasa','Rabu','Kamis','Jumat','Sabtu'];
    const months = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
    document.getElementById('summaryDate').textContent =
        `${days[td.getDay()]}, ${td.getDate()} ${months[td.getMonth()]} ${td.getFullYear()}`;

    // Restore state from hidden inputs (back-from-error scenario)
    const savedConsoleId = document.getElementById('consoleInput').value;
    const savedDate      = document.getElementById('dateInput').value;
    const savedTime      = document.getElementById('timeInput').value;
    const savedDuration  = document.getElementById('durationInput').value;
    const savedPayment   = document.getElementById('paymentInput').value;

    if (savedDate) {
        state.date = savedDate;
        const d = new Date(savedDate + 'T00:00:00');
        document.getElementById('summaryDate').textContent =
            `${days[d.getDay()]}, ${d.getDate()} ${months[d.getMonth()]} ${d.getFullYear()}`;
    }
    if (savedTime) {
        state.startTime = savedTime;
        document.getElementById('summaryStart').textContent = savedTime.substring(0, 5) + ' WIB';
    }
    if (savedDuration) {
        state.duration = parseInt(savedDuration);
        document.getElementById('summaryDur').textContent = savedDuration + ' Jam';
    }
    if (savedPayment) {
        document.querySelectorAll('.bk-pay-btn').forEach(btn => {
            if (btn.textContent.trim().includes(savedPayment)) btn.classList.add('selected');
        });
    }

    updateTimeSlots();

    // -------------------------------------------------------
    // AUTO-SELECT dari URL params & jam sekarang
    // -------------------------------------------------------
    const urlParams    = new URLSearchParams(window.location.search);
    const urlConsoleId = urlParams.get('console_id'); // dari "Booking Sekarang" di Status Unit
    const urlType      = urlParams.get('type');       // dari "Booking PS4/PS5" di halaman utama

    // Hitung jam default: sekarang + 1
    const nowHour     = new Date().getHours();
    const defaultHour = nowHour + 1 <= 23 ? nowHour + 1 : nowHour;
    const defaultTimeStr = String(defaultHour).padStart(2, '0') + ':00';

    // Helper: pilih slot waktu default lalu select unit
    function autoSetTimeAndSelectCard(targetCard) {
        if (!targetCard) return;

        if (!state.startTime) {
            // Cari slot jam sekarang+1, atau fallback ke slot tersedia pertama
            const allSlots   = Array.from(document.querySelectorAll('.bk-time-slot'));
            const matchSlot  = allSlots.find(s => s.dataset.time && s.dataset.time.startsWith(defaultTimeStr));
            const chosenSlot = (matchSlot && !matchSlot.classList.contains('disabled'))
                ? matchSlot
                : allSlots.find(s => !s.classList.contains('disabled')) || null;

            if (chosenSlot) {
                selectTime(chosenSlot.dataset.time, chosenSlot.textContent.trim(), chosenSlot);
            }

            // Fetch ulang ketersediaan unit setelah waktu dipilih
            fetchAvailability(() => {
                updateConsoleGrid();
                if (!targetCard.classList.contains('disabled')) {
                    selectConsole(
                        parseInt(targetCard.dataset.consoleId),
                        targetCard.dataset.consoleName,
                        parseInt(targetCard.dataset.consolePrice),
                        targetCard.dataset.consoleImg,
                        targetCard
                    );
                    targetCard.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            });
        } else {
            if (!targetCard.classList.contains('disabled')) {
                selectConsole(
                    parseInt(targetCard.dataset.consoleId),
                    targetCard.dataset.consoleName,
                    parseInt(targetCard.dataset.consolePrice),
                    targetCard.dataset.consoleImg,
                    targetCard
                );
                targetCard.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }
    }

    // Fetch real-time availability → update grid → auto-select
    fetchAvailability(() => {
        updateConsoleGrid();

        // Priority 1: Restore saved console (kembali dari error validasi)
        if (savedConsoleId) {
            const card = document.querySelector(`.bk-console-card[data-console-id="${savedConsoleId}"]`);
            if (card && !card.classList.contains('disabled')) {
                selectConsole(parseInt(savedConsoleId), card.dataset.consoleName,
                    parseInt(card.dataset.consolePrice), card.dataset.consoleImg, card);
            }
            return;
        }

        // Priority 2: console_id dari URL → dari tombol "Booking Sekarang" di Status Unit
        if (urlConsoleId) {
            const card = document.querySelector(`.bk-console-card[data-console-id="${urlConsoleId}"]`);
            autoSetTimeAndSelectCard(card);
            return;
        }

        // Priority 3: type dari URL → dari tombol "Booking PS4/PS5" di halaman utama
        // Pilih unit tersedia dengan harga TERENDAH dari tipe tersebut
        if (urlType) {
            const allCards = Array.from(document.querySelectorAll('.bk-console-card'));
            const candidates = allCards.filter(c =>
                c.dataset.consoleImg === urlType &&
                !c.classList.contains('disabled') &&
                c.dataset.isMaintenance !== 'true'
            );
            if (candidates.length > 0) {
                const cheapest = candidates.reduce((prev, curr) =>
                    parseInt(curr.dataset.consolePrice) < parseInt(prev.dataset.consolePrice) ? curr : prev
                );
                autoSetTimeAndSelectCard(cheapest);
            }
        }
    });
});
</script>
@endpush
@endsection
