#!/bin/sh
set -eu

if [ -x "$HOME/.cargo/bin/rustc" ]; then
    echo "Rust already installed: $("$HOME/.cargo/bin/rustc" --version)"
    exit 0
fi

echo "Installing Rust via rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --no-modify-path --default-toolchain stable --profile default

echo "Installed: $("$HOME/.cargo/bin/rustc" --version) / $("$HOME/.cargo/bin/cargo" --version)"
