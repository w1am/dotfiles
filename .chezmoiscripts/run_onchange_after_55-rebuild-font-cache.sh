#!/bin/sh
set -eu

FONT_VERSION="v3.4.0"   # keep in sync with JetBrainsMono in .chezmoiexternal.toml

if ! command -v fc-cache >/dev/null 2>&1; then
    echo "fc-cache not found (fontconfig missing) — skipping font cache rebuild"
    exit 0
fi

fc-cache -f "$HOME/.local/share/fonts"
echo "Font cache rebuilt (font set $FONT_VERSION)"
