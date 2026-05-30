#!/bin/sh
# Bootstrap zsh on a fresh machine. Runs once (chezmoi tracks by content hash).
# Idempotent: skips anything already in place. May prompt for sudo/your password.
set -eu

# 1. Install zsh + git via apt if missing
if command -v apt-get >/dev/null 2>&1; then
    need=""
    command -v zsh >/dev/null 2>&1 || need="$need zsh"
    command -v git >/dev/null 2>&1 || need="$need git"
    if [ -n "$need" ]; then
        echo "Installing:$need"
        sudo apt-get update
        sudo apt-get install -y $need
    fi
fi

# 2. Make zsh the default login shell
zsh_path="$(command -v zsh || true)"
if [ -n "$zsh_path" ] && [ "${SHELL:-}" != "$zsh_path" ]; then
    echo "Setting default shell to $zsh_path"
    chsh -s "$zsh_path" || echo "chsh failed — run 'chsh -s $zsh_path' manually"
fi

echo "zsh bootstrap complete."
