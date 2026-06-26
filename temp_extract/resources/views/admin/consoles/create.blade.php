@extends('layouts.admin')
@section('title', isset($console) ? 'Edit Konsol' : 'Tambah Konsol')

@section('content')
<div class="admin-header">
    <div>
        <a href="{{ route('admin.consoles.index') }}" style="color:var(--text-secondary); text-decoration:none; font-size:0.875rem; display:inline-flex; align-items:center; gap:6px; margin-bottom:0.5rem;">← Kembali</a>
        <div class="page-title">{{ isset($console) ? 'Edit Konsol' : 'Tambah Konsol Baru' }}</div>
    </div>
</div>

<div class="card" style="max-width:600px;">
    <div class="card-body">
        @if($errors->any())
        <div class="alert alert-danger" style="margin-bottom:1.5rem;">
            <div>@foreach($errors->all() as $e)<div>{{ $e }}</div>@endforeach</div>
        </div>
        @endif

        <form method="POST"
              action="{{ isset($console) ? route('admin.consoles.update', $console) : route('admin.consoles.store') }}"
              enctype="multipart/form-data">
            @csrf
            @if(isset($console)) @method('PUT') @endif

            <div class="form-group">
                <label class="form-label">Nama Konsol *</label>
                <input type="text" name="name" class="form-control" value="{{ old('name', $console->name ?? '') }}" placeholder="Contoh: PS5 Unit 01" required>
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:1rem;">
                <div class="form-group">
                    <label class="form-label">Tipe *</label>
                    <select name="type" class="form-control" required>
                        <option value="PS4" {{ old('type', $console->type ?? '') === 'PS4' ? 'selected' : '' }}>PS4</option>
                        <option value="PS5" {{ old('type', $console->type ?? '') === 'PS5' ? 'selected' : '' }}>PS5</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Status *</label>
                    <select name="status" class="form-control" required>
                        <option value="available" {{ old('status', $console->status ?? 'available') === 'available' ? 'selected' : '' }}>Tersedia</option>
                        <option value="booked" {{ old('status', $console->status ?? '') === 'booked' ? 'selected' : '' }}>Dibooking</option>
                        <option value="maintenance" {{ old('status', $console->status ?? '') === 'maintenance' ? 'selected' : '' }}>Maintenance</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Harga per Jam (Rp) *</label>
                <input type="number" name="price_per_hour" class="form-control" value="{{ old('price_per_hour', $console->price_per_hour ?? '') }}" placeholder="15000" required min="1000">
            </div>

            <div class="form-group">
                <label class="form-label">Deskripsi</label>
                <textarea name="description" class="form-control" rows="4" placeholder="Deskripsi fitur konsol...">{{ old('description', $console->description ?? '') }}</textarea>
            </div>

            <div class="form-group">
                <label class="form-label">Foto Konsol (Opsional)</label>
                <input type="file" name="image" class="form-control" accept="image/*">
                <div style="font-size:0.75rem; color:var(--text-muted); margin-top:4px;">JPG/PNG, maks 2MB</div>
            </div>

            <div style="display:flex; gap:1rem; margin-top:1.5rem;">
                <button type="submit" class="btn btn-primary">
                    {{ isset($console) ? '💾 Simpan Perubahan' : '+ Tambah Konsol' }}
                </button>
                <a href="{{ route('admin.consoles.index') }}" class="btn btn-outline">Batal</a>
            </div>
        </form>
    </div>
</div>
@endsection
