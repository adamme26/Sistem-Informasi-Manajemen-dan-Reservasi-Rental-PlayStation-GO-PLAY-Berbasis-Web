Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$outputPath = 'C:\Users\noval mulyadi\Documents\SMT4\Proyek Perangkat Lunak\LAPORAN\KEL8_REV_UPDATED ( GO PLAY ).docx'
$tmpDir     = 'C:\Users\noval mulyadi\.gemini\antigravity\scratch\goplay\docx_kel8_v2'

if (Test-Path $outputPath) { Remove-Item $outputPath -Force }
if (Test-Path $tmpDir)     { Remove-Item $tmpDir -Recurse -Force }
New-Item -ItemType Directory -Path "$tmpDir\_rels"       -Force | Out-Null
New-Item -ItemType Directory -Path "$tmpDir\word\_rels"  -Force | Out-Null

# ── Write file helper ──────────────────────────────────────────────
function WF([string]$path,[string]$content){
    [System.IO.File]::WriteAllText($path,$content,[System.Text.Encoding]::UTF8)
}

# ── XML-escape plain text ──────────────────────────────────────────
function XE([string]$s){
    $s = $s.Replace('&','&amp;')
    $s = $s.Replace('<','&lt;')
    $s = $s.Replace('>','&gt;')
    $s = $s.Replace('"','&quot;')
    return $s
}

# ── Static package files ───────────────────────────────────────────
WF "$tmpDir\[Content_Types].xml" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml"  ContentType="application/xml"/>
  <Override PartName="/word/document.xml"
    ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/styles.xml"
    ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
</Types>'

WF "$tmpDir\_rels\.rels" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1"
    Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"
    Target="word/document.xml"/>
</Relationships>'

WF "$tmpDir\word\_rels\document.xml.rels" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1"
    Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles"
    Target="styles.xml"/>
</Relationships>'

WF "$tmpDir\word\styles.xml" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">

<w:style w:type="paragraph" w:default="1" w:styleId="Normal">
  <w:name w:val="Normal"/>
  <w:pPr>
    <w:jc w:val="both"/>
    <w:spacing w:before="0" w:after="120" w:line="480" w:lineRule="auto"/>
  </w:pPr>
  <w:rPr>
    <w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman" w:cs="Times New Roman"/>
    <w:sz w:val="24"/><w:szCs w:val="24"/>
  </w:rPr>
</w:style>

<w:style w:type="paragraph" w:styleId="H1">
  <w:name w:val="heading 1"/>
  <w:basedOn w:val="Normal"/>
  <w:pPr>
    <w:jc w:val="center"/>
    <w:spacing w:before="0" w:after="240" w:line="480" w:lineRule="auto"/>
    <w:pageBreakBefore/>
  </w:pPr>
  <w:rPr>
    <w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/>
    <w:b/><w:sz w:val="32"/><w:szCs w:val="32"/>
  </w:rPr>
</w:style>

<w:style w:type="paragraph" w:styleId="H2">
  <w:name w:val="heading 2"/>
  <w:basedOn w:val="Normal"/>
  <w:pPr>
    <w:jc w:val="left"/>
    <w:spacing w:before="240" w:after="120" w:line="480" w:lineRule="auto"/>
  </w:pPr>
  <w:rPr>
    <w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/>
    <w:b/><w:sz w:val="28"/><w:szCs w:val="28"/>
  </w:rPr>
</w:style>

<w:style w:type="paragraph" w:styleId="H3">
  <w:name w:val="heading 3"/>
  <w:basedOn w:val="Normal"/>
  <w:pPr>
    <w:jc w:val="left"/>
    <w:spacing w:before="120" w:after="60" w:line="480" w:lineRule="auto"/>
  </w:pPr>
  <w:rPr>
    <w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/>
    <w:b/><w:sz w:val="26"/><w:szCs w:val="26"/>
  </w:rPr>
</w:style>

<w:style w:type="paragraph" w:styleId="CTR">
  <w:name w:val="CTR"/>
  <w:basedOn w:val="Normal"/>
  <w:pPr><w:jc w:val="center"/></w:pPr>
</w:style>

<w:style w:type="paragraph" w:styleId="CAP">
  <w:name w:val="CAP"/>
  <w:basedOn w:val="Normal"/>
  <w:pPr><w:jc w:val="center"/><w:spacing w:before="0" w:after="120"/></w:pPr>
  <w:rPr><w:i/><w:sz w:val="20"/></w:rPr>
</w:style>

<w:style w:type="paragraph" w:styleId="PH">
  <w:name w:val="PH"/>
  <w:basedOn w:val="Normal"/>
  <w:pPr>
    <w:jc w:val="center"/>
    <w:spacing w:before="120" w:after="120" w:line="240" w:lineRule="auto"/>
    <w:pBdr>
      <w:top    w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/>
      <w:left   w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/>
      <w:bottom w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/>
      <w:right  w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/>
    </w:pBdr>
    <w:shd w:val="clear" w:color="auto" w:fill="FFFF00"/>
  </w:pPr>
  <w:rPr><w:b/><w:color w:val="CC0000"/></w:rPr>
</w:style>

<w:style w:type="paragraph" w:styleId="LI">
  <w:name w:val="LI"/>
  <w:basedOn w:val="Normal"/>
  <w:pPr>
    <w:jc w:val="both"/>
    <w:spacing w:before="0" w:after="60" w:line="480" w:lineRule="auto"/>
    <w:ind w:left="720" w:hanging="0"/>
  </w:pPr>
</w:style>

</w:styles>'

# ── Document builder ───────────────────────────────────────────────
$sb = [System.Text.StringBuilder]::new(500000)

$sb.Append('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>') | Out-Null
$sb.Append('<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">') | Out-Null
$sb.Append('<w:body>') | Out-Null

# Paragraph builders (all text is XML-escaped via XE)
function ap([string]$xml) { $sb.Append($xml) | Out-Null }

function h1([string]$t) {
    $e = XE $t
    ap "<w:p><w:pPr><w:pStyle w:val=`"H1`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$e</w:t></w:r></w:p>"
}
function h2([string]$t) {
    $e = XE $t
    ap "<w:p><w:pPr><w:pStyle w:val=`"H2`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$e</w:t></w:r></w:p>"
}
function h3([string]$t) {
    $e = XE $t
    ap "<w:p><w:pPr><w:pStyle w:val=`"H3`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$e</w:t></w:r></w:p>"
}
function pp([string]$t) {
    $e = XE $t
    ap "<w:p><w:pPr><w:pStyle w:val=`"Normal`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$e</w:t></w:r></w:p>"
}
function pc([string]$t) {
    $e = XE $t
    ap "<w:p><w:pPr><w:pStyle w:val=`"CTR`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$e</w:t></w:r></w:p>"
}
function ph([string]$t) {
    $e = XE $t
    ap "<w:p><w:pPr><w:pStyle w:val=`"PH`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$e</w:t></w:r></w:p>"
}
function bd([string]$t) {
    $e = XE $t
    ap "<w:p><w:pPr><w:pStyle w:val=`"Normal`"/></w:pPr><w:r><w:rPr><w:b/></w:rPr><w:t xml:space=`"preserve`">$e</w:t></w:r></w:p>"
}
function li([string]$t) {
    $e = XE $t
    ap "<w:p><w:pPr><w:pStyle w:val=`"LI`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$e</w:t></w:r></w:p>"
}
function gj([string]$num,[string]$cap) {
    $e = XE "Gambar $num $cap"
    ap "<w:p><w:pPr><w:pStyle w:val=`"CAP`"/></w:pPr><w:r><w:rPr><w:i/></w:rPr><w:t xml:space=`"preserve`">$e</w:t></w:r></w:p>"
}
function el() {
    ap "<w:p><w:pPr><w:pStyle w:val=`"Normal`"/></w:pPr></w:p>"
}
function pb() {
    ap "<w:p><w:r><w:br w:type=`"page`"/></w:r></w:p>"
}

# =====================================================================
# COVER
# =====================================================================
ap "<w:p><w:pPr><w:pStyle w:val=`"H1`"/><w:spacing w:before=`"2880`" w:after=`"240`"/></w:pPr><w:r><w:t>LAPORAN AKHIR PROYEK PERANGKAT LUNAK</w:t></w:r></w:p>"
pc '"Sistem Informasi Manajemen dan Reservasi Rental PlayStation ( GO PLAY ) Berbasis Web"'
el; el
ph "[TEMPEL LOGO UNIVERSITAS SUBANG DI SINI]"
el; el
pc "Disusun oleh:"
pc "Kelompok  8"
el
pc "ADAM. F                    D1A240046"
pc "AZFAR WILDAN. P            D1A240026"
pc "M. NOVAL MULYADI           D1A240039"
pc "DIVI AGUNG SATRIA          D1A240038"
pc "RAMDAN PRAYITNO            D1A240032"
el; el
pc "PROGRAM STUDI SISTEM INFORMASI"
pc "FAKULTAS ILMU KOMPUTER"
pc "UNIVERSITAS SUBANG"
pc "2026"

# =====================================================================
# LEMBAR PENGESAHAN  (diperbaiki dari "PENGASAHAN")
# =====================================================================
pb
h1 "LEMBAR PENGESAHAN"
el
pp "Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY) Berbasis Web"
el
bd "Susunan Tim Proyek:"
el
bd "Project Manager     : Adam Faturrachman                (D1A240046)"
bd "System Analyst      : Ramdan Prayitno                  (D1A240032)"
bd "Designer System     : Muhamad Noval Mulyadi            (D1A240039)"
bd "System Developer    : Azfar Muhammad Wildan Pratama    (D1A240026)"
bd "Tester System       : Divi Agung Satria                (D1A240038)"
el; el
pc "Mengetahui,"
pc "Dosen Pengampu Mata Kuliah Proyek Perangkat Lunak"
el; el; el
pc "Bagus Ali Akbar, S.Si., M.Kom."
pc "NIP. 0410 420 211"

# =====================================================================
# ABSTRAK
# =====================================================================
pb
h1 "ABSTRAK"
pp "Rental PlayStation GO PLAY yang berlokasi di Rawabadak, Kabupaten Subang, saat ini masih mengandalkan sistem pengelolaan konvensional menggunakan buku besar yang rentan terhadap kesalahan manusia (human error), bentrok jadwal (double booking), dan sulitnya rekapitulasi laporan pendapatan secara akurat. Penelitian ini bertujuan untuk membangun Sistem Informasi Manajemen dan Reservasi Rental PlayStation berbasis web guna mengatasi permasalahan tersebut. Sistem dibangun menggunakan framework Laravel 12 (PHP 8.2) dengan arsitektur MVC (Model-View-Controller) dan database SQLite, serta antarmuka yang dikompilasi menggunakan Vite. Hasil pengembangan berupa aplikasi web dengan tiga peran pengguna (Admin, Member, dan Pemilik) yang memiliki fitur utama: Booking Online, Kelola Reservasi (termasuk Walk-in), Monitoring Status Unit dengan Timer Otomatis, Kelola Inventaris, dan Laporan Pendapatan. Sistem telah diuji menggunakan metode Black Box Testing dan User Acceptance Testing (UAT), dengan hasil menunjukkan seluruh fitur berjalan sesuai spesifikasi kebutuhan yang ditetapkan."
el
bd "Kata Kunci: Sistem Informasi, Rental PlayStation, Booking Online, Laravel, MVC, Timer Otomatis."
el
h1 "ABSTRACT"
pp "GO PLAY PlayStation Rental, located in Rawabadak, Subang Regency, currently still relies on a conventional management system using ledger books that are prone to human error, scheduling conflicts (double booking), and difficulties in accurately compiling revenue reports. This study aims to build a web-based PlayStation Rental Management and Reservation Information System to address these problems. The system was built using the Laravel 12 framework (PHP 8.2) with MVC architecture and SQLite database, with an interface compiled using Vite. The result is a web application with three user roles (Admin, Member, and Owner) featuring Online Booking, Reservation Management (including Walk-in), Unit Status Monitoring with Automatic Timer, Inventory Management, and Revenue Reports. The system has been tested using Black Box Testing and User Acceptance Testing (UAT), with results showing all features working according to specified requirements."
el
bd "Keywords: Information System, PlayStation Rental, Online Booking, Laravel, MVC, Automatic Timer."

# =====================================================================
# DAFTAR ISI  (diperbarui – teknologi benar)
# =====================================================================
pb
h1 "DAFTAR ISI"
pp "LEMBAR PENGESAHAN"
pp "ABSTRAK"
pp "ABSTRACT"
pp "DAFTAR ISI"
pp "DAFTAR GAMBAR"
pp "BAB I    PENDAHULUAN"
pp "    1.1  Latar Belakang Masalah"
pp "    1.2  Identifikasi Masalah"
pp "    1.3  Tujuan Pengembangan Sistem"
pp "    1.4  Ruang Lingkup Proyek"
pp "    1.5  Manfaat yang Diharapkan"
pp "BAB II   TINJAUAN SINGKAT DAN LANDASAN KONSEPTUAL"
pp "    2.1  Gambaran Umum Objek Studi Kasus"
pp "    2.2  Landasan Teori dan Konsep Dasar"
pp "         2.2.1  Sistem Informasi"
pp "         2.2.2  Aplikasi Berbasis Web"
pp "         2.2.3  Konsep Real-time Monitoring"
pp "    2.3  Teknologi dan Framework yang Digunakan"
pp "         2.3.1  PHP (Hypertext Preprocessor)"
pp "         2.3.2  Laravel 12"
pp "         2.3.3  SQLite"
pp "         2.3.4  Vite"
pp "    2.4  Metodologi Pengembangan Perangkat Lunak (Waterfall)"
pp "    2.5  Alat Perancangan Sistem (UML)"
pp "BAB III  ANALISIS SISTEM"
pp "    3.1  Analisis Proses Bisnis (BPMN)"
pp "    3.2  Analisis Dokumen"
pp "         3.2.1  Analisis Kebutuhan Sistem (SRS)"
pp "    3.3  Pemodelan Sistem (UML)"
pp "         3.3.1  Use Case Diagram dan Skenario Use Case"
pp "         3.3.2  Activity Diagram"
pp "         3.3.3  Robustness Diagram"
pp "         3.3.4  Class Diagram"
pp "         3.3.5  Sequence Diagram"
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

# =====================================================================
# DAFTAR GAMBAR
# =====================================================================
pb
h1 "DAFTAR GAMBAR"
pp "Gambar 3.1   BPMN Proses Bisnis Sistem GO PLAY"
pp "Gambar 3.2   Use Case Diagram Sistem GO PLAY"
pp "Gambar 3.3   Activity Diagram - Login"
pp "Gambar 3.4   Activity Diagram - Logout"
pp "Gambar 3.5   Activity Diagram - Booking Online"
pp "Gambar 3.6   Activity Diagram - Monitoring Status Unit"
pp "Gambar 3.7   Activity Diagram - Kelola Reservasi"
pp "Gambar 3.8   Activity Diagram - Kelola Inventaris"
pp "Gambar 3.9   Activity Diagram - Laporan Pendapatan"
pp "Gambar 3.10  Robustness Diagram Sistem GO PLAY"
pp "Gambar 3.11  Class Diagram Sistem GO PLAY"
pp "Gambar 3.12  Sequence Diagram - Login"
pp "Gambar 3.13  Sequence Diagram - Logout"
pp "Gambar 3.14  Sequence Diagram - Reservasi / Booking Online"
pp "Gambar 3.15  Sequence Diagram - Laporan Pendapatan"
pp "Gambar 3.16  Sequence Diagram - Kelola Inventaris"
pp "Gambar 3.17  Sequence Diagram - Monitoring Status Unit"
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

# =====================================================================
# BAB I – PENDAHULUAN
# =====================================================================
pb
h1 "BAB I"
h1 "PENDAHULUAN"

h2 "1.1 Latar Belakang Masalah"
pp "Di era digitalisasi saat ini, efisiensi operasional merupakan kunci utama keberlanjutan usaha, termasuk pada sektor hiburan seperti rental video game. Rental PlayStation GO PLAY yang berlokasi di Rawabadak, Kabupaten Subang, saat ini masih mengandalkan sistem pengelolaan konvensional. Seluruh alur kerja, mulai dari pencatatan ketersediaan unit, pendaftaran member, hingga manajemen durasi bermain (billing), masih dilakukan secara manual menggunakan buku besar."
pp "Ketergantungan pada sistem manual ini menimbulkan beberapa kendala kritikal. Pertama, tidak adanya sinkronisasi data secara real-time sering kali menyebabkan double booking atau bentrok jadwal ketika pelanggan melakukan reservasi melalui WhatsApp. Kedua, perhitungan biaya sewa manual sering kali menimbulkan ketidakakuratan yang merugikan baik bagi pengelola maupun pelanggan. Selain itu, risiko kerusakan atau kehilangan fisik buku catatan menjadi ancaman serius bagi integritas laporan keuangan usaha."
pp "Untuk mengatasi kompleksitas tersebut, diperlukan transformasi digital melalui pengembangan Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY) Berbasis Web. Sistem ini dirancang untuk mengintegrasikan seluruh data inventaris unit PS4 dan PS5 dengan modul reservasi dan billing otomatis. Pemilihan platform berbasis web bertujuan agar sistem dapat diakses secara fleksibel oleh pengelola maupun member tanpa terbatas oleh perangkat tertentu."

h2 "1.2 Identifikasi Masalah"
pp "Berdasarkan latar belakang tersebut, masalah-masalah yang diidentifikasi adalah sebagai berikut:"
pp "1. Inefisiensi Administrasi: Proses pencatatan transaksi secara manual memerlukan waktu lama dan rentan terhadap kesalahan penulisan (human error)."
pp "2. Lemahnya Transparansi Informasi: Member tidak memiliki akses langsung untuk memantau status ketersediaan unit secara real-time."
pp "3. Kurangnya Akurasi Billing: Penentuan biaya sewa sering mengalami selisih karena perhitungan durasi bermain yang tidak menggunakan sistem timer otomatis."
pp "4. Kesulitan Rekapitulasi Data: Pemilik (owner) kesulitan dalam melakukan audit pendapatan harian maupun bulanan karena data tidak tersimpan dalam basis data yang terstruktur dan aman."

h2 "1.3 Tujuan Pengembangan Sistem"
pp "Adapun tujuan yang ingin dicapai dalam pengembangan proyek perangkat lunak ini adalah:"
pp "1. Membangun sistem informasi berbasis web yang mampu mengotomatisasi seluruh proses bisnis pada Rental PS GO PLAY."
pp "2. Menyediakan fitur Booking Online mandiri bagi member untuk meningkatkan kepastian jadwal bermain."
pp "3. Mengimplementasikan fitur Monitoring Status Unit yang dilengkapi dengan timer otomatis sebagai dasar perhitungan billing yang akurat."
pp "4. Menghasilkan Laporan Pendapatan yang transparan dan akurat guna memudahkan manajemen usaha oleh Pemilik."

h2 "1.4 Ruang Lingkup Proyek"
pp "Agar pengembangan tetap fokus dan terukur, ruang lingkup proyek ini dibatasi pada:"
pp "1. Fungsionalitas Utama: Manajemen akun (Login dan Log Out), pengelolaan inventaris (PS4/PS5), sistem reservasi online, monitoring status unit (real-time timer), dan pelaporan pendapatan harian/bulanan."
pp "2. Aktor Sistem: Admin (pengelola operasional), Pemilik (pemantau laporan), dan Member (pelanggan terdaftar)."
pp "3. Teknologi: Framework Laravel 12 (PHP 8.2) dengan database SQLite dan frontend Vite + Blade."
pp "4. Batasan Sistem: Sistem tidak mencakup kontrol perangkat keras dan belum mendukung integrasi payment gateway."

h2 "1.5 Manfaat yang Diharapkan"
pp "Bagi Pemilik (Owner): Kemudahan memantau kinerja bisnis secara real-time serta keamanan data finansial melalui laporan pendapatan yang terstruktur."
pp "Bagi Admin: Mempercepat pelayanan transaksi, mempermudah kontrol unit, dan mengurangi beban kerja administratif yang repetitif."
pp "Bagi Member (Pelanggan): Pengalaman pemesanan yang lebih modern, cepat, serta transparansi biaya dan waktu bermain yang lebih jelas."
pp "Bagi Pengembang: Sarana penerapan ilmu rekayasa perangkat lunak dalam membangun sistem informasi berbasis web menggunakan framework modern."

# =====================================================================
# BAB II – TINJAUAN SINGKAT (teknologi dikoreksi ke Laravel/SQLite)
# =====================================================================
pb
h1 "BAB II"
h1 "TINJAUAN SINGKAT DAN LANDASAN KONSEPTUAL"

h2 "2.1 Gambaran Umum Objek Studi Kasus"
pp "Rental PlayStation GO PLAY merupakan unit usaha yang bergerak di bidang jasa hiburan digital yang berlokasi di Rawabadak, Kabupaten Subang. Usaha ini menyediakan fasilitas penyewaan konsol PlayStation 4 (PS4) dan PlayStation 5 (PS5) dengan sistem sewa berbasis durasi waktu."
pp "Operasional GO PLAY didukung oleh dua aktor utama: Pemilik (Owner) yang mengawasi arus kas dan kebijakan bisnis, serta Admin yang menangani layanan transaksi harian. Meskipun memiliki basis pelanggan yang stabil di wilayah Subang, GO PLAY masih menghadapi kendala efisiensi akibat penggunaan buku besar dalam pencatatan transaksi."

h2 "2.2 Landasan Teori dan Konsep Dasar"

h3 "2.2.1 Sistem Informasi"
pp "Sistem Informasi adalah kombinasi dari orang-orang, perangkat keras (hardware), perangkat lunak (software), jaringan komunikasi, dan sumber daya data yang mengumpulkan, mengubah, dan menyebarkan informasi dalam sebuah organisasi (O'Brien dan Marakas, 2011). Dalam konteks GO PLAY, sistem ini berfungsi mengolah data transaksi sewa menjadi informasi laporan pendapatan yang terstruktur."

h3 "2.2.2 Aplikasi Berbasis Web"
pp "Aplikasi berbasis web adalah perangkat lunak yang diakses melalui penjelajah web (web browser) melalui jaringan internet atau intranet. Keunggulan utama adalah sifatnya yang multi-platform, sehingga dapat diakses oleh Member maupun Admin melalui berbagai perangkat tanpa perlu instalasi tambahan."

h3 "2.2.3 Konsep Real-time Monitoring"
pp "Monitoring adalah proses pengumpulan data secara terus-menerus mengenai indikator kinerja tertentu. Konsep real-time memastikan bahwa setiap perubahan data pada status unit akan langsung memperbarui tampilan antarmuka (dashboard), mencegah terjadinya kesalahan informasi bagi Member yang ingin melakukan reservasi."

h2 "2.3 Teknologi dan Framework yang Digunakan"

h3 "2.3.1 PHP (Hypertext Preprocessor)"
pp "PHP adalah bahasa pemrograman server-side yang dirancang khusus untuk pengembangan web. Proyek ini menggunakan PHP versi 8.2 yang menawarkan performa lebih cepat, fitur keamanan terbaru, dan type-hinting yang lebih baik untuk menjaga stabilitas sistem billing."

h3 "2.3.2 Laravel 12"
pp "Laravel adalah framework PHP open-source yang menggunakan pola desain MVC (Model-View-Controller). Laravel 12 digunakan sebagai backbone backend sistem GO PLAY karena kemampuannya dalam menangani routing yang kompleks, sistem autentikasi multi-guard (membedakan Admin, Member, dan Pemilik), manajemen database melalui Eloquent ORM, serta fitur keamanan bawaan seperti proteksi CSRF dan enkripsi password menggunakan Bcrypt."
pp "Komponen MVC dalam Laravel:"
pp "Model    : Mengelola interaksi dengan database (tabel users, admins, consoles, bookings, transactions)."
pp "View     : Mengelola tampilan antarmuka menggunakan Blade Template Engine."
pp "Controller : Menghubungkan logika bisnis antara Model dan View, dipisahkan berdasarkan peran (Admin, Member, Auth)."

h3 "2.3.3 SQLite"
pp "SQLite adalah sistem manajemen basis data relasional berbasis file yang ringan dan tidak memerlukan server database terpisah. SQLite dipilih untuk pengembangan dan pengujian lokal sistem GO PLAY karena kemudahannya dalam setup dan portabilitasnya. Seluruh data sistem tersimpan dalam satu file database.sqlite."

h3 "2.3.4 Vite"
pp "Vite adalah build tool frontend generasi terbaru yang digunakan sebagai pengganti Laravel Mix. Vite menyediakan fitur Hot Module Replacement (HMR) yang memberikan pembaruan tampilan secara instan selama proses pengembangan tanpa perlu me-refresh browser secara manual."

h2 "2.4 Metodologi Pengembangan Perangkat Lunak (Waterfall)"
pp "Pengembangan sistem GO PLAY menggunakan metodologi Waterfall, yaitu pendekatan pengembangan perangkat lunak yang bersifat sekuensial dan terstruktur. Setiap fase harus diselesaikan sepenuhnya sebelum melanjutkan ke fase berikutnya. Tahapan metodologi Waterfall:"
pp "1. Analisis Kebutuhan  : Mengidentifikasi kebutuhan fungsional (F-01 s.d. F-07) dan non-fungsional (NF-01 s.d. NF-06) berdasarkan wawancara dengan pemilik GO PLAY."
pp "2. Perancangan Sistem  : Merancang arsitektur MVC, struktur ERD, diagram UML, dan wireframe Figma."
pp "3. Implementasi (Coding) : Mengimplementasikan rancangan ke dalam kode program menggunakan Laravel 12, SQLite, Blade, dan Vite."
pp "4. Pengujian            : Black Box Testing dan User Acceptance Testing (UAT)."
pp "5. Pemeliharaan         : Perbaikan bug dan penyesuaian sistem pasca-pengujian."

h2 "2.5 Alat Perancangan Sistem (UML)"
pp "Untuk memodelkan kebutuhan dan alur sistem, digunakan diagram dari Unified Modeling Language (UML):"
pp "Use Case Diagram   : Menggambarkan interaksi antara aktor dengan fungsionalitas sistem."
pp "Activity Diagram   : Menggambarkan aliran kerja (workflow) dari setiap proses bisnis."
pp "Robustness Diagram : Menggambarkan hubungan antara aktor, boundary, control, dan entity."
pp "Class Diagram      : Menggambarkan struktur kelas dan hubungan antar objek dalam database."
pp "Sequence Diagram   : Menggambarkan urutan interaksi antar objek dalam setiap skenario use case."

# =====================================================================
# BAB III – ANALISIS SISTEM
# =====================================================================
pb
h1 "BAB III"
h1 "ANALISIS SISTEM"

h2 "3.1 Analisis Proses Bisnis (BPMN)"
pp "Analisis proses bisnis dilakukan untuk memetakan aliran kerja sistem yang diusulkan (To-Be Process). Proses ini digambarkan menggunakan notasi BPMN (Business Process Model and Notation) yang membagi aktivitas berdasarkan pool dan lane aktor."

h3 "3.1.1 Inisiasi Proses (Dua Jalur Utama)"
pp "Jalur Online (Member): Proses dimulai ketika Member melakukan F-01: Login Member. Setelah login, Member masuk ke fitur F-04: Input Booking untuk memilih jadwal bermain dan unit PS yang diinginkan."
pp "Jalur Offline (Walk-in): Pelanggan datang langsung ke lokasi (tanpa aplikasi). Admin menerima kedatangan tersebut dan langsung memprosesnya melalui jalur Input Langsung."
ph "[TEMPEL GAMBAR 3.1 - DIAGRAM BPMN DARI DOKUMEN KEL8_REV (GO PLAY).docx DI SINI]"
gj "3.1" "BPMN Proses Bisnis Sistem GO PLAY"

h3 "3.1.2 Tahap Validasi dan Pengecekan"
pp "Validasi Otomatis (Sistem): Untuk pesanan online, Sistem secara otomatis menjalankan fungsi Mengecek Ketersediaan Jadwal. Jika Penuh: alur dikembalikan ke Member. Jika Tersedia: pesanan diteruskan ke Admin."
pp "Validasi Manual (Admin): Untuk jalur offline, Admin langsung menuju fitur F-05 untuk mengecek ketersediaan unit secara manual di tempat."

h3 "3.1.3 Tahap Pengelolaan Reservasi dan Persiapan (Admin)"
pp "F-05: Kelola Reservasi: Admin mengonfirmasi booking online yang masuk atau melakukan input manual untuk pelanggan offline."
pp "F-03: Kelola Inventaris: Admin melakukan pengecekan fisik pada perangkat (konsol PS dan controller) untuk memastikan kondisi baik dan layak pakai."

h3 "3.1.4 Tahap Operasional dan Monitoring"
pp "F-06: Aktifkan Timer dan Monitoring: Setelah perangkat siap dan pelanggan mulai bermain, Admin mengaktifkan fitur timer untuk memantau durasi bermain dan memberikan notifikasi sisa waktu secara otomatis."

h3 "3.1.5 Tahap Pelaporan (Output Akhir)"
pp "F-07: Laporan Pendapatan: Setelah sesi bermain selesai dan transaksi ditutup, data secara otomatis mengalir ke lajur Pemilik dalam bentuk laporan pendapatan untuk rekapitulasi keuangan."

h2 "3.2 Analisis Dokumen"
pp "Analisis dokumen bertujuan untuk mengidentifikasi variabel data pada sistem manual lama untuk kemudian divalidasi ke dalam skema database sistem baru."
el
bd "Tabel 3.1 Analisis Transformasi Dokumen Manual ke Sistem Digital"
ph "[TEMPEL TABEL ANALISIS DOKUMEN (Buku Member, Logbook Inventaris, Buku Kasir, Laporan Bulanan) DI SINI]"

h3 "3.2.1 Analisis Kebutuhan Sistem (SRS)"
pp "Berdasarkan dokumen SRS, kebutuhan sistem dirinci menjadi Fungsional dan Non-Fungsional."
el
bd "Tabel 3.2 Kebutuhan Fungsional (Functional Requirements)"
ph "[TEMPEL TABEL KEBUTUHAN FUNGSIONAL (F-01 sd F-07) DARI FILE Dokumen SRS_Daftar Kebutuhan_Sistem GOPLAY.pdf DI SINI]"
el
pp "F-01 Login              : Memvalidasi kredensial pengguna. Aktor: Admin, Pemilik, Member. Prioritas: Tinggi."
pp "F-02 Log Out            : Mengakhiri sesi pengguna secara aman. Aktor: Admin, Pemilik, Member. Prioritas: Tinggi."
pp "F-03 Kelola Inventaris  : Mengelola data unit PS4/PS5 dan kelayakan controller. Aktor: Admin. Prioritas: Sedang."
pp "F-04 Booking Online     : Pemesanan jadwal dan unit secara mandiri. Aktor: Member. Prioritas: Tinggi."
pp "F-05 Kelola Reservasi   : Validasi, konfirmasi, atau ubah data reservasi masuk. Aktor: Admin. Prioritas: Tinggi."
pp "F-06 Monitoring Unit    : Pantau status unit, timer otomatis, notifikasi sisa waktu. Aktor: Admin, Member. Prioritas: Tinggi."
pp "F-07 Laporan Pendapatan : Rekapitulasi keuangan transaksi selesai. Aktor: Admin, Pemilik. Prioritas: Sedang."
el
bd "Tabel 3.3 Kebutuhan Non-Fungsional (Non-Functional Requirements)"
ph "[TEMPEL TABEL KEBUTUHAN NON-FUNGSIONAL (NF-01 sd NF-06) DARI DOKUMEN SRS DI SINI]"
el
pp "NF-01 Keamanan (Security)          : Proteksi data, enkripsi password Bcrypt, validasi sesi. Prioritas: Tinggi."
pp "NF-02 Ketersediaan (Availability)  : Sistem dapat diakses 24/7. Prioritas: Tinggi."
pp "NF-03 Akurasi Perhitungan          : Billing otomatis akurat berdasarkan durasi dan tarif. Prioritas: Tinggi."
pp "NF-04 Kemudahan Penggunaan (Usability) : Antarmuka responsif dan intuitif. Prioritas: Sedang."
pp "NF-05 Integritas Data (Backup)     : Pencadangan database secara berkala. Prioritas: Sedang."
pp "NF-06 Performa (Performance)       : Waktu respon validasi tidak lebih dari 3 detik. Prioritas: Sedang."

h2 "3.3 Pemodelan Sistem (UML)"

h3 "3.3.1 Use Case Diagram dan Skenario Use Case"
ph "[TEMPEL GAMBAR 3.2 - USE CASE DIAGRAM DARI DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]"
gj "3.2" "Use Case Diagram Sistem GO PLAY"
el
bd "1. Use Case: Login"
pp "Aktor: Admin, Member, Pemilik"
pp "Deskripsi: Proses masuk ke sistem menggunakan akun yang terdaftar."
pp "Skenario Utama: (1) Aktor membuka aplikasi/web. (2) Sistem menampilkan formulir login. (3) Aktor memasukkan kredensial. (4) Sistem memvalidasi data ke database. (5) Sistem mengarahkan ke dashboard sesuai hak akses."
el
bd "2. Use Case: Log Out"
pp "Aktor: Admin, Member, Pemilik"
pp "Deskripsi: Proses keluar dari sesi sistem secara aman."
pp "Skenario Utama: (1) Aktor menekan tombol Log Out. (2) Sistem menghapus sesi aktif. (3) Sistem mengarahkan kembali ke halaman login."
el
bd "3. Use Case: Kelola Inventaris"
pp "Aktor: Admin"
pp "Deskripsi: Mengatur data perangkat (PS4/PS5) yang tersedia."
pp "Skenario Utama: (1) Admin memilih menu Kelola Inventaris. (2) Sistem menampilkan daftar unit. (3) Admin menambah, mengubah status (baik/rusak), atau menghapus unit. (4) Admin menyimpan perubahan. (5) Sistem memperbarui database."
el
bd "4. Use Case: Booking Online"
pp "Aktor: Member"
pp "Deskripsi: Melakukan reservasi jadwal main secara mandiri."
pp "Skenario Utama: (1) Member masuk ke menu Booking Online. (2) Member memilih jenis unit dan jadwal. (3) Sistem mengecek ketersediaan otomatis. (4) Member mengonfirmasi pemesanan. (5) Sistem menerbitkan kode/status reservasi."
el
bd "5. Use Case: Kelola Reservasi"
pp "Aktor: Admin"
pp "Deskripsi: Mengelola dan memproses data booking yang masuk dari member."
pp "Skenario Utama: (1) Admin masuk ke menu Kelola Reservasi. (2) Sistem menampilkan daftar pesanan. (3) Admin melakukan verifikasi. (4) Admin mengubah status (Konfirmasi/Dibatalkan/Selesai). (5) Sistem memperbarui status jadwal."
el
bd "6. Use Case: Monitoring Status Unit"
pp "Aktor: Admin, Member"
pp "Deskripsi: Memantau sisa waktu bermain dan status unit secara real-time."
pp "Skenario Utama: (1) Aktor membuka dashboard monitoring. (2) Sistem menampilkan status unit (Kosong/Terisi/Dipesan). (3) Sistem menjalankan timer otomatis. (4) Sistem memberikan notifikasi jika waktu hampir habis. (5) Admin dapat menghentikan atau menambah durasi billing."
el
bd "7. Use Case: Laporan Pendapatan"
pp "Aktor: Admin, Pemilik"
pp "Deskripsi: Melihat hasil rekapitulasi keuangan dari transaksi sewa."
pp "Skenario Utama: (1) Aktor masuk ke menu Laporan Pendapatan. (2) Aktor menentukan filter periode (Harian/Bulanan). (3) Sistem menarik data transaksi berstatus Selesai. (4) Sistem menampilkan total pendapatan dan detail. (5) Aktor dapat mengunduh atau mencetak laporan."

h3 "3.3.2 Activity Diagram"
ph "[TEMPEL GAMBAR 3.3 - ACTIVITY DIAGRAM LOGIN DARI DOKUMEN UML DI SINI]"
gj "3.3" "Activity Diagram - Login"
ph "[TEMPEL GAMBAR 3.4 - ACTIVITY DIAGRAM LOGOUT DARI DOKUMEN UML DI SINI]"
gj "3.4" "Activity Diagram - Logout"
ph "[TEMPEL GAMBAR 3.5 - ACTIVITY DIAGRAM BOOKING ONLINE DARI DOKUMEN UML DI SINI]"
gj "3.5" "Activity Diagram - Booking Online"
ph "[TEMPEL GAMBAR 3.6 - ACTIVITY DIAGRAM MONITORING STATUS UNIT DARI DOKUMEN UML DI SINI]"
gj "3.6" "Activity Diagram - Monitoring Status Unit"
ph "[TEMPEL GAMBAR 3.7 - ACTIVITY DIAGRAM KELOLA RESERVASI DARI DOKUMEN UML DI SINI]"
gj "3.7" "Activity Diagram - Kelola Reservasi"
ph "[TEMPEL GAMBAR 3.8 - ACTIVITY DIAGRAM KELOLA INVENTARIS DARI DOKUMEN UML DI SINI]"
gj "3.8" "Activity Diagram - Kelola Inventaris"
ph "[TEMPEL GAMBAR 3.9 - ACTIVITY DIAGRAM LAPORAN PENDAPATAN DARI DOKUMEN UML DI SINI]"
gj "3.9" "Activity Diagram - Laporan Pendapatan"

h3 "3.3.3 Robustness Diagram"
ph "[TEMPEL GAMBAR 3.10 - ROBUSTNESS DIAGRAM DARI DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]"
gj "3.10" "Robustness Diagram Sistem GO PLAY"

h3 "3.3.4 Class Diagram"
ph "[TEMPEL GAMBAR 3.11 - CLASS DIAGRAM DARI DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]"
gj "3.11" "Class Diagram Sistem GO PLAY"

h3 "3.3.5 Sequence Diagram"
ph "[TEMPEL GAMBAR 3.12 - SEQUENCE DIAGRAM LOGIN DARI DOKUMEN UML DI SINI]"
gj "3.12" "Sequence Diagram - Login"
ph "[TEMPEL GAMBAR 3.13 - SEQUENCE DIAGRAM LOGOUT DARI DOKUMEN UML DI SINI]"
gj "3.13" "Sequence Diagram - Logout"
ph "[TEMPEL GAMBAR 3.14 - SEQUENCE DIAGRAM RESERVASI/BOOKING ONLINE DARI DOKUMEN UML DI SINI]"
gj "3.14" "Sequence Diagram - Reservasi / Booking Online"
ph "[TEMPEL GAMBAR 3.15 - SEQUENCE DIAGRAM LAPORAN PENDAPATAN DARI DOKUMEN UML DI SINI]"
gj "3.15" "Sequence Diagram - Laporan Pendapatan"
ph "[TEMPEL GAMBAR 3.16 - SEQUENCE DIAGRAM KELOLA INVENTARIS DARI DOKUMEN UML DI SINI]"
gj "3.16" "Sequence Diagram - Kelola Inventaris"
ph "[TEMPEL GAMBAR 3.17 - SEQUENCE DIAGRAM MONITORING STATUS UNIT DARI DOKUMEN UML DI SINI]"
gj "3.17" "Sequence Diagram - Monitoring Status Unit"

# =====================================================================
# BAB IV – PERANCANGAN SISTEM  (BARU)
# =====================================================================
pb
h1 "BAB IV"
h1 "PERANCANGAN SISTEM"

h2 "4.1 Perancangan Arsitektur Sistem"
pp "Sistem GO PLAY dirancang menggunakan pola arsitektur MVC (Model-View-Controller) melalui framework Laravel 12. Arsitektur ini memisahkan aplikasi menjadi tiga komponen utama:"
pp "Model      : Mengelola data dan interaksi dengan database SQLite. Model utama: User, Admin, Console, Booking, Transaction."
pp "View       : Tampilan antarmuka menggunakan Blade Template Engine, dikompilasi dengan Vite. Setiap peran pengguna memiliki tampilan dashboard yang berbeda."
pp "Controller : Logika bisnis aplikasi, memproses request pengguna, berinteraksi dengan Model, dan mengembalikan respons ke View. Dipisahkan berdasarkan peran: AuthController, BookingController (Member), BookingAdminController, ConsoleController, ReportController (Admin), dan OwnerController."
ph "[TEMPEL GAMBAR 4.1 - DIAGRAM ARSITEKTUR SISTEM MVC GO PLAY DI SINI]"
gj "4.1" "Arsitektur Sistem GO PLAY (MVC)"

h2 "4.2 Desain Basis Data"
pp "Basis data sistem GO PLAY dirancang menggunakan SQLite dengan pendekatan relasional. Struktur tabel dibuat menggunakan fitur Migrations Laravel. Entitas utama beserta atributnya:"
el
bd "Tabel users (Data Member/Pelanggan)"
pp "id (PK), name, email (unique), password (encrypted Bcrypt), phone, email_verified_at, remember_token, created_at, updated_at."
el
bd "Tabel admins (Data Admin)"
pp "id (PK), name, email (unique), password (encrypted Bcrypt), remember_token, created_at, updated_at."
el
bd "Tabel consoles (Data Unit PS4/PS5)"
pp "id (PK), name, type (PS4/PS5), status (available/occupied/maintenance), price_per_hour, description, created_at, updated_at."
el
bd "Tabel bookings (Data Reservasi)"
pp "id (PK), booking_code (unique), user_id (FK - nullable untuk walk-in), console_id (FK), booking_date, start_time, end_time, duration (int, dalam jam), total_price, status (pending/confirmed/completed/cancelled), payment_status (unpaid/paid), created_at, updated_at."
el
bd "Tabel transactions (Data Transaksi Selesai)"
pp "id (PK), booking_id (FK), amount, payment_method, paid_at, created_at, updated_at."
ph "[TEMPEL GAMBAR 4.2 - ENTITY RELATIONSHIP DIAGRAM (ERD) DI SINI]"
gj "4.2" "Entity Relationship Diagram (ERD) Sistem GO PLAY"

h2 "4.3 Desain Antarmuka Pengguna (UI)"
pp "Desain antarmuka pengguna sistem GO PLAY dirancang berdasarkan prinsip kemudahan penggunaan (usability) dan estetika visual yang modern. Desain wireframe dibuat menggunakan Figma sebelum diimplementasikan ke dalam kode."
pp "Link Figma: https://www.figma.com/site/S3ShQKDKt7BylYmXNlHTX7/GOPLAY"
ph "[TEMPEL GAMBAR 4.3 - WIREFRAME HALAMAN UTAMA DARI LAPORAN WIREFRAME UIUX DI SINI]"
gj "4.3" "Wireframe Halaman Utama GO PLAY"
ph "[TEMPEL GAMBAR 4.4 - WIREFRAME HALAMAN LOGIN DARI LAPORAN WIREFRAME UIUX DI SINI]"
gj "4.4" "Wireframe Halaman Login GO PLAY"
ph "[TEMPEL GAMBAR 4.5 - WIREFRAME HALAMAN BOOKING DARI LAPORAN WIREFRAME UIUX DI SINI]"
gj "4.5" "Wireframe Halaman Booking GO PLAY"

# =====================================================================
# BAB V – IMPLEMENTASI DAN PENGUJIAN  (BARU)
# =====================================================================
pb
h1 "BAB V"
h1 "IMPLEMENTASI DAN PENGUJIAN"

h2 "5.1 Implementasi Database"
pp "Database sistem GO PLAY diimplementasikan menggunakan SQLite. Seluruh struktur tabel dibuat menggunakan fitur Migrations Laravel yang memungkinkan pengelolaan versi database secara sistematis. Perintah untuk menginisialisasi database:"
pp "php artisan migrate --seed"
pp "Seeder yang disediakan: data Admin default (admin@goplay.com), data konsol PS4/PS5 (5 unit), dan data Member contoh untuk keperluan pengujian sistem."

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
pp "Source code sistem GO PLAY dikelola menggunakan Git dan dipublikasikan pada repositori GitHub berikut:"
pp "https://github.com/adamme26/Sistem-Informasi-Manajemen-dan-Reservasi-Rental-PlayStation-GO-PLAY-Berbasis-Web"
el
pp "Struktur direktori utama:"
pp "app/Http/Controllers/  - Semua Controller (Admin/, Member/, Auth/)"
pp "app/Models/            - Semua Model (User, Admin, Console, Booking, Transaction)"
pp "database/migrations/   - File migrasi skema database"
pp "database/database.sqlite - File database SQLite"
pp "resources/views/       - Template Blade HTML"
pp "routes/web.php         - File routing seluruh URL aplikasi"
pp "public/                - Asset publik (CSS, JS, gambar)"
pp "vite.config.js         - Konfigurasi build tool frontend"

h2 "5.4 Pengujian Menggunakan Tools"
bd "a. Pengujian Manual (Black Box Testing)"
pp "Pengujian dilakukan secara manual dengan menjalankan aplikasi dan mencoba setiap fitur satu per satu untuk memastikan output sesuai spesifikasi kebutuhan."
el
bd "b. Pengujian Error Handling"
pp "Pengujian dengan memasukkan data tidak valid untuk memastikan sistem menangani error dengan benar. Kasus yang diuji:"
pp "1. Input durasi berupa teks bukan angka menyebabkan TypeError pada Carbon::rawAddUnit() - diperbaiki dengan casting (int) pada parameter durasi."
pp "2. Pemesanan pada unit berstatus maintenance atau occupied - sistem menampilkan pesan error ketersediaan."
pp "3. Login dengan kredensial salah - sistem menampilkan pesan autentikasi gagal."
pp "4. Akses halaman Admin oleh Member - sistem melakukan redirect ke halaman yang sesuai."
el
ph "[TEMPEL TABEL/SCREENSHOT HASIL PENGUJIAN DARI DOKUMENTASI PENGUJIAN DI SINI]"

h2 "5.5 User Acceptance Testing (UAT)"
pp "User Acceptance Testing (UAT) dilakukan dengan melibatkan pengguna nyata (Admin dan Member GO PLAY) untuk memastikan sistem telah memenuhi kebutuhan dan ekspektasi pengguna akhir. UAT dilakukan berdasarkan skenario pengujian yang disusun dari setiap use case yang telah didefinisikan."
el
ph "[TEMPEL TABEL HASIL UAT DAN FORMULIR PENERIMAAN PENGGUNA DI SINI]"

# =====================================================================
# BAB VI – PENUTUP  (BARU)
# =====================================================================
pb
h1 "BAB VI"
h1 "PENUTUP"

h2 "6.1 Kesimpulan"
pp "Berdasarkan hasil analisis, perancangan, implementasi, dan pengujian Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY), ditarik kesimpulan sebagai berikut:"
pp "1. Sistem GO PLAY telah berhasil dikembangkan menggunakan framework Laravel 12 (PHP 8.2) dengan arsitektur MVC, database SQLite, dan antarmuka Vite + Blade Template Engine."
pp "2. Sistem mengimplementasikan tujuh fitur fungsional sesuai SRS: Login multi-peran (F-01), Logout (F-02), Kelola Inventaris (F-03), Booking Online (F-04), Kelola Reservasi termasuk Walk-in (F-05), Monitoring Status Unit dengan Timer Otomatis (F-06), dan Laporan Pendapatan (F-07)."
pp "3. Fitur Booking Online (F-04) berhasil mencegah double booking melalui pengecekan ketersediaan jadwal dan unit secara otomatis."
pp "4. Fitur Timer Otomatis (F-06) berhasil memantau durasi bermain secara real-time dan memberikan notifikasi saat waktu hampir habis, sehingga mengurangi beban kerja Admin."
pp "5. Dashboard Laporan Pendapatan (F-07) menyajikan rekapitulasi keuangan yang akurat, dapat difilter harian maupun bulanan, memudahkan Pemilik dalam audit keuangan."
pp "6. Sistem telah diuji melalui Black Box Testing dan UAT dengan hasil menunjukkan seluruh fitur berjalan sesuai spesifikasi."

h2 "6.2 Saran"
pp "Untuk pengembangan sistem GO PLAY ke depannya, beberapa saran yang dapat dipertimbangkan:"
pp "1. Integrasi Payment Gateway: Menambahkan fitur pembayaran digital (Midtrans, QRIS, Virtual Account) agar transaksi dapat diselesaikan secara online."
pp "2. Notifikasi WhatsApp/Email Otomatis: Integrasi notifikasi via WhatsApp Business API atau email untuk konfirmasi booking dan pengingat jadwal kepada Member."
pp "3. Pengembangan Aplikasi Mobile: Membangun versi aplikasi mobile (Android/iOS) agar Member dapat booking melalui smartphone."
pp "4. Deployment ke Server Hosting: Mengoptimalkan sistem untuk di-deploy ke server hosting Linux dengan database MySQL agar dapat diakses publik 24/7."
pp "5. Migrasi Database ke MySQL: Mengganti SQLite dengan MySQL untuk lingkungan produksi guna mendukung concurrency yang lebih tinggi."
pp "6. Fitur Review dan Rating: Menambahkan fitur ulasan pelanggan untuk evaluasi kualitas layanan secara berkelanjutan."

# =====================================================================
# DAFTAR PUSTAKA
# =====================================================================
pb
h1 "DAFTAR PUSTAKA"
pp "[1]  O Brien, J. A., dan Marakas, G. M. (2011). Management Information Systems (10th ed.). New York: McGraw-Hill."
pp "[2]  Pressman, R. S., dan Maxim, B. R. (2015). Software Engineering: A Practitioner Approach (8th ed.). New York: McGraw-Hill Education."
pp "[3]  Laravel LLC. (2024). Laravel 12.x Documentation. Diakses dari https://laravel.com/docs/12.x"
pp "[4]  Sommerville, I. (2016). Software Engineering (10th ed.). Boston: Pearson Education."
pp "[5]  Fowler, M. (2002). Patterns of Enterprise Application Architecture. Boston: Addison-Wesley."
pp "[6]  SQLite Consortium. (2024). SQLite Documentation. Diakses dari https://www.sqlite.org/docs.html"
pp "[7]  Object Management Group. (2017). Unified Modeling Language (UML) Specification Version 2.5.1. Diakses dari https://www.omg.org/spec/UML/"
pp "[8]  Object Management Group. (2013). Business Process Model and Notation (BPMN) Version 2.0.2. Diakses dari https://www.omg.org/spec/BPMN/"
pp "[9]  Nielsen, J. (1994). Usability Engineering. San Francisco: Morgan Kaufmann Publishers."
pp "[10] Connolly, T. M., dan Begg, C. E. (2014). Database Systems: A Practical Approach (6th ed.). Harlow: Pearson Education."

# =====================================================================
# LAMPIRAN
# =====================================================================
pb
h1 "LAMPIRAN"
h2 "Lampiran 1 - Profile Tim Proyek"
ph "[TEMPEL SELURUH ISI Lampiran Profile Tim Proyek Go Play.docx DI SINI]"
h2 "Lampiran 2 - Dokumen Project Charter"
ph "[TEMPEL SELURUH ISI Lampiran Project Charter GO PLAY .pdf DI SINI]"
h2 "Lampiran 3 - WBS dan Timeline"
ph "[TEMPEL GAMBAR DARI Lampiran Dokumen WBS dan Timeline Proyek GO PLAY.pdf DI SINI]"
h2 "Lampiran 4 - Dokumen SRS / Daftar Kebutuhan"
ph "[TEMPEL ISI Dokumen SRS_Daftar Kebutuhan_Sistem GOPLAY.pdf DI SINI]"
h2 "Lampiran 5 - Dokumen UML"
ph "[TEMPEL GAMBAR DARI DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]"
h2 "Lampiran 6 - Dokumen UI/UX (Wireframe Figma)"
ph "[TEMPEL GAMBAR WIREFRAME DARI LAPORAN WIREFRAME UIUX PROYEK PERANGKAT LUNAK.pdf DI SINI]"
h2 "Lampiran 7 - Dokumentasi Source Code"
pp "Repository GitHub: https://github.com/adamme26/Sistem-Informasi-Manajemen-dan-Reservasi-Rental-PlayStation-GO-PLAY-Berbasis-Web"
ph "[TEMPEL SCREENSHOT REPOSITORI GITHUB DAN CUPLIKAN KODE PENTING DI SINI]"
h2 "Lampiran 8 - Dokumentasi Pengujian Tools dan UAT"
ph "[TEMPEL TABEL HASIL PENGUJIAN TOOLS DAN UAT DI SINI]"
h2 "Lampiran 9 - Dokumentasi Penggunaan Sistem (User Guide)"
ph "[TEMPEL ISI User_Guide_GoPlay.doc DI SINI]"

# =====================================================================
# CLOSE DOCUMENT
# =====================================================================
ap '<w:sectPr><w:pgSz w:w="12240" w:h="15840"/><w:pgMar w:top="1440" w:right="1080" w:bottom="1440" w:left="1800"/></w:sectPr>'
ap '</w:body></w:document>'

# ── Validate XML before writing ────────────────────────────────────
$xmlString = $sb.ToString()
try {
    $xmlDoc = [xml]$xmlString
    Write-Output "XML validation: PASSED"
} catch {
    Write-Error "XML validation FAILED: $_"
    exit 1
}

WF "$tmpDir\word\document.xml" $xmlString

[System.IO.Compression.ZipFile]::CreateFromDirectory(
    $tmpDir, $outputPath,
    [System.IO.Compression.CompressionLevel]::Optimal, $false
)
Remove-Item $tmpDir -Recurse -Force

$size = [math]::Round((Get-Item $outputPath).Length / 1KB, 2)
Write-Output "SUCCESS: $outputPath"
Write-Output "Size   : $size KB"
