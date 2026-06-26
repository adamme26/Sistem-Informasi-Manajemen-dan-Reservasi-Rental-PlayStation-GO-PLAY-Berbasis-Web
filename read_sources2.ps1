Add-Type -AssemblyName System.IO.Compression.FileSystem

function Read-Docx($path) {
    $zip = [System.IO.Compression.ZipFile]::OpenRead($path)
    $docXml = $zip.Entries | Where-Object { $_.FullName -eq 'word/document.xml' }
    $stream = $docXml.Open()
    $reader = New-Object System.IO.StreamReader($stream)
    $xmlString = $reader.ReadToEnd()
    $reader.Close()
    $stream.Close()
    $zip.Dispose()

    $xml = [xml]$xmlString
    $nsmgr = New-Object System.Xml.XmlNamespaceManager($xml.NameTable)
    $nsmgr.AddNamespace("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")

    $nodes = $xml.SelectNodes("//w:t", $nsmgr)
    $text = ""
    foreach ($node in $nodes) {
        $text += $node.InnerText + " "
    }
    return $text
}

$basePath = 'C:\Users\noval mulyadi\Documents\SMT4\Proyek Perangkat Lunak\LAPORAN'

Write-Output "===== PROFILE TIM ====="
Read-Docx "$basePath\Lampiran  Profile Tim Proyek Go Play.docx"

Write-Output "`n===== KEL8 REV GO PLAY ====="
Read-Docx "$basePath\KEL8_REV ( GO PLAY ).docx"
