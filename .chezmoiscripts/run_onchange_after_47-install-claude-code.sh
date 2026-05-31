#!/bin/sh
set -eu

if command -v claude >/dev/null 2>&1; then
    echo "Claude Code already installed: $(claude --version 2>/dev/null || echo present)"
    exit 0
fi

echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

echo "Claude Code installed."
