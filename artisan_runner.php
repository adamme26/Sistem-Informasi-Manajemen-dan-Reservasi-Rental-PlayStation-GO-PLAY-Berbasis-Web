<?php
// artisan_runner.php
// Place in public_html and hit this URL from browser: portofolio-noval.my.id/artisan_runner.php

$output = "<h1>Setup Script</h1><pre>";

// 1. Run artisan migrate
try {
    require __DIR__ . '/../vendor/autoload.php';
    $app = require_once __DIR__ . '/../bootstrap/app.php';
    $kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
    
    $status = $kernel->call('migrate', ['--force' => true]);
    $output .= "Artisan migrate output:\n" . \Illuminate\Support\Facades\Artisan::output() . "\n";
} catch (\Exception $e) {
    $output .= "Error running artisan migrate: " . $e->getMessage() . "\n";
}

// 2. Run composer require
try {
    // If shell_exec is enabled, we can run composer. Otherwise it might fail.
    putenv('COMPOSER_HOME=' . __DIR__ . '/../.composer');
    $composerOutput = shell_exec("composer require laravel/socialite 2>&1");
    $output .= "\nComposer output:\n" . $composerOutput . "\n";
} catch (\Exception $e) {
    $output .= "Error running composer: " . $e->getMessage() . "\n";
}

$output .= "</pre>";
echo $output;
