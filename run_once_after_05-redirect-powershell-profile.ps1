# Point pwsh at the chezmoi-managed profile when Documents is redirected
#
# chezmoi places the profile at ~/Documents/PowerShell, but pwsh reads $PROFILE
# from the *shell* Documents folder, which OneDrive/Intune often moves (e.g. to
# "~/OneDrive - Company/Documents"). Write a stub there that dot-sources the
# managed file, rather than a symlink, which would need admin or Developer Mode.

$managed = Join-Path $env:USERPROFILE "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
$actual = Join-Path ([Environment]::GetFolderPath("MyDocuments")) "PowerShell\Microsoft.PowerShell_profile.ps1"

if ($actual -eq $managed) {
    Write-Host "[SKIP] Documents is not redirected, pwsh reads the managed profile directly" -ForegroundColor DarkGray
    exit 0
}

$marker = "# chezmoi: redirect to managed profile"
$stub = "$marker`n. `"`$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`"`n"

# Never clobber a profile someone wrote by hand
if ((Test-Path -LiteralPath $actual) -and -not (Select-String -LiteralPath $actual -SimpleMatch $marker -Quiet)) {
    Write-Host "[WARN] $actual already exists and isn't a chezmoi stub, leaving it alone" -ForegroundColor Yellow
    exit 0
}

New-Item -ItemType Directory -Path (Split-Path $actual) -Force | Out-Null
Set-Content -LiteralPath $actual -Value $stub -Encoding utf8 -NoNewline
Write-Host "[INSTALL] Profile stub written to $actual" -ForegroundColor Green
