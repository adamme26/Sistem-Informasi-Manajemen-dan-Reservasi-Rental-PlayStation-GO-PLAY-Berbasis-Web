$repo = 'adamme26/Sistem-Informasi-Manajemen-dan-Reservasi-Rental-PlayStation-GO-PLAY-Berbasis-Web'
$headers = @{'User-Agent'='PowerShell'}

$commits = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/commits" -Headers $headers

if ($commits.Count -gt 0) {
    $tree = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/git/trees/$($commits[0].sha)?recursive=1" -Headers $headers
    
    # Check if database.sqlite is uploaded
    $hasDb = $tree.tree | Where-Object { $_.path -match 'database\.sqlite' }
    if ($hasDb) { Write-Host "FOUND: database.sqlite" } else { Write-Host "MISSING: database.sqlite" }
    
    # Check if .env is uploaded
    $hasEnv = $tree.tree | Where-Object { $_.path -eq '.env' }
    if ($hasEnv) { Write-Host "FOUND: .env" } else { Write-Host "MISSING: .env" }
    
    # Print some stats
    Write-Host "Total files/folders in repo: $($tree.tree.Count)"
}
