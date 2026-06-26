<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Booking extends Model
{
    protected $fillable = [
        'booking_code', 'user_id', 'console_id', 'booking_date',
        'start_time', 'duration_hours', 'end_time', 'total_price', 'status', 'notes', 'started_at'
    ];

    protected $casts = [
        'booking_date' => 'date',
        'total_price'  => 'decimal:2',
        'started_at'   => 'datetime',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function console(): BelongsTo
    {
        return $this->belongsTo(Console::class);
    }

    public function payment(): HasOne
    {
        return $this->hasOne(Payment::class);
    }

    public function getStatusBadgeAttribute(): string
    {
        if ($this->status === 'confirmed' && $this->started_at) {
            return '<span class="badge" style="background-color: #ef4444; color: white; animation: pulse 2s infinite;">Sedang Bermain</span>';
        }

        return match ($this->status) {
            'pending'   => '<span class="badge badge-warning">Menunggu Konfirmasi</span>',
            'confirmed' => '<span class="badge badge-success">Dikonfirmasi</span>',
            'cancelled' => '<span class="badge badge-danger">Dibatalkan</span>',
            'completed' => '<span class="badge badge-info">Selesai</span>',
            default     => '<span class="badge badge-secondary">' . $this->status . '</span>',
        };
    }

    public static function generateCode(): string
    {
        $year = now()->year;
        $last = static::whereYear('created_at', $year)->count() + 1;
        return 'GP-' . $year . '-' . str_pad($last, 4, '0', STR_PAD_LEFT);
    }

    public function getIsPlayingAttribute(): bool
    {
        return $this->status === 'confirmed' && $this->started_at !== null;
    }

    public function getRemainingSecondsAttribute(): int
    {
        if (!$this->started_at) {
            return $this->duration_hours * 3600;
        }

        $endTime = $this->started_at->copy()->addHours($this->duration_hours);
        $remaining = now()->diffInSeconds($endTime, false);
        return $remaining > 0 ? $remaining : 0;
    }
}
