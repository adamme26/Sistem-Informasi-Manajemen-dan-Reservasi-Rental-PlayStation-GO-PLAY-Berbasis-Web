<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$output = "<h1>Migration Script</h1><pre>";

try {
    require __DIR__ . '/../goplay_backend/vendor/autoload.php';
    $app = require_once __DIR__ . '/../goplay_backend/bootstrap/app.php';
    $kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
    
    $status = $kernel->call('migrate', ['--force' => true]);
    $output .= "Artisan migrate output:\n" . \Illuminate\Support\Facades\Artisan::output() . "\n";
} catch (\Exception $e) {
    $output .= "Error running artisan migrate: " . $e->getMessage() . "\n";
}

$output .= "</pre>";
echo $output;
