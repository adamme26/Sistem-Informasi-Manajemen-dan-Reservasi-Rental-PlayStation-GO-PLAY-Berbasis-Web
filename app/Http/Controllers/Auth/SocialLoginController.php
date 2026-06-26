<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Laravel\Socialite\Facades\Socialite;

class SocialLoginController extends Controller
{
    public function redirect($provider)
    {
        return Socialite::driver($provider)->redirect();
    }

    public function callback($provider)
    {
        try {
            $socialUser = Socialite::driver($provider)->user();
        } catch (\Exception $e) {
            return redirect()->route('login')->with('error', 'Login via ' . ucfirst($provider) . ' gagal atau dibatalkan.');
        }

        // Cari apakah user dengan social id ini sudah ada
        $user = User::where($provider . '_id', $socialUser->getId())->first();

        if (!$user) {
            // Jika belum ada by provider_id, cari by email
            $user = User::where('email', $socialUser->getEmail())->first();

            if ($user) {
                // Jika email sudah terdaftar (misal register manual), tautkan ID provider ini
                $user->update([
                    $provider . '_id' => $socialUser->getId(),
                    'avatar' => $user->avatar ?? $socialUser->getAvatar(),
                ]);
            } else {
                // User benar-benar baru, buat akun baru
                $user = User::create([
                    'name' => $socialUser->getName() ?? $socialUser->getNickname() ?? 'Pengguna',
                    'email' => $socialUser->getEmail(),
                    $provider . '_id' => $socialUser->getId(),
                    'avatar' => $socialUser->getAvatar(),
                    'password' => null, // Password nullable di database
                    'role' => 'user',
                    'email_verified_at' => now(), // Anggap email dari Google/FB sudah terverifikasi
                ]);
            }
        }

        Auth::login($user);

        return redirect()->intended('/profile');
    }
}
