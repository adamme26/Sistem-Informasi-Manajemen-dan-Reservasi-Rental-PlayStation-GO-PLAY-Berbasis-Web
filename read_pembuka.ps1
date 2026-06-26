Add-Type -AssemblyName System.IO.Compression.FileSystem
$folder = "C:\Users\noval mulyadi\Documents\SMT4\Proyek Perangkat Lunak"
$files = Get-ChildItem -Path $folder -Filter "*.docx"
foreach ($f in $files) {
    if ($f.Name -like "*Pembuka*") {
        Write-Host "Found: $($f.FullName)"
        $docPath = $f.FullName
        $zip = [System.IO.Compression.ZipFile]::OpenRead($docPath)
        $entry = $zip.Entries | Where-Object { $_.FullName -eq "word/document.xml" }
        $stream = $entry.Open()
        $reader = New-Object System.IO.StreamReader($stream)
        $content = $reader.ReadToEnd()
        $reader.Close()
        $zip.Dispose()
        $text = $content -replace "<[^>]+>", " "
        $text = $text -replace "\s+", " "
        $outPath = "C:\Users\noval mulyadi\Documents\pembuka_text.txt"
        $text | Out-File $outPath -Encoding UTF8
        Write-Host "Saved to $outPath"
    }
}
