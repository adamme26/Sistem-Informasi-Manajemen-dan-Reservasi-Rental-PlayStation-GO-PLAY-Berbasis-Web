Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$outputPath = 'C:\Users\noval mulyadi\Documents\SMT4\Proyek Perangkat Lunak\LAPORAN\LAPORAN_AKHIR_GOPLAY_KEL8.docx'
$tmpDir = 'C:\Users\noval mulyadi\.gemini\antigravity\scratch\goplay\docx_tmp'

# Clean up
if (Test-Path $outputPath) { Remove-Item $outputPath -Force }
if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
New-Item -ItemType Directory -Path $tmpDir | Out-Null
New-Item -ItemType Directory -Path "$tmpDir\_rels" | Out-Null
New-Item -ItemType Directory -Path "$tmpDir\word" | Out-Null
New-Item -ItemType Directory -Path "$tmpDir\word\_rels" | Out-Null

# Helper: Write XML file
function WriteFile($path, $content) {
    [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
}

# [Content_Types].xml
WriteFile "$tmpDir\[Content_Types].xml" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
  <Override PartName="/word/numbering.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml"/>
</Types>'

# _rels/.rels
WriteFile "$tmpDir\_rels\.rels" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>'

# word/_rels/document.xml.rels
WriteFile "$tmpDir\word\_rels\document.xml.rels" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
  <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering" Target="numbering.xml"/>
</Relationships>'

# word/numbering.xml
WriteFile "$tmpDir\word\numbering.xml" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:numbering xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:abstractNum w:abstractNumId="0">
    <w:lvl w:ilvl="0"><w:start w:val="1"/><w:numFmt w:val="decimal"/><w:lvlText w:val="%1."/><w:lvlJc w:val="left"/>
    <w:pPr><w:ind w:left="720" w:hanging="360"/></w:pPr></w:lvl>
  </w:abstractNum>
  <w:num w:numId="1"><w:abstractNumId w:val="0"/></w:num>
</w:numbering>'

# word/styles.xml
WriteFile "$tmpDir\word\styles.xml" '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:style w:type="paragraph" w:default="1" w:styleId="Normal">
    <w:name w:val="Normal"/>
    <w:pPr><w:jc w:val="both"/><w:spacing w:before="0" w:after="120" w:line="480" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman" w:cs="Times New Roman"/><w:sz w:val="24"/><w:szCs w:val="24"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Heading1">
    <w:name w:val="heading 1"/>
    <w:basedOn w:val="Normal"/>
    <w:pPr><w:jc w:val="center"/><w:spacing w:before="0" w:after="240" w:line="480" w:lineRule="auto"/><w:pageBreakBefore/></w:pPr>
    <w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="32"/><w:szCs w:val="32"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Heading2">
    <w:name w:val="heading 2"/>
    <w:basedOn w:val="Normal"/>
    <w:pPr><w:jc w:val="left"/><w:spacing w:before="120" w:after="120" w:line="480" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="28"/><w:szCs w:val="28"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Heading3">
    <w:name w:val="heading 3"/>
    <w:basedOn w:val="Normal"/>
    <w:pPr><w:jc w:val="left"/><w:spacing w:before="120" w:after="120" w:line="480" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="28"/><w:szCs w:val="28"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Heading4">
    <w:name w:val="heading 4"/>
    <w:basedOn w:val="Normal"/>
    <w:pPr><w:jc w:val="left"/><w:spacing w:before="120" w:after="120" w:line="480" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="26"/><w:szCs w:val="26"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Placeholder">
    <w:name w:val="Placeholder"/>
    <w:basedOn w:val="Normal"/>
    <w:pPr><w:jc w:val="center"/><w:spacing w:before="120" w:after="120" w:line="240" w:lineRule="auto"/>
    <w:pBdr><w:top w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/><w:left w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/><w:bottom w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/><w:right w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/></w:pBdr>
    <w:shd w:val="clear" w:color="auto" w:fill="FFFF00"/></w:pPr>
    <w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="CC0000"/><w:sz w:val="24"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="CenterNormal">
    <w:name w:val="CenterNormal"/>
    <w:basedOn w:val="Normal"/>
    <w:pPr><w:jc w:val="center"/></w:pPr>
    <w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="CoverTitle">
    <w:name w:val="CoverTitle"/>
    <w:basedOn w:val="Normal"/>
    <w:pPr><w:jc w:val="center"/><w:spacing w:before="0" w:after="120" w:line="480" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="28"/><w:szCs w:val="28"/></w:rPr>
  </w:style>
</w:styles>'

# ---- Build Paragraphs ----
function H1($text) { "<w:p><w:pPr><w:pStyle w:val=`"Heading1`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>" }
function H2($text) { "<w:p><w:pPr><w:pStyle w:val=`"Heading2`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>" }
function H3($text) { "<w:p><w:pPr><w:pStyle w:val=`"Heading3`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>" }
function P($text) { "<w:p><w:pPr><w:pStyle w:val=`"Normal`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>" }
function PH($text) { "<w:p><w:pPr><w:pStyle w:val=`"Placeholder`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>" }
function PC($text) { "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>" }
function Bold($text) { "<w:p><w:pPr><w:pStyle w:val=`"Normal`"/></w:pPr><w:r><w:rPr><w:b/></w:rPr><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>" }
function PB() { "<w:p><w:r><w:br w:type=`"page`"/></w:r></w:p>" }
function EL() { "<w:p><w:pPr><w:pStyle w:val=`"Normal`"/></w:pPr></w:p>" }
function GJ($num, $caption) { 
    "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:rPr><w:i/></w:rPr><w:t xml:space=`"preserve`">Gambar $num $caption</w:t></w:r></w:p>"
}

$doc = [System.Collections.Generic.List[string]]::new()

# ============================================================
# COVER
# ============================================================
$doc.Add("<w:p><w:pPr><w:pStyle w:val=`"CoverTitle`"/><w:jc w:val=`"center`"/></w:pPr><w:r><w:t>LAPORAN AKHIR PROYEK PERANGKAT LUNAK</w:t></w:r></w:p>")
$doc.Add(PC "Sistem Informasi Manajemen dan Reservasi Rental PlayStation")
$doc.Add(PC "(GO PLAY) Berbasis Web")
$doc.Add(EL)
$doc.Add(PH "[TEMPEL LOGO UNIVERSITAS SUBANG DI SINI]")
$doc.Add(EL)
$doc.Add(PC "Disusun oleh : Kelompok 8")
$doc.Add(EL)
$doc.Add(PC "Adam. F                    D1A240046")
$doc.Add(PC "Azfar Wildan. P            D1A240026")
$doc.Add(PC "M. Noval Mulyadi           D1A240039")
$doc.Add(PC "Divi Agung Satria          D1A240038")
$doc.Add(PC "Ramdan Prayitno            D1A240032")
$doc.Add(EL)
$doc.Add(PC "PROGRAM STUDI SISTEM INFORMASI")
$doc.Add(PC "FAKULTAS ILMU KOMPUTER")
$doc.Add(PC "UNIVERSITAS SUBANG")
$doc.Add(PC "2026")

# ============================================================
# LEMBAR PENGESAHAN
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "LEMBAR PENGESAHAN")
$doc.Add(P "Judul Proyek      : Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY) Berbasis Web")
$doc.Add(P "Program Studi     : Sistem Informasi")
$doc.Add(P "Fakultas          : Ilmu Komputer")
$doc.Add(P "Universitas       : Universitas Subang")
$doc.Add(P "Tahun Akademik    : 2025/2026")
$doc.Add(P "Kelompok          : 8")
$doc.Add(EL)
$doc.Add(P "Anggota Tim:")
$doc.Add(P "1. Adam. F              - D1A240046")
$doc.Add(P "2. Azfar Wildan. P      - D1A240026")
$doc.Add(P "3. M. Noval Mulyadi     - D1A240039")
$doc.Add(P "4. Divi Agung Satria    - D1A240038")
$doc.Add(P "5. Ramdan Prayitno      - D1A240032")
$doc.Add(EL)
$doc.Add(PH "[TEMPEL TANDA TANGAN DOSEN PEMBIMBING DAN KETUA KELOMPOK DI SINI]")

# ============================================================
# ABSTRAK
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "ABSTRAK")
$doc.Add(P "Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY) dikembangkan untuk mengatasi permasalahan operasional yang umum terjadi pada bisnis rental PlayStation konvensional, yaitu pencatatan manual yang rawan kesalahan, risiko bentrok jadwal pemesanan (double booking), dan sulitnya merekap laporan pendapatan secara akurat. Sistem ini dibangun menggunakan framework Laravel 12 (PHP 8.2) dengan database SQLite dan antarmuka berbasis Vite, serta menerapkan arsitektur MVC (Model-View-Controller). Hasil pengembangan berupa aplikasi web yang memiliki tiga peran pengguna (Admin, Member, dan Pemilik) dengan fitur utama meliputi: Booking Online oleh Member, Kelola Reservasi dan Walk-in oleh Admin, Monitoring Status Unit dengan Timer Otomatis, Pengelolaan Inventaris konsol PS4/PS5, dan Dashboard Laporan Pendapatan untuk Pemilik. Sistem ini terbukti mampu mengotomatisasi proses bisnis rental PlayStation sehingga meminimalisir kesalahan operasional dan meningkatkan efisiensi kerja Admin.")
$doc.Add(EL)
$doc.Add(Bold "Kata Kunci: Sistem Informasi, Rental PlayStation, Booking Online, Laravel, MVC, Timer Otomatis.")
$doc.Add(EL)
$doc.Add(H1 "ABSTRACT")
$doc.Add(P "The PlayStation Rental Management and Reservation Information System (GO PLAY) was developed to address operational problems commonly found in conventional PlayStation rental businesses, namely error-prone manual recording, the risk of scheduling conflicts (double booking), and difficulties in accurately compiling revenue reports. This system was built using the Laravel 12 framework (PHP 8.2) with a SQLite database and a Vite-based interface, applying MVC (Model-View-Controller) architecture. The resulting web application has three user roles (Admin, Member, and Owner) with main features including: Online Booking by Members, Reservation and Walk-in Management by Admin, Unit Status Monitoring with Automatic Timer, PS4/PS5 Console Inventory Management, and Revenue Report Dashboard for Owners. This system has been proven capable of automating PlayStation rental business processes, thereby minimizing operational errors and improving Admin work efficiency.")
$doc.Add(EL)
$doc.Add(Bold "Keywords: Information System, PlayStation Rental, Online Booking, Laravel, MVC, Automatic Timer.")

# ============================================================
# DAFTAR ISI
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "DAFTAR ISI")
$doc.Add(P "LEMBAR PENGESAHAN")
$doc.Add(P "ABSTRAK")
$doc.Add(P "ABSTRACT")
$doc.Add(P "DAFTAR ISI")
$doc.Add(P "DAFTAR GAMBAR")
$doc.Add(P "BAB I    PENDAHULUAN")
$doc.Add(P "    1.1  Latar Belakang")
$doc.Add(P "    1.2  Identifikasi Masalah")
$doc.Add(P "    1.3  Tujuan Pengembangan Sistem")
$doc.Add(P "    1.4  Ruang Lingkup Proyek")
$doc.Add(P "    1.5  Manfaat yang Diharapkan")
$doc.Add(P "BAB II   TINJAUAN SINGKAT DAN LANDASAN KONSEPTUAL")
$doc.Add(P "    2.1  Gambaran Singkat Organisasi atau Objek Studi Kasus")
$doc.Add(P "    2.2  Konsep Sistem Informasi yang Relevan")
$doc.Add(P "    2.3  Teknologi, Framework, dan Metodologi yang Digunakan")
$doc.Add(P "BAB III  ANALISIS SISTEM")
$doc.Add(P "    3.1  Analisis Proses Bisnis atau Sistem Berjalan (BPMN)")
$doc.Add(P "    3.2  Analisis Dokumen")
$doc.Add(P "    3.3  Analisis Kebutuhan Informasi dan Pengguna (SRS)")
$doc.Add(P "    3.4  Pemodelan Sistem (UML)")
$doc.Add(P "BAB IV   PERANCANGAN SISTEM")
$doc.Add(P "    4.1  Perancangan Arsitektur Sistem")
$doc.Add(P "    4.2  Desain Basis Data")
$doc.Add(P "    4.3  Desain Antarmuka Pengguna (UI)")
$doc.Add(P "BAB V    IMPLEMENTASI DAN PENGUJIAN")
$doc.Add(P "    5.1  Implementasi Database")
$doc.Add(P "    5.2  Implementasi Antarmuka")
$doc.Add(P "    5.3  Struktur Program dan Pengelolaan Source Code")
$doc.Add(P "    5.4  Pengujian menggunakan Tools")
$doc.Add(P "    5.5  User Acceptance Testing (UAT)")
$doc.Add(P "BAB VI   PENUTUP")
$doc.Add(P "    6.1  Kesimpulan")
$doc.Add(P "    6.2  Saran")
$doc.Add(P "DAFTAR PUSTAKA")
$doc.Add(P "LAMPIRAN")

# ============================================================
# DAFTAR GAMBAR
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "DAFTAR GAMBAR")
$doc.Add(P "Gambar 3.1   BPMN Proses Bisnis GO PLAY")
$doc.Add(P "Gambar 3.2   Use Case Diagram Sistem GO PLAY")
$doc.Add(P "Gambar 3.3   Activity Diagram - Login")
$doc.Add(P "Gambar 3.4   Activity Diagram - Booking Online")
$doc.Add(P "Gambar 3.5   Activity Diagram - Kelola Reservasi")
$doc.Add(P "Gambar 3.6   Activity Diagram - Monitoring Status Unit")
$doc.Add(P "Gambar 3.7   Activity Diagram - Kelola Inventaris")
$doc.Add(P "Gambar 3.8   Activity Diagram - Laporan Pendapatan")
$doc.Add(P "Gambar 3.9   Robustness Diagram Sistem GO PLAY")
$doc.Add(P "Gambar 3.10  Class Diagram Sistem GO PLAY")
$doc.Add(P "Gambar 3.11  Sequence Diagram - Login")
$doc.Add(P "Gambar 3.12  Sequence Diagram - Booking Online")
$doc.Add(P "Gambar 3.13  Sequence Diagram - Kelola Reservasi")
$doc.Add(P "Gambar 3.14  Sequence Diagram - Monitoring Status Unit")
$doc.Add(P "Gambar 4.1   Arsitektur Sistem GO PLAY (MVC)")
$doc.Add(P "Gambar 4.2   Entity Relationship Diagram (ERD)")
$doc.Add(P "Gambar 4.3   Wireframe Halaman Utama")
$doc.Add(P "Gambar 4.4   Wireframe Halaman Login")
$doc.Add(P "Gambar 4.5   Wireframe Halaman Booking")
$doc.Add(P "Gambar 5.1   Screenshot Halaman Utama GO PLAY")
$doc.Add(P "Gambar 5.2   Screenshot Halaman Login")
$doc.Add(P "Gambar 5.3   Screenshot Dashboard Member")
$doc.Add(P "Gambar 5.4   Screenshot Halaman Booking Online")
$doc.Add(P "Gambar 5.5   Screenshot Dashboard Admin")
$doc.Add(P "Gambar 5.6   Screenshot Monitoring Timer Unit")
$doc.Add(P "Gambar 5.7   Screenshot Kelola Reservasi Admin")
$doc.Add(P "Gambar 5.8   Screenshot Laporan Pendapatan")

# ============================================================
# BAB I
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "BAB I")
$doc.Add(H1 "PENDAHULUAN")
$doc.Add(H2 "1.1 Latar Belakang")
$doc.Add(P "Industri hiburan berbasis gaming, khususnya penyewaan unit PlayStation, saat ini tengah berkembang pesat di berbagai kota di Indonesia. Bisnis rental PlayStation (PS) merupakan salah satu bentuk usaha mikro yang diminati oleh berbagai kalangan, terutama di lingkungan perkotaan dan kawasan kampus. Namun, sebagian besar usaha rental PlayStation masih dikelola secara konvensional, yaitu dengan mengandalkan pencatatan manual menggunakan buku tulis, papan tulis jadwal, atau aplikasi sederhana yang tidak terintegrasi.")
$doc.Add(P "Sistem konvensional tersebut rentan menimbulkan berbagai permasalahan operasional, seperti: (1) terjadinya bentrok jadwal pemesanan (double booking) akibat tidak adanya sistem pengecekan otomatis; (2) kesulitan dalam memantau sisa waktu bermain pelanggan yang mengharuskan Admin selalu siaga secara manual; (3) pengelolaan inventaris konsol PS4/PS5 dan aksesoris yang tidak terdokumentasi dengan baik; serta (4) pelaporan pendapatan yang tidak akurat dan memakan waktu lama karena harus direkap secara manual.")
$doc.Add(P "Berdasarkan permasalahan tersebut, dikembangkanlah Sistem Informasi Manajemen dan Reservasi Rental PlayStation dengan nama GO PLAY. Sistem ini merupakan aplikasi berbasis web yang dirancang untuk mengotomatisasi dan mendigitalisasi seluruh proses bisnis rental PlayStation, mulai dari pemesanan (booking) online oleh pelanggan, pengelolaan reservasi oleh Admin, monitoring status unit secara real-time, hingga penyajian laporan pendapatan kepada Pemilik usaha.")
$doc.Add(H2 "1.2 Identifikasi Masalah")
$doc.Add(P "Berdasarkan latar belakang di atas, dapat diidentifikasi beberapa permasalahan utama yang menjadi dasar pengembangan sistem GO PLAY:")
$doc.Add(P "1. Proses pencatatan reservasi yang masih manual menyebabkan potensi kesalahan data dan duplikasi jadwal (double booking).")
$doc.Add(P "2. Tidak adanya sistem pemantauan otomatis terhadap durasi bermain pelanggan, sehingga Admin harus memantau secara manual.")
$doc.Add(P "3. Pengelolaan data inventaris konsol PS4/PS5 yang tidak terstruktur dan sulit dipantau kondisinya.")
$doc.Add(P "4. Sulitnya pemilik usaha mendapatkan laporan pendapatan yang akurat dan real-time tanpa harus meminta Admin merekap data secara manual.")
$doc.Add(P "5. Tidak tersedianya media bagi pelanggan untuk melakukan pemesanan (booking) dari jarak jauh tanpa harus datang langsung ke lokasi.")
$doc.Add(H2 "1.3 Tujuan Pengembangan Sistem")
$doc.Add(P "Tujuan utama dari pengembangan sistem GO PLAY adalah:")
$doc.Add(P "1. Membangun sistem informasi berbasis web yang mampu mengelola reservasi rental PlayStation secara digital dan terintegrasi.")
$doc.Add(P "2. Menyediakan fitur Booking Online bagi Member untuk melakukan pemesanan jadwal bermain secara mandiri dari mana saja.")
$doc.Add(P "3. Mengimplementasikan fitur Monitoring Status Unit dengan Timer Otomatis untuk membantu Admin memantau durasi bermain pelanggan secara real-time.")
$doc.Add(P "4. Menyediakan fitur Kelola Inventaris bagi Admin untuk mendokumentasikan kondisi dan ketersediaan setiap unit konsol PS4/PS5.")
$doc.Add(P "5. Menyajikan Dashboard Laporan Pendapatan yang akurat dan dapat difilter berdasarkan periode kepada Pemilik usaha.")
$doc.Add(H2 "1.4 Ruang Lingkup Proyek")
$doc.Add(P "Pengembangan sistem GO PLAY mencakup ruang lingkup sebagai berikut:")
$doc.Add(P "1. Sistem berbasis web yang dapat diakses melalui browser pada perangkat desktop maupun laptop.")
$doc.Add(P "2. Tiga jenis pengguna (User Role): Member (pelanggan terdaftar), Admin (pengelola rental), dan Pemilik (owner).")
$doc.Add(P "3. Fitur utama yang dikembangkan: Login/Logout multi-peran, Registrasi Member, Booking Online, Kelola Reservasi (termasuk Walk-in), Monitoring Status Unit + Timer, Kelola Inventaris, dan Laporan Pendapatan.")
$doc.Add(P "4. Database yang digunakan: SQLite.")
$doc.Add(P "5. Framework yang digunakan: Laravel 12 (PHP 8.2) sebagai backend, dan Vite + Blade sebagai frontend.")
$doc.Add(P "6. Sistem ini tidak mencakup: integrasi payment gateway, fitur chat real-time, dan aplikasi mobile (Android/iOS).")
$doc.Add(H2 "1.5 Manfaat yang Diharapkan")
$doc.Add(P "Bagi Admin: Mempermudah dan mempercepat proses pengelolaan reservasi, baik online maupun walk-in, serta memantau durasi bermain pelanggan tanpa pengawasan manual yang intensif.")
$doc.Add(P "Bagi Member (Pelanggan): Memberikan kemudahan dalam melakukan pemesanan jadwal bermain secara mandiri melalui aplikasi web kapan saja dan di mana saja.")
$doc.Add(P "Bagi Pemilik: Memberikan visibilitas terhadap kinerja bisnis melalui laporan pendapatan yang otomatis, akurat, dan dapat diakses kapan saja.")
$doc.Add(P "Bagi Pengembang: Sebagai sarana untuk mengimplementasikan ilmu rekayasa perangkat lunak dalam pengembangan sistem informasi berbasis web menggunakan framework modern.")

# ============================================================
# BAB II
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "BAB II")
$doc.Add(H1 "TINJAUAN SINGKAT DAN LANDASAN KONSEPTUAL")
$doc.Add(H2 "2.1 Gambaran Singkat Organisasi atau Objek Studi Kasus")
$doc.Add(P "GO PLAY merupakan sebuah usaha mikro yang bergerak di bidang penyewaan unit PlayStation (PS4 dan PS5). Usaha ini melayani pelanggan yang ingin bermain game konsol secara sewa per jam, baik secara walk-in (datang langsung) maupun melalui sistem reservasi online.")
$doc.Add(Bold "Nama Usaha       : GO PLAY - Rental PlayStation")
$doc.Add(Bold "Bidang Usaha     : Penyewaan Unit Game Console (PlayStation)")
$doc.Add(Bold "Layanan          : Sewa PS4/PS5 per jam, Booking Online, Walk-in")
$doc.Add(Bold "Target Pasar     : Pelajar, Mahasiswa, dan Masyarakat Umum")
$doc.Add(EL)
$doc.Add(P "Visi: Menjadi penyedia layanan rental PlayStation terbaik yang modern, efisien, dan mudah diakses oleh seluruh kalangan masyarakat.")
$doc.Add(P "Misi: (1) Memberikan pengalaman bermain yang nyaman dan menyenangkan; (2) Mengelola reservasi secara digital untuk meminimalisir antrian dan bentrok jadwal; (3) Menjaga kualitas dan kondisi setiap unit konsol melalui pengelolaan inventaris yang terstruktur.")
$doc.Add(H2 "2.2 Konsep Sistem Informasi yang Relevan")
$doc.Add(Bold "a. Sistem Informasi Manajemen (SIM)")
$doc.Add(P "Sistem Informasi Manajemen adalah suatu sistem yang mengumpulkan, memproses, menyimpan, dan menyajikan informasi untuk mendukung proses pengambilan keputusan manajemen. Dalam konteks GO PLAY, SIM diterapkan pada fitur Dashboard Laporan Pendapatan yang membantu Pemilik dalam memantau kinerja bisnisnya.")
$doc.Add(Bold "b. Sistem Reservasi")
$doc.Add(P "Sistem reservasi adalah sistem yang memungkinkan pelanggan untuk memesan atau mengalokasikan sumber daya (dalam hal ini: unit PS) pada waktu tertentu di masa depan. Sistem ini mencegah terjadinya konflik jadwal melalui pengecekan ketersediaan secara otomatis.")
$doc.Add(Bold "c. Sistem Monitoring Real-Time")
$doc.Add(P "Sistem monitoring real-time memungkinkan pemantauan terhadap kondisi atau status suatu objek secara langsung dan terus-menerus. Dalam GO PLAY, konsep ini diterapkan pada fitur Timer Otomatis yang memantau sisa waktu bermain setiap pelanggan.")
$doc.Add(H2 "2.3 Teknologi, Framework, dan Metodologi yang Digunakan")
$doc.Add(Bold "a. Laravel 12 (PHP 8.2)")
$doc.Add(P "Laravel adalah framework PHP open-source yang mengikuti pola arsitektur MVC (Model-View-Controller). Laravel 12 digunakan sebagai backbone backend sistem GO PLAY, menangani routing, autentikasi multi-guard, manajemen database melalui Eloquent ORM, dan logika bisnis aplikasi.")
$doc.Add(Bold "b. Vite dan Blade Template Engine")
$doc.Add(P "Vite digunakan sebagai build tool frontend yang memberikan Hot Module Replacement (HMR) yang cepat selama pengembangan. Blade Template Engine adalah mesin template bawaan Laravel yang digunakan untuk membangun tampilan (view) antarmuka pengguna.")
$doc.Add(Bold "c. SQLite")
$doc.Add(P "SQLite adalah sistem manajemen database relasional berbasis file yang ringan dan tidak memerlukan server terpisah. SQLite digunakan sebagai database utama dalam pengembangan dan pengujian lokal sistem GO PLAY.")
$doc.Add(Bold "d. Arsitektur MVC (Model-View-Controller)")
$doc.Add(P "MVC adalah pola arsitektur perangkat lunak yang memisahkan aplikasi menjadi tiga komponen utama: Model (pengelolaan data), View (tampilan antarmuka), dan Controller (logika bisnis). Pemisahan ini meningkatkan keterbacaan kode dan kemudahan pemeliharaan sistem.")
$doc.Add(Bold "e. Metodologi Pengembangan (Waterfall)")
$doc.Add(P "Pengembangan sistem GO PLAY menggunakan pendekatan metodologi Waterfall yang terstruktur, meliputi tahapan: Analisis Kebutuhan, Perancangan Sistem, Implementasi (Coding), Pengujian, dan Pemeliharaan.")

# ============================================================
# BAB III
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "BAB III")
$doc.Add(H1 "ANALISIS SISTEM")
$doc.Add(H2 "3.1 Analisis Proses Bisnis atau Sistem Berjalan (BPMN)")
$doc.Add(P "Analisis proses bisnis dilakukan terhadap sistem yang diusulkan (To-Be Process). Proses ini digambarkan menggunakan notasi BPMN (Business Process Model and Notation) yang membagi aktivitas berdasarkan pool dan lane aktor.")
$doc.Add(H3 "3.1.1 Inisiasi Proses (Dua Jalur Utama)")
$doc.Add(P "Jalur Online (Member): Proses dimulai ketika Member melakukan F-01: Login Member. Setelah login, Member masuk ke fitur F-04: Input Booking untuk memilih jadwal bermain dan unit PS yang diinginkan.")
$doc.Add(P "Jalur Offline (Walk-in): Pelanggan datang langsung ke lokasi (tanpa aplikasi). Admin menerima kedatangan tersebut dan langsung memprosesnya melalui jalur Input Langsung.")
$doc.Add(PH "[TEMPEL GAMBAR 3.1 - DIAGRAM BPMN DARI FILE KEL8_REV (GO PLAY).docx DI SINI]")
$doc.Add(GJ "3.1" "BPMN Proses Bisnis Sistem GO PLAY")
$doc.Add(H3 "3.1.2 Tahap Validasi dan Pengecekan")
$doc.Add(P "Validasi Otomatis (Sistem): Untuk pesanan online, Sistem secara otomatis menjalankan fungsi Mengecek Ketersediaan Jadwal. Jika Penuh (TIDAK): Alur dikembalikan ke Member. Jika Tersedia (YA): Pesanan diteruskan ke Admin.")
$doc.Add(P "Validasi Manual (Admin): Untuk jalur offline, Admin langsung menuju fitur F-05 untuk mengecek ketersediaan unit secara manual di tempat.")
$doc.Add(H3 "3.1.3 Tahap Pengelolaan Reservasi dan Persiapan (Admin)")
$doc.Add(P "F-05: Kelola Reservasi: Admin mengonfirmasi booking online yang masuk atau melakukan input manual untuk pelanggan offline.")
$doc.Add(P "F-03: Kelola Inventaris: Admin melakukan pengecekan fisik pada perangkat (konsol PS dan controller) untuk memastikan semuanya dalam kondisi baik.")
$doc.Add(H3 "3.1.4 Tahap Operasional dan Monitoring")
$doc.Add(P "F-06: Aktifkan Timer dan Monitoring: Setelah perangkat siap dan pelanggan mulai bermain, Admin mengaktifkan fitur timer untuk memantau durasi bermain dan memberikan notifikasi sisa waktu secara otomatis.")
$doc.Add(H3 "3.1.5 Tahap Pelaporan (Output Akhir)")
$doc.Add(P "F-07: Laporan Pendapatan: Setelah sesi bermain selesai dan transaksi ditutup, data secara otomatis mengalir ke lajur Pemilik dalam bentuk laporan pendapatan.")

$doc.Add(H2 "3.2 Analisis Dokumen")
$doc.Add(P "Analisis dokumen bertujuan untuk mengidentifikasi variabel data yang ada pada sistem manual lama untuk kemudian divalidasi ke dalam skema database sistem baru.")
$doc.Add(EL)
$doc.Add(Bold "Tabel 3.1 Analisis Transformasi Dokumen Manual ke Digital")
$doc.Add(PH "[TEMPEL TABEL ANALISIS DOKUMEN (Buku Member > users, Logbook Inventaris > units, Buku Kasir > transactions, Laporan Bulanan > reports) DI SINI]")

$doc.Add(H2 "3.3 Analisis Kebutuhan Informasi dan Pengguna (SRS)")
$doc.Add(H3 "3.3.1 Kebutuhan Fungsional")
$doc.Add(Bold "Tabel 3.2 Spesifikasi Kebutuhan Fungsional Sistem GO PLAY")
$doc.Add(PH "[TEMPEL TABEL KEBUTUHAN FUNGSIONAL (F-01 sd F-07) DARI FILE Dokumen SRS_Daftar Kebutuhan_Sistem GOPLAY.pdf DI SINI]")
$doc.Add(EL)
$doc.Add(P "F-01 - Login: Memvalidasi kredensial pengguna untuk masuk ke sistem sesuai hak akses. Aktor: Admin, Pemilik, Member. Prioritas: Tinggi.")
$doc.Add(P "F-02 - Log Out: Mengakhiri sesi pengguna pada sistem secara aman. Prioritas: Tinggi.")
$doc.Add(P "F-03 - Kelola Inventaris: Mengelola data unit (PS4/PS5) dan memantau kelayakan perangkat/controller. Aktor: Admin. Prioritas: Sedang.")
$doc.Add(P "F-04 - Booking Online: Melakukan pemesanan jadwal dan unit secara mandiri melalui aplikasi. Aktor: Member. Prioritas: Tinggi.")
$doc.Add(P "F-05 - Kelola Reservasi: Memvalidasi ketersediaan unit, mengonfirmasi, atau mengubah data reservasi masuk. Aktor: Admin. Prioritas: Tinggi.")
$doc.Add(P "F-06 - Monitoring Status Unit: Memantau status unit (Kosong/Isi), menjalankan timer otomatis, dan notifikasi sisa waktu. Aktor: Admin, Member. Prioritas: Tinggi.")
$doc.Add(P "F-07 - Laporan Pendapatan: Menyusun dan menampilkan rekapitulasi keuangan berdasarkan transaksi yang selesai. Aktor: Admin, Pemilik. Prioritas: Sedang.")

$doc.Add(H3 "3.3.2 Kebutuhan Non-Fungsional")
$doc.Add(Bold "Tabel 3.3 Spesifikasi Kebutuhan Non-Fungsional Sistem GO PLAY")
$doc.Add(PH "[TEMPEL TABEL KEBUTUHAN NON-FUNGSIONAL (NF-01 sd NF-06) DARI DOKUMEN SRS DI SINI]")
$doc.Add(EL)
$doc.Add(P "NF-01 - Keamanan (Security): Melindungi kerahasiaan data profil pengguna, password (enkripsi), dan validasi sesi login. Prioritas: Tinggi.")
$doc.Add(P "NF-02 - Ketersediaan (Availability): Sistem harus dapat diakses 24/7 agar Member dapat melakukan Booking Online kapan saja. Prioritas: Tinggi.")
$doc.Add(P "NF-03 - Akurasi Perhitungan: Menjamin ketepatan perhitungan billing otomatis berdasarkan durasi main dan tarif unit secara real-time. Prioritas: Tinggi.")
$doc.Add(P "NF-04 - Kemudahan Penggunaan (Usability): Antarmuka harus responsif dan intuitif. Prioritas: Sedang.")
$doc.Add(P "NF-05 - Integritas Data (Backup): Melakukan pencadangan database secara berkala. Prioritas: Sedang.")
$doc.Add(P "NF-06 - Performa (Performance): Waktu respon sistem saat memvalidasi ketersediaan unit tidak boleh lebih dari 3 detik. Prioritas: Sedang.")

$doc.Add(H2 "3.4 Pemodelan Sistem (UML)")
$doc.Add(H3 "3.4.1 Use Case Diagram dan Skenario Use Case")
$doc.Add(PH "[TEMPEL GAMBAR 3.2 - USE CASE DIAGRAM DARI FILE DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]")
$doc.Add(GJ "3.2" "Use Case Diagram Sistem GO PLAY")
$doc.Add(EL)
$doc.Add(Bold "Skenario Use Case 1: Login")
$doc.Add(P "Aktor: Admin, Member, Pemilik. Deskripsi: Proses masuk ke sistem menggunakan akun yang terdaftar.")
$doc.Add(P "Skenario Utama: (1) Aktor membuka aplikasi/web. (2) Sistem menampilkan formulir login. (3) Aktor memasukkan kredensial dan menekan tombol login. (4) Sistem memvalidasi data ke database. (5) Sistem mengarahkan aktor ke dashboard sesuai hak akses masing-masing.")
$doc.Add(EL)
$doc.Add(Bold "Skenario Use Case 2: Log Out")
$doc.Add(P "Aktor: Admin, Member, Pemilik. Deskripsi: Proses keluar dari sesi sistem secara aman.")
$doc.Add(P "Skenario Utama: (1) Aktor menekan tombol Log Out pada menu navigasi. (2) Sistem menghapus sesi aktif aktor. (3) Sistem mengarahkan kembali ke halaman utama atau halaman login.")
$doc.Add(EL)
$doc.Add(Bold "Skenario Use Case 3: Kelola Inventaris")
$doc.Add(P "Aktor: Admin. Deskripsi: Mengatur data perangkat (PS4/PS5) yang tersedia.")
$doc.Add(P "Skenario Utama: (1) Admin memilih menu Kelola Inventaris. (2) Sistem menampilkan daftar unit yang ada. (3) Admin dapat menambah, mengubah status (baik/rusak), atau menghapus data unit. (4) Admin menyimpan perubahan. (5) Sistem memperbarui data inventaris di database.")
$doc.Add(EL)
$doc.Add(Bold "Skenario Use Case 4: Booking Online")
$doc.Add(P "Aktor: Member. Deskripsi: Melakukan reservasi jadwal main secara mandiri.")
$doc.Add(P "Skenario Utama: (1) Member masuk ke menu Booking Online. (2) Member memilih jenis unit (PS4/PS5) dan jadwal (tanggal/jam). (3) Sistem mengecek ketersediaan unit secara otomatis. (4) Member mengonfirmasi pemesanan. (5) Sistem menerbitkan kode reservasi.")
$doc.Add(EL)
$doc.Add(Bold "Skenario Use Case 5: Kelola Reservasi")
$doc.Add(P "Aktor: Admin. Deskripsi: Mengelola dan memproses data booking yang masuk dari member maupun walk-in.")
$doc.Add(P "Skenario Utama: (1) Admin masuk ke menu Kelola Reservasi. (2) Sistem menampilkan daftar pesanan masuk dari Member. (3) Admin melakukan verifikasi/validasi data booking. (4) Admin mengubah status reservasi (Konfirmasi/Dibatalkan/Selesai). (5) Sistem memperbarui status jadwal.")
$doc.Add(EL)
$doc.Add(Bold "Skenario Use Case 6: Monitoring Status Unit")
$doc.Add(P "Aktor: Admin, Member. Deskripsi: Memantau sisa waktu bermain dan status penggunaan unit secara real-time.")
$doc.Add(P "Skenario Utama: (1) Aktor membuka dashboard monitoring. (2) Sistem menampilkan status unit (Kosong/Terisi/Dipesan). (3) Sistem menjalankan timer otomatis untuk unit yang sedang digunakan. (4) Sistem memberikan peringatan/notifikasi jika waktu bermain hampir habis. (5) Admin dapat menghentikan atau menambah durasi billing.")
$doc.Add(EL)
$doc.Add(Bold "Skenario Use Case 7: Laporan Pendapatan")
$doc.Add(P "Aktor: Admin, Pemilik. Deskripsi: Melihat hasil rekapitulasi keuangan dari transaksi sewa.")
$doc.Add(P "Skenario Utama: (1) Aktor masuk ke menu Laporan Pendapatan. (2) Aktor menentukan filter periode (Harian/Bulanan). (3) Sistem menarik data transaksi berstatus Selesai. (4) Sistem menampilkan total pendapatan dan detail transaksi. (5) Aktor dapat mengunduh atau mencetak laporan.")

$doc.Add(H3 "3.4.2 Activity Diagram")
$doc.Add(PH "[TEMPEL GAMBAR 3.3 - ACTIVITY DIAGRAM LOGIN DARI DOKUMEN UML DI SINI]")
$doc.Add(GJ "3.3" "Activity Diagram - Login")
$doc.Add(PH "[TEMPEL GAMBAR 3.4 - ACTIVITY DIAGRAM BOOKING ONLINE DARI DOKUMEN UML DI SINI]")
$doc.Add(GJ "3.4" "Activity Diagram - Booking Online")
$doc.Add(PH "[TEMPEL GAMBAR 3.5 - ACTIVITY DIAGRAM KELOLA RESERVASI DARI DOKUMEN UML DI SINI]")
$doc.Add(GJ "3.5" "Activity Diagram - Kelola Reservasi")
$doc.Add(PH "[TEMPEL GAMBAR 3.6 - ACTIVITY DIAGRAM MONITORING STATUS UNIT DARI DOKUMEN UML DI SINI]")
$doc.Add(GJ "3.6" "Activity Diagram - Monitoring Status Unit")
$doc.Add(PH "[TEMPEL GAMBAR 3.7 - ACTIVITY DIAGRAM KELOLA INVENTARIS DARI DOKUMEN UML DI SINI]")
$doc.Add(GJ "3.7" "Activity Diagram - Kelola Inventaris")
$doc.Add(PH "[TEMPEL GAMBAR 3.8 - ACTIVITY DIAGRAM LAPORAN PENDAPATAN DARI DOKUMEN UML DI SINI]")
$doc.Add(GJ "3.8" "Activity Diagram - Laporan Pendapatan")

$doc.Add(H3 "3.4.3 Robustness Diagram")
$doc.Add(PH "[TEMPEL GAMBAR 3.9 - ROBUSTNESS DIAGRAM DARI DOKUMEN DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]")
$doc.Add(GJ "3.9" "Robustness Diagram Sistem GO PLAY")

$doc.Add(H3 "3.4.4 Class Diagram")
$doc.Add(PH "[TEMPEL GAMBAR 3.10 - CLASS DIAGRAM DARI DOKUMEN DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]")
$doc.Add(GJ "3.10" "Class Diagram Sistem GO PLAY")

$doc.Add(H3 "3.4.5 Sequence Diagram")
$doc.Add(PH "[TEMPEL GAMBAR 3.11 - SEQUENCE DIAGRAM LOGIN DARI DOKUMEN UML DI SINI]")
$doc.Add(GJ "3.11" "Sequence Diagram - Login")
$doc.Add(PH "[TEMPEL GAMBAR 3.12 - SEQUENCE DIAGRAM BOOKING ONLINE DARI DOKUMEN UML DI SINI]")
$doc.Add(GJ "3.12" "Sequence Diagram - Booking Online")
$doc.Add(PH "[TEMPEL GAMBAR 3.13 - SEQUENCE DIAGRAM KELOLA RESERVASI DARI DOKUMEN UML DI SINI]")
$doc.Add(GJ "3.13" "Sequence Diagram - Kelola Reservasi")
$doc.Add(PH "[TEMPEL GAMBAR 3.14 - SEQUENCE DIAGRAM MONITORING STATUS UNIT DARI DOKUMEN UML DI SINI]")
$doc.Add(GJ "3.14" "Sequence Diagram - Monitoring Status Unit")

# ============================================================
# BAB IV
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "BAB IV")
$doc.Add(H1 "PERANCANGAN SISTEM")
$doc.Add(H2 "4.1 Perancangan Arsitektur Sistem")
$doc.Add(P "Sistem GO PLAY dirancang menggunakan pola arsitektur MVC (Model-View-Controller) yang diimplementasikan melalui framework Laravel 12. Model bertanggung jawab atas pengelolaan data dan interaksi dengan database SQLite. View bertanggung jawab atas tampilan antarmuka pengguna yang dibangun menggunakan Blade Template Engine dan dikompilasi menggunakan Vite. Controller bertanggung jawab atas logika bisnis aplikasi, memproses request dari pengguna, berinteraksi dengan Model, dan mengembalikan respons ke View.")
$doc.Add(PH "[TEMPEL GAMBAR 4.1 - DIAGRAM ARSITEKTUR SISTEM MVC GO PLAY DI SINI]")
$doc.Add(GJ "4.1" "Arsitektur Sistem GO PLAY (MVC)")

$doc.Add(H2 "4.2 Desain Basis Data")
$doc.Add(P "Basis data sistem GO PLAY dirancang menggunakan SQLite dengan pendekatan relasional. Entitas utama yang terlibat adalah sebagai berikut:")
$doc.Add(Bold "Tabel users: Menyimpan data akun pelanggan (Member).")
$doc.Add(P "Kolom: id, name, email, password, phone, email_verified_at, remember_token, created_at, updated_at.")
$doc.Add(Bold "Tabel admins: Menyimpan data akun Admin.")
$doc.Add(P "Kolom: id, name, email, password, remember_token, created_at, updated_at.")
$doc.Add(Bold "Tabel consoles: Menyimpan data unit konsol PS4/PS5.")
$doc.Add(P "Kolom: id, name, type (PS4/PS5), status (available/occupied/maintenance), price_per_hour, description, created_at, updated_at.")
$doc.Add(Bold "Tabel bookings: Menyimpan data reservasi.")
$doc.Add(P "Kolom: id, booking_code, user_id, console_id, booking_date, start_time, end_time, duration, total_price, status (pending/confirmed/completed/cancelled), payment_status, created_at, updated_at.")
$doc.Add(Bold "Tabel transactions: Menyimpan data transaksi yang telah selesai.")
$doc.Add(P "Kolom: id, booking_id, amount, payment_method, paid_at, created_at, updated_at.")
$doc.Add(PH "[TEMPEL GAMBAR 4.2 - ENTITY RELATIONSHIP DIAGRAM (ERD) DI SINI]")
$doc.Add(GJ "4.2" "Entity Relationship Diagram (ERD) Sistem GO PLAY")

$doc.Add(H2 "4.3 Desain Antarmuka Pengguna (UI)")
$doc.Add(P "Desain antarmuka pengguna sistem GO PLAY dirancang dengan memperhatikan prinsip kemudahan penggunaan (usability) dan estetika visual yang modern. Desain awal (wireframe) dibuat menggunakan Figma sebelum diimplementasikan ke dalam kode.")
$doc.Add(P "Link Figma: https://www.figma.com/site/S3ShQKDKt7BylYmXNlHTX7/GOPLAY")
$doc.Add(PH "[TEMPEL GAMBAR 4.3 - WIREFRAME HALAMAN UTAMA DARI LAPORAN WIREFRAME UIUX DI SINI]")
$doc.Add(GJ "4.3" "Wireframe Halaman Utama GO PLAY")
$doc.Add(PH "[TEMPEL GAMBAR 4.4 - WIREFRAME HALAMAN LOGIN DARI LAPORAN WIREFRAME UIUX DI SINI]")
$doc.Add(GJ "4.4" "Wireframe Halaman Login GO PLAY")
$doc.Add(PH "[TEMPEL GAMBAR 4.5 - WIREFRAME HALAMAN BOOKING DARI LAPORAN WIREFRAME UIUX DI SINI]")
$doc.Add(GJ "4.5" "Wireframe Halaman Booking GO PLAY")

# ============================================================
# BAB V
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "BAB V")
$doc.Add(H1 "IMPLEMENTASI DAN PENGUJIAN")
$doc.Add(H2 "5.1 Implementasi Database")
$doc.Add(P "Database sistem GO PLAY diimplementasikan menggunakan SQLite. Struktur tabel dibuat menggunakan fitur Migrations milik Laravel, sehingga memudahkan proses pembuatan ulang dan pengelolaan versi database. Perintah untuk menjalankan migrasi database: php artisan migrate --seed")
$doc.Add(P "Seeder (data awal) yang disediakan meliputi: data Admin default, data konsol PS4/PS5 (5 unit), dan data Member contoh untuk keperluan pengujian.")
$doc.Add(H2 "5.2 Implementasi Antarmuka")
$doc.Add(H3 "5.2.1 Halaman Utama dan Login")
$doc.Add(PH "[TEMPEL GAMBAR 5.1 - SCREENSHOT HALAMAN UTAMA DARI FILE User_Guide_GoPlay.doc DI SINI]")
$doc.Add(GJ "5.1" "Screenshot Halaman Utama GO PLAY")
$doc.Add(PH "[TEMPEL GAMBAR 5.2 - SCREENSHOT HALAMAN LOGIN DARI USER GUIDE DI SINI]")
$doc.Add(GJ "5.2" "Screenshot Halaman Login GO PLAY")
$doc.Add(H3 "5.2.2 Dashboard dan Fitur Member")
$doc.Add(PH "[TEMPEL GAMBAR 5.3 - SCREENSHOT DASHBOARD MEMBER DARI USER GUIDE DI SINI]")
$doc.Add(GJ "5.3" "Screenshot Dashboard Member GO PLAY")
$doc.Add(PH "[TEMPEL GAMBAR 5.4 - SCREENSHOT HALAMAN BOOKING ONLINE DARI USER GUIDE DI SINI]")
$doc.Add(GJ "5.4" "Screenshot Halaman Booking Online GO PLAY")
$doc.Add(H3 "5.2.3 Dashboard dan Fitur Admin")
$doc.Add(PH "[TEMPEL GAMBAR 5.5 - SCREENSHOT DASHBOARD ADMIN DARI USER GUIDE DI SINI]")
$doc.Add(GJ "5.5" "Screenshot Dashboard Admin GO PLAY")
$doc.Add(PH "[TEMPEL GAMBAR 5.6 - SCREENSHOT HALAMAN MONITORING TIMER DARI USER GUIDE DI SINI]")
$doc.Add(GJ "5.6" "Screenshot Monitoring Timer Unit")
$doc.Add(PH "[TEMPEL GAMBAR 5.7 - SCREENSHOT KELOLA RESERVASI DARI USER GUIDE DI SINI]")
$doc.Add(GJ "5.7" "Screenshot Kelola Reservasi Admin")
$doc.Add(PH "[TEMPEL GAMBAR 5.8 - SCREENSHOT LAPORAN PENDAPATAN DARI USER GUIDE DI SINI]")
$doc.Add(GJ "5.8" "Screenshot Laporan Pendapatan GO PLAY")

$doc.Add(H2 "5.3 Struktur Program dan Pengelolaan Source Code")
$doc.Add(P "Source code sistem GO PLAY dikelola menggunakan sistem kontrol versi Git dan dipublikasikan pada repositori GitHub berikut:")
$doc.Add(P "Repository: https://github.com/adamme26/Sistem-Informasi-Manajemen-dan-Reservasi-Rental-PlayStation-GO-PLAY-Berbasis-Web")
$doc.Add(EL)
$doc.Add(P "Struktur direktori utama:")
$doc.Add(P "app/Http/Controllers/ - Berisi semua Controller (Admin, Member, Auth)")
$doc.Add(P "app/Models/ - Berisi semua Model (User, Admin, Console, Booking, Transaction)")
$doc.Add(P "database/migrations/ - Berisi file migrasi skema database")
$doc.Add(P "database/database.sqlite - File database SQLite")
$doc.Add(P "resources/views/ - Berisi template Blade HTML untuk tampilan")
$doc.Add(P "routes/web.php - File routing seluruh URL aplikasi")
$doc.Add(P "public/ - Berisi asset publik (CSS, JS, gambar)")
$doc.Add(P "vite.config.js - Konfigurasi build tool frontend")

$doc.Add(H2 "5.4 Pengujian Menggunakan Tools")
$doc.Add(Bold "a. Pengujian Manual (Black Box Testing)")
$doc.Add(P "Pengujian dilakukan secara manual dengan cara menjalankan aplikasi dan mencoba setiap fitur satu per satu untuk memastikan output yang dihasilkan sesuai dengan yang diharapkan berdasarkan spesifikasi kebutuhan.")
$doc.Add(Bold "b. Pengujian Error Handling")
$doc.Add(P "Diuji dengan cara memasukkan data yang tidak valid, seperti: input durasi bukan angka (yang menyebabkan error Carbon::rawAddUnit() dan telah diperbaiki dengan casting (int)), pemesanan pada unit yang sudah terisi (double booking prevention), dan login dengan kredensial yang salah.")
$doc.Add(EL)
$doc.Add(PH "[TEMPEL TABEL/SCREENSHOT HASIL PENGUJIAN DARI DOKUMENTASI PENGUJIAN TOOLS DI SINI]")

$doc.Add(H2 "5.5 User Acceptance Testing (UAT)")
$doc.Add(P "User Acceptance Testing (UAT) dilakukan dengan melibatkan pengguna nyata (Admin dan Member) untuk memastikan bahwa sistem yang dikembangkan telah memenuhi kebutuhan dan ekspektasi pengguna akhir.")
$doc.Add(PH "[TEMPEL TABEL HASIL UAT DAN FORMULIR PENERIMAAN PENGGUNA DI SINI]")

# ============================================================
# BAB VI
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "BAB VI")
$doc.Add(H1 "PENUTUP")
$doc.Add(H2 "6.1 Kesimpulan")
$doc.Add(P "Berdasarkan hasil analisis, perancangan, implementasi, dan pengujian yang telah dilakukan, dapat ditarik kesimpulan sebagai berikut:")
$doc.Add(P "1. Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY) telah berhasil dikembangkan menggunakan framework Laravel 12 (PHP 8.2) dengan arsitektur MVC dan database SQLite.")
$doc.Add(P "2. Sistem berhasil mengimplementasikan tujuh fitur fungsional utama: Login multi-peran, Booking Online, Kelola Reservasi (termasuk Walk-in), Monitoring Status Unit dengan Timer Otomatis, Kelola Inventaris, Laporan Pendapatan, dan Logout.")
$doc.Add(P "3. Fitur Booking Online berhasil mencegah terjadinya double booking melalui mekanisme pengecekan ketersediaan jadwal secara otomatis sebelum reservasi dikonfirmasi.")
$doc.Add(P "4. Fitur Timer Otomatis pada dashboard Admin berhasil memantau durasi bermain pelanggan secara real-time dan memberikan notifikasi saat waktu hampir habis.")
$doc.Add(P "5. Dashboard Laporan Pendapatan berhasil menyajikan rekapitulasi keuangan yang akurat dan dapat difilter berdasarkan periode kepada Pemilik usaha.")
$doc.Add(P "6. Sistem telah diuji melalui pengujian fungsional (black-box) dan UAT, dengan hasil yang menunjukkan bahwa seluruh fitur berjalan sesuai dengan spesifikasi kebutuhan yang telah ditetapkan.")

$doc.Add(H2 "6.2 Saran")
$doc.Add(P "Untuk pengembangan sistem GO PLAY ke depannya, beberapa saran yang dapat dipertimbangkan:")
$doc.Add(P "1. Integrasi Payment Gateway: Menambahkan fitur pembayaran digital (seperti Midtrans atau QRIS) agar transaksi dapat diselesaikan secara online.")
$doc.Add(P "2. Notifikasi WhatsApp/Email: Mengintegrasikan notifikasi otomatis via WhatsApp API atau email untuk konfirmasi booking dan pengingat jadwal kepada Member.")
$doc.Add(P "3. Pengembangan Aplikasi Mobile: Membangun versi aplikasi mobile (Android/iOS) agar Member dapat melakukan booking melalui smartphone dengan lebih mudah.")
$doc.Add(P "4. Deployment ke Server Hosting: Mengoptimalkan sistem untuk dapat di-deploy ke server hosting berbasis Linux dengan database MySQL agar sistem dapat diakses secara publik 24/7.")
$doc.Add(P "5. Fitur Review dan Rating: Menambahkan fitur ulasan dari pelanggan terhadap layanan untuk membantu Pemilik mengevaluasi kualitas layanan secara berkelanjutan.")

# ============================================================
# DAFTAR PUSTAKA
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "DAFTAR PUSTAKA")
$doc.Add(P "[1]  O Brien, J. A., dan Marakas, G. M. (2011). Management Information Systems (10th ed.). McGraw-Hill.")
$doc.Add(P "[2]  Pressman, R. S., dan Maxim, B. R. (2015). Software Engineering: A Practitioner Approach (8th ed.). McGraw-Hill Education.")
$doc.Add(P "[3]  Laravel. (2024). Laravel 12.x Documentation. https://laravel.com/docs/12.x")
$doc.Add(P "[4]  Sommerville, I. (2016). Software Engineering (10th ed.). Pearson Education.")
$doc.Add(P "[5]  Fowler, M. (2002). Patterns of Enterprise Application Architecture. Addison-Wesley Professional.")
$doc.Add(P "[6]  SQLite Consortium. (2024). SQLite Documentation. https://www.sqlite.org/docs.html")
$doc.Add(P "[7]  Object Management Group. (2017). Unified Modeling Language (UML) Specification Version 2.5.1. https://www.omg.org/spec/UML/")
$doc.Add(P "[8]  Object Management Group. (2013). Business Process Model and Notation (BPMN) Version 2.0.2. https://www.omg.org/spec/BPMN/")
$doc.Add(P "[9]  Nielsen, J. (1994). Usability Engineering. Morgan Kaufmann Publishers.")
$doc.Add(P "[10] Connolly, T. M., dan Begg, C. E. (2014). Database Systems: A Practical Approach to Design, Implementation, and Management (6th ed.). Pearson Education.")

# ============================================================
# LAMPIRAN
# ============================================================
$doc.Add(PB)
$doc.Add(H1 "LAMPIRAN")
$doc.Add(H2 "Lampiran 1 - Profile Tim Proyek")
$doc.Add(PH "[TEMPEL SELURUH ISI DOKUMEN Lampiran Profile Tim Proyek Go Play.docx DI SINI]")
$doc.Add(H2 "Lampiran 2 - Dokumen Project Charter")
$doc.Add(PH "[TEMPEL SELURUH ISI DOKUMEN Lampiran Project Charter GO PLAY .pdf DI SINI]")
$doc.Add(H2 "Lampiran 3 - WBS dan Timeline")
$doc.Add(PH "[TEMPEL SELURUH GAMBAR DARI Lampiran Dokumen WBS dan Timeline Proyek GO PLAY.pdf DI SINI]")
$doc.Add(H2 "Lampiran 4 - Dokumen SRS / Daftar Kebutuhan")
$doc.Add(PH "[TEMPEL SELURUH ISI DOKUMEN Dokumen SRS_Daftar Kebutuhan_Sistem GOPLAY.pdf DI SINI]")
$doc.Add(H2 "Lampiran 5 - Dokumen UML")
$doc.Add(PH "[TEMPEL SELURUH GAMBAR DIAGRAM DARI DOKUMEN DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]")
$doc.Add(H2 "Lampiran 6 - Dokumen UI/UX (Wireframe)")
$doc.Add(PH "[TEMPEL GAMBAR WIREFRAME DARI FILE LAPORAN WIREFRAME UIUX PROYEK PERANGKAT LUNAK.pdf DI SINI]")
$doc.Add(H2 "Lampiran 7 - Dokumentasi Source Code")
$doc.Add(P "Repository GitHub: https://github.com/adamme26/Sistem-Informasi-Manajemen-dan-Reservasi-Rental-PlayStation-GO-PLAY-Berbasis-Web")
$doc.Add(PH "[TEMPEL SCREENSHOT REPOSITORI GITHUB DAN CUPLIKAN KODE PENTING DI SINI]")
$doc.Add(H2 "Lampiran 8 - Dokumentasi Pengujian Tools dan UAT")
$doc.Add(PH "[TEMPEL TABEL HASIL PENGUJIAN TOOLS DAN UAT DI SINI]")
$doc.Add(H2 "Lampiran 9 - Dokumentasi Penggunaan Sistem (User Guide)")
$doc.Add(PH "[TEMPEL SELURUH ISI DOKUMEN User_Guide_GoPlay.doc DI SINI]")

# ============================================================
# BUILD document.xml
# ============================================================
$sb = [System.Text.StringBuilder]::new()
$sb.AppendLine('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>') | Out-Null
$sb.AppendLine('<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">') | Out-Null
$sb.AppendLine('<w:body>') | Out-Null
foreach ($p in $doc) { $sb.AppendLine($p) | Out-Null }
$sb.AppendLine('<w:sectPr>') | Out-Null
$sb.AppendLine('  <w:pgSz w:w="12240" w:h="15840"/>') | Out-Null
$sb.AppendLine('  <w:pgMar w:top="1440" w:right="1080" w:bottom="1440" w:left="1800"/>') | Out-Null
$sb.AppendLine('</w:sectPr>') | Out-Null
$sb.AppendLine('</w:body>') | Out-Null
$sb.AppendLine('</w:document>') | Out-Null

WriteFile "$tmpDir\word\document.xml" $sb.ToString()

# ============================================================
# ZIP everything into .docx
# ============================================================
[System.IO.Compression.ZipFile]::CreateFromDirectory($tmpDir, $outputPath, [System.IO.Compression.CompressionLevel]::Optimal, $false)

# Cleanup tmp
Remove-Item $tmpDir -Recurse -Force

$size = (Get-Item $outputPath).Length / 1KB
Write-Output "SUCCESS: File created at $outputPath"
Write-Output "File size: $([math]::Round($size, 2)) KB"

