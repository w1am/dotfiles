#!/bin/sh
set -eu

USE_LTS=true
NODE_VERSION="22"              # only used when USE_LTS=false
fnm_bin="$HOME/.local/bin/fnm"

if [ ! -x "$fnm_bin" ]; then
    echo "Installing fnm..."
    curl -fsSL https://fnm.vercel.app/install \
        | bash -s -- --install-dir "$HOME/.local/bin" --skip-shell
fi

export PATH="$HOME/.local/bin:$PATH"
eval "$("$fnm_bin" env --shell bash)"

if [ "$USE_LTS" = "true" ]; then
    echo "Installing Node (LTS)..."
    "$fnm_bin" install --lts
    "$fnm_bin" use lts-latest
    "$fnm_bin" default lts-latest
else
    echo "Installing Node ($NODE_VERSION)..."
    "$fnm_bin" install "$NODE_VERSION"
    "$fnm_bin" use "$NODE_VERSION"
    "$fnm_bin" default "$NODE_VERSION"
fi

echo "Enabling corepack + pnpm..."
corepack enable
corepack prepare pnpm@latest --activate

echo "node $(node -v), npm $(npm -v), pnpm $(pnpm -v)"
