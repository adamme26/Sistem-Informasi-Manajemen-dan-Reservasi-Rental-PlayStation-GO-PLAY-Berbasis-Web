$mermaid = @"
%%{init: {'theme': 'default', 'themeCSS': 'body { background-color: white !important; }', 'themeVariables': { 'background': '#ffffff'}}}%%
erDiagram
    users {
        int id PK
        string name
        string email
        string password
        string role
        string phone
        datetime email_verified_at
        string remember_token
        datetime created_at
        datetime updated_at
    }

    consoles {
        int id PK
        string name
        string type
        string status
        int price_per_hour
        text description
        datetime created_at
        datetime updated_at
    }

    bookings {
        int id PK
        string booking_code
        int user_id FK
        int console_id FK
        date booking_date
        time start_time
        time end_time
        int duration
        int total_price
        string status
        string payment_status
        datetime created_at
        datetime updated_at
    }

    transactions {
        int id PK
        int booking_id FK
        int amount
        string payment_method
        datetime paid_at
        datetime created_at
        datetime updated_at
    }

    users ||--o{ bookings : "melakukan"
    consoles ||--o{ bookings : "dipesan dalam"
    bookings ||--o| transactions : "memiliki"
"@

$body = @{
    diagram_source = $mermaid
    diagram_type = "mermaid"
    output_format = "png"
} | ConvertTo-Json

$outputPath = "C:\Users\noval mulyadi\Documents\SMT4\Proyek Perangkat Lunak\LAPORAN\Diagram_ERD_GoPlay.png"
Invoke-RestMethod -Uri "https://kroki.io/" -Method Post -Body $body -ContentType "application/json" -OutFile $outputPath

Write-Output "File PNG ERD berhasil dibuat di: $outputPath"
