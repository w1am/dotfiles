#!/bin/sh
# Authenticate to GitHub over SSH. gh generates an ed25519 key and uploads it
# during the web flow (the token gets the admin:public_key scope). run_once_:
# per-machine auth, done once. Safe to re-run — skips the login if gh is already
# authenticated.
#
# No git config wiring here: URL routing (https://github.com/ -> git@github.com:)
# lives declaratively in the synced ~/.gitconfig via url.insteadOf. This script
# is auth-only.
set -eu

if ! command -v gh >/dev/null 2>&1; then
    echo "gh (GitHub CLI) not found — skipping GitHub auth setup"
    exit 0
fi

if gh auth status >/dev/null 2>&1; then
    echo "gh already authenticated"
else
    echo "Authenticating with GitHub over SSH (follow the prompts)..."
    gh auth login --hostname github.com --git-protocol ssh --web
fi

echo "GitHub SSH auth configured — 'update' / git push works over SSH."
