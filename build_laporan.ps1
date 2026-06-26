Add-Type -AssemblyName System.IO.Compression.FileSystem

# =====================================================
# BUILD A PROPER .docx FROM SCRATCH USING OPENXML
# =====================================================

$outputPath = 'C:\Users\noval mulyadi\Documents\SMT4\Proyek Perangkat Lunak\LAPORAN\LAPORAN_AKHIR_GOPLAY_KEL8.docx'

# Remove if exists
if (Test-Path $outputPath) { Remove-Item $outputPath -Force }

# Create zip stream
$ms = New-Object System.IO.MemoryStream
$zip = [System.IO.Compression.ZipArchive]::new($ms, [System.IO.Compression.ZipArchiveMode]::Create, $true)

# ---- [Content_Types].xml ----
$ct = $zip.CreateEntry('[Content_Types].xml')
$sw = New-Object System.IO.StreamWriter($ct.Open())
$sw.Write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
  <Override PartName="/word/numbering.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml"/>
</Types>')
$sw.Flush(); $sw.Dispose()

# ---- _rels/.rels ----
$rels = $zip.CreateEntry('_rels/.rels')
$sw = New-Object System.IO.StreamWriter($rels.Open())
$sw.Write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>')
$sw.Flush(); $sw.Dispose()

# ---- word/_rels/document.xml.rels ----
$docRels = $zip.CreateEntry('word/_rels/document.xml.rels')
$sw = New-Object System.IO.StreamWriter($docRels.Open())
$sw.Write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
  <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering" Target="numbering.xml"/>
</Relationships>')
$sw.Flush(); $sw.Dispose()

# ---- word/numbering.xml ----
$numEntry = $zip.CreateEntry('word/numbering.xml')
$sw = New-Object System.IO.StreamWriter($numEntry.Open())
$sw.Write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:numbering xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:abstractNum w:abstractNumId="0">
    <w:lvl w:ilvl="0"><w:start w:val="1"/><w:numFmt w:val="decimal"/><w:lvlText w:val="%1."/><w:lvlJc w:val="left"/><w:pPr><w:ind w:left="720" w:hanging="360"/></w:pPr></w:lvl>
  </w:abstractNum>
  <w:num w:numId="1"><w:abstractNumId w:val="0"/></w:num>
</w:numbering>')
$sw.Flush(); $sw.Dispose()

# ---- word/styles.xml ----
$stylesEntry = $zip.CreateEntry('word/styles.xml')
$sw = New-Object System.IO.StreamWriter($stylesEntry.Open())
$sw.Write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
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
    <w:pPr><w:jc w:val="center"/><w:spacing w:before="120" w:after="120" w:line="240" w:lineRule="auto"/><w:pBdr><w:top w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/><w:left w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/><w:bottom w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/><w:right w:val="dashed" w:sz="6" w:space="1" w:color="FF0000"/></w:pBdr><w:shd w:val="clear" w:color="auto" w:fill="FFFF00"/></w:pPr>
    <w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:color w:val="CC0000"/><w:sz w:val="24"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="CoverTitle">
    <w:name w:val="CoverTitle"/>
    <w:basedOn w:val="Normal"/>
    <w:pPr><w:jc w:val="center"/><w:spacing w:before="0" w:after="120" w:line="480" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:b/><w:sz w:val="28"/><w:szCs w:val="28"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="CenterNormal">
    <w:name w:val="CenterNormal"/>
    <w:basedOn w:val="Normal"/>
    <w:pPr><w:jc w:val="center"/><w:spacing w:before="0" w:after="120" w:line="480" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/><w:sz w:val="24"/><w:szCs w:val="24"/></w:rPr>
  </w:style>
</w:styles>')
$sw.Flush(); $sw.Dispose()

# Helper functions to build XML paragraphs
function H1 { param($text)
    return "<w:p><w:pPr><w:pStyle w:val=`"Heading1`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>"
}
function H2 { param($text)
    return "<w:p><w:pPr><w:pStyle w:val=`"Heading2`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>"
}
function H3 { param($text)
    return "<w:p><w:pPr><w:pStyle w:val=`"Heading3`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>"
}
function H4 { param($text)
    return "<w:p><w:pPr><w:pStyle w:val=`"Heading4`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>"
}
function P { param($text)
    return "<w:p><w:pPr><w:pStyle w:val=`"Normal`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>"
}
function PH { param($text)
    return "<w:p><w:pPr><w:pStyle w:val=`"Placeholder`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>"
}
function PCenter { param($text)
    return "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>"
}
function PageBreak {
    return "<w:p><w:r><w:br w:type=`"page`"/></w:r></w:p>"
}
function EmptyLine {
    return "<w:p><w:pPr><w:pStyle w:val=`"Normal`"/></w:pPr></w:p>"
}
function Bold { param($text)
    return "<w:p><w:pPr><w:pStyle w:val=`"Normal`"/></w:pPr><w:r><w:rPr><w:b/></w:rPr><w:t xml:space=`"preserve`">$text</w:t></w:r></w:p>"
}

# Build the document body
$body = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
<w:body>
<w:sectPr>
  <w:pgSz w:w="12240" w:h="15840"/>
  <w:pgMar w:top="1440" w:right="1080" w:bottom="1440" w:left="1800" w:header="720" w:footer="720" w:gutter="0"/>
</w:sectPr>
</w:body>
</w:document>'

# Build actual content
$doc = @()

# ================================================================
# COVER
# ================================================================
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CoverTitle`"/><w:spacing w:before=`"2880`" w:after=`"240`"/></w:pPr><w:r><w:t>LAPORAN AKHIR PROYEK PERANGKAT LUNAK</w:t></w:r></w:p>"
$doc += PCenter "SISTEM INFORMASI MANAJEMEN DAN RESERVASI RENTAL PLAYSTATION"
$doc += PCenter "(GO PLAY) BERBASIS WEB"
$doc += EmptyLine
$doc += EmptyLine
$doc += PH "[TEMPEL LOGO UNIVERSITAS SUBANG DI SINI]"
$doc += EmptyLine
$doc += EmptyLine
$doc += PCenter "Disusun oleh:"
$doc += PCenter "Kelompok 8"
$doc += EmptyLine
$doc += PCenter "ADAM. F          D1A240046"
$doc += PCenter "AZFAR WILDAN. P  D1A240026"
$doc += PCenter "M. NOVAL MULYADI D1A240039"
$doc += PCenter "DIVI AGUNG SATRIA D1A240038"
$doc += PCenter "RAMDAN PRAYITNO  D1A240032"
$doc += EmptyLine
$doc += EmptyLine
$doc += PCenter "PROGRAM STUDI SISTEM INFORMASI"
$doc += PCenter "FAKULTAS ILMU KOMPUTER"
$doc += PCenter "UNIVERSITAS SUBANG"
$doc += PCenter "2026"

$doc += PageBreak

# ================================================================
# LEMBAR PENGESAHAN
# ================================================================
$doc += "<w:p><w:pPr><w:jc w:val=`"center`"/><w:spacing w:before=`"0`" w:after=`"240`" w:line=`"480`" w:lineRule=`"auto`"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii=`"Times New Roman`" w:hAnsi=`"Times New Roman`"/><w:b/><w:sz w:val=`"28`"/></w:rPr><w:t>LEMBAR PENGESAHAN</w:t></w:r></w:p>"
$doc += EmptyLine
$doc += P "Judul Proyek : Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY) Berbasis Web"
$doc += P "Program Studi : Sistem Informasi"
$doc += P "Fakultas : Ilmu Komputer"
$doc += P "Universitas : Universitas Subang"
$doc += P "Tahun Akademik : 2025/2026"
$doc += P "Kelompok : 8"
$doc += EmptyLine
$doc += P "Anggota Tim:"
$doc += P "1. Adam. F - D1A240046"
$doc += P "2. Azfar Wildan. P - D1A240026"
$doc += P "3. M. Noval Mulyadi - D1A240039"
$doc += P "4. Divi Agung Satria - D1A240038"
$doc += P "5. Ramdan Prayitno - D1A240032"
$doc += EmptyLine
$doc += PH "[TEMPEL TANDA TANGAN DOSEN PEMBIMBING DAN KETUA KELOMPOK DI SINI]"

$doc += PageBreak

# ================================================================
# ABSTRAK
# ================================================================
$doc += H1 "ABSTRAK"
$doc += P "Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY) dikembangkan untuk mengatasi permasalahan operasional yang umum terjadi pada bisnis rental PlayStation konvensional, yaitu pencatatan manual yang rawan kesalahan, risiko bentrok jadwal pemesanan (double booking), dan sulitnya merekap laporan pendapatan secara akurat. Sistem ini dibangun menggunakan framework Laravel 12 (PHP 8.2) dengan database SQLite dan antarmuka berbasis Vite, serta menerapkan arsitektur MVC (Model-View-Controller). Hasil pengembangan berupa aplikasi web yang memiliki tiga peran pengguna (Admin, Member, dan Pemilik) dengan fitur utama meliputi: Booking Online oleh Member, Kelola Reservasi dan Walk-in oleh Admin, Monitoring Status Unit dengan Timer Otomatis, Pengelolaan Inventaris konsol PS4/PS5, dan Dashboard Laporan Pendapatan untuk Pemilik. Sistem ini terbukti mampu mengotomatisasi proses bisnis rental PlayStation sehingga meminimalisir kesalahan operasional dan meningkatkan efisiensi kerja Admin."
$doc += EmptyLine
$doc += Bold "Kata Kunci: Sistem Informasi, Rental PlayStation, Booking Online, Laravel, MVC, Timer Otomatis."
$doc += EmptyLine
$doc += H1 "ABSTRACT"
$doc += P "The PlayStation Rental Management and Reservation Information System (GO PLAY) was developed to address operational problems commonly found in conventional PlayStation rental businesses, namely error-prone manual recording, the risk of scheduling conflicts (double booking), and difficulties in accurately compiling revenue reports. This system was built using the Laravel 12 framework (PHP 8.2) with a SQLite database and a Vite-based interface, applying MVC (Model-View-Controller) architecture. The resulting web application has three user roles (Admin, Member, and Owner) with main features including: Online Booking by Members, Reservation and Walk-in Management by Admin, Unit Status Monitoring with Automatic Timer, PS4/PS5 Console Inventory Management, and Revenue Report Dashboard for Owners. This system has been proven capable of automating PlayStation rental business processes, thereby minimizing operational errors and improving Admin work efficiency."
$doc += EmptyLine
$doc += Bold "Keywords: Information System, PlayStation Rental, Online Booking, Laravel, MVC, Automatic Timer."

$doc += PageBreak

# ================================================================
# DAFTAR ISI
# ================================================================
$doc += H1 "DAFTAR ISI"
$doc += P "LEMBAR PENGESAHAN"
$doc += P "ABSTRAK"
$doc += P "ABSTRACT"
$doc += P "DAFTAR ISI"
$doc += P "DAFTAR GAMBAR"
$doc += P "BAB I PENDAHULUAN"
$doc += P "    1.1 Latar Belakang"
$doc += P "    1.2 Identifikasi Masalah"
$doc += P "    1.3 Tujuan Pengembangan Sistem"
$doc += P "    1.4 Ruang Lingkup Proyek"
$doc += P "    1.5 Manfaat yang Diharapkan"
$doc += P "BAB II TINJAUAN SINGKAT DAN LANDASAN KONSEPTUAL"
$doc += P "    2.1 Gambaran Singkat Organisasi atau Objek Studi Kasus"
$doc += P "    2.2 Konsep Sistem Informasi yang Relevan"
$doc += P "    2.3 Teknologi, Framework, dan Metodologi yang Digunakan"
$doc += P "BAB III ANALISIS SISTEM"
$doc += P "    3.1 Analisis Proses Bisnis atau Sistem Berjalan (BPMN)"
$doc += P "    3.2 Analisis Dokumen"
$doc += P "    3.3 Analisis Kebutuhan Informasi dan Pengguna (SRS)"
$doc += P "    3.4 Pemodelan Sistem (UML)"
$doc += P "BAB IV PERANCANGAN SISTEM"
$doc += P "    4.1 Perancangan Arsitektur Sistem"
$doc += P "    4.2 Desain Basis Data"
$doc += P "    4.3 Desain Antarmuka Pengguna (UI)"
$doc += P "BAB V IMPLEMENTASI DAN PENGUJIAN"
$doc += P "    5.1 Implementasi Database"
$doc += P "    5.2 Implementasi Antarmuka"
$doc += P "    5.3 Struktur Program dan Pengelolaan Source Code"
$doc += P "    5.4 Pengujian menggunakan Tools"
$doc += P "    5.5 User Acceptance Testing (UAT)"
$doc += P "BAB VI PENUTUP"
$doc += P "    6.1 Kesimpulan"
$doc += P "    6.2 Saran"
$doc += P "DAFTAR PUSTAKA"
$doc += P "LAMPIRAN"

$doc += PageBreak

# ================================================================
# DAFTAR GAMBAR
# ================================================================
$doc += H1 "DAFTAR GAMBAR"
$doc += P "Gambar 3.1 BPMN Proses Bisnis GO PLAY"
$doc += P "Gambar 3.2 Use Case Diagram Sistem GO PLAY"
$doc += P "Gambar 3.3 Activity Diagram - Login"
$doc += P "Gambar 3.4 Activity Diagram - Booking Online"
$doc += P "Gambar 3.5 Activity Diagram - Kelola Reservasi"
$doc += P "Gambar 3.6 Activity Diagram - Monitoring Status Unit"
$doc += P "Gambar 3.7 Activity Diagram - Kelola Inventaris"
$doc += P "Gambar 3.8 Activity Diagram - Laporan Pendapatan"
$doc += P "Gambar 3.9 Robustness Diagram"
$doc += P "Gambar 3.10 Class Diagram"
$doc += P "Gambar 3.11 Sequence Diagram - Login"
$doc += P "Gambar 3.12 Sequence Diagram - Booking Online"
$doc += P "Gambar 3.13 Sequence Diagram - Kelola Reservasi"
$doc += P "Gambar 3.14 Sequence Diagram - Monitoring Status Unit"
$doc += P "Gambar 4.1 Arsitektur Sistem GO PLAY (MVC)"
$doc += P "Gambar 4.2 Entity Relationship Diagram (ERD)"
$doc += P "Gambar 4.3 Wireframe - Halaman Utama"
$doc += P "Gambar 4.4 Wireframe - Halaman Login"
$doc += P "Gambar 4.5 Wireframe - Halaman Booking"
$doc += P "Gambar 5.1 Screenshot Halaman Utama"
$doc += P "Gambar 5.2 Screenshot Halaman Login"
$doc += P "Gambar 5.3 Screenshot Dashboard Member"
$doc += P "Gambar 5.4 Screenshot Halaman Booking Online"
$doc += P "Gambar 5.5 Screenshot Dashboard Admin"
$doc += P "Gambar 5.6 Screenshot Monitoring Timer"
$doc += P "Gambar 5.7 Screenshot Kelola Reservasi"
$doc += P "Gambar 5.8 Screenshot Laporan Pendapatan"

$doc += PageBreak

# ================================================================
# BAB I PENDAHULUAN
# ================================================================
$doc += H1 "BAB I`nPENDAHULUAN"

$doc += H2 "1.1 Latar Belakang"
$doc += P "Industri hiburan berbasis gaming, khususnya penyewaan unit PlayStation, saat ini tengah berkembang pesat di berbagai kota di Indonesia. Bisnis rental PlayStation (PS) merupakan salah satu bentuk usaha mikro yang diminati oleh berbagai kalangan, terutama di lingkungan perkotaan dan kawasan kampus. Namun, sebagian besar usaha rental PlayStation masih dikelola secara konvensional, yaitu dengan mengandalkan pencatatan manual menggunakan buku tulis, papan tulis jadwal, atau aplikasi sederhana yang tidak terintegrasi."
$doc += P "Sistem konvensional tersebut rentan menimbulkan berbagai permasalahan operasional, seperti: (1) terjadinya bentrok jadwal pemesanan (double booking) akibat tidak adanya sistem pengecekan otomatis; (2) kesulitan dalam memantau sisa waktu bermain pelanggan yang mengharuskan Admin selalu siaga secara manual; (3) pengelolaan inventaris konsol PS4/PS5 dan aksesoris yang tidak terdokumentasi dengan baik; serta (4) pelaporan pendapatan yang tidak akurat dan memakan waktu lama karena harus direkap secara manual."
$doc += P "Berdasarkan permasalahan tersebut, dikembangkanlah Sistem Informasi Manajemen dan Reservasi Rental PlayStation dengan nama GO PLAY. Sistem ini merupakan aplikasi berbasis web yang dirancang untuk mengotomatisasi dan mendigitalisasi seluruh proses bisnis rental PlayStation, mulai dari pemesanan (booking) online oleh pelanggan, pengelolaan reservasi oleh Admin, monitoring status unit secara real-time, hingga penyajian laporan pendapatan kepada Pemilik usaha."

$doc += H2 "1.2 Identifikasi Masalah"
$doc += P "Berdasarkan latar belakang di atas, dapat diidentifikasi beberapa permasalahan utama yang menjadi dasar pengembangan sistem GO PLAY:"
$doc += P "1. Proses pencatatan reservasi yang masih manual menyebabkan potensi kesalahan data dan duplikasi jadwal (double booking)."
$doc += P "2. Tidak adanya sistem pemantauan otomatis terhadap durasi bermain pelanggan, sehingga Admin harus memantau secara manual."
$doc += P "3. Pengelolaan data inventaris konsol PS4/PS5 yang tidak terstruktur dan sulit dipantau kondisinya."
$doc += P "4. Sulitnya pemilik usaha mendapatkan laporan pendapatan yang akurat dan real-time tanpa harus meminta Admin merekap data secara manual."
$doc += P "5. Tidak tersedianya media bagi pelanggan untuk melakukan pemesanan (booking) dari jarak jauh tanpa harus datang langsung ke lokasi."

$doc += H2 "1.3 Tujuan Pengembangan Sistem"
$doc += P "Tujuan utama dari pengembangan sistem GO PLAY adalah:"
$doc += P "1. Membangun sistem informasi berbasis web yang mampu mengelola reservasi rental PlayStation secara digital dan terintegrasikan."
$doc += P "2. Menyediakan fitur Booking Online bagi Member (pelanggan terdaftar) untuk melakukan pemesanan jadwal bermain secara mandiri dari mana saja."
$doc += P "3. Mengimplementasikan fitur Monitoring Status Unit dengan Timer Otomatis untuk membantu Admin memantau durasi bermain pelanggan secara real-time."
$doc += P "4. Menyediakan fitur Kelola Inventaris bagi Admin untuk mendokumentasikan kondisi dan ketersediaan setiap unit konsol PS4/PS5."
$doc += P "5. Menyajikan Dashboard Laporan Pendapatan yang akurat dan dapat difilter berdasarkan periode kepada Pemilik usaha."

$doc += H2 "1.4 Ruang Lingkup Proyek"
$doc += P "Pengembangan sistem GO PLAY mencakup ruang lingkup sebagai berikut:"
$doc += P "1. Sistem berbasis web yang dapat diakses melalui browser pada perangkat desktop maupun laptop."
$doc += P "2. Tiga jenis pengguna (User Role): Member (pelanggan terdaftar), Admin (pengelola rental), dan Pemilik (owner)."
$doc += P "3. Fitur utama yang dikembangkan: Login/Logout multi-peran, Registrasi Member, Booking Online, Kelola Reservasi (termasuk Walk-in), Monitoring Status Unit + Timer, Kelola Inventaris, dan Laporan Pendapatan."
$doc += P "4. Database yang digunakan: SQLite (pengembangan lokal)."
$doc += P "5. Framework yang digunakan: Laravel 12 (PHP 8.2) sebagai backend, dan Vite + Blade sebagai frontend."
$doc += P "6. Sistem ini TIDAK mencakup: integrasi payment gateway, fitur chat real-time, dan aplikasi mobile (Android/iOS)."

$doc += H2 "1.5 Manfaat yang Diharapkan"
$doc += P "Manfaat yang diharapkan dari pengembangan sistem ini adalah:"
$doc += P "Bagi Admin: Mempermudah dan mempercepat proses pengelolaan reservasi, baik online maupun walk-in, serta memantau durasi bermain pelanggan tanpa pengawasan manual yang intensif."
$doc += P "Bagi Member (Pelanggan): Memberikan kemudahan dalam melakukan pemesanan jadwal bermain secara mandiri melalui aplikasi web kapan saja dan di mana saja."
$doc += P "Bagi Pemilik: Memberikan visibilitas terhadap kinerja bisnis melalui laporan pendapatan yang otomatis, akurat, dan dapat diakses kapan saja."
$doc += P "Bagi Pengembang: Sebagai sarana untuk mengimplementasikan dan menerapkan ilmu rekayasa perangkat lunak, khususnya dalam pengembangan sistem informasi berbasis web menggunakan framework modern."

$doc += PageBreak

# ================================================================
# BAB II TINJAUAN SINGKAT
# ================================================================
$doc += H1 "BAB II`nTINJAUAN SINGKAT DAN LANDASAN KONSEPTUAL"

$doc += H2 "2.1 Gambaran Singkat Organisasi atau Objek Studi Kasus"
$doc += P "GO PLAY merupakan sebuah usaha mikro yang bergerak di bidang penyewaan unit PlayStation (PS4 dan PS5). Usaha ini melayani pelanggan yang ingin bermain game konsol secara sewa per jam, baik secara walk-in (datang langsung) maupun melalui sistem reservasi online. Berikut adalah gambaran singkat mengenai objek studi kasus:"
$doc += Bold "Nama Usaha  : GO PLAY - Rental PlayStation"
$doc += Bold "Bidang Usaha : Penyewaan Unit Game Console (PlayStation)"
$doc += Bold "Layanan  : Sewa PS4/PS5 per jam, Booking Online, Walk-in"
$doc += Bold "Target Pasar : Pelajar, Mahasiswa, dan Masyarakat Umum"
$doc += EmptyLine
$doc += P "Visi: Menjadi penyedia layanan rental PlayStation terbaik yang modern, efisien, dan mudah diakses oleh seluruh kalangan masyarakat."
$doc += P "Misi: (1) Memberikan pengalaman bermain yang nyaman dan menyenangkan; (2) Mengelola reservasi secara digital untuk meminimalisir antrian dan bentrok jadwal; (3) Menjaga kualitas dan kondisi setiap unit konsol melalui pengelolaan inventaris yang terstruktur."

$doc += H2 "2.2 Konsep Sistem Informasi yang Relevan"
$doc += P "Berikut adalah beberapa konsep sistem informasi yang menjadi landasan teori dalam pengembangan sistem GO PLAY:"
$doc += Bold "a. Sistem Informasi Manajemen (SIM)"
$doc += P "Sistem Informasi Manajemen adalah suatu sistem yang mengumpulkan, memproses, menyimpan, dan menyajikan informasi untuk mendukung proses pengambilan keputusan manajemen. Dalam konteks GO PLAY, SIM diterapkan pada fitur Dashboard Laporan Pendapatan yang membantu Pemilik dalam memantau kinerja bisnisnya."
$doc += Bold "b. Sistem Reservasi"
$doc += P "Sistem reservasi adalah sistem yang memungkinkan pelanggan untuk memesan atau mengalokasikan sumber daya (dalam hal ini: unit PS) pada waktu tertentu di masa depan. Sistem ini mencegah terjadinya konflik jadwal melalui pengecekan ketersediaan secara otomatis."
$doc += Bold "c. Sistem Monitoring Real-Time"
$doc += P "Sistem monitoring real-time memungkinkan pemantauan terhadap kondisi atau status suatu objek secara langsung dan terus-menerus. Dalam GO PLAY, konsep ini diterapkan pada fitur Timer Otomatis yang memantau sisa waktu bermain setiap pelanggan."

$doc += H2 "2.3 Teknologi, Framework, dan Metodologi yang Digunakan"
$doc += Bold "a. Laravel 12 (PHP 8.2)"
$doc += P "Laravel adalah framework PHP open-source yang mengikuti pola arsitektur MVC (Model-View-Controller). Laravel 12 digunakan sebagai backbone backend sistem GO PLAY, menangani routing, autentikasi multi-guard, manajemen database melalui Eloquent ORM, dan logika bisnis aplikasi."
$doc += Bold "b. Vite + Blade Template Engine"
$doc += P "Vite digunakan sebagai build tool frontend yang menggantikan Laravel Mix, memberikan Hot Module Replacement (HMR) yang cepat selama pengembangan. Blade Template Engine adalah mesin template bawaan Laravel yang digunakan untuk membangun tampilan (view) antarmuka pengguna."
$doc += Bold "c. SQLite"
$doc += P "SQLite adalah sistem manajemen database relasional berbasis file yang ringan dan tidak memerlukan server terpisah. SQLite digunakan sebagai database utama dalam pengembangan dan pengujian lokal sistem GO PLAY."
$doc += Bold "d. Arsitektur MVC (Model-View-Controller)"
$doc += P "MVC adalah pola arsitektur perangkat lunak yang memisahkan aplikasi menjadi tiga komponen utama: Model (pengelolaan data), View (tampilan antarmuka), dan Controller (logika bisnis). Pemisahan ini meningkatkan keterbacaan kode dan kemudahan pemeliharaan sistem."
$doc += Bold "e. Metodologi Pengembangan"
$doc += P "Pengembangan sistem GO PLAY menggunakan pendekatan metodologi Waterfall yang terstruktur, meliputi tahapan: Analisis Kebutuhan, Perancangan Sistem, Implementasi (Coding), Pengujian, dan Pemeliharaan."

$doc += PageBreak

# ================================================================
# BAB III ANALISIS SISTEM
# ================================================================
$doc += H1 "BAB III`nANALISIS SISTEM"

$doc += H2 "3.1 Analisis Proses Bisnis atau Sistem Berjalan (BPMN)"
$doc += P "Analisis proses bisnis dilakukan terhadap sistem yang diusulkan (To-Be Process). Proses ini digambarkan menggunakan notasi BPMN (Business Process Model and Notation) yang membagi aktivitas berdasarkan pool dan lane aktor."

$doc += H3 "3.1.1 Inisiasi Proses (Dua Jalur Utama)"
$doc += P "Diagram ini menunjukkan bahwa proses dapat dimulai dari dua titik berbeda tergantung pada cara pelanggan datang:"
$doc += P "Jalur Online (Member): Proses dimulai ketika Member melakukan F-01: Login Member. Setelah login, Member masuk ke fitur F-04: Input Booking untuk memilih jadwal bermain dan unit PS yang diinginkan."
$doc += P "Jalur Offline (Walk-in): Pelanggan datang langsung ke lokasi (tanpa aplikasi). Admin menerima kedatangan tersebut dan langsung memprosesnya melalui jalur Input Langsung."
$doc += PH "[TEMPEL GAMBAR 3.1 - DIAGRAM BPMN PROSES BISNIS GO PLAY DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.1 BPMN Proses Bisnis Sistem GO PLAY</w:t></w:r></w:p>"

$doc += H3 "3.1.2 Tahap Validasi dan Pengecekan"
$doc += P "Pada tahap ini, sistem dan Admin bekerja untuk memastikan ketersediaan:"
$doc += P "Validasi Otomatis (Sistem): Untuk pesanan online, Sistem secara otomatis menjalankan fungsi Mengecek Ketersediaan Jadwal. Jika Penuh (TIDAK): Alur akan dikembalikan ke Member pada fitur F-04 untuk memilih jadwal atau unit lain. Jika Tersedia (YA): Pesanan diteruskan ke Admin dan masuk ke dalam antrean reservasi."
$doc += P "Validasi Manual (Admin): Untuk jalur offline, Admin langsung menuju fitur F-05 untuk mengecek ketersediaan unit secara manual di tempat."

$doc += H3 "3.1.3 Tahap Pengelolaan Reservasi dan Persiapan (Admin)"
$doc += P "Setelah jadwal dipastikan tersedia, Admin mengambil alih kendali penuh:"
$doc += P "F-05: Kelola Reservasi: Admin mengonfirmasi booking online yang masuk atau melakukan input manual untuk pelanggan offline."
$doc += P "F-03: Kelola Inventaris: Sebelum permainan dimulai, Admin melakukan pengecekan fisik pada perangkat (konsol PS dan controller) untuk memastikan semuanya dalam kondisi baik dan layak pakai."

$doc += H3 "3.1.4 Tahap Operasional dan Monitoring"
$doc += P "F-06: Aktifkan Timer & Monitoring: Setelah perangkat siap dan pelanggan mulai bermain, Admin mengaktifkan fitur timer. Fitur ini berfungsi untuk memantau durasi bermain dan memberikan notifikasi sisa waktu secara otomatis."

$doc += H3 "3.1.5 Tahap Pelaporan (Output Akhir)"
$doc += P "F-07: Laporan Pendapatan: Setelah sesi bermain selesai dan transaksi ditutup, data tersebut secara otomatis mengalir ke lajur Pemilik dalam bentuk laporan pendapatan. Ini memudahkan Pemilik untuk memantau rekapitulasi keuangan berdasarkan transaksi yang sudah selesai."

$doc += H2 "3.2 Analisis Dokumen"
$doc += P "Analisis dokumen bertujuan untuk mengidentifikasi variabel data yang ada pada sistem manual lama untuk kemudian divalidasi ke dalam skema database sistem baru."
$doc += EmptyLine
$doc += P "Tabel 3.1 Analisis Transformasi Dokumen Manual ke Digital"
$doc += PH "[TEMPEL TABEL ANALISIS DOKUMEN (Buku Member, Logbook Inventaris, Buku Kasir, Laporan Bulanan) DI SINI - Dapat dilihat pada dokumen KEL8_REV (GO PLAY).docx]"

$doc += H2 "3.3 Analisis Kebutuhan Informasi dan Pengguna (SRS)"

$doc += H3 "3.3.1 Kebutuhan Fungsional"
$doc += P "Tabel 3.2 Spesifikasi Kebutuhan Fungsional"
$doc += PH "[TEMPEL TABEL KEBUTUHAN FUNGSIONAL (F-01 s/d F-07) DARI FILE Dokumen SRS_Daftar Kebutuhan_Sistem GOPLAY.pdf DI SINI]"
$doc += EmptyLine
$doc += P "Berikut ringkasan kebutuhan fungsional sistem GO PLAY:"
$doc += P "F-01 - Login: Memvalidasi kredensial pengguna untuk masuk ke dalam sistem sesuai hak akses. Aktor: Admin, Pemilik, Member. Prioritas: Tinggi."
$doc += P "F-02 - Log Out: Mengakhiri sesi pengguna pada sistem secara aman. Aktor: Admin, Pemilik, Member. Prioritas: Tinggi."
$doc += P "F-03 - Kelola Inventaris: Mengelola data unit (PS4/PS5) dan memantau kelayakan perangkat/controller. Aktor: Admin. Prioritas: Sedang."
$doc += P "F-04 - Booking Online: Melakukan pemesanan jadwal dan unit secara mandiri melalui aplikasi. Aktor: Member. Prioritas: Tinggi."
$doc += P "F-05 - Kelola Reservasi: Memvalidasi ketersediaan unit, mengonfirmasi, atau mengubah data reservasi masuk. Aktor: Admin. Prioritas: Tinggi."
$doc += P "F-06 - Monitoring Status Unit: Memantau status unit (Kosong/Isi), menjalankan timer otomatis, dan notifikasi sisa waktu. Aktor: Admin, Member. Prioritas: Tinggi."
$doc += P "F-07 - Laporan Pendapatan: Menyusun dan menampilkan rekapitulasi keuangan berdasarkan transaksi yang selesai. Aktor: Admin, Pemilik. Prioritas: Sedang."

$doc += H3 "3.3.2 Kebutuhan Non-Fungsional"
$doc += P "Tabel 3.3 Spesifikasi Kebutuhan Non-Fungsional"
$doc += PH "[TEMPEL TABEL KEBUTUHAN NON-FUNGSIONAL (NF-01 s/d NF-06) DARI FILE Dokumen SRS DI SINI]"
$doc += EmptyLine
$doc += P "NF-01 - Keamanan (Security): Melindungi kerahasiaan data profil pengguna, password (enkripsi), dan validasi sesi login. Prioritas: Tinggi."
$doc += P "NF-02 - Ketersediaan (Availability): Sistem harus dapat diakses 24/7 agar Member dapat melakukan Booking Online kapan saja. Prioritas: Tinggi."
$doc += P "NF-03 - Akurasi Perhitungan: Menjamin ketepatan perhitungan billing otomatis berdasarkan durasi main dan tarif unit secara real-time. Prioritas: Tinggi."
$doc += P "NF-04 - Kemudahan Penggunaan (Usability): Antarmuka harus responsif dan intuitif. Prioritas: Sedang."
$doc += P "NF-05 - Integritas Data (Backup): Melakukan pencadangan database secara berkala. Prioritas: Sedang."
$doc += P "NF-06 - Performa (Performance): Waktu respon sistem saat memvalidasi ketersediaan unit tidak boleh lebih dari 3 detik. Prioritas: Sedang."

$doc += H2 "3.4 Pemodelan Sistem (UML)"

$doc += H3 "3.4.1 Use Case Diagram dan Skenario Use Case"
$doc += PH "[TEMPEL GAMBAR 3.2 - USE CASE DIAGRAM DARI FILE DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.2 Use Case Diagram Sistem GO PLAY</w:t></w:r></w:p>"
$doc += EmptyLine
$doc += Bold "Skenario Use Case 1: Login"
$doc += P "Aktor: Admin, Member, Pemilik"
$doc += P "Deskripsi: Proses masuk ke sistem menggunakan akun yang terdaftar."
$doc += P "Skenario Utama: (1) Aktor membuka aplikasi/web. (2) Sistem menampilkan formulir login. (3) Aktor memasukkan kredensial dan menekan tombol login. (4) Sistem memvalidasi data ke database. (5) Sistem mengarahkan aktor ke dashboard sesuai hak akses masing-masing."
$doc += EmptyLine
$doc += Bold "Skenario Use Case 2: Booking Online"
$doc += P "Aktor: Member"
$doc += P "Deskripsi: Melakukan reservasi jadwal main secara mandiri."
$doc += P "Skenario Utama: (1) Member masuk ke menu Booking Online. (2) Member memilih jenis unit (PS4/PS5) dan jadwal. (3) Sistem mengecek ketersediaan unit secara otomatis. (4) Member mengonfirmasi pemesanan. (5) Sistem menerbitkan kode reservasi."
$doc += EmptyLine
$doc += Bold "Skenario Use Case 3: Kelola Reservasi"
$doc += P "Aktor: Admin"
$doc += P "Deskripsi: Mengelola dan memproses data booking yang masuk dari member maupun walk-in."
$doc += P "Skenario Utama: (1) Admin masuk ke menu Kelola Reservasi. (2) Sistem menampilkan daftar pesanan masuk. (3) Admin melakukan verifikasi/validasi data booking. (4) Admin mengubah status reservasi (Konfirmasi/Dibatalkan/Selesai). (5) Sistem memperbarui status jadwal."
$doc += EmptyLine
$doc += Bold "Skenario Use Case 4: Monitoring Status Unit"
$doc += P "Aktor: Admin, Member"
$doc += P "Deskripsi: Memantau sisa waktu bermain dan status penggunaan unit secara real-time."
$doc += P "Skenario Utama: (1) Aktor membuka dashboard monitoring. (2) Sistem menampilkan status unit (Kosong/Terisi/Dipesan). (3) Sistem menjalankan timer otomatis. (4) Sistem memberikan notifikasi jika waktu hampir habis. (5) Admin dapat menghentikan atau menambah durasi billing."
$doc += EmptyLine
$doc += Bold "Skenario Use Case 5: Laporan Pendapatan"
$doc += P "Aktor: Admin, Pemilik"
$doc += P "Deskripsi: Melihat hasil rekapitulasi keuangan dari transaksi sewa."
$doc += P "Skenario Utama: (1) Aktor masuk ke menu Laporan Pendapatan. (2) Aktor menentukan filter periode (Harian/Bulanan). (3) Sistem menarik data transaksi berstatus Selesai. (4) Sistem menampilkan total pendapatan dan detail transaksi. (5) Aktor dapat mengunduh atau mencetak laporan."

$doc += H3 "3.4.2 Activity Diagram"
$doc += PH "[TEMPEL GAMBAR 3.3 - ACTIVITY DIAGRAM LOGIN DARI DOKUMEN UML DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.3 Activity Diagram - Login</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 3.4 - ACTIVITY DIAGRAM BOOKING ONLINE DARI DOKUMEN UML DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.4 Activity Diagram - Booking Online</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 3.5 - ACTIVITY DIAGRAM KELOLA RESERVASI DARI DOKUMEN UML DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.5 Activity Diagram - Kelola Reservasi</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 3.6 - ACTIVITY DIAGRAM MONITORING UNIT DARI DOKUMEN UML DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.6 Activity Diagram - Monitoring Status Unit</w:t></w:r></w:p>"

$doc += H3 "3.4.3 Robustness Diagram"
$doc += PH "[TEMPEL GAMBAR 3.9 - ROBUSTNESS DIAGRAM DARI DOKUMEN UML DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.9 Robustness Diagram Sistem GO PLAY</w:t></w:r></w:p>"

$doc += H3 "3.4.4 Class Diagram"
$doc += PH "[TEMPEL GAMBAR 3.10 - CLASS DIAGRAM DARI DOKUMEN UML DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.10 Class Diagram Sistem GO PLAY</w:t></w:r></w:p>"

$doc += H3 "3.4.5 Sequence Diagram"
$doc += PH "[TEMPEL GAMBAR 3.11 - SEQUENCE DIAGRAM LOGIN DARI DOKUMEN UML DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.11 Sequence Diagram - Login</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 3.12 - SEQUENCE DIAGRAM BOOKING ONLINE DARI DOKUMEN UML DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.12 Sequence Diagram - Booking Online</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 3.13 - SEQUENCE DIAGRAM KELOLA RESERVASI DARI DOKUMEN UML DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.13 Sequence Diagram - Kelola Reservasi</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 3.14 - SEQUENCE DIAGRAM MONITORING UNIT DARI DOKUMEN UML DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 3.14 Sequence Diagram - Monitoring Status Unit</w:t></w:r></w:p>"

$doc += PageBreak

# ================================================================
# BAB IV PERANCANGAN SISTEM
# ================================================================
$doc += H1 "BAB IV`nPERANCANGAN SISTEM"

$doc += H2 "4.1 Perancangan Arsitektur Sistem"
$doc += P "Sistem GO PLAY dirancang menggunakan pola arsitektur MVC (Model-View-Controller) yang diimplementasikan melalui framework Laravel 12. Berikut adalah penjelasan masing-masing komponen:"
$doc += P "Model: Bertanggung jawab atas pengelolaan data dan interaksi dengan database SQLite. Model utama yang digunakan meliputi: User, Admin, Console (unit PS), Booking (reservasi), dan Transaction."
$doc += P "View: Bertanggung jawab atas tampilan antarmuka pengguna yang dibangun menggunakan Blade Template Engine Laravel dan dikompilasi menggunakan Vite. Setiap peran pengguna (Member, Admin, Pemilik) memiliki tampilan dan navigasi yang berbeda-beda."
$doc += P "Controller: Bertanggung jawab atas logika bisnis aplikasi, memproses request dari pengguna, berinteraksi dengan Model, dan mengembalikan respons ke View. Controller dipisahkan berdasarkan peran: Auth, Member, Admin, dan Owner controller."
$doc += PH "[TEMPEL GAMBAR 4.1 - DIAGRAM ARSITEKTUR SISTEM MVC GO PLAY DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 4.1 Arsitektur Sistem GO PLAY (MVC)</w:t></w:r></w:p>"

$doc += H2 "4.2 Desain Basis Data"
$doc += P "Basis data sistem GO PLAY dirancang menggunakan SQLite dengan pendekatan relasional. Entitas utama yang terlibat adalah sebagai berikut:"
$doc += EmptyLine
$doc += Bold "Tabel users: Menyimpan data akun pelanggan (Member)."
$doc += P "Kolom: id, name, email, password, phone, email_verified_at, remember_token, timestamps."
$doc += EmptyLine
$doc += Bold "Tabel admins: Menyimpan data akun Admin."
$doc += P "Kolom: id, name, email, password, remember_token, timestamps."
$doc += EmptyLine
$doc += Bold "Tabel consoles: Menyimpan data unit konsol PS4/PS5."
$doc += P "Kolom: id, name, type (PS4/PS5), status (available/occupied/maintenance), price_per_hour, description, timestamps."
$doc += EmptyLine
$doc += Bold "Tabel bookings: Menyimpan data reservasi."
$doc += P "Kolom: id, booking_code, user_id, console_id, booking_date, start_time, end_time, duration, total_price, status (pending/confirmed/completed/cancelled), payment_status, timestamps."
$doc += EmptyLine
$doc += Bold "Tabel transactions: Menyimpan data transaksi yang telah selesai."
$doc += P "Kolom: id, booking_id, amount, payment_method, paid_at, timestamps."
$doc += EmptyLine
$doc += PH "[TEMPEL GAMBAR 4.2 - ENTITY RELATIONSHIP DIAGRAM (ERD) DARI DOKUMEN UML DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 4.2 Entity Relationship Diagram (ERD)</w:t></w:r></w:p>"

$doc += H2 "4.3 Desain Antarmuka Pengguna (UI)"
$doc += P "Desain antarmuka pengguna sistem GO PLAY dirancang dengan memperhatikan prinsip kemudahan penggunaan (usability) dan estetika visual yang modern. Desain awal (wireframe) dibuat menggunakan Figma sebelum diimplementasikan ke dalam kode."
$doc += P "Link Figma: https://www.figma.com/site/S3ShQKDKt7BylYmXNlHTX7/GOPLAY"
$doc += PH "[TEMPEL GAMBAR 4.3 - WIREFRAME HALAMAN UTAMA DARI LAPORAN WIREFRAME UI/UX DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 4.3 Wireframe Halaman Utama</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 4.4 - WIREFRAME HALAMAN LOGIN DARI LAPORAN WIREFRAME DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 4.4 Wireframe Halaman Login</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 4.5 - WIREFRAME HALAMAN BOOKING DARI LAPORAN WIREFRAME DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 4.5 Wireframe Halaman Booking</w:t></w:r></w:p>"

$doc += PageBreak

# ================================================================
# BAB V IMPLEMENTASI DAN PENGUJIAN
# ================================================================
$doc += H1 "BAB V`nIMPLEMENTASI DAN PENGUJIAN"

$doc += H2 "5.1 Implementasi Database"
$doc += P "Database sistem GO PLAY diimplementasikan menggunakan SQLite. Struktur tabel dibuat menggunakan fitur Migrations milik Laravel, sehingga memudahkan proses pembuatan ulang dan pengelolaan versi database."
$doc += P "Perintah untuk menjalankan migrasi database:"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"Normal`"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii=`"Lucida Console`" w:hAnsi=`"Lucida Console`"/><w:sz w:val=`"20`"/></w:rPr><w:t xml:space=`"preserve`">php artisan migrate --seed</w:t></w:r></w:p>"
$doc += P "Seeder (data awal) yang disediakan meliputi: data Admin default, data konsol PS4/PS5 (5 unit), dan data Member contoh untuk keperluan pengujian."

$doc += H2 "5.2 Implementasi Antarmuka"
$doc += P "Berikut adalah implementasi antarmuka pengguna sistem GO PLAY yang telah berhasil dibangun:"

$doc += H3 "5.2.1 Halaman Utama dan Login"
$doc += PH "[TEMPEL GAMBAR 5.1 - SCREENSHOT HALAMAN UTAMA DARI USER GUIDE DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 5.1 Screenshot Halaman Utama GO PLAY</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 5.2 - SCREENSHOT HALAMAN LOGIN DARI USER GUIDE DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 5.2 Screenshot Halaman Login</w:t></w:r></w:p>"

$doc += H3 "5.2.2 Dashboard dan Fitur Member"
$doc += PH "[TEMPEL GAMBAR 5.3 - SCREENSHOT DASHBOARD MEMBER DARI USER GUIDE DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 5.3 Screenshot Dashboard Member</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 5.4 - SCREENSHOT HALAMAN BOOKING ONLINE DARI USER GUIDE DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 5.4 Screenshot Halaman Booking Online</w:t></w:r></w:p>"

$doc += H3 "5.2.3 Dashboard dan Fitur Admin"
$doc += PH "[TEMPEL GAMBAR 5.5 - SCREENSHOT DASHBOARD ADMIN DARI USER GUIDE DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 5.5 Screenshot Dashboard Admin</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 5.6 - SCREENSHOT HALAMAN MONITORING TIMER DARI USER GUIDE DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 5.6 Screenshot Monitoring Timer Unit</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 5.7 - SCREENSHOT KELOLA RESERVASI DARI USER GUIDE DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 5.7 Screenshot Kelola Reservasi Admin</w:t></w:r></w:p>"
$doc += PH "[TEMPEL GAMBAR 5.8 - SCREENSHOT LAPORAN PENDAPATAN DARI USER GUIDE DI SINI]"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"CenterNormal`"/></w:pPr><w:r><w:t>Gambar 5.8 Screenshot Laporan Pendapatan</w:t></w:r></w:p>"

$doc += H2 "5.3 Struktur Program dan Pengelolaan Source Code"
$doc += P "Source code sistem GO PLAY dikelola menggunakan sistem kontrol versi Git dan dipublikasikan pada repositori GitHub berikut:"
$doc += P "Repository: https://github.com/adamme26/Sistem-Informasi-Manajemen-dan-Reservasi-Rental-PlayStation-GO-PLAY-Berbasis-Web"
$doc += EmptyLine
$doc += P "Struktur direktori utama sistem GO PLAY adalah sebagai berikut:"
$doc += "<w:p><w:pPr><w:pStyle w:val=`"Normal`"/></w:pPr><w:r><w:rPr><w:rFonts w:ascii=`"Lucida Console`" w:hAnsi=`"Lucida Console`"/><w:sz w:val=`"20`"/></w:rPr><w:t xml:space=`"preserve`">GoPlay_SourceCode/ | app/ | Http/Controllers/ | Admin/ (BookingAdminController) | Member/ (BookingController) | Auth/ (LoginController) | Models/ (User, Admin, Console, Booking) | database/ | migrations/ | database.sqlite | resources/views/ | routes/web.php | public/ | vite.config.js</w:t></w:r></w:p>"

$doc += H2 "5.4 Pengujian Menggunakan Tools"
$doc += P "Pengujian sistem GO PLAY dilakukan menggunakan beberapa pendekatan:"
$doc += Bold "a. Pengujian Manual (Black Box Testing)"
$doc += P "Pengujian dilakukan secara manual dengan cara menjalankan aplikasi dan mencoba setiap fitur satu per satu untuk memastikan output yang dihasilkan sesuai dengan yang diharapkan berdasarkan spesifikasi kebutuhan."
$doc += Bold "b. Pengujian Error Handling"
$doc += P "Diuji dengan cara memasukkan data yang tidak valid, seperti: input durasi bukan angka (yang menyebabkan error Carbon::addHours TypeError dan telah diperbaiki dengan casting integer), pemesanan pada unit yang sudah terisi, dan login dengan kredensial yang salah."
$doc += EmptyLine
$doc += PH "[TEMPEL TABEL/SCREENSHOT HASIL PENGUJIAN DARI DOKUMENTASI PENGUJIAN TOOLS DI SINI]"

$doc += H2 "5.5 User Acceptance Testing (UAT)"
$doc += P "User Acceptance Testing (UAT) dilakukan dengan melibatkan pengguna nyata untuk memastikan bahwa sistem yang dikembangkan telah memenuhi kebutuhan dan ekspektasi pengguna akhir."
$doc += PH "[TEMPEL TABEL HASIL UAT DAN FORMULIR PENERIMAAN PENGGUNA DI SINI]"

$doc += PageBreak

# ================================================================
# BAB VI PENUTUP
# ================================================================
$doc += H1 "BAB VI`nPENUTUP"

$doc += H2 "6.1 Kesimpulan"
$doc += P "Berdasarkan hasil analisis, perancangan, implementasi, dan pengujian yang telah dilakukan, dapat ditarik kesimpulan sebagai berikut:"
$doc += P "1. Sistem Informasi Manajemen dan Reservasi Rental PlayStation (GO PLAY) telah berhasil dikembangkan menggunakan framework Laravel 12 (PHP 8.2) dengan arsitektur MVC dan database SQLite."
$doc += P "2. Sistem berhasil mengimplementasikan tujuh fitur fungsional utama: Login multi-peran, Booking Online, Kelola Reservasi (termasuk Walk-in), Monitoring Status Unit dengan Timer Otomatis, Kelola Inventaris, Laporan Pendapatan, dan Logout."
$doc += P "3. Fitur Booking Online berhasil mencegah terjadinya double booking melalui mekanisme pengecekan ketersediaan jadwal secara otomatis sebelum reservasi dikonfirmasi."
$doc += P "4. Fitur Timer Otomatis pada dashboard Admin berhasil memantau durasi bermain pelanggan secara real-time dan memberikan notifikasi saat waktu hampir habis, sehingga mengurangi beban kerja Admin secara signifikan."
$doc += P "5. Dashboard Laporan Pendapatan berhasil menyajikan rekapitulasi keuangan yang akurat dan dapat difilter berdasarkan periode kepada Pemilik usaha."
$doc += P "6. Sistem telah diuji melalui pengujian fungsional (black-box) dan UAT, dengan hasil yang menunjukkan bahwa seluruh fitur berjalan sesuai dengan spesifikasi kebutuhan yang telah ditetapkan."

$doc += H2 "6.2 Saran"
$doc += P "Untuk pengembangan sistem GO PLAY ke depannya, beberapa saran yang dapat dipertimbangkan adalah sebagai berikut:"
$doc += P "1. Integrasi Payment Gateway: Menambahkan fitur pembayaran digital (seperti Midtrans, QRIS, atau transfer bank otomatis) agar transaksi dapat diselesaikan secara online tanpa harus membayar di tempat."
$doc += P "2. Notifikasi WhatsApp/Email: Mengintegrasikan notifikasi otomatis via WhatsApp API atau email untuk memberikan konfirmasi booking dan pengingat jadwal kepada Member secara langsung."
$doc += P "3. Pengembangan Aplikasi Mobile: Membangun versi aplikasi mobile (Android/iOS) agar Member dapat melakukan booking dan memantau status pesanan melalui smartphone dengan lebih mudah."
$doc += P "4. Deployment ke Server Hosting: Mengoptimalkan sistem untuk dapat di-deploy ke server hosting berbasis Linux dengan database MySQL/MariaDB agar sistem dapat diakses secara publik 24/7."
$doc += P "5. Fitur Review dan Rating: Menambahkan fitur ulasan dan penilaian dari pelanggan terhadap layanan, untuk membantu Pemilik mengevaluasi kualitas layanan secara berkelanjutan."

$doc += PageBreak

# ================================================================
# DAFTAR PUSTAKA
# ================================================================
$doc += H1 "DAFTAR PUSTAKA"
$doc += P "[1] O`t Brien, J. A., & Marakas, G. M. (2011). Management Information Systems (10th ed.). McGraw-Hill."
$doc += P "[2] Pressman, R. S., & Maxim, B. R. (2015). Software Engineering: A Practitioner`'s Approach (8th ed.). McGraw-Hill Education."
$doc += P "[3] Laravel. (2024). Laravel 12.x Documentation. https://laravel.com/docs/12.x"
$doc += P "[4] Sommerville, I. (2016). Software Engineering (10th ed.). Pearson Education."
$doc += P "[5] Fowler, M. (2002). Patterns of Enterprise Application Architecture. Addison-Wesley Professional."
$doc += P "[6] SQLite Consortium. (2024). SQLite Documentation. https://www.sqlite.org/docs.html"
$doc += P "[7] Object Management Group. (2017). Unified Modeling Language (UML) Specification Version 2.5.1. https://www.omg.org/spec/UML/"
$doc += P "[8] Object Management Group. (2013). Business Process Model and Notation (BPMN) Version 2.0.2. https://www.omg.org/spec/BPMN/"
$doc += P "[9] Nielsen, J. (1994). Usability Engineering. Morgan Kaufmann Publishers."
$doc += P "[10] Connolly, T. M., & Begg, C. E. (2014). Database Systems: A Practical Approach to Design, Implementation, and Management (6th ed.). Pearson Education."

$doc += PageBreak

# ================================================================
# LAMPIRAN
# ================================================================
$doc += H1 "LAMPIRAN"

$doc += H2 "Lampiran 1 - Profile Tim Proyek"
$doc += PH "[TEMPEL SELURUH ISI DOKUMEN Lampiran Profile Tim Proyek Go Play.docx DI SINI]"

$doc += H2 "Lampiran 2 - Dokumen Project Charter"
$doc += PH "[TEMPEL SELURUH ISI/SCAN DOKUMEN Lampiran Project Charter GO PLAY .pdf DI SINI]"

$doc += H2 "Lampiran 3 - WBS dan Timeline"
$doc += PH "[TEMPEL SELURUH ISI/GAMBAR DOKUMEN Lampiran Dokumen WBS dan Timeline Proyek GO PLAY.pdf DI SINI]"

$doc += H2 "Lampiran 4 - Dokumen SRS / Daftar Kebutuhan"
$doc += PH "[TEMPEL SELURUH ISI/SCAN DOKUMEN Dokumen SRS_Daftar Kebutuhan_Sistem GOPLAY.pdf DI SINI]"

$doc += H2 "Lampiran 5 - Dokumen UML"
$doc += PH "[TEMPEL SELURUH GAMBAR DIAGRAM UML DARI DOKUMEN DOKUMEN_UML_GO_PLAY_Kelompok8.pdf DI SINI]"

$doc += H2 "Lampiran 6 - Dokumen UI/UX (Wireframe)"
$doc += PH "[TEMPEL GAMBAR WIREFRAME DARI FILE LAPORAN WIREFRAME UIUX PROYEK PERANGKAT LUNAK.pdf DI SINI]"

$doc += H2 "Lampiran 7 - Dokumentasi Source Code"
$doc += P "Repository GitHub: https://github.com/adamme26/Sistem-Informasi-Manajemen-dan-Reservasi-Rental-PlayStation-GO-PLAY-Berbasis-Web"
$doc += PH "[TEMPEL SCREENSHOT REPOSITORI GITHUB DAN CUPLIKAN KODE PENTING DI SINI]"

$doc += H2 "Lampiran 8 - Dokumentasi Pengujian"
$doc += PH "[TEMPEL TABEL HASIL PENGUJIAN TOOLS DAN UAT DI SINI]"

$doc += H2 "Lampiran 9 - Dokumentasi Penggunaan Sistem (User Guide)"
$doc += PH "[TEMPEL SELURUH ISI DOKUMEN User_Guide_GoPlay.doc DI SINI]"

# ================================================================
# BUILD THE FINAL DOCUMENT XML
# ================================================================
$docXmlContent = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
<w:body>
<w:sectPr>
  <w:pgSz w:w="12240" w:h="15840"/>
  <w:pgMar w:top="1440" w:right="1080" w:bottom="1440" w:left="1800" w:header="720" w:footer="720" w:gutter="0"/>
</w:sectPr>
</w:body>
</w:document>'

# Insert paragraphs before </w:body>
$insertContent = $doc -join "`n"
$docXmlContent = $docXmlContent -replace '</w:body>', "$insertContent`n</w:body>"

# Write document.xml
$docEntry = $zip.CreateEntry('word/document.xml')
$sw = New-Object System.IO.StreamWriter($docEntry.Open(), [System.Text.Encoding]::UTF8)
$sw.Write($docXmlContent)
$sw.Flush(); $sw.Dispose()

# Finalize zip
$zip.Dispose()

# Write to file
$fileStream = [System.IO.File]::OpenWrite($outputPath)
$ms.WriteTo($fileStream)
$fileStream.Flush()
$fileStream.Dispose()
$ms.Dispose()

Write-Output "SUCCESS: File created at $outputPath"
$size = (Get-Item $outputPath).Length / 1KB
Write-Output "File size: $([math]::Round($size, 2)) KB"

