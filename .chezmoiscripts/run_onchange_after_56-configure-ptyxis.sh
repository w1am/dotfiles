#!/bin/sh
# Point Ptyxis (the GNOME/Ubuntu default terminal) at the JetBrainsMono Nerd Font
# so the agnoster prompt's Powerline glyphs render. Ptyxis stores the font
# globally via GSettings (org.gnome.Ptyxis), not per-profile. run_onchange_:
# re-runs when this script changes — edit FONT below to restyle. No-ops cleanly
# where Ptyxis isn't installed (other terminals, headless, non-GNOME).
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
