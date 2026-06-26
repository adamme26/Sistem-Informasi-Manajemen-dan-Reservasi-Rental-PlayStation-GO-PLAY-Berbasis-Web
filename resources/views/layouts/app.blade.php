<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'GO PLAY') — Rental PlayStation</title>
    <link rel="stylesheet" href="{{ asset('css/app.css?v=23') }}">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    @stack('styles')
    <style>
    .user-dropdown-menu {
        position: absolute;
        top: 100%;
        right: 0;
        margin-top: 16px;
        background: #17172A;
        border: 1px solid rgba(255,255,255,0.05);
        border-radius: 16px;
        width: 240px;
        padding: 8px 0;
        box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        opacity: 0;
        visibility: hidden;
        transform: translateY(-10px);
        transition: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        z-index: 1000;
    }
    .user-dropdown-menu.show {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }
    .dropdown-item {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 20px;
        color: #9CA3AF;
        font-size: 14px;
        text-decoration: none;
        font-weight: 500;
        background: transparent;
        border: none;
        cursor: pointer;
        font-family: inherit;
        width: 100%;
        text-align: left;
    }
    .dropdown-item svg { width: 18px; height: 18px; }
    .dropdown-item:hover {
        background: rgba(255,255,255,0.03);
        color: white;
    }
    .dropdown-item.text-danger:hover {
        color: #ef4444;
        background: rgba(239, 68, 68, 0.05);
    }
    .dropdown-divider {
        height: 1px;
        background: rgba(255,255,255,0.05);
        margin: 8px 0;
    }
    </style>
</head>
<body>

{{-- Navbar --}}
<nav class="navbar">
    {{-- Logo --}}
    <a href="{{ route('home') }}?v=1" class="logo">
        <div class="logo-icon">
            <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 14.5v-9l6 4.5-6 4.5z"/>
                <path fill="none" d="M0 0h24v24H0z"/>
                <!-- Controller icon simplified -->
                <path d="M21 6H3c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h18c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm-10 7H8v3H6v-3H3v-2h3V8h2v3h3v2zm4.5 2c-.83 0-1.5-.67-1.5-1.5S14.67 12 15.5 12s1.5.67 1.5 1.5S16.33 15 15.5 15zm3-3c-.83 0-1.5-.67-1.5-1.5S17.67 9 18.5 9s1.5.67 1.5 1.5S19.33 12 18.5 12z"/>
            </svg>
        </div>
        <div class="logo-text">
            <span class="logo-name">GO PLAY</span>
            <span class="logo-sub">Rental PlayStation</span>
        </div>
    </a>

    {{-- Nav Links (logged-in users) --}}
    @auth
    <ul class="nav-links">
    </ul>
    @endauth

    {{-- Right Side --}}
    <div class="nav-right">
        @auth
        {{-- Bell Dropdown Wrap --}}
        <div class="nav-bell-wrap" style="position: relative;">
            <div style="cursor: pointer; position: relative; width:44px; height:44px; display:flex; align-items:center; justify-content:center;"
                 onclick="document.getElementById('notif-dropdown').classList.toggle('show')">
                {{-- Gold bell icon --}}
                <svg width="22" height="22" viewBox="0 0 24 24" fill="#FACC15" stroke="none">
                    <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/>
                    <path d="M13.73 21a2 2 0 0 1-3.46 0" fill="#FACC15"/>
                </svg>
                @if(auth()->user()->unreadNotifications->count() > 0)
                <span style="position: absolute; top: 6px; right: 6px; width: 9px; height: 9px; background: #E879A0; border-radius: 50%; border: 2px solid #09090F;"></span>
                @endif
            </div>

            <div id="notif-dropdown" class="user-dropdown-menu" style="width: 320px; padding: 0;">
                <div style="padding: 12px 16px; border-bottom: 1px solid rgba(255,255,255,0.05); display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-weight: 700; color: white; font-size: 14px;">Notifikasi</span>
                    @if(auth()->user()->unreadNotifications->count() > 0)
                    <form action="{{ route('notifications.read') }}" method="POST" style="margin:0;">
                        @csrf
                        <button type="submit" style="background: none; border: none; color: #9B5BFF; font-size: 12px; cursor: pointer; font-weight: 600;">Tandai Dibaca</button>
                    </form>
                    @endif
                </div>
                
                <div style="max-height: 300px; overflow-y: auto;">
                    @forelse(auth()->user()->notifications->take(5) as $notification)
                    <a href="{{ $notification->data['url'] ?? '#' }}" class="dropdown-item" style="align-items: start; padding: 12px 16px; border-bottom: 1px solid rgba(255,255,255,0.02); {{ $notification->read_at ? 'opacity: 0.7;' : 'background: rgba(123, 47, 247, 0.05);' }}">
                        <div style="width: 32px; height: 32px; background: rgba(123, 47, 247, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; flex-shrink: 0; color: #9B5BFF; margin-top: 2px;">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                        </div>
                        <div style="flex: 1; min-width: 0;">
                            <div style="font-size: 13px; font-weight: 700; color: white; margin-bottom: 2px;">{{ $notification->data['title'] ?? 'Pemberitahuan' }}</div>
                            <div style="font-size: 12px; color: #9CA3AF; line-height: 1.4;">{{ $notification->data['message'] ?? 'Ada pembaruan baru.' }}</div>
                            <div style="font-size: 11px; color: #6B7280; margin-top: 4px;">{{ $notification->created_at->diffForHumans() }}</div>
                        </div>
                    </a>
                    @empty
                    <div style="padding: 32px 16px; text-align: center; color: #6B7280; font-size: 13px;">
                        Tidak ada notifikasi saat ini.
                    </div>
                    @endforelse
                </div>
            </div>
        </div>
        {{-- User Dropdown Wrap (pill style) --}}
        <div class="nav-user-wrap" style="position: relative;">
            <button
                onclick="document.getElementById('user-dropdown').classList.toggle('show')"
                style="display:flex; align-items:center; gap:12px;
                       background:#1A1A2E; border:1px solid rgba(255,255,255,0.08);
                       border-radius:50px; padding:8px 18px 8px 8px;
                       cursor:pointer; font-family:inherit; color:#fff;
                       font-size:14px; font-weight:600; transition:all 0.2s;
                       box-shadow: 0 2px 12px rgba(0,0,0,0.3);"
                onmouseover="this.style.background='#22223F'"
                onmouseout="this.style.background='#1A1A2E'"
            >
                {{-- Circle avatar with person icon --}}
                <span style="width:32px; height:32px; background:rgba(123,79,255,0.15);
                             border:1.5px solid rgba(123,79,255,0.3);
                             border-radius:50%; display:flex; align-items:center;
                             justify-content:center; flex-shrink:0;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#9B6FFF" stroke-width="2">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                        <circle cx="12" cy="7" r="4"/>
                    </svg>
                </span>
                <span>Halo, {{ auth()->user()->name }}</span>
                {{-- Solid filled triangle ▼ --}}
                <svg width="10" height="8" viewBox="0 0 10 8" fill="white" style="opacity:0.7; flex-shrink:0;">
                    <polygon points="0,0 10,0 5,8"/>
                </svg>
            </button>

            <div id="user-dropdown" class="user-dropdown-menu">
                <a href="{{ route('profile.edit') }}" class="dropdown-item">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                    Profil & Riwayat Pesanan
                </a>
                <div class="dropdown-divider"></div>
                <form action="{{ route('logout') }}" method="POST" style="margin:0" onsubmit="return confirm('Apakah Anda yakin ingin keluar dari sistem?');">
                    @csrf
                    <button type="submit" class="dropdown-item text-danger" style="color: #ef4444;">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg>
                        Keluar
                    </button>
                </form>
            </div>
        </div>
        @else
        <a href="{{ route('login') }}" class="btn btn-outline btn-sm" style="border-radius:12px; padding:8px 24px;">Login</a>
        @endauth
    </div>
</nav>

{{-- Flash Messages --}}
@if(session('success'))
<div style="padding:10px 24px; background:rgba(34,197,94,0.1); border-bottom:1px solid rgba(34,197,94,0.2); color:#22c55e; font-size:13px; display:flex; align-items:center; gap:8px;">
    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg>
    {{ session('success') }}
</div>
@endif
@if(session('error'))
<div style="padding:10px 24px; background:rgba(239,68,68,0.1); border-bottom:1px solid rgba(239,68,68,0.2); color:#ef4444; font-size:13px; display:flex; align-items:center; gap:8px;">
    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
    {{ session('error') }}
</div>
@endif

{{-- Main Content --}}
@yield('content')

@stack('scripts')
<script>
    document.addEventListener('click', function(e) {
        if (!e.target.closest('.nav-user-wrap')) {
            const dropdown = document.getElementById('user-dropdown');
            if (dropdown && dropdown.classList.contains('show')) {
                dropdown.classList.remove('show');
            }
        }
        if (!e.target.closest('.nav-bell-wrap')) {
            const notifDropdown = document.getElementById('notif-dropdown');
            if (notifDropdown && notifDropdown.classList.contains('show')) {
                notifDropdown.classList.remove('show');
            }
        }
    });
</script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 800,
        once: true,
        offset: 100,
    });
</script>
</body>
</html>
