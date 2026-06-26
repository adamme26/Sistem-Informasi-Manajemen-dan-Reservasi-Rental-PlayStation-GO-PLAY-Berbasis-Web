<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ request()->routeIs('register') ? 'Daftar' : 'Login' }} — GO PLAY Rental PlayStation</title>
    <link rel="stylesheet" href="{{ asset('css/app.css?v=13') }}">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <style>
        /* Smooth Slide Animation using CSS Grid */
        .auth-forms-container {
            display: grid;
            grid-template-columns: 1fr;
            align-items: start;
        }
        .auth-forms-container > * {
            grid-column: 1 / 2;
            grid-row: 1 / 2;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .auth-view {
            opacity: 0;
            pointer-events: none;
            visibility: hidden;
            transform: translateX(30px);
        }
        .auth-view.active {
            opacity: 1;
            pointer-events: auto;
            visibility: visible;
            transform: translateX(0);
            position: relative;
            z-index: 2;
        }
        .auth-view.slide-left {
            transform: translateX(-30px);
        }
    </style>
</head>
<body>

<div class="auth-page">
    {{-- LEFT PANEL --}}
    <div class="auth-left">
        <div class="auth-left-logo">
            <a href="{{ route('home') }}" class="logo">
                <div class="logo-icon">
                    <svg viewBox="0 0 24 24" fill="white" width="20" height="20">
                        <path d="M21 6H3c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h18c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm-10 7H8v3H6v-3H3v-2h3V8h2v3h3v2zm4.5 2c-.83 0-1.5-.67-1.5-1.5S14.67 12 15.5 12s1.5.67 1.5 1.5S16.33 15 15.5 15zm3-3c-.83 0-1.5-.67-1.5-1.5S17.67 9 18.5 9s1.5.67 1.5 1.5S19.33 12 18.5 12z"/>
                    </svg>
                </div>
                <div class="logo-text">
                    <span class="logo-name">GO PLAY</span>
                    <span class="logo-sub">Rental PlayStation</span>
                </div>
            </a>
        </div>

        <div class="auth-left-content">
            <h1 class="auth-hero-title">
                Main Lebih<br>
                Seru dengan<br>
                <span class="brand-gradient">GO<br>PLAY</span>
            </h1>
            <p class="auth-hero-desc">
                Sistem reservasi dan monitoring rental PlayStation modern, mudah dan terpercaya dengan tampilan realtime.
            </p>
            <img src="{{ asset('images/gaming_hero.png') }}" alt="Gaming Setup" class="auth-hero-image">
        </div>
    </div>

    {{-- RIGHT PANEL --}}
    <div class="auth-right">
        <div class="auth-card" id="authCard">
            {{-- Tabs --}}
            <div class="auth-tabs">
                <button type="button" id="tab-login" class="auth-tab {{ request()->routeIs('login') ? 'active' : '' }}" onclick="switchAuth('login')">Login</button>
                <button type="button" id="tab-register" class="auth-tab {{ request()->routeIs('register') ? 'active' : '' }}" onclick="switchAuth('register')">Register</button>
            </div>

            @if($errors->any())
            <div class="alert alert-danger" style="margin-bottom:20px; font-size: 13px;">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                <div>@foreach($errors->all() as $e)<div>{{ $e }}</div>@endforeach</div>
            </div>
            @endif

            @if(session('status'))
            <div class="alert alert-success" style="margin-bottom:20px; font-size: 13px;">{{ session('status') }}</div>
            @endif

            <div class="auth-forms-container" id="formsContainer">
                {{-- LOGIN FORM --}}
                <div id="view-login" class="auth-view {{ request()->routeIs('login') ? 'active' : 'slide-left' }}">
                    <h2 class="auth-form-title">Login Akun</h2>
                    <p class="auth-form-sub">Selamat datang kembali! Silakan login untuk melanjutkan.</p>

                    <form method="POST" action="{{ route('login') }}">
                        @csrf
                        <div class="form-group">
                            <label class="form-label">Email atau Username</label>
                            <div class="input-wrap">
                                <span class="input-icon">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                                </span>
                                <input type="text" name="email" class="form-control has-icon" placeholder="username@gmail.com" value="{{ old('email') }}" required autofocus>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <div class="input-wrap">
                                <span class="input-icon">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                                </span>
                                <input type="password" id="password_login" name="password" class="form-control has-icon has-icon-right" placeholder="••••••••" required>
                                <button type="button" class="input-icon-right" onclick="togglePw('password_login', this)">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                                </button>
                            </div>
                        </div>

                        <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:20px;">
                            <label class="form-check">
                                <input type="checkbox" name="remember"> Ingat saya
                            </label>
                            @if(Route::has('password.request'))
                            <a href="{{ route('password.request') }}" style="font-size:12px; color:var(--purple-light);">Lupa password?</a>
                            @endif
                        </div>

                        <button type="submit" class="btn btn-primary btn-full btn-lg" style="margin-bottom:16px;">Login</button>

                        <div class="form-divider">atau masuk dengan</div>

                        <a href="{{ route('social.login', 'google') }}" class="oauth-btn" style="text-decoration:none;">
                            <svg width="16" height="16" viewBox="0 0 24 24"><path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/><path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/><path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/><path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/></svg>
                            Google
                        </a>
                        <a href="{{ route('social.login', 'facebook') }}" class="oauth-btn" style="text-decoration:none;">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="#1877F2"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg>
                            Facebook
                        </a>
                    </form>
                </div>

                {{-- REGISTER FORM --}}
                <div id="view-register" class="auth-view {{ request()->routeIs('register') ? 'active' : '' }}">
                    <h2 class="auth-form-title">Daftar Akun</h2>
                    <p class="auth-form-sub">Buat akun baru untuk mulai reservasi dan menikmati layanan kami.</p>

                    <form method="POST" action="{{ route('register') }}">
                        @csrf
                        <div class="form-group">
                            <label class="form-label">Nama Lengkap</label>
                            <div class="input-wrap">
                                <span class="input-icon">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                                </span>
                                <input type="text" name="name" class="form-control has-icon" placeholder="Masukkan nama lengkap" value="{{ old('name') }}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <div class="input-wrap">
                                <span class="input-icon">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                                </span>
                                <input type="email" name="email" class="form-control has-icon" placeholder="Masukkan email" value="{{ old('email') }}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Username</label>
                            <div class="input-wrap">
                                <span class="input-icon">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                                </span>
                                <input type="text" name="username" class="form-control has-icon" placeholder="Buat username" value="{{ old('username') }}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Nomor WhatsApp</label>
                            <div class="input-wrap">
                                <span class="input-icon">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.61 3.38 2 2 0 0 1 3.58 1h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L7.91 8.1a16 16 0 0 0 6 6l.92-.92a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 15.5v1.42z"/></svg>
                                </span>
                                <input type="text" name="phone" class="form-control has-icon" placeholder="08xxxxxxxxxx" value="{{ old('phone') }}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <div class="input-wrap">
                                <span class="input-icon">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                                </span>
                                <input type="password" id="password_reg" name="password" class="form-control has-icon has-icon-right" placeholder="Buat password" required autocomplete="new-password">
                                <button type="button" class="input-icon-right" onclick="togglePw('password_reg',this)">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                                </button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Konfirmasi Password</label>
                            <div class="input-wrap">
                                <span class="input-icon">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                                </span>
                                <input type="password" id="password_conf" name="password_confirmation" class="form-control has-icon has-icon-right" placeholder="Ulangi password" required>
                                <button type="button" class="input-icon-right" onclick="togglePw('password_conf',this)">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                                </button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-check">
                                <input type="checkbox" name="terms" required>
                                <span>Saya setuju dengan <a href="#" style="color:var(--purple-light);">Syarat &amp; Ketentuan</a> dan <a href="#" style="color:var(--purple-light);">Kebijakan Privasi</a></span>
                            </label>
                        </div>

                        <button type="submit" class="btn btn-primary btn-full btn-lg" style="margin-bottom:16px;">
                            Daftar Sekarang
                        </button>
                        <div class="form-divider">atau daftar dengan</div>

                        <a href="{{ route('social.login', 'google') }}" class="oauth-btn" style="text-decoration:none;">
                            <svg width="16" height="16" viewBox="0 0 24 24"><path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/><path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/><path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/><path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/></svg>
                            Google
                        </a>
                        <a href="{{ route('social.login', 'facebook') }}" class="oauth-btn" style="text-decoration:none;">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="#1877F2"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg>
                            Facebook
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function togglePw(id, btn) {
    const input = document.getElementById(id);
    if (input.type === 'password') {
        input.type = 'text';
        btn.innerHTML = '<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/></svg>';
    } else {
        input.type = 'password';
        btn.innerHTML = '<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>';
    }
}

function switchAuth(target) {
    const viewLogin = document.getElementById('view-login');
    const viewRegister = document.getElementById('view-register');
    const tabLogin = document.getElementById('tab-login');
    const tabRegister = document.getElementById('tab-register');

    if (target === 'login' && !viewLogin.classList.contains('active')) {
        viewRegister.classList.remove('active');
        setTimeout(() => {
            viewLogin.classList.remove('slide-left');
            viewLogin.classList.add('active');
        }, 50);

        tabLogin.classList.add('active');
        tabRegister.classList.remove('active');
        window.history.pushState(null, '', '{{ route("login") }}');
        
    } else if (target === 'register' && !viewRegister.classList.contains('active')) {
        viewLogin.classList.remove('active');
        viewLogin.classList.add('slide-left');
        setTimeout(() => {
            viewRegister.classList.remove('slide-left');
            viewRegister.classList.add('active');
        }, 50);

        tabRegister.classList.add('active');
        tabLogin.classList.remove('active');
        window.history.pushState(null, '', '{{ route("register") }}');
    }
}
</script>
</body>
</html>
