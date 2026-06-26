Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = 'C:\Users\noval mulyadi\Documents\SMT4\Proyek Perangkat Lunak\LAPORAN\KEL8_REV ( GO PLAY ).docx'
$zip = [System.IO.Compression.ZipFile]::OpenRead($docxPath)
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
Write-Output $text
