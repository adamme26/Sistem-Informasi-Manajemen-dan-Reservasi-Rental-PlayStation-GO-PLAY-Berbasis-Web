<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Console extends Model
{
    protected $fillable = [
        'name', 'type', 'description', 'price_per_hour', 'status', 'image',
    ];

    protected $casts = [
        'price_per_hour' => 'decimal:2',
    ];

    public function bookings(): HasMany
    {
        return $this->hasMany(Booking::class);
    }

    public function isAvailable(): bool
    {
        return $this->status === 'available';
    }

    public function getImageUrlAttribute(): string
    {
        if ($this->image) {
            return asset('storage/' . $this->image);
        }
        return asset('images/default-' . strtolower($this->type) . '.png');
    }

    /**
     * Get booked time slots for a given date
     */
    public function getBookedSlots(string $date): array
    {
        return $this->bookings()
            ->whereDate('booking_date', $date)
            ->whereIn('status', ['pending', 'confirmed'])
            ->get(['start_time', 'end_time', 'duration_hours'])
            ->toArray();
    }

    /**
     * Check if the console is currently booked at this exact time
     */
    public function isCurrentlyBooked(): bool
    {
        $now = now();
        $date = $now->format('Y-m-d');
        $time = $now->format('H:i:s');

        return $this->bookings()
            ->whereDate('booking_date', $date)
            ->whereTime('start_time', '<=', $time)
            ->whereTime('end_time', '>', $time)
            ->whereIn('status', ['pending', 'confirmed'])
            ->exists();
    }
}
