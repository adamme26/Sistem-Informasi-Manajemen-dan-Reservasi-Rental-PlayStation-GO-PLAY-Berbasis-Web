<?php

use App\Http\Controllers\HomeController;
use App\Http\Controllers\ConsoleController;
use App\Http\Controllers\BookingController;
use App\Http\Controllers\Admin\DashboardController as AdminDashboard;
use App\Http\Controllers\Admin\BookingAdminController;
use App\Http\Controllers\Admin\ConsoleAdminController;
use App\Http\Middleware\AdminMiddleware;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\JadwalController;

// Public routes
Route::get('/', [HomeController::class, 'index'])->name('home');


// Auth routes (Breeze)
require __DIR__ . '/auth.php';

// Customer routes (auth required)
Route::middleware('auth')->group(function () {
    Route::get('/dashboard', [BookingController::class, 'dashboard'])->name('dashboard');
    Route::get('/jadwal', [JadwalController::class, 'index'])->name('jadwal.index');
    Route::get('/booking', [BookingController::class, 'bookingIndex'])->name('booking.index');
    Route::post('/notifications/mark-read', [BookingController::class, 'markNotificationsRead'])->name('notifications.read');

    // Bookings
    Route::post('/booking', [BookingController::class, 'store'])->name('bookings.store');
    Route::get('/booking/{booking}', [BookingController::class, 'show'])->name('bookings.show');
    Route::post('/booking/{booking}/proof', [BookingController::class, 'uploadProof'])->name('bookings.proof');
    Route::post('/booking/{booking}/cancel', [BookingController::class, 'cancel'])->name('bookings.cancel');

    // Profile (Breeze)
    Route::get('/profile', [\App\Http\Controllers\ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [\App\Http\Controllers\ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [\App\Http\Controllers\ProfileController::class, 'destroy'])->name('profile.destroy');
});

// Admin auth routes
Route::prefix('admin')->name('admin.')->group(function () {
    Route::get('/login', [\App\Http\Controllers\Admin\Auth\AuthenticatedSessionController::class, 'create'])->name('login');
    Route::post('/login', [\App\Http\Controllers\Admin\Auth\AuthenticatedSessionController::class, 'store'])->name('login.store');
    Route::get('/register', [\App\Http\Controllers\Admin\Auth\RegisteredUserController::class, 'create'])->name('register');
    Route::post('/register', [\App\Http\Controllers\Admin\Auth\RegisteredUserController::class, 'store'])->name('register.store');
    Route::post('/logout', [\App\Http\Controllers\Admin\Auth\AuthenticatedSessionController::class, 'destroy'])->name('logout');
});

// Admin routes
Route::middleware(['auth:admin'])
    ->prefix('admin')
    ->name('admin.')
    ->group(function () {
        Route::get('/', [AdminDashboard::class, 'index'])->name('dashboard');

        // Bookings
        Route::get('/bookings', [BookingAdminController::class, 'index'])->name('bookings.index');
        Route::get('/bookings/{booking}', [BookingAdminController::class, 'show'])->name('bookings.show');
        Route::patch('/bookings/{booking}/status', [BookingAdminController::class, 'updateStatus'])->name('bookings.status');
        Route::patch('/bookings/{booking}/verify-payment', [BookingAdminController::class, 'verifyPayment'])->name('bookings.verify');
        Route::get('/schedule', [BookingAdminController::class, 'schedule'])->name('schedule');

        // Consoles
        Route::resource('/consoles', ConsoleAdminController::class);
    });
