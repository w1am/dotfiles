#!/bin/sh
set -eu

[ "$(uname -s)" = "Darwin" ] || { echo "not macOS — skipping Dock settings"; exit 0; }

defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 0.4
killall Dock 2>/dev/null || true

echo "macOS Dock: instant autohide applied"
