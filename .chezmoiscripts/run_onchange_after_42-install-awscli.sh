#!/bin/sh
# Install the AWS CLI v2 user-local (no sudo) from AWS's official bundled
# installer into ~/.local/aws-cli, with the `aws`/`aws_completer` symlinks in
# ~/.local/bin (already on PATH — see dot_zshrc). AWS publishes v2 only as this
# zip; there is no apt package, so this mirrors the uv/rust/.NET user-local
# pattern rather than the Docker apt-repo one.
# run_onchange_: re-runs when this script changes. Idempotent.
set -eu

# AWS CLI v2 supports x86_64 and aarch64 Linux only; the zip suffix is uname -m.
arch="$(uname -m)"
case "$arch" in
    x86_64 | aarch64) ;;
    *) echo "AWS CLI v2 has no build for $arch — skipping"; exit 0 ;;
esac

command -v curl >/dev/null 2>&1 || { echo "curl missing — skipping AWS CLI"; exit 0; }
command -v unzip >/dev/null 2>&1 || { echo "unzip missing — skipping AWS CLI"; exit 0; }

install_dir="$HOME/.local/aws-cli"
bin_dir="$HOME/.local/bin"

# Always-update: re-run the installer over any existing install so each run
# refreshes to the latest v2. Unlike the .NET/uv scripts (which exit early when
# present), the AWS bundled installer refuses to overwrite without --update.
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
# --bin-dir puts symlinks on the existing PATH; --install-dir keeps it self-contained.
"$tmp/aws/install" --install-dir "$install_dir" --bin-dir "$bin_dir" $install_flags

echo "AWS CLI installed: $("$bin_dir/aws" --version)"
