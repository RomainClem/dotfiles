# Install PowerShell modules

# On a fresh machine chezmoi runs this under Windows PowerShell 5.1: pwsh was only
# just installed by script 01 and isn't on chezmoi's PATH yet. 5.1 installs
# CurrentUser modules to Documents\WindowsPowerShell\Modules, which pwsh never
# reads, so hand over to pwsh whenever it exists.
if ($PSVersionTable.PSEdition -ne "Core") {
    # winget installs pwsh as MSIX (reachable only via the WindowsApps alias) or
    # as an MSI under Program Files, depending on the winget version
    $pwsh = @(
        (Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\pwsh.exe"),
        (Join-Path $env:ProgramFiles "PowerShell\7\pwsh.exe")
    ) | Where-Object { Test-Path $_ } | Select-Object -First 1
    if ($pwsh) {
        & $pwsh -NoProfile -ExecutionPolicy Bypass -File $PSCommandPath
        exit $LASTEXITCODE
    }
    Write-Host "[WARN] pwsh not found, installing modules for Windows PowerShell only" -ForegroundColor Yellow
}

$modules = @("PSReadLine", "Terminal-Icons", "PendingReboot")

foreach ($mod in $modules) {
    if (Get-Module -ListAvailable -Name $mod) {
        Write-Host "[SKIP] $mod is already installed" -ForegroundColor DarkGray
    } else {
        Write-Host "[INSTALL] $mod..." -ForegroundColor Yellow
        Install-Module -Name $mod -Force -Scope CurrentUser
    }
}
