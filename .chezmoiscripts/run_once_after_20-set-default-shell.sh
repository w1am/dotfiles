#!/bin/sh
# Make zsh the default login shell. run_once_: a per-machine action, done once.
# May prompt for your password (chsh). Safe to re-run — it no-ops if already set.
set -eu

zsh_path="$(command -v zsh || true)"
if [ -z "$zsh_path" ]; then
    echo "zsh not installed — skipping default-shell change"
    exit 0
fi

if [ "${SHELL:-}" != "$zsh_path" ]; then
    echo "Setting default shell to $zsh_path"
    chsh -s "$zsh_path" || echo "chsh failed — run 'chsh -s $zsh_path' manually"
else
    echo "Default shell already $zsh_path"
fi
