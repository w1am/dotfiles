#!/bin/sh
# Install Claude Code (Anthropic's CLI) via the native installer into ~/.local.
# No sudo, and independent of the fnm-managed Node version (unlike `npm -g`).
# run_onchange_: re-runs if this script changes; Claude Code self-updates otherwise.
set -eu

if command -v claude >/dev/null 2>&1; then
    echo "Claude Code already installed: $(claude --version 2>/dev/null || echo present)"
    exit 0
fi

echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

echo "Claude Code installed."
