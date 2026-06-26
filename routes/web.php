<?php

use App\Http\Controllers\HomeController;
use App\Http\Controllers\ConsoleController;
use App\Http\Controllers\BookingController;
use App\Http\Controllers\Admin\DashboardController as AdminDashboard;
use App\Http\Controllers\Admin\BookingAdminController;
use App\Http\Controllers\Admin\ConsoleAdminController;
use App\Http\Controllers\Admin\LaporanController;
use App\Http\Middleware\AdminMiddleware;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\JadwalController;

// Public routes
Route::get('/', [HomeController::class, 'index'])->name('home');


// Auth routes (Breeze)
require __DIR__ . '/auth.php';

// Social Login Routes
Route::get('/auth/{provider}/redirect', [\App\Http\Controllers\Auth\SocialLoginController::class, 'redirect'])->name('social.login');
Route::get('/auth/{provider}/callback', [\App\Http\Controllers\Auth\SocialLoginController::class, 'callback'])->name('social.callback');

// Customer routes (auth required)
Route::middleware('auth')->group(function () {
    Route::get('/dashboard', function () {
        return redirect()->route('profile.edit');
    })->name('dashboard');
    Route::get('/jadwal', [JadwalController::class, 'index'])->name('jadwal.index');
    Route::get('/booking', [BookingController::class, 'bookingIndex'])->name('booking.index');
    Route::post('/notifications/mark-read', [BookingController::class, 'markNotificationsRead'])->name('notifications.read');

    // Bookings
    Route::post('/booking', [BookingController::class, 'store'])->name('bookings.store');
    Route::get('/booking/availability', [BookingController::class, 'availability'])->name('bookings.availability');
    Route::get('/booking/{booking}', [BookingController::class, 'show'])->name('bookings.show');
    Route::post('/booking/{booking}/proof', [BookingController::class, 'uploadProof'])->name('bookings.proof');
    Route::post('/booking/{booking}/cancel', [BookingController::class, 'cancel'])->name('bookings.cancel');
    Route::post('/booking/{booking}/notify-30m', [BookingController::class, 'notifyHalfHour'])->name('bookings.notify-30m');

    // Profile (Breeze)
    Route::get('/profile', [\App\Http\Controllers\ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [\App\Http\Controllers\ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [\App\Http\Controllers\ProfileController::class, 'destroy'])->name('profile.destroy');
});

// Admin auth routes
Route::name('admin.')->group(function () {
    Route::get('/login090506', [\App\Http\Controllers\Admin\Auth\AuthenticatedSessionController::class, 'create'])->name('login');
    Route::post('/login090506', [\App\Http\Controllers\Admin\Auth\AuthenticatedSessionController::class, 'store'])->name('login.store');
    Route::get('/register090506', [\App\Http\Controllers\Admin\Auth\RegisteredUserController::class, 'create'])->name('register');
    Route::post('/register090506', [\App\Http\Controllers\Admin\Auth\RegisteredUserController::class, 'store'])->name('register.store');
    Route::post('/admin-logout090506', [\App\Http\Controllers\Admin\Auth\AuthenticatedSessionController::class, 'destroy'])->name('logout');
});

// Admin routes
Route::middleware(['auth:admin'])
    ->prefix('admin090506')
    ->name('admin.')
    ->group(function () {
        Route::get('/', [AdminDashboard::class, 'index'])->name('dashboard');

        // Bookings
        Route::get('/bookings', [BookingAdminController::class, 'index'])->name('bookings.index');
        Route::get('/bookings/{booking}', [BookingAdminController::class, 'show'])->name('bookings.show');
        Route::patch('/bookings/{booking}/status', [BookingAdminController::class, 'updateStatus'])->name('bookings.status');
        Route::patch('/bookings/{booking}/verify-payment', [BookingAdminController::class, 'verifyPayment'])->name('bookings.verify');
        Route::post('/bookings/{booking}/start-playing', [BookingAdminController::class, 'startPlaying'])->name('bookings.start-playing');
        Route::post('/bookings/walk-in', [BookingAdminController::class, 'walkInBooking'])->name('bookings.walk-in');
        Route::post('/bookings/{booking}/add-duration', [BookingAdminController::class, 'addDuration'])->name('bookings.add-duration');
        Route::post('/bookings/{booking}/stop', [BookingAdminController::class, 'stopTimer'])->name('bookings.stop');
        Route::get('/schedule', [BookingAdminController::class, 'schedule'])->name('schedule');

        // Consoles
        Route::resource('/consoles', ConsoleAdminController::class);

        // Laporan Pendapatan
        Route::get('/laporan', [LaporanController::class, 'index'])->name('laporan.index');
    });
