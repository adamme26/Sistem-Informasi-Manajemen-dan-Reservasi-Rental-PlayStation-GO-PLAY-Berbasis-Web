<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Booking extends Model
{
    protected $fillable = [
        'booking_code', 'user_id', 'console_id', 'booking_date',
        'start_time', 'duration_hours', 'end_time', 'total_price', 'status', 'notes',
    ];

    protected $casts = [
        'booking_date' => 'date',
        'total_price'  => 'decimal:2',
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
}
