#!/bin/sh
# Authenticate to GitHub and wire git to push over HTTPS via the gh credential
# helper. run_once_: per-machine auth, done once. No SSH key to generate or paste.
# Safe to re-run — skips the login prompt if gh is already authenticated.
set -eu

if ! command -v gh >/dev/null 2>&1; then
    echo "gh (GitHub CLI) not found — skipping GitHub auth setup"
    exit 0
fi

if gh auth status >/dev/null 2>&1; then
    echo "gh already authenticated"
else
    echo "Authenticating with GitHub (follow the prompts)..."
    gh auth login --hostname github.com --git-protocol https --web
fi

# Use gh's stored token as git's credential helper so HTTPS pushes need no
# manual key setup. Idempotent — rewrites the helper config each run.
#
# Write the helper into ~/.gitconfig.local (included by the synced ~/.gitconfig)
# rather than ~/.gitconfig itself, so chezmoi never sees this machine-specific,
# keyring-backed config as drift. GIT_CONFIG_GLOBAL redirects where gh's
# underlying `git config --global` writes (git >= 2.32).
GIT_CONFIG_GLOBAL="$HOME/.gitconfig.local" gh auth setup-git
echo "GitHub HTTPS auth configured — 'update' / git push works over HTTPS."
