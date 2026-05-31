#!/bin/sh
set -eu

FONT="JetBrainsMono Nerd Font 12"

if ! command -v gsettings >/dev/null 2>&1; then
    echo "gsettings not found — skipping Ptyxis font config"
    exit 0
fi
if ! gsettings list-schemas 2>/dev/null | grep -q '^org.gnome.Ptyxis$'; then
    echo "Ptyxis schema not present — skipping font config"
    exit 0
fi

gsettings set org.gnome.Ptyxis use-system-font false
gsettings set org.gnome.Ptyxis font-name "$FONT"
echo "Ptyxis font set to: $FONT"
