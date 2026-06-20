#!/bin/sh
set -eu

if [ -x "$HOME/.bun/bin/bun" ]; then
    echo "Bun already installed: $("$HOME/.bun/bin/bun" --version)"
    exit 0
fi

echo "Installing Bun..."
export BUN_INSTALL="$HOME/.bun"
curl -fsSL https://bun.sh/install | bash

echo "Bun installed: $("$HOME/.bun/bin/bun" --version)"
