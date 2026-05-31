#!/bin/sh
set -eu

NVIM_CHANNEL="stable"          # "stable" = latest stable; or pin a tag e.g. "v0.11.6"
prefix="$HOME/.local"
dest="$prefix/nvim"            # not ~/.local/share/nvim, which is nvim's data dir

arch="$(uname -m)"
case "$arch" in
    x86_64)  asset="nvim-linux-x86_64.tar.gz" ;;
    aarch64) asset="nvim-linux-arm64.tar.gz" ;;
    *) echo "Unsupported arch '$arch' — install neovim manually"; exit 0 ;;
esac

url="https://github.com/neovim/neovim/releases/download/$NVIM_CHANNEL/$asset"
echo "Installing Neovim ($NVIM_CHANNEL, $arch) from $url"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
if ! curl -fsSL "$url" -o "$tmp/nvim.tar.gz"; then
    echo "Download failed — leaving any existing neovim in place"
    exit 0
fi

rm -rf "$dest"
mkdir -p "$dest" "$prefix/bin"
tar -xzf "$tmp/nvim.tar.gz" -C "$dest" --strip-components=1
ln -sf "$dest/bin/nvim" "$prefix/bin/nvim"

echo "Neovim installed: $("$prefix/bin/nvim" --version | head -1)"
