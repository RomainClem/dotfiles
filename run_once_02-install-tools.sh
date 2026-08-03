#!/bin/bash
set -e

# Install Starship
if ! command -v starship &>/dev/null; then
    echo "[INSTALL] Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
    echo "[SKIP] Starship is already installed"
fi

# Bun is installed and pinned by mise (see private_dot_config/mise/config.toml),
# not by bun.sh/install -- a curl-installed bun is unversioned and self-upgrading.
