#!/bin/sh
set -eu

packages="zsh git gh tmux wl-clipboard \
curl wget gnupg unzip \
ripgrep fd-find bat fzf jq tree htop ncdu \
build-essential pkg-config libssl-dev \
fontconfig"

if ! command -v apt-get >/dev/null 2>&1; then
    echo "apt-get not found — skipping package install (non-Debian system?)"
    exit 0
fi

need=""
for pkg in $packages; do
    # package name differs from command name (e.g. wl-clipboard → wl-copy)
    dpkg -s "$pkg" >/dev/null 2>&1 || need="$need $pkg"
done

if [ -n "$need" ]; then
    echo "Installing:$need"
    sudo apt-get update
    sudo apt-get install -y $need
else
    echo "All packages already installed:$packages"
fi
