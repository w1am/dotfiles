#!/bin/sh
# Generate this machine's own SSH key. run_once_: keys are per-machine identity
# and are NEVER synced through the dotfiles repo. Skips if a key already exists.
set -eu

key="$HOME/.ssh/id_ed25519"
if [ -f "$key" ]; then
    echo "SSH key already present at $key"
    exit 0
fi

mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
echo "Generating a new SSH key for this machine..."
ssh-keygen -t ed25519 -C "william-chong@outlook.com" -f "$key" -N "" -q

# Trust GitHub's host key so the first push doesn't fail on verification
ssh-keygen -F github.com >/dev/null 2>&1 || \
    ssh-keyscan -t ed25519 github.com >> "$HOME/.ssh/known_hosts" 2>/dev/null

echo ""
echo ">>> ADD THIS PUBLIC KEY TO GITHUB (Settings > SSH and GPG keys):"
cat "$key.pub"
echo ">>> or, once gh is authenticated: gh ssh-key add $key.pub --title \"\$(hostname)\""
echo ""
