#!/bin/sh
# Bind GNOME keyboard shortcuts. Uses the built-in "home" media key (open the
# file manager) rather than a custom command, so it honors the default file
# manager set via xdg-mime instead of hardcoding nautilus. User-local, no sudo.
# run_onchange_: re-applies when the bindings below change. Skips cleanly when
# there's no graphical/dconf session (e.g. headless or non-GNOME).
set -eu

command -v gsettings >/dev/null 2>&1 || { echo "gsettings not found — skipping"; exit 0; }
[ -n "${DBUS_SESSION_BUS_ADDRESS:-}" ] || { echo "no dbus session — skipping GNOME shortcuts"; exit 0; }

if ! gsettings writable org.gnome.settings-daemon.plugins.media-keys home >/dev/null 2>&1; then
    echo "GNOME media-keys schema not available — skipping"
    exit 0
fi

# Win+E (Super+E) opens the file manager.
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"

echo "GNOME shortcuts: file manager bound to $(gsettings get org.gnome.settings-daemon.plugins.media-keys home)"
