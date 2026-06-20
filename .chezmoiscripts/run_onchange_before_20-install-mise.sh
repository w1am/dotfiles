#!/bin/sh
set -eu

# Installs the mise binary only. Runtimes are declared in ~/.config/mise/config.toml
# and installed by run_onchange_after_45-mise-install.sh once that config is applied.
if [ -x "$HOME/.local/bin/mise" ]; then
    echo "mise already installed: $("$HOME/.local/bin/mise" version)"
    exit 0
fi

echo "Installing mise..."
curl -fsSL https://mise.run | sh
echo "mise installed: $("$HOME/.local/bin/mise" version)"
