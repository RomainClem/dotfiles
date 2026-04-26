# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) for a cross-platform development environment (Windows + WSL/Ubuntu) with a unified [Starship](https://starship.rs/) prompt.

## Quick Start

### Windows (fresh machine)

```powershell
winget install twpayne.chezmoi
chezmoi init --apply RomainClem
```

### WSL / Linux (fresh machine)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply RomainClem
```

That's it. Chezmoi will clone this repo, place all config files, and run the install scripts automatically.

## What Gets Installed

### Windows (`*.ps1` scripts)

| Script | What it does |
|---|---|
| `run_once_01-install-packages.ps1` | Imports all apps from `winget-packages.json` via `winget import` |
| `run_once_02-install-fonts.ps1` | Installs FiraCode Nerd Font and Google Sans Code from GitHub |
| `run_once_03-install-powershell-modules.ps1` | Installs PSReadLine, Terminal-Icons, PendingReboot |

### Linux / WSL (`*.sh` scripts)

| Script | What it does |
|---|---|
| `run_once_01-install-packages.sh` | Installs zsh, Oh My Zsh, zsh-autosuggestions, zsh-syntax-highlighting |
| `run_once_02-install-tools.sh` | Installs Starship, NVM, Bun |

## Config Files Placed by Chezmoi

| Source (this repo) | Target | OS |
|---|---|---|
| `dot_zshrc` | `~/.zshrc` | Linux |
| `dot_config/starship.toml` | `~/.config/starship.toml` | Both |
| `Documents/PowerShell/Microsoft.PowerShell_profile.ps1` | `~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1` | Windows |
| `AppData/.../LocalState/settings.json` | Windows Terminal settings | Windows |

## Managing Your Dotfiles

```bash
chezmoi edit ~/.zshrc          # Edit a managed file
chezmoi diff                   # Preview pending changes
chezmoi apply                  # Apply changes to home directory
chezmoi cd                     # cd into the source directory
chezmoi update                 # Pull latest from git and apply
```

### Re-export winget packages

After installing new apps on Windows, update the package list:

```powershell
chezmoi cd
winget export -o winget-packages.json
git add winget-packages.json && git commit -m "update winget packages"
chezmoi apply
```

## What's Configured

### ZSH (`dot_zshrc`)
- Oh My Zsh with **git**, **zsh-autosuggestions**, and **zsh-syntax-highlighting** plugins
- NVM auto-load for Node.js version management
- Bun runtime on PATH
- `WINDOWS_HOST_IP` extraction for WSL interop
- ASP.NET dev certificate trust via `SSL_CERT_DIR`

### Starship (`dot_config/starship.toml`)
- Gruvbox Dark color palette
- OS, shell, username, hostname, directory, and git status indicators
- Language version detection: Node.js, C/C++, Rust, Go, PHP, Java, Kotlin, Haskell, Python
- Docker, Conda, and Pixi environment awareness

### PowerShell (`Microsoft.PowerShell_profile.ps1`)
- PSReadLine with history-based predictions in list view
- Terminal-Icons for file/folder icons
- PendingReboot module
- Starship prompt

### Windows Terminal (`settings.json`)
- Default profile: PowerShell Core
- Font: FiraCode Nerd Font Mono
- 70% opacity with acrylic transparency
- Solarized Light (modified) color scheme

## License

[Apache 2.0](LICENSE)
