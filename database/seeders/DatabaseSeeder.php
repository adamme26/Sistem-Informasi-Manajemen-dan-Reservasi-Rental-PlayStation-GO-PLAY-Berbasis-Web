<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Admin;
use App\Models\Console;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Admin Backend (Untuk login panel admin)
        Admin::firstOrCreate(['email' => 'admin@goplay.id'], [
            'name'     => 'Admin GOPLAY',
            'password' => 'admin123',
        ]);

        // Admin Frontend (Opsional, jika dibutuhkan di tabel users)
        User::firstOrCreate(['email' => 'admin@goplay.id'], [
            'name'     => 'Admin GOPLAY',
            'phone'    => '081234567890',
            'role'     => 'admin',
            'password' => Hash::make('admin123'),
        ]);

        // Demo customer
        User::firstOrCreate(['email' => 'customer@goplay.id'], [
            'name'     => 'Noval',
            'phone'    => '081298765432',
            'role'     => 'customer',
            'password' => Hash::make('password'),
        ]);

        // 12 consoles — sesuai desain Figma (3 baris x 4 kategori = 12, wait, 3 kolom x 4 baris = 12 unit)
        $consoles = [
            // Group 1: PS4 Reguler
            ['name' => 'PS4 REGULER 1', 'type' => 'PS4', 'price_per_hour' => 10000, 'description' => 'PlayStation 4 dengan library game lengkap dan DualShock 4.'],
            ['name' => 'PS4 REGULER 2', 'type' => 'PS4', 'price_per_hour' => 10000, 'description' => 'PlayStation 4 dengan library game lengkap dan DualShock 4.'],
            ['name' => 'PS4 REGULER 3', 'type' => 'PS4', 'price_per_hour' => 10000, 'description' => 'PlayStation 4 dengan library game lengkap dan DualShock 4.'],

            // Group 2: PS5 Reguler
            ['name' => 'PS5 REGULER 1', 'type' => 'PS5', 'price_per_hour' => 15000, 'description' => 'PlayStation 5 SSD ultra-cepat, DualSense haptic feedback, 4K gaming.'],
            ['name' => 'PS5 REGULER 2', 'type' => 'PS5', 'price_per_hour' => 15000, 'description' => 'PlayStation 5 SSD ultra-cepat, DualSense haptic feedback, 4K gaming.'],
            ['name' => 'PS5 REGULER 3', 'type' => 'PS5', 'price_per_hour' => 15000, 'description' => 'PlayStation 5 SSD ultra-cepat, DualSense haptic feedback, 4K gaming.'],

            // Group 3: PS4 Room
            ['name' => 'PS4 ROOM 1', 'type' => 'PS4', 'price_per_hour' => 20000, 'description' => 'PS4 Room privat dengan kenyamanan ekstra.'],
            ['name' => 'PS4 ROOM 2', 'type' => 'PS4', 'price_per_hour' => 20000, 'description' => 'PS4 Room privat dengan kenyamanan ekstra.'],
            ['name' => 'PS4 ROOM 3', 'type' => 'PS4', 'price_per_hour' => 20000, 'description' => 'PS4 Room privat dengan kenyamanan ekstra.'],

            // Group 4: PS5 Room
            ['name' => 'PS5 ROOM 1', 'type' => 'PS5', 'price_per_hour' => 25000, 'description' => 'PS5 Room privat dengan kenyamanan ekstra dan audio premium.'],
            ['name' => 'PS5 ROOM 2', 'type' => 'PS5', 'price_per_hour' => 25000, 'description' => 'PS5 Room privat dengan kenyamanan ekstra dan audio premium.'],
            ['name' => 'PS5 ROOM 3', 'type' => 'PS5', 'price_per_hour' => 25000, 'description' => 'PS5 Room privat dengan kenyamanan ekstra dan audio premium.'],

            // Group 5: PS5 VIP Room
            ['name' => 'PS5 VIP ROOM 1', 'type' => 'PS5', 'price_per_hour' => 35000, 'description' => 'PS5 VIP Room premium dengan fasilitas eksklusif.'],
            ['name' => 'PS5 VIP ROOM 2', 'type' => 'PS5', 'price_per_hour' => 35000, 'description' => 'PS5 VIP Room premium dengan fasilitas eksklusif.'],
            ['name' => 'PS5 VIP ROOM 3', 'type' => 'PS5', 'price_per_hour' => 35000, 'description' => 'PS5 VIP Room premium dengan fasilitas eksklusif.'],
        ];

        foreach ($consoles as $data) {
            Console::firstOrCreate(
                ['name' => $data['name']],
                [
                    'type'           => $data['type'],
                    'description'    => $data['description'],
                    'price_per_hour' => $data['price_per_hour'],
                    'status'         => 'available',
                ]
            );
        }
    }
}
