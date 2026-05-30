#!/bin/sh
# Merge sensible defaults into ~/.claude/settings.json using jq.
# Existing values always win — this never overwrites what's already set.
# run_once_: runs once per machine; safe because jq only fills in gaps.
set -eu

settings="$HOME/.claude/settings.json"

if ! command -v jq >/dev/null 2>&1; then
    echo "jq not found — skipping Claude Code settings (install jq first)"
    exit 0
fi

mkdir -p "$HOME/.claude"

# Start from existing file, or empty object if none exists yet.
existing="$(cat "$settings" 2>/dev/null || echo '{}')"

defaults=$(cat << 'EOF'
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "theme": "dark",
  "defaultShell": "zsh",
  "editorMode": "vim",
  "tui": "fullscreen",
  "autoUpdatesChannel": "latest",
  "includeGitInstructions": true,
  "showTurnDuration": true,
  "permissions": {
    "defaultMode": "acceptEdits"
  },
  "env": {
    "EDITOR": "nvim",
    "VISUAL": "nvim"
  },
  "worktree": {
    "symlinkDirectories": ["node_modules", ".cache"]
  }
}
EOF
)

# Deep-merge: defaults provide the base, existing file overrides any conflicts.
printf '%s' "$existing" | jq --argjson defaults "$defaults" '$defaults * .' > "${settings}.tmp"
mv "${settings}.tmp" "$settings"

echo "Claude Code settings updated at $settings"
