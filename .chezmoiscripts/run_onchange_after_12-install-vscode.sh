#!/bin/sh
# Install Visual Studio Code from Microsoft's official apt repository.
# run_onchange_: re-runs if this script changes. Idempotent. Needs sudo (password).
set -eu

command -v apt-get >/dev/null 2>&1 || { echo "not apt-based — skipping VS Code"; exit 0; }

if command -v code >/dev/null 2>&1; then
    echo "VS Code already installed: $(code --version | head -1)"
    exit 0
fi

echo "Adding Microsoft apt repository for VS Code..."
tmp="$(mktemp)"
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > "$tmp"
sudo install -D -o root -g root -m 644 "$tmp" /usr/share/keyrings/microsoft.gpg
rm -f "$tmp"
echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
    | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
sudo apt-get update
sudo apt-get install -y code
echo "VS Code installed: $(code --version | head -1)"
