Add-Type -AssemblyName System.IO.Compression.FileSystem

function Read-DocxFull($path) {
    $zip = [System.IO.Compression.ZipFile]::OpenRead($path)
    $docXml = $zip.Entries | Where-Object { $_.FullName -eq 'word/document.xml' }
    $stream = $docXml.Open()
    $reader = New-Object System.IO.StreamReader($stream)
    $xmlString = $reader.ReadToEnd()
    $reader.Close(); $stream.Close(); $zip.Dispose()
    
    $xml = [xml]$xmlString
    $nsmgr = New-Object System.Xml.XmlNamespaceManager($xml.NameTable)
    $nsmgr.AddNamespace("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
    
    $paragraphs = $xml.SelectNodes("//w:p", $nsmgr)
    $result = @()
    foreach ($para in $paragraphs) {
        $styleNode = $para.SelectSingleNode("w:pPr/w:pStyle/@w:val", $nsmgr)
        $style = if ($styleNode) { $styleNode.Value } else { "Normal" }
        $textNodes = $para.SelectNodes(".//w:t", $nsmgr)
        $text = ($textNodes | ForEach-Object { $_.InnerText }) -join ""
        if ($text.Trim() -ne "") {
            $result += "[${style}] $text"
        }
    }
    return $result -join "`n"
}

Write-Output "===== KEL8_REV CONTENT ====="
Read-DocxFull ".\kel8_copy.docx"
