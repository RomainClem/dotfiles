# Install PowerShell modules

$modules = @("PSReadLine", "Terminal-Icons", "PendingReboot")

foreach ($mod in $modules) {
    if (Get-Module -ListAvailable -Name $mod) {
        Write-Host "[SKIP] $mod is already installed" -ForegroundColor DarkGray
    } else {
        Write-Host "[INSTALL] $mod..." -ForegroundColor Yellow
        Install-Module -Name $mod -Force -Scope CurrentUser
    }
}
