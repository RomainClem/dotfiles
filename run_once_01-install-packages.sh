#!/bin/bash
set -e

# Install zsh
if ! command -v zsh &>/dev/null; then
    echo "[INSTALL] zsh..."
    sudo apt update
    sudo apt install -y zsh
else
    echo "[SKIP] zsh is already installed"
fi

# Set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "[INSTALL] Setting zsh as default shell..."
    chsh -s "$(which zsh)"
else
    echo "[SKIP] zsh is already the default shell"
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "[INSTALL] Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "[SKIP] Oh My Zsh is already installed"
fi

# Install zsh-autosuggestions
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "[INSTALL] zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "[SKIP] zsh-autosuggestions is already installed"
fi

# Install zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "[INSTALL] zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo "[SKIP] zsh-syntax-highlighting is already installed"
fi
