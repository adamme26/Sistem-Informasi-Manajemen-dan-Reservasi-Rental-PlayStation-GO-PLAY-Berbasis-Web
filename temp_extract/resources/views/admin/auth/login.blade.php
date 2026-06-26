<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | GOPLAY</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
    <style>
        body {
            background-color: #0A0A12; /* Darker than front end */
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .admin-auth-box {
            background: #17172A;
            padding: 3rem;
            border-radius: 1rem;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.5);
            border: 1px solid rgba(255,255,255,0.05);
        }
        .admin-brand {
            text-align: center;
            margin-bottom: 2rem;
        }
        .admin-brand .logo-text { font-family: 'Orbitron', sans-serif; font-size: 2rem; font-weight: 900; color: #FFF; letter-spacing: 0.1em; }
        .admin-brand .logo-sub { font-family: 'Inter', sans-serif; font-size: 0.8rem; color: #9CA3AF; letter-spacing: 0.2em; text-transform: uppercase; margin-top: 5px; }
    </style>
</head>
<body>
    <div class="admin-auth-box">
        <div class="admin-brand">
            <div class="logo-text">GOPLAY</div>
            <div class="logo-sub">ADMINISTRATOR</div>
        </div>

        @if($errors->any())
        <div class="alert alert-danger" style="margin-bottom:1.5rem;">
            {{ $errors->first() }}
        </div>
        @endif

        <form method="POST" action="{{ route('admin.login.store') }}">
            @csrf
            <div class="form-group">
                <label class="form-label">Email Admin</label>
                <input type="email" name="email" class="form-control" value="{{ old('email') }}" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <div class="form-group" style="display:flex; align-items:center; gap:8px;">
                <input type="checkbox" name="remember" id="remember">
                <label for="remember" style="color:var(--text-secondary); font-size:0.875rem;">Ingat Saya</label>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%; justify-content:center; margin-top:1rem;">Masuk ke Panel Admin</button>
        </form>

        <div style="text-align:center; margin-top:1.5rem; font-size:0.875rem;">
            <a href="{{ route('home') }}" style="color:var(--text-muted); text-decoration:none;">&larr; Kembali ke Situs Pelanggan</a>
        </div>
    </div>
</body>
</html>
