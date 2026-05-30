#!/bin/sh
# Install the .NET SDK user-local via Microsoft's dotnet-install.sh into
# ~/.dotnet (no sudo — like fnm/uv/rust). Needed by the OmniSharp C# language
# server to analyze .csproj/.sln projects. dot_zshrc puts ~/.dotnet on PATH.
# run_onchange_: re-runs when this script changes — bump DOTNET_CHANNEL (or edit
# a comment) to force an upgrade to a newer SDK band.
set -eu

DOTNET_CHANNEL="LTS"           # "LTS", "STS", or a band like "8.0"
install_dir="$HOME/.dotnet"

if [ -x "$install_dir/dotnet" ]; then
    echo ".NET SDK already installed: $("$install_dir/dotnet" --version)"
    exit 0
fi

echo "Installing .NET SDK ($DOTNET_CHANNEL) into $install_dir ..."
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
if ! curl -fsSL https://dot.net/v1/dotnet-install.sh -o "$tmp"; then
    echo "Download failed — leaving any existing .NET install in place"
    exit 0
fi

# dotnet-install.sh is a bash script; --install-dir keeps it self-contained.
if ! bash "$tmp" --channel "$DOTNET_CHANNEL" --install-dir "$install_dir"; then
    echo "dotnet-install.sh failed (missing libicu? non-glibc?) — skipping"
    exit 0
fi

echo ".NET SDK installed: $("$install_dir/dotnet" --version)"
