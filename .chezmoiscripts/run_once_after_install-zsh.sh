#!/bin/sh
# Bootstrap zsh on a fresh machine. Runs once (chezmoi tracks by content hash).
# Idempotent: skips anything already in place. May prompt for sudo/your password.
set -eu

# 1. Install zsh + git + GitHub CLI via apt if missing
if command -v apt-get >/dev/null 2>&1; then
    need=""
    command -v zsh >/dev/null 2>&1 || need="$need zsh"
    command -v git >/dev/null 2>&1 || need="$need git"
    command -v gh  >/dev/null 2>&1 || need="$need gh"
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

# 3. Ensure this machine has its own SSH key (per-machine identity, never synced)
key="$HOME/.ssh/id_ed25519"
if [ ! -f "$key" ]; then
    mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
    echo "Generating a new SSH key for this machine..."
    ssh-keygen -t ed25519 -C "william-chong@outlook.com" -f "$key" -N "" -q
    # Trust GitHub's host key so the first push doesn't fail
    ssh-keygen -F github.com >/dev/null 2>&1 || \
        ssh-keyscan -t ed25519 github.com >> "$HOME/.ssh/known_hosts" 2>/dev/null
    echo ""
    echo ">>> ADD THIS PUBLIC KEY TO GITHUB (Settings > SSH and GPG keys):"
    cat "$key.pub"
    echo ">>> or run: gh ssh-key add $key.pub --title \"\$(hostname)\""
    echo ""
fi

echo "zsh bootstrap complete."
