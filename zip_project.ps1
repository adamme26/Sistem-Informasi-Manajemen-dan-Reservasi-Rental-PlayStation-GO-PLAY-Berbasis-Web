$source = "C:\Users\noval mulyadi\.gemini\antigravity\scratch\goplay"
$destination = "C:\Users\noval mulyadi\Desktop\GoPlay_SourceCode.zip"

if (Test-Path $destination) {
    Remove-Item $destination -Force
}

$items = Get-ChildItem -Path $source -Exclude "vendor", "node_modules", ".git", ".env.example"
Compress-Archive -Path $items.FullName -DestinationPath $destination -Force

Write-Host "Zip created successfully!"
