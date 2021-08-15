#!/bin/bash

# Turn on universal access mode and set reduce keyboard delay for fast typing experience
gsettings set org.gnome.desktop.a11y always-show-universal-access-status true
gsettings set org.gnome.desktop.peripherals.keyboard delay 198

# Configure general settings and turn on dark theme
gsettings set org.gnome.desktop.interface gtk-theme "HighContrastInverse"
gsettings set org.gnome.desktop.interface enable-animations false
dconf write /org/gnome/desktop/sound/event-sounds false

gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide false
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true

# Power settings
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# Change locale format
gsettings set org.gnome.system.locale region 'en_GB.UTF-8'

# Change default terminal
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

# Top bar
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-date true
