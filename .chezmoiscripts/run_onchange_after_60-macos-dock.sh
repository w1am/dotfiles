#!/bin/sh
# macOS Dock tweaks: instant autohide (no show/hide delay, snappier animation).
# run_onchange_: re-applies when the values below change. Darwin-only — skips
# cleanly on the apt machines.
set -eu

[ "$(uname -s)" = "Darwin" ] || { echo "not macOS — skipping Dock settings"; exit 0; }

defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 0.4
killall Dock 2>/dev/null || true

echo "macOS Dock: instant autohide applied"
