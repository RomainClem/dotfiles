# Install winget packages from exported package list
$packagesFile = Join-Path $env:USERPROFILE ".local/share/chezmoi/winget-packages.json"

if (-not (Test-Path $packagesFile)) {
    Write-Host "[ERROR] winget-packages.json not found at $packagesFile" -ForegroundColor Red
    exit 1
}

Write-Host "Importing winget packages..." -ForegroundColor Yellow
winget import --import-file $packagesFile --accept-source-agreements --accept-package-agreements --ignore-unavailable
Write-Host "[DONE] Winget packages imported" -ForegroundColor Green
