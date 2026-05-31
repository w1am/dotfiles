#!/bin/sh
set -eu

if [ -x "$HOME/.local/bin/uv" ]; then
    echo "uv already installed: $("$HOME/.local/bin/uv" --version)"
    exit 0
fi

echo "Installing uv..."
export INSTALLER_NO_MODIFY_PATH=1
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "Installed: $("$HOME/.local/bin/uv" --version)"
