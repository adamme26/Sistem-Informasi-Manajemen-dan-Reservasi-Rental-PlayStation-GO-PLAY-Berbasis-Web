@extends('layouts.admin')
@section('title', 'Jadwal Kalender')

@section('content')
<div class="admin-page">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:2rem;">
        <div style="font-family:'Orbitron',sans-serif; font-size:1.5rem; font-weight:700;">Jadwal Kalender</div>
        <a href="{{ route('admin.bookings.index') }}" class="btn btn-outline btn-sm">Lihat Tabel</a>
    </div>

    <div class="table-card">
        <div class="card-body" style="padding:1.5rem;">
            <div style="display:flex; gap:1.5rem; margin-bottom:1.5rem; flex-wrap:wrap;">
                <div style="display:flex; align-items:center; gap:8px; font-size:0.8rem;">
                    <div style="width:14px; height:14px; border-radius:3px; background:#7C3AED;"></div>
                    <span style="color:var(--text-secondary);">Dikonfirmasi</span>
                </div>
                <div style="display:flex; align-items:center; gap:8px; font-size:0.8rem;">
                    <div style="width:14px; height:14px; border-radius:3px; background:#f59e0b;"></div>
                    <span style="color:var(--text-secondary);">Pending</span>
                </div>
            </div>
            <div id="admin-calendar"></div>
        </div>
    </div>
</div>
@endsection

@push('styles')
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css' rel='stylesheet' />
<style>
    :root {
      --fc-page-bg-color: var(--bg-main);
      --fc-neutral-bg-color: var(--bg-card);
      --fc-neutral-text-color: var(--text-secondary);
      --fc-border-color: var(--border);
      --fc-button-text-color: var(--text-primary);
      --fc-button-bg-color: var(--bg-input);
      --fc-button-border-color: var(--border);
      --fc-button-hover-bg-color: rgba(255,255,255,0.05);
      --fc-button-hover-border-color: var(--border);
      --fc-button-active-bg-color: var(--purple);
      --fc-button-active-border-color: var(--purple);
      --fc-event-bg-color: var(--purple);
      --fc-event-border-color: var(--purple);
      --fc-event-text-color: #fff;
      --fc-today-bg-color: rgba(123,47,247,0.1);
    }
    .fc-theme-standard td, .fc-theme-standard th, .fc-theme-standard .fc-scrollgrid { border-color: var(--border) !important; }
    .fc-col-header-cell-cushion, .fc-timegrid-axis-cushion, .fc-timegrid-slot-label-cushion { color: var(--text-primary) !important; text-decoration: none; font-weight: 500; font-size: 0.85rem; }
    .fc .fc-toolbar-title { color: var(--text-primary); font-family: 'Orbitron', sans-serif; font-weight: 700; }
    .fc .fc-button-primary:not(:disabled).fc-button-active, .fc .fc-button-primary:not(:disabled):active { background-color: var(--purple); border-color: var(--purple); }
    .fc-v-event .fc-event-main { padding: 4px; }
    .fc .fc-timegrid-slot-minor { border-top-style: dashed; }
</style>
@endpush

@push('scripts')
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('admin-calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'timeGridWeek',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        height: 680,
        slotMinTime: '08:00:00',
        slotMaxTime: '24:00:00',
        allDaySlot: false,
        nowIndicator: true,
        slotLabelFormat: { hour: '2-digit', minute: '2-digit', hour12: false },
        eventTimeFormat: { hour: '2-digit', minute: '2-digit', hour12: false },
        events: {!! $events->toJson() !!},
        eventClick: function(info) {
            const p = info.event.extendedProps;
            alert('Kode: ' + p.booking_code + '\nStatus: ' + p.status);
        },
    });
    calendar.render();
});
</script>
@endpush
