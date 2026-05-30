#!/bin/sh
# Install base packages via apt. run_onchange_: re-runs whenever this file's
# contents change — so adding a package to the list below triggers a reinstall
# on every machine, even ones already bootstrapped. Idempotent (skips installed).
set -eu

# Edit this list to add/remove packages — changing it re-runs the script.
# Core shells/tools, modern CLI essentials, dev-installer deps (curl/gnupg/unzip),
# and Rust build deps (build-essential/pkg-config/libssl-dev).
packages="zsh git gh tmux wl-clipboard \
curl wget gnupg unzip \
ripgrep fd-find bat fzf eza zoxide jq tree htop ncdu \
build-essential pkg-config libssl-dev"

if ! command -v apt-get >/dev/null 2>&1; then
    echo "apt-get not found — skipping package install (non-Debian system?)"
    exit 0
fi

need=""
for pkg in $packages; do
    # Check by package name (command name may differ, e.g. wl-clipboard -> wl-copy)
    dpkg -s "$pkg" >/dev/null 2>&1 || need="$need $pkg"
done

if [ -n "$need" ]; then
    echo "Installing:$need"
    sudo apt-get update
    sudo apt-get install -y $need
else
    echo "All packages already installed:$packages"
fi
