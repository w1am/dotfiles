#!/bin/sh
# Install base packages via apt. run_onchange_: re-runs whenever this file's
# contents change — so adding a package to the list below triggers a reinstall
# on every machine, even ones already bootstrapped. Idempotent (skips installed).
set -eu

# Edit this list to add/remove packages — changing it re-runs the script.
packages="zsh git gh"

if ! command -v apt-get >/dev/null 2>&1; then
    echo "apt-get not found — skipping package install (non-Debian system?)"
    exit 0
fi

need=""
for pkg in $packages; do
    command -v "$pkg" >/dev/null 2>&1 || need="$need $pkg"
done

if [ -n "$need" ]; then
    echo "Installing:$need"
    sudo apt-get update
    sudo apt-get install -y $need
else
    echo "All packages already installed:$packages"
fi
