Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$outputPath = 'C:\Users\noval mulyadi\Documents\SMT4\Proyek Perangkat Lunak\LAPORAN\LAPORAN_AKHIR_GOPLAY_KEL8.docx'
$tmpDir = 'C:\Users\noval mulyadi\.gemini\antigravity\scratch\goplay\docx_tmp'

if (Test-Path $outputPath) { Remove-Item $outputPath -Force }
if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
New-Item -ItemType Directory -Path "$tmpDir\_rels" -Force | Out-Null
New-Item -ItemType Directory -Path "$tmpDir\word\_rels" -Force | Out-Null

function WriteFile($path, $content) {
    [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
}

WriteFile "$tmpDir\[Content_Types].xml" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/><Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/></Types>'

WriteFile "$tmpDir\_rels\.rels" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/></Relationships>'

WriteFile "$tmpDir\word\_rels\document.xml.rels" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/></Relationships>'

WriteFile "$tmpDir\word\styles.xml" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
<w:style w:type="paragraph" w:default="1" w:styleId="Normal"><w:name w:val="Normal"/><w:pPr><w:jc w:val="both"/><w:spacing w:before="0" w:after="120" w:line="480" w:lineRule="auto"/></w:pPr><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/></w:rPr></w:style>
<w:style w:type="paragraph" w:styleId="H1"><w:name w:val="heading 1"/><w:basedOn w:val="Normal"/><w:pPr><w:jc w:val="center"/><w:spacing w:before="0" w:after="240" w:line="480" w:lineRule="auto"/><w:pageBreakBefore/></w:pPr><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="32"/></w:rPr></w:style>
<w:style w:type="paragraph" w:styleId="H2"><w:name w:val="heading 2"/><w:basedOn w:val="Normal"/><w:pPr><w:jc w:val="left"/><w:spacing w:before="120" w:after="120" w:line="480" w:lineRule="auto"/></w:pPr><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="28"/></w:rPr></w:style>
<w:style w:type="paragraph" w:styleId="H3"><w:name w:val="heading 3"/><w:basedOn w:val="Normal"/><w:pPr><w:jc w:val="left"/><w:spacing w:before="120" w:after="120" w:line="480" w:lineRule="auto"/></w:pPr><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="26"/></w:rPr></w:style>
<w:style w:type="paragraph" w:styleId="CTR"><w:name w:val="CTR"/><w:basedOn w:val="Normal"/><w:pPr><w:jc w:val="center"/></w:pPr></w:style>
<w:style w:type="paragraph" w:styleId="CAP"><w:name w:val="CAP"/><w:basedOn w:val="Normal"/><w:pPr><w:jc w:val="center"/></w:pPr><w:rPr><w:i/></w:rPr></w:style>
<w:style w:type="paragraph" w:styleId="PH"><w:name w:val="PH"/><w:basedOn w:val="Normal"/><w:pPr><w:jc w:val="center"/><w:spacing w:before="120" w:after="120" w:line="240" w:lineRule="auto"/><w:pBdr><w:top w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/><w:left w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/><w:bottom w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/><w:right w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/><w:shd w:val="clear" w:color="auto" w:fill="FFFF00"/></w:pBdr></w:pPr><w:rPr><w:b/><w:color w:val="CC0000"/></w:rPr></w:style>
</w:styles>'

# Build XML content as one big string
$sb = [System.Text.StringBuilder]::new()
$sb.Append('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>') | Out-Null
$sb.Append('<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:body>') | Out-Null

# Shortcuts
$W = 'http://schemas.openxmlformats.org/wordprocessingml/2006/main'

function ap($xml) { $sb.Append($xml) | Out-Null }

function h1([string]$t) { ap "<w:p><w:pPr><w:pStyle w:val='H1'/></w:pPr><w:r><w:t xml:space='preserve'>$t</w:t></w:r></w:p>" }
function h2([string]$t) { ap "<w:p><w:pPr><w:pStyle w:val='H2'/></w:pPr><w:r><w:t xml:space='preserve'>$t</w:t></w:r></w:p>" }
function h3([string]$t) { ap "<w:p><w:pPr><w:pStyle w:val='H3'/></w:pPr><w:r><w:t xml:space='preserve'>$t</w:t></w:r></w:p>" }
function pp([string]$t) { ap "<w:p><w:pPr><w:pStyle w:val='Normal'/></w:pPr><w:r><w:t xml:space='preserve'>$t</w:t></w:r></w:p>" }
function pc([string]$t) { ap "<w:p><w:pPr><w:pStyle w:val='CTR'/></w:pPr><w:r><w:t xml:space='preserve'>$t</w:t></w:r></w:p>" }
function ph([string]$t) { ap "<w:p><w:pPr><w:pStyle w:val='PH'/></w:pPr><w:r><w:t xml:space='preserve'>$t</w:t></w:r></w:p>" }
function pb() { ap "<w:p><w:r><w:br w:type='page'/></w:r></w:p>" }
function el() { ap "<w:p><w:pPr><w:pStyle w:val='Normal'/></w:pPr></w:p>" }
function bd([string]$t) { ap "<w:p><w:pPr><w:pStyle w:val='Normal'/></w:pPr><w:r><w:rPr><w:b/></w:rPr><w:t xml:space='preserve'>$t</w:t></w:r></w:p>" }
function gj([string]$num, [string]$cap) { ap "<w:p><w:pPr><w:pStyle w:val='CAP'/></w:pPr><w:r><w:rPr><w:i/></w:rPr><w:t xml:space='preserve'>Gambar $num $cap</w:t></w:r></w:p>" }

# ==================== COVER ====================
ap "<w:p><w:pPr><w:pStyle w:val='H1'/><w:spacing w:before='2880' w:after='240'/></w:pPr><w:r><w:t>LAPORAN AKHIR PROYEK PERANGKAT LUNAK</w:t></w:r></w:p>"
pc "Sistem Informasi Manajemen dan Reservasi Rental PlayStation"
pc "(GO PLAY) Berbasis Web"
el; el
ph "[TEMPEL LOGO UNIVERSITAS SUBANG DI SINI]"
el; el
pc "Disusun oleh : Kelompok 8"; el
pc "Adam. F                    D1A240046"
pc "Azfar Wildan. P            D1A240026"
pc "M. Noval Mulyadi           D1A240039"
pc "Divi Agung Satria          D1A240038"
pc "Ramdan Prayitno            D1A240032"
el; el
pc "PROGRAM STUDI SISTEM INFORMASI"
pc "FAKULTAS ILMU KOMPUTER"
pc "UNIVERSITAS SUBANG"
pc "2026"

# ==================== LEMBAR PENGESAHAN ====================
pb
h1 "LEMBAR PENGESAHAN"
pp "Judul Proyek      : Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY) Berbasis Web"
pp "Program Studi     : Sistem Informasi"
pp "Fakultas          : Ilmu Komputer"
pp "Universitas       : Universitas Subang"
pp "Tahun Akademik    : 2025/2026"
pp "Kelompok          : 8"; el
pp "Anggota Tim:"
pp "1. Adam. F              - D1A240046"
pp "2. Azfar Wildan. P      - D1A240026"
pp "3. M. Noval Mulyadi     - D1A240039"
pp "4. Divi Agung Satria    - D1A240038"
pp "5. Ramdan Prayitno      - D1A240032"
el
ph "[TEMPEL TANDA TANGAN DOSEN PEMBIMBING DAN KETUA KELOMPOK DI SINI]"

# ==================== ABSTRAK ====================
pb
h1 "ABSTRAK"
pp "Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY) dikembangkan untuk mengatasi permasalahan operasional pada bisnis rental PlayStation konvensional, yaitu pencatatan manual yang rawan kesalahan, risiko bentrok jadwal pemesanan (double booking), dan sulitnya merekap laporan pendapatan secara akurat. Sistem ini dibangun menggunakan framework Laravel 12 (PHP 8.2) dengan database SQLite dan antarmuka berbasis Vite, serta menerapkan arsitektur MVC (Model-View-Controller). Hasil pengembangan berupa aplikasi web yang memiliki tiga peran pengguna (Admin, Member, dan Pemilik) dengan fitur utama meliputi: Booking Online oleh Member, Kelola Reservasi dan Walk-in oleh Admin, Monitoring Status Unit dengan Timer Otomatis, Pengelolaan Inventaris konsol PS4/PS5, dan Dashboard Laporan Pendapatan untuk Pemilik. Sistem ini terbukti mampu mengotomatisasi proses bisnis rental PlayStation sehingga meminimalisir kesalahan operasional dan meningkatkan efisiensi kerja Admin."
el
bd "Kata Kunci: Sistem Informasi, Rental PlayStation, Booking Online, Laravel, MVC, Timer Otomatis."
el
h1 "ABSTRACT"
pp "The PlayStation Rental Management and Reservation Information System (GO PLAY) was developed to address operational problems commonly found in conventional PlayStation rental businesses, namely error-prone manual recording, the risk of scheduling conflicts (double booking), and difficulties in accurately compiling revenue reports. This system was built using the Laravel 12 framework (PHP 8.2) with a SQLite database and a Vite-based interface, applying MVC (Model-View-Controller) architecture. The resulting web application has three user roles (Admin, Member, and Owner) with main features including: Online Booking by Members, Reservation and Walk-in Management by Admin, Unit Status Monitoring with Automatic Timer, PS4/PS5 Console Inventory Management, and Revenue Report Dashboard for Owners."
el
bd "Keywords: Information System, PlayStation Rental, Online Booking, Laravel, MVC, Automatic Timer."

# ==================== DAFTAR ISI ====================
pb
h1 "DAFTAR ISI"
pp "LEMBAR PENGESAHAN"
pp "ABSTRAK"
pp "ABSTRACT"
pp "DAFTAR ISI"
pp "DAFTAR GAMBAR"
pp "BAB I    PENDAHULUAN"
pp "    1.1  Latar Belakang"
pp "    1.2  Identifikasi Masalah"
pp "    1.3  Tujuan Pengembangan Sistem"
pp "    1.4  Ruang Lingkup Proyek"
pp "    1.5  Manfaat yang Diharapkan"
pp "BAB II   TINJAUAN SINGKAT DAN LANDASAN KONSEPTUAL"
pp "    2.1  Gambaran Singkat Organisasi atau Objek Studi Kasus"
pp "    2.2  Konsep Sistem Informasi yang Relevan"
pp "    2.3  Teknologi, Framework, dan Metodologi yang Digunakan"
pp "BAB III  ANALISIS SISTEM"
pp "    3.1  Analisis Proses Bisnis atau Sistem Berjalan (BPMN)"
pp "    3.2  Analisis Dokumen"
pp "    3.3  Analisis Kebutuhan Informasi dan Pengguna (SRS)"
pp "    3.4  Pemodelan Sistem (UML)"
pp "BAB IV   PERANCANGAN SISTEM"
pp "    4.1  Perancangan Arsitektur Sistem"
pp "    4.2  Desain Basis Data"
pp "    4.3  Desain Antarmuka Pengguna (UI)"
pp "BAB V    IMPLEMENTASI DAN PENGUJIAN"
pp "    5.1  Implementasi Database"
pp "    5.2  Implementasi Antarmuka"
pp "    5.3  Struktur Program dan Pengelolaan Source Code"
pp "    5.4  Pengujian menggunakan Tools"
pp "    5.5  User Acceptance Testing (UAT)"
pp "BAB VI   PENUTUP"
pp "    6.1  Kesimpulan"
pp "    6.2  Saran"
pp "DAFTAR PUSTAKA"
pp "LAMPIRAN"

# ==================== DAFTAR GAMBAR ====================
pb
h1 "DAFTAR GAMBAR"
pp "Gambar 3.1   BPMN Proses Bisnis GO PLAY"
pp "Gambar 3.2   Use Case Diagram Sistem GO PLAY"
pp "Gambar 3.3   Activity Diagram - Login"
pp "Gambar 3.4   Activity Diagram - Booking Online"
pp "Gambar 3.5   Activity Diagram - Kelola Reservasi"
pp "Gambar 3.6   Activity Diagram - Monitoring Status Unit"
pp "Gambar 3.7   Activity Diagram - Kelola Inventaris"
pp "Gambar 3.8   Activity Diagram - Laporan Pendapatan"
pp "Gambar 3.9   Robustness Diagram Sistem GO PLAY"
pp "Gambar 3.10  Class Diagram Sistem GO PLAY"
pp "Gambar 3.11  Sequence Diagram - Login"
pp "Gambar 3.12  Sequence Diagram - Booking Online"
pp "Gambar 3.13  Sequence Diagram - Kelola Reservasi"
pp "Gambar 3.14  Sequence Diagram - Monitoring Status Unit"
pp "Gambar 4.1   Arsitektur Sistem GO PLAY (MVC)"
pp "Gambar 4.2   Entity Relationship Diagram (ERD)"
pp "Gambar 4.3   Wireframe Halaman Utama"
pp "Gambar 4.4   Wireframe Halaman Login"
pp "Gambar 4.5   Wireframe Halaman Booking"
pp "Gambar 5.1   Screenshot Halaman Utama GO PLAY"
pp "Gambar 5.2   Screenshot Halaman Login"
pp "Gambar 5.3   Screenshot Dashboard Member"
pp "Gambar 5.4   Screenshot Halaman Booking Online"
pp "Gambar 5.5   Screenshot Dashboard Admin"
pp "Gambar 5.6   Screenshot Monitoring Timer Unit"
pp "Gambar 5.7   Screenshot Kelola Reservasi Admin"
pp "Gambar 5.8   Screenshot Laporan Pendapatan"

# ==================== BAB I ====================
pb
h1 "BAB I"
h1 "PENDAHULUAN"
h2 "1.1 Latar Belakang"
pp "Industri hiburan berbasis gaming, khususnya penyewaan unit PlayStation, saat ini tengah berkembang pesat di berbagai kota di Indonesia. Bisnis rental PlayStation (PS) merupakan salah satu bentuk usaha mikro yang diminati oleh berbagai kalangan, terutama di lingkungan perkotaan dan kawasan kampus. Namun, sebagian besar usaha rental PlayStation masih dikelola secara konvensional dengan mengandalkan pencatatan manual menggunakan buku tulis atau papan tulis jadwal yang tidak terintegrasi."
pp "Sistem konvensional tersebut rentan menimbulkan berbagai permasalahan operasional, seperti: (1) terjadinya bentrok jadwal pemesanan (double booking) akibat tidak adanya sistem pengecekan otomatis; (2) kesulitan dalam memantau sisa waktu bermain pelanggan; (3) pengelolaan inventaris konsol PS4/PS5 yang tidak terdokumentasi dengan baik; serta (4) pelaporan pendapatan yang tidak akurat dan memakan waktu lama karena harus direkap secara manual."
pp "Berdasarkan permasalahan tersebut, dikembangkanlah Sistem Informasi Manajemen dan Reservasi Rental PlayStation dengan nama GO PLAY. Sistem ini merupakan aplikasi berbasis web yang dirancang untuk mengotomatisasi dan mendigitalisasi seluruh proses bisnis rental PlayStation, mulai dari pemesanan (booking) online oleh pelanggan, pengelolaan reservasi oleh Admin, monitoring status unit secara real-time, hingga penyajian laporan pendapatan kepada Pemilik usaha."
h2 "1.2 Identifikasi Masalah"
pp "Berdasarkan latar belakang di atas, dapat diidentifikasi beberapa permasalahan utama:"
pp "1. Proses pencatatan reservasi yang masih manual menyebabkan potensi kesalahan data dan duplikasi jadwal (double booking)."
pp "2. Tidak adanya sistem pemantauan otomatis terhadap durasi bermain pelanggan."
pp "3. Pengelolaan data inventaris konsol PS4/PS5 yang tidak terstruktur."
pp "4. Sulitnya pemilik mendapatkan laporan pendapatan yang akurat dan real-time."
pp "5. Tidak tersedianya media bagi pelanggan untuk melakukan pemesanan dari jarak jauh."
h2 "1.3 Tujuan Pengembangan Sistem"
pp "1. Membangun sistem informasi berbasis web yang mampu mengelola reservasi rental PlayStation secara digital dan terintegrasi."
pp "2. Menyediakan fitur Booking Online bagi Member untuk melakukan pemesanan jadwal bermain secara mandiri."
pp "3. Mengimplementasikan fitur Monitoring Status Unit dengan Timer Otomatis."
pp "4. Menyediakan fitur Kelola Inventaris bagi Admin untuk mendokumentasikan kondisi setiap unit konsol."
pp "5. Menyajikan Dashboard Laporan Pendapatan yang akurat kepada Pemilik usaha."
h2 "1.4 Ruang Lingkup Proyek"
pp "1. Sistem berbasis web yang dapat diakses melalui browser pada perangkat desktop maupun laptop."
pp "2. Tiga jenis pengguna (User Role): Member, Admin, dan Pemilik."
pp "3. Fitur utama: Login/Logout multi-peran, Registrasi Member, Booking Online, Kelola Reservasi (termasuk Walk-in), Monitoring + Timer, Kelola Inventaris, dan Laporan Pendapatan."
pp "4. Database yang digunakan: SQLite."
pp "5. Framework: Laravel 12 (PHP 8.2) backend, Vite + Blade frontend."
pp "6. Tidak mencakup: integrasi payment gateway, fitur chat real-time, dan aplikasi mobile."
h2 "1.5 Manfaat yang Diharapkan"
pp "Bagi Admin: Mempermudah dan mempercepat proses pengelolaan reservasi serta memantau durasi bermain pelanggan tanpa pengawasan manual yang intensif."
pp "Bagi Member (Pelanggan): Memberikan kemudahan dalam melakukan pemesanan jadwal bermain secara mandiri melalui aplikasi web kapan saja dan di mana saja."
pp "Bagi Pemilik: Memberikan visibilitas terhadap kinerja bisnis melalui laporan pendapatan yang otomatis, akurat, dan dapat diakses kapan saja."
pp "Bagi Pengembang: Sebagai sarana untuk mengimplementasikan ilmu rekayasa perangkat lunak dalam pengembangan sistem informasi berbasis web menggunakan framework modern."

# ==================== BAB II ====================
pb
h1 "BAB II"
h1 "TINJAUAN SINGKAT DAN LANDASAN KONSEPTUAL"
h2 "2.1 Gambaran Singkat Organisasi atau Objek Studi Kasus"
pp "GO PLAY merupakan sebuah usaha mikro yang bergerak di bidang penyewaan unit PlayStation (PS4 dan PS5). Usaha ini melayani pelanggan yang ingin bermain game konsol secara sewa per jam, baik secara walk-in (datang langsung) maupun melalui sistem reservasi online."
bd "Nama Usaha       : GO PLAY - Rental PlayStation"
bd "Bidang Usaha     : Penyewaan Unit Game Console (PlayStation)"
bd "Layanan          : Sewa PS4/PS5 per jam, Booking Online, Walk-in"
bd "Target Pasar     : Pelajar, Mahasiswa, dan Masyarakat Umum"
el
pp "Visi: Menjadi penyedia layanan rental PlayStation terbaik yang modern, efisien, dan mudah diakses oleh seluruh kalangan masyarakat."
pp "Misi: (1) Memberikan pengalaman bermain yang nyaman; (2) Mengelola reservasi secara digital untuk meminimalisir antrian dan bentrok jadwal; (3) Menjaga kualitas dan kondisi setiap unit konsol melalui pengelolaan inventaris yang terstruktur."
ph "[TEMPEL STRUKTUR ORGANISASI DARI FILE Lampiran Profile Tim Proyek Go Play.docx DI SINI]"
h2 "2.2 Konsep Sistem Informasi yang Relevan"
bd "a. Sistem Informasi Manajemen (SIM)"
pp "Sistem Informasi Manajemen adalah suatu sistem yang mengumpulkan, memproses, menyimpan, dan menyajikan informasi untuk mendukung proses pengambilan keputusan manajemen. Dalam GO PLAY, SIM diterapkan pada fitur Dashboard Laporan Pendapatan."
bd "b. Sistem Reservasi"
pp "Sistem reservasi memungkinkan pelanggan untuk memesan atau mengalokasikan sumber daya (unit PS) pada waktu tertentu. Sistem ini mencegah konflik jadwal melalui pengecekan ketersediaan secara otomatis."
bd "c. Sistem Monitoring Real-Time"
pp "Sistem monitoring real-time memungkinkan pemantauan terhadap kondisi suatu objek secara langsung. Dalam GO PLAY, konsep ini diterapkan pada fitur Timer Otomatis yang memantau sisa waktu bermain setiap pelanggan."
h2 "2.3 Teknologi, Framework, dan Metodologi yang Digunakan"
bd "a. Laravel 12 (PHP 8.2)"
pp "Laravel adalah framework PHP open-source yang mengikuti pola arsitektur MVC. Laravel 12 digunakan sebagai backbone backend sistem GO PLAY, menangani routing, autentikasi multi-guard, manajemen database melalui Eloquent ORM, dan logika bisnis aplikasi."
bd "b. Vite dan Blade Template Engine"
pp "Vite digunakan sebagai build tool frontend yang memberikan Hot Module Replacement (HMR) yang cepat selama pengembangan. Blade Template Engine adalah mesin template bawaan Laravel untuk membangun tampilan antarmuka pengguna."
bd "c. SQLite"
pp "SQLite adalah sistem manajemen database relasional berbasis file yang ringan dan tidak memerlukan server terpisah. SQLite digunakan sebagai database utama dalam pengembangan dan pengujian lokal."
bd "d. Arsitektur MVC (Model-View-Controller)"
pp "MVC memisahkan aplikasi menjadi tiga komponen: Model (pengelolaan data), View (tampilan antarmuka), dan Controller (logika bisnis). Pemisahan ini meningkatkan keterbacaan kode dan kemudahan pemeliharaan."
bd "e. Metodologi Pengembangan (Waterfall)"
pp "Pengembangan sistem menggunakan metodologi Waterfall: Analisis Kebutuhan, Perancangan Sistem, Implementasi (Coding), Pengujian, dan Pemeliharaan."

# ==================== BAB III ====================
pb
h1 "BAB III"
h1 "ANALISIS SISTEM"
h2 "3.1 Analisis Proses Bisnis atau Sistem Berjalan (BPMN)"
pp "Analisis proses bisnis dilakukan terhadap sistem yang diusulkan (To-Be Process). Proses ini digambarkan menggunakan notasi BPMN (Business Process Model and Notation) yang membagi aktivitas berdasarkan pool dan lane aktor."
h3 "3.1.1 Inisiasi Proses (Dua Jalur Utama)"
pp "Jalur Online (Member): Proses dimulai ketika Member melakukan F-01: Login Member. Setelah login, Member masuk ke fitur F-04: Input Booking untuk memilih jadwal bermain dan unit PS yang diinginkan."
pp "Jalur Offline (Walk-in): Pelanggan datang langsung ke lokasi tanpa aplikasi. Admin menerima kedatangan tersebut dan langsung memprosesnya melalui jalur Input Langsung."
ph "[TEMPEL GAMBAR 3.1 - DIAGRAM BPMN DARI DOKUMEN KEL8_REV (GO PLAY).docx DI SINI]"
gj "3.1" "BPMN Proses Bisnis Sistem GO PLAY"
h3 "3.1.2 Tahap Validasi dan Pengecekan"
pp "Validasi Otomatis (Sistem): Untuk pesanan online, Sistem secara otomatis menjalankan fungsi Mengecek Ketersediaan Jadwal. Jika Penuh (TIDAK): Alur dikembalikan ke Member. Jika Tersedia (YA): Pesanan diteruskan ke Admin."
pp "Validasi Manual (Admin): Untuk jalur offline, Admin langsung menuju fitur F-05 untuk mengecek ketersediaan unit secara manual di tempat."
h3 "3.1.3 Tahap Pengelolaan Reservasi dan Persiapan (Admin)"
pp "F-05: Kelola Reservasi: Admin mengonfirmasi booking online yang masuk atau melakukan input manual untuk pelanggan offline."
pp "F-03: Kelola Inventaris: Admin melakukan pengecekan fisik pada perangkat (konsol PS dan controller) untuk memastikan kondisi baik dan layak pakai."
h3 "3.1.4 Tahap Operasional dan Monitoring"
pp "F-06: Aktifkan Timer dan Monitoring: Setelah perangkat siap dan pelanggan mulai bermain, Admin mengaktifkan fitur timer untuk memantau durasi bermain dan memberikan notifikasi sisa waktu secara otomatis."
h3 "3.1.5 Tahap Pelaporan (Output Akhir)"
pp "F-07: Laporan Pendapatan: Setelah sesi bermain selesai dan transaksi ditutup, data secara otomatis mengalir ke lajur Pemilik dalam bentuk laporan pendapatan."
h2 "3.2 Analisis Dokumen"
pp "Analisis dokumen bertujuan untuk mengidentifikasi variabel data yang ada pada sistem manual lama untuk kemudian divalidasi ke dalam skema database sistem baru."
el
bd "Tabel 3.1 Analisis Transformasi Dokumen Manual ke Digital"
ph "[TEMPEL TABEL ANALISIS DOKUMEN (Buku Member > users, Logbook Inventaris > units, Buku Kasir > transactions, Laporan Bulanan > reports) DI SINI]"
h2 "3.3 Analisis Kebutuhan Informasi dan Pengguna (SRS)"
h3 "3.3.1 Kebutuhan Fungsional"
bd "Tabel 3.2 Spesifikasi Kebutuhan Fungsional Sistem GO PLAY"
ph "[TEMPEL TABEL KEBUTUHAN FUNGSIONAL (F-01 sd F-07) DARI FILE Dokumen SRS_Daftar Kebutuhan_Sistem GOPLAY.pdf DI SINI]"
el
pp "F-01 - Login: Memvalidasi kredensial pengguna untuk masuk ke sistem sesuai hak akses. Aktor: Admin, Pemilik, Member. Prioritas: Tinggi."
pp "F-02 - Log Out: Mengakhiri sesi pengguna pada sistem secara aman. Prioritas: Tinggi."
pp "F-03 - Kelola Inventaris: Mengelola data unit (PS4/PS5) dan memantau kelayakan perangkat. Aktor: Admin. Prioritas: Sedang."
pp "F-04 - Booking Online: Melakukan pemesanan jadwal dan unit secara mandiri. Aktor: Member. Prioritas: Tinggi."
pp "F-05 - Kelola Reservasi: Memvalidasi ketersediaan unit, mengonfirmasi, atau mengubah data reservasi. Aktor: Admin. Prioritas: Tinggi."
pp "F-06 - Monitoring Status Unit: Memantau status unit, menjalankan timer otomatis, dan notifikasi sisa waktu. Aktor: Admin, Member. Prioritas: Tinggi."
pp "F-07 - Laporan Pendapatan: Menyusun dan menampilkan rekapitulasi keuangan. Aktor: Admin, Pemilik. Prioritas: Sedang."
h3 "3.3.2 Kebutuhan Non-Fungsional"
bd "Tabel 3.3 Spesifikasi Kebutuhan Non-Fungsional Sistem GO PLAY"
ph "[TEMPEL TABEL KEBUTUHAN NON-FUNGSIONAL (NF-01 sd NF-06) DARI DOKUMEN SRS DI SINI]"
el
pp "NF-01 - Keamanan (Security): Melindungi kerahasiaan data profil pengguna dan enkripsi password. Prioritas: Tinggi."
pp "NF-02 - Ketersediaan (Availability): Sistem harus dapat diakses 24/7. Prioritas: Tinggi."
pp "NF-03 - Akurasi Perhitungan: Menjamin ketepatan perhitungan billing otomatis. Prioritas: Tinggi."
pp "NF-04 - Kemudahan Penggunaan (Usability): Antarmuka harus responsif dan intuitif. Prioritas: Sedang."
pp "NF-05 - Integritas Data (Backup): Melakukan pencadangan database secara berkala. Prioritas: Sedang."
pp "NF-06 - Performa (Performance): Waktu respon sistem tidak boleh lebih dari 3 detik. Prioritas: Sedang."
h2 "3.4 Pemodelan Sistem (UML)"
h3 "3.4.1 Use Case Diagram dan Skenario Use Case"
ph "[TEMPEL GAMBAR 3.2 - USE CASE DIAGRAM DARI DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]"
gj "3.2" "Use Case Diagram Sistem GO PLAY"
el
bd "Skenario Use Case 1: Login"
pp "Aktor: Admin, Member, Pemilik. Deskripsi: Proses masuk ke sistem menggunakan akun yang terdaftar."
pp "Skenario Utama: (1) Aktor membuka aplikasi/web. (2) Sistem menampilkan formulir login. (3) Aktor memasukkan kredensial dan menekan tombol login. (4) Sistem memvalidasi data ke database. (5) Sistem mengarahkan aktor ke dashboard sesuai hak akses masing-masing."
el
bd "Skenario Use Case 2: Log Out"
pp "Aktor: Admin, Member, Pemilik. Deskripsi: Proses keluar dari sesi sistem secara aman."
pp "Skenario Utama: (1) Aktor menekan tombol Log Out. (2) Sistem menghapus sesi aktif. (3) Sistem mengarahkan ke halaman login."
el
bd "Skenario Use Case 3: Kelola Inventaris"
pp "Aktor: Admin. Deskripsi: Mengatur data perangkat (PS4/PS5) yang tersedia."
pp "Skenario Utama: (1) Admin memilih menu Kelola Inventaris. (2) Sistem menampilkan daftar unit. (3) Admin dapat menambah, mengubah status, atau menghapus data unit. (4) Admin menyimpan perubahan. (5) Sistem memperbarui data di database."
el
bd "Skenario Use Case 4: Booking Online"
pp "Aktor: Member. Deskripsi: Melakukan reservasi jadwal main secara mandiri."
pp "Skenario Utama: (1) Member masuk ke menu Booking Online. (2) Member memilih jenis unit dan jadwal. (3) Sistem mengecek ketersediaan otomatis. (4) Member mengonfirmasi pemesanan. (5) Sistem menerbitkan kode reservasi."
el
bd "Skenario Use Case 5: Kelola Reservasi"
pp "Aktor: Admin. Deskripsi: Mengelola dan memproses data booking yang masuk."
pp "Skenario Utama: (1) Admin masuk ke menu Kelola Reservasi. (2) Sistem menampilkan daftar pesanan. (3) Admin melakukan verifikasi. (4) Admin mengubah status (Konfirmasi/Dibatalkan/Selesai). (5) Sistem memperbarui status jadwal."
el
bd "Skenario Use Case 6: Monitoring Status Unit"
pp "Aktor: Admin, Member. Deskripsi: Memantau sisa waktu bermain dan status unit secara real-time."
pp "Skenario Utama: (1) Aktor membuka dashboard monitoring. (2) Sistem menampilkan status unit (Kosong/Terisi/Dipesan). (3) Sistem menjalankan timer otomatis. (4) Sistem memberikan notifikasi jika waktu hampir habis. (5) Admin dapat menghentikan atau menambah durasi billing."
el
bd "Skenario Use Case 7: Laporan Pendapatan"
pp "Aktor: Admin, Pemilik. Deskripsi: Melihat hasil rekapitulasi keuangan dari transaksi sewa."
pp "Skenario Utama: (1) Aktor masuk ke menu Laporan Pendapatan. (2) Aktor menentukan filter periode. (3) Sistem menarik data transaksi berstatus Selesai. (4) Sistem menampilkan total pendapatan dan detail. (5) Aktor dapat mengunduh atau mencetak laporan."
h3 "3.4.2 Activity Diagram"
ph "[TEMPEL GAMBAR 3.3 - ACTIVITY DIAGRAM LOGIN DARI DOKUMEN UML DI SINI]"
gj "3.3" "Activity Diagram - Login"
ph "[TEMPEL GAMBAR 3.4 - ACTIVITY DIAGRAM BOOKING ONLINE DARI DOKUMEN UML DI SINI]"
gj "3.4" "Activity Diagram - Booking Online"
ph "[TEMPEL GAMBAR 3.5 - ACTIVITY DIAGRAM KELOLA RESERVASI DARI DOKUMEN UML DI SINI]"
gj "3.5" "Activity Diagram - Kelola Reservasi"
ph "[TEMPEL GAMBAR 3.6 - ACTIVITY DIAGRAM MONITORING STATUS UNIT DARI DOKUMEN UML DI SINI]"
gj "3.6" "Activity Diagram - Monitoring Status Unit"
ph "[TEMPEL GAMBAR 3.7 - ACTIVITY DIAGRAM KELOLA INVENTARIS DARI DOKUMEN UML DI SINI]"
gj "3.7" "Activity Diagram - Kelola Inventaris"
ph "[TEMPEL GAMBAR 3.8 - ACTIVITY DIAGRAM LAPORAN PENDAPATAN DARI DOKUMEN UML DI SINI]"
gj "3.8" "Activity Diagram - Laporan Pendapatan"
h3 "3.4.3 Robustness Diagram"
ph "[TEMPEL GAMBAR 3.9 - ROBUSTNESS DIAGRAM DARI DOKUMEN DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]"
gj "3.9" "Robustness Diagram Sistem GO PLAY"
h3 "3.4.4 Class Diagram"
ph "[TEMPEL GAMBAR 3.10 - CLASS DIAGRAM DARI DOKUMEN DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]"
gj "3.10" "Class Diagram Sistem GO PLAY"
h3 "3.4.5 Sequence Diagram"
ph "[TEMPEL GAMBAR 3.11 - SEQUENCE DIAGRAM LOGIN DARI DOKUMEN UML DI SINI]"
gj "3.11" "Sequence Diagram - Login"
ph "[TEMPEL GAMBAR 3.12 - SEQUENCE DIAGRAM BOOKING ONLINE DARI DOKUMEN UML DI SINI]"
gj "3.12" "Sequence Diagram - Booking Online"
ph "[TEMPEL GAMBAR 3.13 - SEQUENCE DIAGRAM KELOLA RESERVASI DARI DOKUMEN UML DI SINI]"
gj "3.13" "Sequence Diagram - Kelola Reservasi"
ph "[TEMPEL GAMBAR 3.14 - SEQUENCE DIAGRAM MONITORING UNIT DARI DOKUMEN UML DI SINI]"
gj "3.14" "Sequence Diagram - Monitoring Status Unit"

# ==================== BAB IV ====================
pb
h1 "BAB IV"
h1 "PERANCANGAN SISTEM"
h2 "4.1 Perancangan Arsitektur Sistem"
pp "Sistem GO PLAY dirancang menggunakan pola arsitektur MVC (Model-View-Controller) melalui framework Laravel 12. Model bertanggung jawab atas pengelolaan data dan interaksi dengan database SQLite. View bertanggung jawab atas tampilan antarmuka menggunakan Blade Template Engine dan Vite. Controller bertanggung jawab atas logika bisnis, memproses request pengguna dan mengembalikan respons."
ph "[TEMPEL GAMBAR 4.1 - DIAGRAM ARSITEKTUR SISTEM MVC GO PLAY DI SINI]"
gj "4.1" "Arsitektur Sistem GO PLAY (MVC)"
h2 "4.2 Desain Basis Data"
pp "Basis data sistem GO PLAY dirancang menggunakan SQLite dengan pendekatan relasional. Entitas utama yang terlibat:"
bd "Tabel users: Menyimpan data akun pelanggan (Member)."
pp "Kolom: id, name, email, password, phone, email_verified_at, remember_token, created_at, updated_at."
bd "Tabel admins: Menyimpan data akun Admin."
pp "Kolom: id, name, email, password, remember_token, created_at, updated_at."
bd "Tabel consoles: Menyimpan data unit konsol PS4/PS5."
pp "Kolom: id, name, type (PS4/PS5), status (available/occupied/maintenance), price_per_hour, description, created_at, updated_at."
bd "Tabel bookings: Menyimpan data reservasi."
pp "Kolom: id, booking_code, user_id, console_id, booking_date, start_time, end_time, duration, total_price, status (pending/confirmed/completed/cancelled), payment_status, created_at, updated_at."
bd "Tabel transactions: Menyimpan data transaksi yang telah selesai."
pp "Kolom: id, booking_id, amount, payment_method, paid_at, created_at, updated_at."
ph "[TEMPEL GAMBAR 4.2 - ENTITY RELATIONSHIP DIAGRAM (ERD) DI SINI]"
gj "4.2" "Entity Relationship Diagram (ERD) Sistem GO PLAY"
h2 "4.3 Desain Antarmuka Pengguna (UI)"
pp "Desain antarmuka pengguna sistem GO PLAY dirancang dengan memperhatikan prinsip kemudahan penggunaan (usability) dan estetika visual yang modern. Desain awal (wireframe) dibuat menggunakan Figma (https://www.figma.com/site/S3ShQKDKt7BylYmXNlHTX7/GOPLAY) sebelum diimplementasikan ke dalam kode."
ph "[TEMPEL GAMBAR 4.3 - WIREFRAME HALAMAN UTAMA DARI LAPORAN WIREFRAME UIUX DI SINI]"
gj "4.3" "Wireframe Halaman Utama GO PLAY"
ph "[TEMPEL GAMBAR 4.4 - WIREFRAME HALAMAN LOGIN DARI LAPORAN WIREFRAME UIUX DI SINI]"
gj "4.4" "Wireframe Halaman Login GO PLAY"
ph "[TEMPEL GAMBAR 4.5 - WIREFRAME HALAMAN BOOKING DARI LAPORAN WIREFRAME UIUX DI SINI]"
gj "4.5" "Wireframe Halaman Booking GO PLAY"

# ==================== BAB V ====================
pb
h1 "BAB V"
h1 "IMPLEMENTASI DAN PENGUJIAN"
h2 "5.1 Implementasi Database"
pp "Database sistem GO PLAY diimplementasikan menggunakan SQLite. Struktur tabel dibuat menggunakan fitur Migrations milik Laravel. Perintah untuk menjalankan migrasi: php artisan migrate --seed"
pp "Seeder yang disediakan meliputi: data Admin default, data konsol PS4/PS5 (5 unit), dan data Member contoh untuk keperluan pengujian."
h2 "5.2 Implementasi Antarmuka"
h3 "5.2.1 Halaman Utama dan Login"
ph "[TEMPEL GAMBAR 5.1 - SCREENSHOT HALAMAN UTAMA DARI FILE User_Guide_GoPlay.doc DI SINI]"
gj "5.1" "Screenshot Halaman Utama GO PLAY"
ph "[TEMPEL GAMBAR 5.2 - SCREENSHOT HALAMAN LOGIN DARI USER GUIDE DI SINI]"
gj "5.2" "Screenshot Halaman Login GO PLAY"
h3 "5.2.2 Dashboard dan Fitur Member"
ph "[TEMPEL GAMBAR 5.3 - SCREENSHOT DASHBOARD MEMBER DARI USER GUIDE DI SINI]"
gj "5.3" "Screenshot Dashboard Member GO PLAY"
ph "[TEMPEL GAMBAR 5.4 - SCREENSHOT HALAMAN BOOKING ONLINE DARI USER GUIDE DI SINI]"
gj "5.4" "Screenshot Halaman Booking Online GO PLAY"
h3 "5.2.3 Dashboard dan Fitur Admin"
ph "[TEMPEL GAMBAR 5.5 - SCREENSHOT DASHBOARD ADMIN DARI USER GUIDE DI SINI]"
gj "5.5" "Screenshot Dashboard Admin GO PLAY"
ph "[TEMPEL GAMBAR 5.6 - SCREENSHOT MONITORING TIMER DARI USER GUIDE DI SINI]"
gj "5.6" "Screenshot Monitoring Timer Unit"
ph "[TEMPEL GAMBAR 5.7 - SCREENSHOT KELOLA RESERVASI DARI USER GUIDE DI SINI]"
gj "5.7" "Screenshot Kelola Reservasi Admin"
ph "[TEMPEL GAMBAR 5.8 - SCREENSHOT LAPORAN PENDAPATAN DARI USER GUIDE DI SINI]"
gj "5.8" "Screenshot Laporan Pendapatan GO PLAY"
h2 "5.3 Struktur Program dan Pengelolaan Source Code"
pp "Source code sistem GO PLAY dikelola menggunakan Git dan dipublikasikan pada repositori GitHub:"
pp "https://github.com/adamme26/Sistem-Informasi-Manajemen-dan-Reservasi-Rental-PlayStation-GO-PLAY-Berbasis-Web"
el
pp "Struktur direktori utama:"
pp "app/Http/Controllers/ - Berisi semua Controller (Admin, Member, Auth)"
pp "app/Models/ - Berisi semua Model (User, Admin, Console, Booking, Transaction)"
pp "database/migrations/ - Berisi file migrasi skema database"
pp "database/database.sqlite - File database SQLite"
pp "resources/views/ - Berisi template Blade HTML untuk tampilan"
pp "routes/web.php - File routing seluruh URL aplikasi"
pp "public/ - Berisi asset publik (CSS, JS, gambar)"
pp "vite.config.js - Konfigurasi build tool frontend"
h2 "5.4 Pengujian Menggunakan Tools"
bd "a. Pengujian Manual (Black Box Testing)"
pp "Pengujian dilakukan secara manual dengan cara menjalankan aplikasi dan mencoba setiap fitur satu per satu untuk memastikan output yang dihasilkan sesuai dengan spesifikasi kebutuhan."
bd "b. Pengujian Error Handling"
pp "Diuji dengan cara memasukkan data tidak valid, seperti: input durasi bukan angka (yang menyebabkan error Carbon::rawAddUnit() dan telah diperbaiki dengan casting (int)), pemesanan pada unit yang sudah terisi (double booking prevention), dan login dengan kredensial salah."
el
ph "[TEMPEL TABEL/SCREENSHOT HASIL PENGUJIAN DARI DOKUMENTASI PENGUJIAN TOOLS DI SINI]"
h2 "5.5 User Acceptance Testing (UAT)"
pp "User Acceptance Testing (UAT) dilakukan dengan melibatkan pengguna nyata (Admin dan Member) untuk memastikan sistem telah memenuhi kebutuhan dan ekspektasi pengguna akhir."
ph "[TEMPEL TABEL HASIL UAT DAN FORMULIR PENERIMAAN PENGGUNA DI SINI]"

# ==================== BAB VI ====================
pb
h1 "BAB VI"
h1 "PENUTUP"
h2 "6.1 Kesimpulan"
pp "Berdasarkan hasil analisis, perancangan, implementasi, dan pengujian yang telah dilakukan, dapat ditarik kesimpulan sebagai berikut:"
pp "1. Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY) telah berhasil dikembangkan menggunakan framework Laravel 12 (PHP 8.2) dengan arsitektur MVC dan database SQLite."
pp "2. Sistem berhasil mengimplementasikan tujuh fitur fungsional utama: Login multi-peran, Booking Online, Kelola Reservasi (termasuk Walk-in), Monitoring Status Unit dengan Timer Otomatis, Kelola Inventaris, Laporan Pendapatan, dan Logout."
pp "3. Fitur Booking Online berhasil mencegah terjadinya double booking melalui mekanisme pengecekan ketersediaan jadwal secara otomatis sebelum reservasi dikonfirmasi."
pp "4. Fitur Timer Otomatis pada dashboard Admin berhasil memantau durasi bermain pelanggan secara real-time dan memberikan notifikasi saat waktu hampir habis."
pp "5. Dashboard Laporan Pendapatan berhasil menyajikan rekapitulasi keuangan yang akurat dan dapat difilter berdasarkan periode kepada Pemilik usaha."
pp "6. Sistem telah diuji melalui pengujian fungsional (black-box) dan UAT, dengan hasil yang menunjukkan bahwa seluruh fitur berjalan sesuai dengan spesifikasi kebutuhan."
h2 "6.2 Saran"
pp "Untuk pengembangan sistem GO PLAY ke depannya, beberapa saran yang dapat dipertimbangkan:"
pp "1. Integrasi Payment Gateway: Menambahkan fitur pembayaran digital (Midtrans, QRIS) agar transaksi dapat diselesaikan secara online."
pp "2. Notifikasi WhatsApp/Email: Mengintegrasikan notifikasi otomatis via WhatsApp API atau email untuk konfirmasi booking dan pengingat jadwal."
pp "3. Pengembangan Aplikasi Mobile: Membangun versi aplikasi mobile (Android/iOS) agar Member dapat booking melalui smartphone."
pp "4. Deployment ke Server Hosting: Mengoptimalkan sistem untuk di-deploy ke server hosting Linux dengan database MySQL agar dapat diakses publik 24/7."
pp "5. Fitur Review dan Rating: Menambahkan fitur ulasan dari pelanggan untuk membantu Pemilik mengevaluasi kualitas layanan."

# ==================== DAFTAR PUSTAKA ====================
pb
h1 "DAFTAR PUSTAKA"
pp "[1]  O Brien, J. A., dan Marakas, G. M. (2011). Management Information Systems (10th ed.). McGraw-Hill."
pp "[2]  Pressman, R. S., dan Maxim, B. R. (2015). Software Engineering: A Practitioner Approach (8th ed.). McGraw-Hill Education."
pp "[3]  Laravel. (2024). Laravel 12.x Documentation. https://laravel.com/docs/12.x"
pp "[4]  Sommerville, I. (2016). Software Engineering (10th ed.). Pearson Education."
pp "[5]  Fowler, M. (2002). Patterns of Enterprise Application Architecture. Addison-Wesley Professional."
pp "[6]  SQLite Consortium. (2024). SQLite Documentation. https://www.sqlite.org/docs.html"
pp "[7]  Object Management Group. (2017). Unified Modeling Language (UML) Specification Version 2.5.1. https://www.omg.org/spec/UML/"
pp "[8]  Object Management Group. (2013). Business Process Model and Notation (BPMN) Version 2.0.2. https://www.omg.org/spec/BPMN/"
pp "[9]  Nielsen, J. (1994). Usability Engineering. Morgan Kaufmann Publishers."
pp "[10] Connolly, T. M., dan Begg, C. E. (2014). Database Systems: A Practical Approach (6th ed.). Pearson Education."

# ==================== LAMPIRAN ====================
pb
h1 "LAMPIRAN"
h2 "Lampiran 1 - Profile Tim Proyek"
ph "[TEMPEL SELURUH ISI DOKUMEN Lampiran Profile Tim Proyek Go Play.docx DI SINI]"
h2 "Lampiran 2 - Dokumen Project Charter"
ph "[TEMPEL SELURUH ISI DOKUMEN Lampiran Project Charter GO PLAY .pdf DI SINI]"
h2 "Lampiran 3 - WBS dan Timeline"
ph "[TEMPEL SELURUH GAMBAR DARI Lampiran Dokumen WBS dan Timeline Proyek GO PLAY.pdf DI SINI]"
h2 "Lampiran 4 - Dokumen SRS / Daftar Kebutuhan"
ph "[TEMPEL SELURUH ISI DOKUMEN Dokumen SRS_Daftar Kebutuhan_Sistem GOPLAY.pdf DI SINI]"
h2 "Lampiran 5 - Dokumen UML"
ph "[TEMPEL SELURUH GAMBAR DIAGRAM DARI DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]"
h2 "Lampiran 6 - Dokumen UI/UX (Wireframe)"
ph "[TEMPEL GAMBAR WIREFRAME DARI FILE LAPORAN WIREFRAME UIUX PROYEK PERANGKAT LUNAK.pdf DI SINI]"
h2 "Lampiran 7 - Dokumentasi Source Code"
pp "Repository GitHub: https://github.com/adamme26/Sistem-Informasi-Manajemen-dan-Reservasi-Rental-PlayStation-GO-PLAY-Berbasis-Web"
ph "[TEMPEL SCREENSHOT REPOSITORI GITHUB DAN CUPLIKAN KODE PENTING DI SINI]"
h2 "Lampiran 8 - Dokumentasi Pengujian Tools dan UAT"
ph "[TEMPEL TABEL HASIL PENGUJIAN TOOLS DAN UAT DI SINI]"
h2 "Lampiran 9 - Dokumentasi Penggunaan Sistem (User Guide)"
ph "[TEMPEL SELURUH ISI DOKUMEN User_Guide_GoPlay.doc DI SINI]"

# ==================== CLOSE DOCUMENT ====================
ap '<w:sectPr><w:pgSz w:w="12240" w:h="15840"/><w:pgMar w:top="1440" w:right="1080" w:bottom="1440" w:left="1800"/></w:sectPr>'
ap '</w:body></w:document>'

WriteFile "$tmpDir\word\document.xml" $sb.ToString()

[System.IO.Compression.ZipFile]::CreateFromDirectory($tmpDir, $outputPath, [System.IO.Compression.CompressionLevel]::Optimal, $false)
Remove-Item $tmpDir -Recurse -Force

$size = (Get-Item $outputPath).Length / 1KB
Write-Output "SUCCESS: File created!"
Write-Output "Path: $outputPath"
Write-Output "Size: $([math]::Round($size, 2)) KB"
