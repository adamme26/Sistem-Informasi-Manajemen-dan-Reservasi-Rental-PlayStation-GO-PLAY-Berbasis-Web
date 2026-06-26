<?php

namespace App\Notifications;

use App\Models\Booking;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;

class BookingCreatedNotification extends Notification
{
    use Queueable;

    public function __construct(public readonly Booking $booking) {}

    public function via(object $notifiable): array
    {
        return ['mail', 'database'];
    }

    public function toDatabase(object $notifiable): array
    {
        return [
            'title' => 'Pesanan Berhasil',
            'message' => "Booking {$this->booking->console->name} pada {$this->booking->booking_date->format('d M Y')} berhasil dibuat.",
            'url' => route('bookings.show', $this->booking->id),
        ];
    }

    public function toMail(object $notifiable): MailMessage
    {
        $booking = $this->booking;
        $console = $booking->console;
        $payment = $booking->payment;

        return (new MailMessage)
            ->subject("🎮 Pesanan GOPLAY Berhasil - #{$booking->booking_code}")
            ->greeting("Halo, {$notifiable->name}!")
            ->line("Pesanan PlayStation Anda telah berhasil dibuat. Berikut detailnya:")
            ->line("**Kode Booking:** {$booking->booking_code}")
            ->line("**Konsol:** {$console->name} ({$console->type})")
            ->line("**Tanggal:** " . $booking->booking_date->format('d F Y'))
            ->line("**Waktu:** {$booking->start_time} - {$booking->end_time} ({$booking->duration_hours} jam)")
            ->line("**Total:** Rp " . number_format($booking->total_price, 0, ',', '.'))
            ->line("---")
            ->line("**Instruksi Pembayaran:**")
            ->line("Bank: {$payment->bank_name}")
            ->line("No. Rekening: {$payment->account_number}")
            ->line("Atas Nama: {$payment->account_name}")
            ->action('Lihat Detail Pesanan', route('bookings.show', $booking))
            ->line("Segera upload bukti transfer setelah melakukan pembayaran.")
            ->salutation("Terima kasih telah menggunakan GOPLAY! 🕹️");
    }
}
