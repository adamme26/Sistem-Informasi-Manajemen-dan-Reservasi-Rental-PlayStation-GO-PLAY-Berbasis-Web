$mermaid = @"
flowchart TD
    Owner(["Owner"])
    Member(["Member"])

    subgraph View ["VIEW (Frontend: Blade + Vite)"]
        direction TB
        V_Login["Halaman Login & Utama"]
        V_DashboardO["Dashboard Owner"]
        V_DashboardM["Dashboard Member"]
    end

    subgraph Controller ["CONTROLLER (Backend: Laravel 12)"]
        direction TB
        C_Route{"Routing / Web.php"}
        C_Auth["AuthController"]
        C_Booking["BookingController"]
        C_Console["ConsoleController"]
        C_Report["ReportController"]
    end

    subgraph Model ["MODEL (Database: SQLite)"]
        direction TB
        M_User[("User (Owner & Member)")]
        M_Console[("Console (PS4 & PS5)")]
        M_Booking[("Booking (Reservasi)")]
        M_Transaction[("Transaction (Pembayaran)")]
    end

    Owner -->|Interaksi| V_Login
    Owner -->|Mengelola| V_DashboardO
    Member -->|Interaksi| V_Login
    Member -->|Booking| V_DashboardM

    V_Login <-->|HTTP Request / Response| C_Route
    V_DashboardO <-->|HTTP Request / Response| C_Route
    V_DashboardM <-->|HTTP Request / Response| C_Route

    C_Route --> C_Auth
    C_Route --> C_Booking
    C_Route --> C_Console
    C_Route --> C_Report

    C_Auth <-->|Validasi & Sesi| M_User
    C_Booking <-->|Cek Jadwal & Simpan| M_Booking
    C_Booking <-->|Cek Status Unit| M_Console
    C_Console <-->|Kelola Unit| M_Console
    C_Report <-->|Tarik Data Selesai| M_Transaction
    C_Report <-->|Tarik Data Booking| M_Booking
"@

$body = @{
    diagram_source = $mermaid
    diagram_type = "mermaid"
    output_format = "png"
} | ConvertTo-Json

$outputPath = "C:\Users\noval mulyadi\Documents\SMT4\Proyek Perangkat Lunak\LAPORAN\Diagram_Arsitektur_MVC_GoPlay.png"
Invoke-RestMethod -Uri "https://kroki.io/" -Method Post -Body $body -ContentType "application/json" -OutFile $outputPath

Write-Output "File PNG berhasil dibuat di: $outputPath"
