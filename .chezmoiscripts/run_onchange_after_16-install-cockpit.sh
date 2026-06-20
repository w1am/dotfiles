#!/bin/sh
set -eu

command -v apt-get >/dev/null 2>&1 || { echo "not apt-based — skipping Cockpit"; exit 0; }

if dpkg -s cockpit >/dev/null 2>&1; then
    echo "Cockpit already installed"
else
    echo "Installing Cockpit..."
    sudo apt-get update
    sudo apt-get install -y cockpit
    echo "Cockpit installed"
fi

sudo systemctl enable --now cockpit.socket
echo "Cockpit reachable at https://$(hostname -I | awk '{print $1}'):9090"
