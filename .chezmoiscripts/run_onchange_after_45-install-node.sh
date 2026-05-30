#!/bin/sh
# Install fnm (Node version manager), the chosen Node version, and enable pnpm
# via corepack (npm ships with Node). User-local, no sudo. run_onchange_: change
# NODE_VERSION below to install/default a different version on every machine.
set -eu

NODE_VERSION="--lts"          # e.g. "--lts", "22", "v20.11.0"
fnm_bin="$HOME/.local/bin/fnm"

if [ ! -x "$fnm_bin" ]; then
    echo "Installing fnm..."
    curl -fsSL https://fnm.vercel.app/install \
        | bash -s -- --install-dir "$HOME/.local/bin" --skip-shell
fi

export PATH="$HOME/.local/bin:$PATH"
eval "$("$fnm_bin" env)"

echo "Installing Node ($NODE_VERSION)..."
"$fnm_bin" install $NODE_VERSION
"$fnm_bin" use $NODE_VERSION
"$fnm_bin" default "$(node -v)"

echo "Enabling corepack + pnpm..."
corepack enable
corepack prepare pnpm@latest --activate

echo "node $(node -v), npm $(npm -v), pnpm $(pnpm -v)"
