# Install fonts from GitHub

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

    $fontsFolder = (New-Object -ComObject Shell.Application).Namespace(0x14)
    $fontCount = 0
    foreach ($font in (Get-ChildItem $tempDir -Filter "*.ttf" -Recurse)) {
        $fontPath = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Fonts\$($font.Name)"
        if (-not (Test-Path $fontPath)) {
            $fontsFolder.CopyHere($font.FullName, 0x10)
            $fontCount++
        }
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

Install-FontFromZip -Name "Google Sans Code" `
    -Url "https://github.com/googlefonts/googlesans-code/archive/refs/heads/main.zip"
