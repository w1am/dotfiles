#!/bin/sh
set -eu

command -v gsettings >/dev/null 2>&1 || { echo "gsettings not found — skipping"; exit 0; }
[ -n "${DBUS_SESSION_BUS_ADDRESS:-}" ] || { echo "no dbus session — skipping GNOME shortcuts"; exit 0; }

if ! gsettings writable org.gnome.settings-daemon.plugins.media-keys home >/dev/null 2>&1; then
    echo "GNOME media-keys schema not available — skipping"
    exit 0
fi

gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"

echo "GNOME shortcuts: file manager bound to $(gsettings get org.gnome.settings-daemon.plugins.media-keys home)"
