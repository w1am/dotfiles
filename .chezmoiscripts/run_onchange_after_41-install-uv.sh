#!/bin/sh
# Install uv (fast Python package/project manager) + uvx into ~/.local/bin.
# User-local, no sudo. ~/.local/bin is already on PATH (see dot_zshrc), so tell
# the installer not to touch shell profiles. run_onchange_: re-runs if this
# script changes; uv self-updates via `uv self update`.
set -eu

if [ -x "$HOME/.local/bin/uv" ]; then
    echo "uv already installed: $("$HOME/.local/bin/uv" --version)"
    exit 0
fi

echo "Installing uv..."
export INSTALLER_NO_MODIFY_PATH=1
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "Installed: $("$HOME/.local/bin/uv" --version)"
