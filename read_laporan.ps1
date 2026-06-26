Add-Type -AssemblyName System.IO.Compression.FileSystem
$docPath = "C:\Users\noval mulyadi\Documents\SMT4\Proyek Perangkat Lunak\LAPORAN\Laporan Akhir PPL Kelompok8 GoPlay.docx"
$zip = [System.IO.Compression.ZipFile]::OpenRead($docPath)
$entry = $zip.Entries | Where-Object { $_.FullName -eq "word/document.xml" }
$stream = $entry.Open()
$reader = New-Object System.IO.StreamReader($stream)
$content = $reader.ReadToEnd()
$reader.Close()
$zip.Dispose()
$text = $content -replace "<[^>]+>", " "
$text = $text -replace "\s+", " "
$outPath = "C:\Users\noval mulyadi\Documents\laporan_text.txt"
$text | Out-File $outPath -Encoding UTF8
Write-Host "Done. Saved to $outPath"
