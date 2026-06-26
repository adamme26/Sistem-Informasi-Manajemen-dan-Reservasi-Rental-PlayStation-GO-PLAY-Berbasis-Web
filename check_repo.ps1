$repo = 'adamme26/Sistem-Informasi-Manajemen-dan-Reservasi-Rental-PlayStation-GO-PLAY-Berbasis-Web'
$headers = @{'User-Agent'='PowerShell'}

$commits = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/commits" -Headers $headers
Write-Host "LATEST COMMITS:"
$commits | Select-Object -First 3 -Property @{N='Date';E={$_.commit.author.date}}, @{N='Message';E={$_.commit.message}} | Format-Table -AutoSize

if ($commits.Count -gt 0) {
    $tree = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/git/trees/$($commits[0].sha)" -Headers $headers
    Write-Host "`nROOT FILES/FOLDERS:"
    $tree.tree | Select-Object path, type | Format-Table -AutoSize
}
