#!/bin/sh
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
