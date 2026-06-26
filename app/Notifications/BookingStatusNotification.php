<?php

namespace App\Notifications;

use App\Models\Booking;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;

class BookingStatusNotification extends Notification
{
    use Queueable;

    public function __construct(public readonly Booking $booking) {}

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        $statusLabel = match ($this->booking->status) {
            'confirmed'  => '✅ Dikonfirmasi',
            'cancelled'  => '❌ Dibatalkan',
            'completed'  => '🎮 Selesai',
            default      => '⏳ Pending',
        };

        return [
            'title'   => 'Update Pesanan',
            'message' => "Pesanan #{$this->booking->booking_code} {$statusLabel}",
            'url'     => route('bookings.show', $this->booking),
        ];
    }

    public function toMail(object $notifiable): MailMessage
    {
        $booking = $this->booking;
        $statusLabel = match ($booking->status) {
            'confirmed'  => '✅ Dikonfirmasi',
            'cancelled'  => '❌ Dibatalkan',
            'completed'  => '🎮 Selesai',
            default      => '⏳ Pending',
        };

        return (new MailMessage)
            ->subject("🎮 Update Status Pesanan #{$booking->booking_code}")
            ->greeting("Halo, {$notifiable->name}!")
            ->line("Status pesanan Anda telah diperbarui: **{$statusLabel}**")
            ->line("**Kode Booking:** {$booking->booking_code}")
            ->line("**Konsol:** {$booking->console->name}")
            ->line("**Tanggal:** " . $booking->booking_date->format('d F Y'))
            ->line("**Waktu:** {$booking->start_time} - {$booking->end_time}")
            ->action('Lihat Detail Pesanan', route('bookings.show', $booking))
            ->salutation("Terima kasih telah menggunakan GOPLAY! 🕹️");
    }
}
