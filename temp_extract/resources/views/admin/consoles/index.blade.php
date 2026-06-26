@extends('layouts.admin')
@section('title', 'Kelola Konsol')

@section('content')
<div class="admin-page">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:2rem;">
        <div style="font-family:'Orbitron',sans-serif; font-size:1.5rem; font-weight:700;">Kelola Konsol</div>
        <a href="{{ route('admin.consoles.create') }}" class="btn btn-primary">+ Tambah Konsol</a>
    </div>

    <div class="table-card">
        <div style="overflow-x:auto;">
            <table class="gp-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nama</th>
                        <th>Tipe</th>
                        <th>Harga/Jam</th>
                        <th>Status</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($consoles as $console)
                    <tr>
                        <td style="color:var(--text-muted); font-size:0.8rem;">{{ $console->id }}</td>
                        <td>
                            <div style="display:flex; align-items:center; gap:0.75rem;">
                                <div class="{{ $console->type === 'PS5' ? 'ps5-bg' : 'ps4-bg' }}" style="width:36px; height:36px; border-radius:8px; display:flex; align-items:center; justify-content:center; font-size:1.2rem; flex-shrink:0;">
                                    {{ $console->type === 'PS5' ? '🎮' : '🕹️' }}
                                </div>
                                <span style="font-weight:500; font-size:0.875rem;">{{ $console->name }}</span>
                            </div>
                        </td>
                        <td><span class="console-type-badge {{ $console->type === 'PS5' ? 'badge-ps5' : 'badge-ps4' }}">{{ $console->type }}</span></td>
                        <td style="color:var(--blue); font-weight:600; font-size:0.875rem;">Rp {{ number_format($console->price_per_hour, 0, ',', '.') }}</td>
                        <td>
                            @if($console->status === 'maintenance')
                            <span class="badge badge-warning">Maintenance</span>
                            @elseif($console->isCurrentlyBooked() || $console->status === 'booked')
                            <span class="badge badge-primary" style="background:rgba(59, 130, 246, 0.2); color:#3b82f6;">Dibooking</span>
                            @else
                            <span class="badge badge-success">Tersedia</span>
                            @endif
                        </td>
                        <td>
                            <div style="display:flex; gap:0.5rem;">
                                <a href="{{ route('admin.consoles.edit', $console) }}" class="btn btn-outline btn-sm">Edit</a>
                                <form method="POST" action="{{ route('admin.consoles.destroy', $console) }}" onsubmit="return confirm('Hapus konsol ini?')">
                                    @csrf @method('DELETE')
                                    <button type="submit" class="btn btn-danger btn-sm">Hapus</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    @empty
                    <tr><td colspan="6" style="text-align:center; color:var(--text-secondary); padding:3rem;">Belum ada konsol</td></tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
    <div style="margin-top:1.5rem;">{{ $consoles->links() }}</div>
</div>
@endsection

@push('scripts')
<script>
    // Auto-refresh halaman setiap 60 detik agar status real-time
    setTimeout(function(){
        window.location.reload();
    }, 60000);
</script>
@endpush
