#!/bin/sh
# Install Docker Engine + CLI + Buildx/Compose plugins from Docker's official apt
# repository, and add you to the `docker` group so `docker` works without sudo.
# run_onchange_: re-runs if this script changes. Idempotent. Needs sudo (password).
set -eu

command -v apt-get >/dev/null 2>&1 || { echo "not apt-based — skipping Docker"; exit 0; }

if command -v docker >/dev/null 2>&1; then
    echo "Docker already installed: $(docker --version)"
else
    echo "Adding Docker's official apt repository..."
    # Docker keys the repo per-distro; derive the Ubuntu codename from os-release.
    codename="$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")"
    arch="$(dpkg --print-architecture)"

    tmp="$(mktemp)"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor > "$tmp"
    sudo install -D -o root -g root -m 644 "$tmp" /etc/apt/keyrings/docker.gpg
    rm -f "$tmp"
    echo "deb [arch=$arch signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $codename stable" \
        | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    echo "Docker installed: $(docker --version)"
fi

# Let the invoking user run docker without sudo. Idempotent — usermod is a no-op
# if already a member. Takes effect on next login (or `newgrp docker` now).
if ! id -nG "$USER" | tr ' ' '\n' | grep -qx docker; then
    echo "Adding $USER to the docker group (re-login required to take effect)..."
    sudo usermod -aG docker "$USER"
else
    echo "$USER already in the docker group"
fi
