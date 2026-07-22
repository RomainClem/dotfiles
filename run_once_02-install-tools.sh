#!/bin/bash
set -e

# Install Starship
if ! command -v starship &>/dev/null; then
    echo "[INSTALL] Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
    echo "[SKIP] Starship is already installed"
fi

# Install Bun
if ! command -v bun &>/dev/null; then
    echo "[INSTALL] Bun..."
    curl -fsSL https://bun.sh/install | bash
else
    echo "[SKIP] Bun is already installed"
fi
