#!/bin/sh
set -eu

command -v gsettings >/dev/null 2>&1 || { echo "gsettings not found — skipping"; exit 0; }
[ -n "${DBUS_SESSION_BUS_ADDRESS:-}" ] || { echo "no dbus session — skipping GNOME keyboard settings"; exit 0; }

if ! gsettings writable org.gnome.desktop.peripherals.keyboard delay >/dev/null 2>&1; then
    echo "GNOME keyboard schema not available — skipping"
    exit 0
fi

gsettings set org.gnome.desktop.peripherals.keyboard repeat true
gsettings set org.gnome.desktop.peripherals.keyboard delay 300

echo "GNOME keyboard: repeat on, delay $(gsettings get org.gnome.desktop.peripherals.keyboard delay)"
