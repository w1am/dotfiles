#!/bin/sh
set -eu

command -v apt-get >/dev/null 2>&1 || { echo "not apt-based — skipping Samba"; exit 0; }

if dpkg -s samba >/dev/null 2>&1; then
    echo "Samba already installed"
else
    echo "Installing Samba..."
    sudo apt-get update
    sudo apt-get install -y samba
    echo "Samba installed"
fi

conf=/etc/samba/smb.conf
if [ -f "$conf" ] && ! grep -qE '^[[:space:]]*include[[:space:]]*=[[:space:]]*registry' "$conf"; then
    echo "Enabling registry-backed shares (required by cockpit-file-sharing)..."
    sudo sed -i '/^\[global\]/a\   include = registry' "$conf"
    sudo net conf list >/dev/null 2>&1 || true
fi

sudo systemctl enable smbd nmbd
sudo systemctl restart smbd nmbd
echo "Samba running — configure shares in Cockpit or /etc/samba/smb.conf, add users with 'sudo smbpasswd -a <user>'"
