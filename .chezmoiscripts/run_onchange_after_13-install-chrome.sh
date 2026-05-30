#!/bin/sh
# Install Google Chrome from Google's official apt repository.
# run_onchange_: re-runs if this script changes. Idempotent. Needs sudo (password).
set -eu

command -v apt-get >/dev/null 2>&1 || { echo "not apt-based — skipping Chrome"; exit 0; }

if command -v google-chrome-stable >/dev/null 2>&1 || command -v google-chrome >/dev/null 2>&1; then
    echo "Chrome already installed: $(google-chrome --version 2>/dev/null || google-chrome-stable --version)"
    exit 0
fi

echo "Adding Google apt repository for Chrome..."
tmp="$(mktemp)"
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > "$tmp"
sudo install -D -o root -g root -m 644 "$tmp" /usr/share/keyrings/google-chrome.gpg
rm -f "$tmp"
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
    | sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null
sudo apt-get update
sudo apt-get install -y google-chrome-stable
echo "Chrome installed: $(google-chrome-stable --version)"
