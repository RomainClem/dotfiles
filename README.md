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

> ⚠️ **Important: chezmoi reads from its own source directory, not this repo.**
>
> When you run `chezmoi init`, chezmoi clones this repo into its **source directory**:
> - **Windows:** `%USERPROFILE%\.local\share\chezmoi`
> - **Linux/WSL:** `~/.local/share/chezmoi`
>
> Editing files in a separate working clone of this repo (e.g. `~/Documents/WorkSpace/Repos/dotfiles`) has **no effect** on `chezmoi apply` until those changes reach the source directory.

### Recommended workflow

Always edit through chezmoi so you're working in the source directory:

```bash
chezmoi cd                     # jump into the source directory
chezmoi edit ~/.zshrc          # edit a managed file in $EDITOR
chezmoi diff                   # preview pending changes vs. home
chezmoi apply                  # apply changes to home directory
```

Then commit and push from the source directory:

```bash
chezmoi cd
git add -A && git commit -m "tweak zshrc"
git push
exit                           # leave the chezmoi shell
```

### Pulling changes on another machine

```bash
chezmoi update                 # git pull in source dir + apply
```

### Re-export winget packages

After installing new apps on Windows, update the package list:

```powershell
chezmoi cd
winget export -o winget-packages.json
git add winget-packages.json; git commit -m "update winget packages"; git push
chezmoi apply
```

### Working from a separate clone (optional)

If you prefer to keep your working clone elsewhere (e.g. under `~/Documents/WorkSpace/Repos/dotfiles`), point chezmoi at it instead of the default source directory by adding to `~/.config/chezmoi/chezmoi.toml`:

```toml
sourceDir = 'C:\Users\YOU\Documents\WorkSpace\Repos\dotfiles'
```

Otherwise, edits made outside the source directory must be `git push`ed and then pulled with `chezmoi update` before `chezmoi apply` will see them.

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
