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

# Install C/C++ build toolchain
# Needed by anything that compiles from source: tree-sitter grammars
# (`tree-sitter test` shells out to cc), node-gyp native addons, cargo crates
# with C dependencies. python3 is node-gyp's other prerequisite and ships with
# Ubuntu already.
if ! command -v cc &>/dev/null || ! command -v pkg-config &>/dev/null; then
    echo "[INSTALL] build-essential, pkg-config..."
    sudo apt update
    sudo apt install -y build-essential pkg-config
else
    echo "[SKIP] C build toolchain is already installed"
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

# Install zsh-autocomplete
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ]; then
    echo "[INSTALL] zsh-autocomplete..."
    git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete "$ZSH_CUSTOM/plugins/zsh-autocomplete"
else
    echo "[SKIP] zsh-autocomplete is already installed"
fi
