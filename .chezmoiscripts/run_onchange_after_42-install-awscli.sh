#!/bin/sh
set -eu

arch="$(uname -m)"
case "$arch" in
    x86_64 | aarch64) ;;
    *) echo "AWS CLI v2 has no build for $arch — skipping"; exit 0 ;;
esac

command -v curl >/dev/null 2>&1 || { echo "curl missing — skipping AWS CLI"; exit 0; }
command -v unzip >/dev/null 2>&1 || { echo "unzip missing — skipping AWS CLI"; exit 0; }

install_dir="$HOME/.local/aws-cli"
bin_dir="$HOME/.local/bin"

install_flags=""
if [ -x "$bin_dir/aws" ]; then
    echo "AWS CLI present ($("$bin_dir/aws" --version)) — updating to latest v2"
    install_flags="--update"
fi

echo "Installing AWS CLI v2 ($arch) into $install_dir ..."
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

if ! curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-$arch.zip" -o "$tmp/awscli.zip"; then
    echo "Download failed — leaving any existing AWS CLI install in place"
    exit 0
fi

unzip -q "$tmp/awscli.zip" -d "$tmp"
"$tmp/aws/install" --install-dir "$install_dir" --bin-dir "$bin_dir" $install_flags

echo "AWS CLI installed: $("$bin_dir/aws" --version)"
