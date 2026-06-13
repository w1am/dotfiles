#!/bin/sh
set -eu

command -v apt-get >/dev/null 2>&1 || { echo "not apt-based — skipping cockpit-file-sharing"; exit 0; }

if [ -f /etc/apt/sources.list.d/45drives.sources ]; then
    echo "Removing stale 45Drives apt repository..."
    sudo rm -f /etc/apt/sources.list.d/45drives.sources /usr/share/keyrings/45drives-archive-keyring.gpg
fi

if dpkg -s cockpit-file-sharing >/dev/null 2>&1; then
    echo "cockpit-file-sharing already installed"
    exit 0
fi

version="4.5.7-2"
deb="cockpit-file-sharing_${version}jammy_all.deb"
url="https://github.com/45Drives/cockpit-file-sharing/releases/download/v${version}/${deb}"

echo "Installing cockpit-file-sharing ${version}..."
tmp="$(mktemp -d)"
curl -fsSL -o "$tmp/$deb" "$url"
sudo apt-get install -y "$tmp/$deb"
rm -rf "$tmp"
echo "cockpit-file-sharing installed — manage Samba shares from the Cockpit web UI"
