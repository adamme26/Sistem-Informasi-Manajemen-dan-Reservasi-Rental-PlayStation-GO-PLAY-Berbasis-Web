@extends('layouts.app')
@section('title', 'GO PLAY — Rental PlayStation Modern & Realtime')

@section('content')

{{-- ===================== HERO SECTION ===================== --}}
<section class="hero-section">
    <div class="hero-content">
        <h1 class="hero-title">
            Rental<br>
            <span class="gradient-text">PlayStation</span><br>
            Modern &<br>
            <span class="gradient-text">Realtime</span>
        </h1>
        <p class="hero-desc">
            Reservasi online, pantau status unit<br>
            secara realtime dan nikmati<br>
            pengalaman bermain terbaik dengan<br>
            sistem modern berbasis web.
        </p>
        <a href="{{ route('booking.index') }}" class="btn btn-primary btn-lg" style="border-radius: 12px;">
            Booking Online
        </a>
    </div>

    <div class="hero-image-wrap">
        <img src="{{ asset('images/gaming_hero.png') }}" alt="Gaming Setup" class="hero-image">
    </div>
</section>

{{-- ===================== PILIH UNIT SECTION ===================== --}}
<section class="section" style="padding-top: 40px;">
    
    <div class="glowing-divider" style="position: relative;">
        <canvas class="webgl-canvas" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 100vw; height: 160px; pointer-events: none; z-index: 0;"></canvas>
        <div class="glow-line-wrap">
            <div class="glow-light"></div>
        </div>
        <div class="divider-text-wrap">
            <span class="divider-label">BOOKING ONLINE</span>
        </div>
        <div class="glow-line-wrap right">
            <div class="glow-light right"></div>
        </div>
    </div>

    <h2 class="section-title" style="font-size: 42px; font-weight: 800; margin-bottom: 60px; line-height: 1.2;">Pilih Unit &<br>Jadwal Bermain</h2>

    <div class="ps-cards-grid">
        {{-- PS5 Card --}}
        <div class="ps-card">
            <div class="ps-card-img">
                <img src="{{ asset('images/ps5.png') }}" alt="PlayStation 5">
            </div>
            <div class="ps-card-info">
                <div class="ps-card-name">PS5</div>
                <div class="ps-card-sub">Next Generation Gaming</div>
                <ul class="ps-card-features">
                    <li>Grafis 4K & 120FPS</li>
                    <li>DualSense Controller</li>
                    <li>Performa Super Cepat</li>
                </ul>
                <div class="ps-card-price-label">Mulai dari</div>
                <div class="ps-card-price">Rp 15.000 <span>/jam</span></div>
                <a href="{{ route('booking.index') }}?type=ps5" class="btn btn-primary btn-full" style="border-radius: 12px; padding: 14px;">Booking PS5</a>
            </div>
        </div>

        {{-- PS4 Card --}}
        <div class="ps-card">
            <div class="ps-card-img">
                <img src="{{ asset('images/ps4.png') }}" alt="PlayStation 4">
            </div>
            <div class="ps-card-info">
                <div class="ps-card-name">PS4</div>
                <div class="ps-card-sub">Fun Gaming Experience</div>
                <ul class="ps-card-features">
                    <li>Game Favorit Lengkap</li>
                    <li>Multiplayer Seru</li>
                    <li>Harga Lebih Terjangkau</li>
                </ul>
                <div class="ps-card-price-label">Mulai dari</div>
                <div class="ps-card-price">Rp 10.000 <span>/jam</span></div>
                <a href="{{ route('booking.index') }}?type=ps4" class="btn btn-primary btn-full" style="border-radius: 12px; padding: 14px;">Booking PS4</a>
            </div>
        </div>
    </div>
</section>

{{-- ===================== STATUS UNIT SECTION ===================== --}}
<section class="section" style="padding-top: 40px;">
    <div class="glowing-divider" style="position: relative;">
        <canvas class="webgl-canvas" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 100vw; height: 160px; pointer-events: none; z-index: 0;"></canvas>
        <div class="glow-line-wrap">
            <div class="glow-light"></div>
        </div>
        <div class="divider-text-wrap">
            <span class="divider-label">STATUS UNIT</span>
        </div>
        <div class="glow-line-wrap right">
            <div class="glow-light right"></div>
        </div>
    </div>

    <h2 class="section-title" style="font-size: 42px; font-weight: 800; margin-bottom: 60px; line-height: 1.2;">Cek Status<br>Unit Tersedia</h2>

    <div class="status-grid" style="max-width:1100px; margin:0 auto;">
        @foreach($consoles as $console)
        @php
            $activeBooking = $console->activeBooking ?? null;
            $isAvailable = !$activeBooking;
        @endphp
        <div class="status-card">
            <div class="status-header">
                <span class="status-badge-new {{ $isAvailable ? 'available' : 'reserved' }}">
                    {{ $isAvailable ? 'AVAILABLE' : 'RESERVED' }}
                </span>
                <span class="status-room-name">{{ $console->name }}</span>
            </div>
            
            <div class="status-body">
                @if($isAvailable)
                    <div class="status-title">Tersedia</div>
                    <div class="status-desc">Siap dimainkan sekarang</div>
                @else
                    <div class="status-title">Akan Digunakan</div>
                    <div class="status-desc">Jadwal berikutnya pukul {{ \Carbon\Carbon::parse($activeBooking->end_time)->format('H:i') }}</div>
                @endif
            </div>

            <div class="status-action">
                @if($isAvailable)
                    <a href="{{ route('booking.index') }}?console_id={{ $console->id }}" class="btn-booking-now">Booking Sekarang</a>
                @else
                    <div class="btn-reserved-placeholder"></div>
                @endif
            </div>
        </div>
        @endforeach
    </div>

    <div style="max-width:1100px; margin: 40px auto 0;">
        <a href="{{ route('jadwal.index') }}" class="btn-lihat-jadwal-full">
            Lihat Jadwal
        </a>
    </div>
</section>

{{-- ===================== CONTACT SECTION ===================== --}}
<section class="contact-section" style="padding-top: 60px; padding-bottom: 80px;">
    <div class="glowing-divider" style="position: relative;">
        <canvas class="webgl-canvas" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 100vw; height: 160px; pointer-events: none; z-index: 0;"></canvas>
        <div class="glow-line-wrap">
            <div class="glow-light"></div>
        </div>
        <div class="divider-text-wrap">
            <span class="divider-label">TENTANG KITA</span>
        </div>
        <div class="glow-line-wrap right">
            <div class="glow-light right"></div>
        </div>
    </div>

    <h2 class="contact-title" style="font-size: 42px; font-weight: 800; margin-top: 60px; margin-bottom: 80px; line-height: 1.2;">Butuh Bantuan?<br>Hubungi Kami</h2>
    <div class="contact-grid" style="display: flex; justify-content: center; gap: 80px;">
        <div class="contact-item" style="display: flex; align-items: center; gap: 24px;">
            <div class="contact-icon" style="background: white; width: 72px; height: 72px; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 0 20px rgba(255,255,255,0.1); border: none;">
                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#0E0E1A" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
            </div>
            <div style="text-align: left;">
                <div class="contact-item-label" style="font-size: 16px; font-weight: 800; color: white; margin-bottom: 4px; letter-spacing: 0.05em; text-transform: uppercase;">ALAMAT</div>
                <div class="contact-item-value" style="font-size: 14px; color: #9CA3AF; line-height: 1.4; text-transform: uppercase;">JL. KAPTEN HANAFIAH -<br>RAWABADAK SUBANG</div>
            </div>
        </div>
        <div class="contact-item" style="display: flex; align-items: center; gap: 24px;">
            <div class="contact-icon" style="background: linear-gradient(45deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%, #bc1888 100%); width: 72px; height: 72px; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 0 20px rgba(220,39,67,0.3); border: none;">
                <svg width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg>
            </div>
            <div style="text-align: left;">
                <div class="contact-item-label" style="font-size: 16px; font-weight: 800; color: white; margin-bottom: 4px; letter-spacing: 0.05em; text-transform: uppercase;">INSTAGRAM</div>
                <div class="contact-item-value" style="font-size: 14px; color: #9CA3AF; text-transform: uppercase;">GOPLAY.SBG</div>
            </div>
        </div>
    </div>
</section>

<footer style="text-align: center; padding: 40px; color: #6B7280; font-size: 14px; background: transparent; border: none;">
    <p>© 2026 GO PLAY Rental PlayStation</p>
</footer>

<script>
function initGradientShader(canvas) {
    const gl = canvas.getContext("webgl", { alpha: true, premultipliedAlpha: false }) || canvas.getContext("experimental-webgl");
    if (!gl) return;

    const vertexShaderSource = `
        attribute vec2 a_position;
        void main() { gl_Position = vec4(a_position, 0.0, 1.0); }
    `;

    const fragmentShaderSource = `
        precision mediump float;
        uniform vec2 iResolution;
        uniform float iTime;
        uniform float uSpeed;
        uniform float uLineCount;
        uniform float uAmplitude;
        uniform float uYOffset;

        const float MAX_LINES = 20.0;

        float wave(vec2 uv, float speed, float amplitude, float thickness, float softness) {
            float falloff = smoothstep(1.0, 0.5, abs(uv.x));
            float y = falloff * sin(iTime * speed + uv.x * 10.0) * amplitude - uYOffset;
            return 1.0 - smoothstep(thickness, thickness + softness, abs(uv.y - y));
        }

        void main() {
            vec2 uv = gl_FragCoord.xy / iResolution.xy;
            uv -= 0.5;
            uv.x *= iResolution.x / iResolution.y;

            vec4 col = vec4(0.0);
            vec3 col1 = vec3(0.0, 0.8, 1.0);
            vec3 col2 = vec3(0.8, 0.0, 1.0);
            float aaDy = iResolution.y * 0.000005;

            for (float i = 0.0; i < MAX_LINES; i += 1.0) {
                if (i < uLineCount) {
                    float t = i / max(uLineCount - 1.0, 1.0);
                    vec3 lineCol = mix(col1, col2, t);
                    float bokeh = pow(t, 3.0);
                    float thickness = 0.015;
                    float softness = aaDy + bokeh * 0.2;
                    float amt = max(0.0, pow(1.0 - bokeh, 2.0) * 0.9);
                    float waveMask = wave(uv, uSpeed * (1.0 + t), uAmplitude - 0.05 * t, thickness, softness);
                    
                    col.rgb += waveMask * lineCol * amt * 2.5;
                    col.a += waveMask * 0.3;
                }
            }
            gl_FragColor = col;
        }
    `;

    function compileShader(type, source) {
        const shader = gl.createShader(type);
        gl.shaderSource(shader, source);
        gl.compileShader(shader);
        return shader;
    }

    const vertexShader = compileShader(gl.VERTEX_SHADER, vertexShaderSource);
    const fragmentShader = compileShader(gl.FRAGMENT_SHADER, fragmentShaderSource);
    const program = gl.createProgram();
    gl.attachShader(program, vertexShader);
    gl.attachShader(program, fragmentShader);
    gl.linkProgram(program);
    gl.useProgram(program);

    gl.enable(gl.BLEND);
    gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);

    const positionBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
    const positions = [-1, -1, 1, -1, -1, 1, -1, 1, 1, -1, 1, 1];
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(positions), gl.STATIC_DRAW);

    const positionLocation = gl.getAttribLocation(program, "a_position");
    gl.enableVertexAttribArray(positionLocation);
    gl.vertexAttribPointer(positionLocation, 2, gl.FLOAT, false, 0, 0);

    const uniforms = {
        iResolution: gl.getUniformLocation(program, "iResolution"),
        iTime: gl.getUniformLocation(program, "iTime"),
        uSpeed: gl.getUniformLocation(program, "uSpeed"),
        uLineCount: gl.getUniformLocation(program, "uLineCount"),
        uAmplitude: gl.getUniformLocation(program, "uAmplitude"),
        uYOffset: gl.getUniformLocation(program, "uYOffset"),
    };

    const startTime = Date.now();

    function resize() {
        const width = canvas.clientWidth;
        const height = canvas.clientHeight;
        if (canvas.width !== width || canvas.height !== height) {
            canvas.width = width;
            canvas.height = height;
            gl.viewport(0, 0, width, height);
        }
    }

    function render() {
        resize();
        const elapsed = (Date.now() - startTime) / 1000;
        gl.clearColor(0, 0, 0, 0);
        gl.clear(gl.COLOR_BUFFER_BIT);

        gl.uniform2f(uniforms.iResolution, gl.canvas.width, gl.canvas.height);
        gl.uniform1f(uniforms.iTime, elapsed);
        gl.uniform1f(uniforms.uSpeed, 1.0);
        gl.uniform1f(uniforms.uLineCount, 12.0); 
        gl.uniform1f(uniforms.uAmplitude, 0.40); 
        gl.uniform1f(uniforms.uYOffset, 0.0); 

        gl.drawArrays(gl.TRIANGLES, 0, 6);
        requestAnimationFrame(render);
    }
    
    render();
}

document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.webgl-canvas').forEach(initGradientShader);
});
</script>

@endsection
