@extends('layouts.app')
@section('title', 'Jadwal Unit — GO PLAY')

@section('content')
@push('styles')
<meta http-equiv="refresh" content="60">
<style>
    .schedule-page { padding: 24px 32px; font-family: 'Inter', sans-serif; }
    .schedule-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px; flex-wrap: wrap; gap: 12px; }
    .schedule-title { font-size: 32px; font-weight: 800; color: #fff; margin-bottom: 4px; }
    .schedule-sub { color: #9CA3AF; font-size: 14px; }

    .schedule-date-nav {
        display: flex; align-items: center; gap: 16px;
        font-size: 20px; font-weight: 700; color: #fff;
    }
    
    .schedule-legend {
        display: flex; gap: 20px; flex-wrap: wrap;
        font-size: 13px; color: #D1D5DB;
    }
    .legend-item { display: flex; align-items: center; gap: 8px; }
    .legend-dot { width: 12px; height: 12px; border-radius: 50%; }
    .legend-available { background: #358356; }
    .legend-booked { background: #fbbf24; }
    .legend-done { background: #cbd5e1; }
    .legend-maint { background: #ef4444; }

    .schedule-table-wrap {
        overflow-x: auto;
        background: #11111a;
        border-radius: 8px;
        border: 1px solid rgba(255,255,255,0.05);
        margin-bottom: 24px;
    }
    .schedule-table {
        width: 100%;
        border-collapse: collapse;
        min-width: 1800px; 
    }
    .schedule-table th {
        background: #181824;
        padding: 16px;
        text-align: center;
        font-weight: 700;
        font-size: 12px;
        color: #fff;
        border-bottom: 1px solid rgba(255,255,255,0.05);
        border-right: 1px solid rgba(255,255,255,0.05);
        white-space: nowrap;
    }
    .schedule-table th:first-child { width: 140px; background: #181824; position: sticky; left: 0; z-index: 10; }
    
    .schedule-table td {
        padding: 4px;
        border-bottom: 1px solid rgba(255,255,255,0.05);
        border-right: 1px solid rgba(255,255,255,0.05);
        height: 50px;
        background: #358356; /* Default available background */
        vertical-align: middle;
        text-align: center;
    }
    .schedule-table td:first-child {
        background: #11111a;
        color: #D1D5DB;
        font-size: 13px;
        position: sticky; left: 0; z-index: 10;
        border-right: 1px solid rgba(255,255,255,0.1);
    }
    
    .booking-block {
        border-radius: 6px;
        padding: 4px;
        font-size: 11px;
        line-height: 1.3;
        font-weight: 700;
        color: #000;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 100%;
        height: 100%;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    .booking-block small { font-size: 10px; font-weight: 600; opacity: 0.8; }
    
    .block-booked { background: #fbbf24; } /* Yellow */
    .block-done { background: #cbd5e1; } /* Grey */
    
    .auto-update-text {
        font-size: 12px; color: #6B7280;
    }
</style>
@endpush

<div class="schedule-page">
    <div style="display:flex; justify-content:space-between; align-items:flex-end; margin-bottom: 30px;">
        <div>
            <a href="javascript:history.back()" style="display:inline-flex; align-items:center; justify-content:center; width:36px; height:36px; border-radius:8px; background:rgba(255,255,255,0.05); color:#fff; margin-bottom:16px; text-decoration:none; font-size:20px;">←</a>
            <h1 class="schedule-title">Jadwal Unit</h1>
            <p class="schedule-sub">Lihat jadwal unit yang tersedia dan sudah dibooking</p>
        </div>
    </div>

    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 24px;">
        <div class="schedule-date-nav">
            <span>{{ \Carbon\Carbon::parse($date)->locale('id')->isoFormat('dddd, D MMMM Y') }}</span>
        </div>

        <div class="schedule-legend">
            <div class="legend-item"><div class="legend-dot legend-available"></div> Tersedia</div>
            <div class="legend-item"><div class="legend-dot legend-booked"></div> Dipesan</div>
            <div class="legend-item"><div class="legend-dot legend-done"></div> Selesai</div>
            <div class="legend-item"><div class="legend-dot legend-maint"></div> Maintenance</div>
        </div>
    </div>

    @php
        // Ordered as requested by user
        $orderedNames = [
            'PS4 REGULER 1', 'PS4 REGULER 2', 'PS4 REGULER 3',
            'PS5 REGULER 1', 'PS5 REGULER 2', 'PS5 REGULER 3',
            'PS4 ROOM 1', 'PS4 ROOM 2', 'PS4 ROOM 3',
            'PS5 ROOM 1', 'PS5 ROOM 2', 'PS5 ROOM 3',
            'PS5 VIP ROOM 1', 'PS5 VIP ROOM 2', 'PS5 VIP ROOM 3'
        ];
        
        $orderedConsoles = collect();
        foreach($orderedNames as $name) {
            $c = $consoles->firstWhere('name', $name);
            if($c) $orderedConsoles->push($c);
        }
        // Append any others not in the list
        foreach($consoles as $c) {
            if(!in_array(strtoupper($c->name), $orderedNames)) {
                $orderedConsoles->push($c);
            }
        }

        $timeSlots = [];
        for ($h = 0; $h <= 23; $h++) {
            $startT = sprintf('%02d:00', $h);
            $endT = sprintf('%02d:00', $h + 1 == 24 ? 24 : $h + 1);
            $startVal = sprintf('%02d:00:00', $h);
            $timeSlots[] = [$startT, $endT, $startVal];
        }
    @endphp

    <div class="schedule-table-wrap">
        <table class="schedule-table">
            <thead>
                <tr>
                    <th>Waktu</th>
                    @foreach($orderedConsoles as $console)
                    <th>{{ strtoupper($console->name) }}</th>
                    @endforeach
                </tr>
            </thead>
            <tbody>
                @foreach($timeSlots as [$startT, $endT, $startVal])
                <tr>
                    <td>{{ $startT }} - {{ $endT }}</td>
                    @foreach($orderedConsoles as $console)
                    @php
                        $dateStr = \Carbon\Carbon::parse($date)->format('Y-m-d');
                        $startDt = \Carbon\Carbon::parse($dateStr . ' ' . $startVal);
                        $endDt   = $startDt->copy()->addHour();

                        $booking = $bookings->where('console_id', $console->id)
                            ->first(function($b) use ($startDt, $endDt) {
                                $bDate = \Carbon\Carbon::parse($b->booking_date)->format('Y-m-d');
                                $bs = \Carbon\Carbon::parse($bDate . ' ' . $b->start_time);
                                $be = \Carbon\Carbon::parse($bDate . ' ' . $b->end_time);
                                return $bs < $endDt && $be > $startDt;
                            });

                        $now = \Carbon\Carbon::now();
                        $blockClass = '';
                        $blockText = '';
                        $timeText = '';

                        if ($booking) {
                            $bDate = \Carbon\Carbon::parse($booking->booking_date)->format('Y-m-d');
                            $bs = \Carbon\Carbon::parse($bDate . ' ' . $booking->start_time);
                            $be = \Carbon\Carbon::parse($bDate . ' ' . $booking->end_time);
                            $timeText = $bs->format('H:i') . ' - ' . $be->format('H:i');
                            
                            if ($now > $be) {
                                $blockClass = 'block-done';
                            } else {
                                $blockClass = 'block-booked';
                            }
                            $blockText = $booking->user->name ?? 'Dipesan';
                        }
                    @endphp
                    <td>
                        @if($booking)
                        <div class="booking-block {{ $blockClass }}">
                            {{ Str::limit($blockText, 12) }}<br>
                            <small>{{ $timeText }}</small>
                        </div>
                        @endif
                    </td>
                    @endforeach
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>

    <div class="auto-update-text">
        * Jadwal update otomatis setiap menit
    </div>

</div>

@push('scripts')
<script>
    setTimeout(function(){
        window.location.reload();
    }, 60000);
</script>
@endpush
@endsection
