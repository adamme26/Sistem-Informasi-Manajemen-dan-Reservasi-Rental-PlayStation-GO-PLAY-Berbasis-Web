<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "Current time: " . now()->format('Y-m-d H:i:s') . "\n";
echo "Active bookings: \n";
$bookings = \App\Models\Booking::latest()->get();
foreach ($bookings as $b) {
    echo "ID: {$b->id}, Console: {$b->console_id}, Date: {$b->booking_date}, Start: {$b->start_time}, End: {$b->end_time}, Status: {$b->status}, Started: {$b->started_at}\n";
}
