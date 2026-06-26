<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class WhatsAppService
{
    public static function send(string $phone, string $message): bool
    {
        $token = config('services.fonnte.token');

        if (!$token || $token === 'your_fonnte_token_here') {
            return false;
        }

        // Normalize phone number (remove +, 0 → 62)
        $phone = preg_replace('/\D/', '', $phone);
        if (str_starts_with($phone, '0')) {
            $phone = '62' . substr($phone, 1);
        }

        try {
            $response = Http::withHeaders([
                'Authorization' => $token,
            ])->post('https://api.fonnte.com/send', [
                'target'  => $phone,
                'message' => $message,
            ]);

            return $response->successful();
        } catch (\Exception $e) {
            return false;
        }
    }
}
