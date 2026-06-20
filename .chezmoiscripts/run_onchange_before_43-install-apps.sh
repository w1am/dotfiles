#!/bin/sh
set -eu

command -v apt-get >/dev/null 2>&1 || { echo "not apt-based — skipping app installs"; exit 0; }

apt_updated=

apt_update_once() {
    [ -n "$apt_updated" ] && return 0
    sudo apt-get update
    apt_updated=1
}

ensure_apt_source() {
    keyring="$1"; key_url="$2"; list="$3"; deb_line="$4"
    [ -f "$keyring" ] && [ -f "$list" ] && return 0
    echo "Adding apt source: $list"
    tmp="$(mktemp)"
    curl -fsSL "$key_url" | gpg --dearmor > "$tmp"
    sudo install -D -o root -g root -m 644 "$tmp" "$keyring"
    rm -f "$tmp"
    echo "$deb_line" | sudo tee "$list" >/dev/null
    apt_updated=
}

ensure_packages() {
    need=""
    for pkg in "$@"; do
        dpkg -s "$pkg" >/dev/null 2>&1 || need="$need $pkg"
    done
    [ -z "$need" ] && return 0
    apt_update_once
    echo "Installing:$need"
    sudo apt-get install -y $need
}

ensure_release_deb() {
    pkg="$1"; url="$2"
    dpkg -s "$pkg" >/dev/null 2>&1 && return 0
    echo "Installing $pkg from $url"
    tmp="$(mktemp -d)"
    deb="$tmp/$(basename "$url")"
    curl -fsSL -o "$deb" "$url"
    sudo apt-get install -y "$deb"
    rm -rf "$tmp"
}

ensure_apt_source /usr/share/keyrings/microsoft.gpg \
    https://packages.microsoft.com/keys/microsoft.asc \
    /etc/apt/sources.list.d/vscode.list \
    "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main"
ensure_packages code

ensure_apt_source /usr/share/keyrings/google-chrome.gpg \
    https://dl.google.com/linux/linux_signing_key.pub \
    /etc/apt/sources.list.d/google-chrome.list \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main"
ensure_packages google-chrome-stable

docker_codename="$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")"
docker_arch="$(dpkg --print-architecture)"
ensure_apt_source /etc/apt/keyrings/docker.gpg \
    https://download.docker.com/linux/ubuntu/gpg \
    /etc/apt/sources.list.d/docker.list \
    "deb [arch=$docker_arch signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $docker_codename stable"
ensure_packages docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

if ! id -nG "$USER" | tr ' ' '\n' | grep -qx docker; then
    echo "Adding $USER to the docker group (re-login required to take effect)..."
    sudo usermod -aG docker "$USER"
fi

# One-time migration: drop the stale 45Drives repo cockpit-file-sharing used to ship from.
if [ -f /etc/apt/sources.list.d/45drives.sources ]; then
    echo "Removing stale 45Drives apt repository..."
    sudo rm -f /etc/apt/sources.list.d/45drives.sources /usr/share/keyrings/45drives-archive-keyring.gpg
fi

cfs_version="4.5.7-2"
ensure_release_deb cockpit-file-sharing \
    "https://github.com/45Drives/cockpit-file-sharing/releases/download/v${cfs_version}/cockpit-file-sharing_${cfs_version}jammy_all.deb"
