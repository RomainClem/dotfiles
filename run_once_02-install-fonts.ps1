# Install fonts from GitHub (per-user, no admin required)

function Install-FontFromZip {
    param(
        [string]$Name,
        [string]$Url
    )
    Write-Host "Installing $Name..." -ForegroundColor Yellow

    $tempDir = Join-Path $env:TEMP $Name.Replace(" ", "")
    $zipPath = "$tempDir.zip"

    if (Test-Path $tempDir) { Remove-Item $tempDir -Recurse -Force }

    Invoke-WebRequest -Uri $Url -OutFile $zipPath -UseBasicParsing
    Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force

    $userFontsDir = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Fonts"
    $registryKey = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
    New-Item -ItemType Directory -Path $userFontsDir -Force | Out-Null
    if (-not (Test-Path $registryKey)) { New-Item -Path $registryKey -Force | Out-Null }

    # Registered font paths, so a file already registered under another name
    # (e.g. by a previous shell-based install) isn't registered twice
    $registeredPaths = (Get-ItemProperty -Path $registryKey).PSObject.Properties |
        Where-Object { $_.Value -is [string] } | ForEach-Object { $_.Value }

    $fontCount = 0
    foreach ($font in (Get-ChildItem $tempDir -Filter "*.ttf" -Recurse)) {
        $fontPath = Join-Path $userFontsDir $font.Name
        # -LiteralPath: font filenames may contain [] which Test-Path treats as wildcards
        $fileMissing = -not (Test-Path -LiteralPath $fontPath)
        $registryMissing = $registeredPaths -notcontains $fontPath
        if ($fileMissing) {
            Copy-Item -LiteralPath $font.FullName -Destination $fontPath -Force
        }
        if ($registryMissing) {
            New-ItemProperty -Path $registryKey -Name "$($font.BaseName) (TrueType)" `
                -Value $fontPath -PropertyType String -Force | Out-Null
        }
        if ($fileMissing -or $registryMissing) { $fontCount++ }
    }

    if ($fontCount -gt 0) {
        Write-Host "[INSTALL] Installed $fontCount font files for $Name" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] $Name is already installed" -ForegroundColor DarkGray
    }

    Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
    Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}

Install-FontFromZip -Name "FiraCode Nerd Font" `
    -Url "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"

# Google Sans Code assets are version-stamped (GoogleSansCode-vX.XXX.zip), so
# resolve the latest release via the API instead of hardcoding a version
$gscAsset = (Invoke-RestMethod "https://api.github.com/repos/googlefonts/googlesans-code/releases/latest").assets |
    Where-Object { $_.name -match '^GoogleSansCode-v[\d.]+\.zip$' } |
    Select-Object -First 1
Install-FontFromZip -Name "Google Sans Code" -Url $gscAsset.browser_download_url
