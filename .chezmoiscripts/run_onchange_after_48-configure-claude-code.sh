#!/bin/sh
# Merge sensible defaults into ~/.claude/settings.json and a baseline
# permission allow-list into ~/.claude/settings.local.json, using jq.
# Existing values always win — this never overwrites what's already set, and
# the allow-list is unioned so per-machine entries Claude added are preserved.
# run_onchange_: re-merges when defaults below change; existing values still win.
set -eu

settings="$HOME/.claude/settings.json"
local_settings="$HOME/.claude/settings.local.json"

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
  "editorMode": "vim",
  "tui": "default",
  "attribution": {
    "commit": "",
    "pr": ""
  },
  "autoUpdatesChannel": "latest",
  "teammateMode": "tmux",
  "includeGitInstructions": true,
  "showTurnDuration": true,
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh",
    "padding": 0
  },
  "permissions": {
    "defaultMode": "auto"
  },
  "worktree": {
    "symlinkDirectories": ["node_modules", ".cache"]
  },
  "enabledPlugins": {
    "code-review@claude-plugins-official": true,
    "code-simplifier@claude-plugins-official": true,
    "skill-creator@claude-plugins-official": true,
    "github@claude-plugins-official": true,
    "claude-md-management@claude-plugins-official": true,
    "feature-dev@claude-plugins-official": true,
    "typescript-lsp@claude-plugins-official": true,
    "security-guidance@claude-plugins-official": true,
    "claude-code-setup@claude-plugins-official": true,
    "commit-commands@claude-plugins-official": true,
    "pr-review-toolkit@claude-plugins-official": true,
    "pyright-lsp@claude-plugins-official": true,
    "chrome-devtools-mcp@claude-plugins-official": true,
    "plugin-dev@claude-plugins-official": true,
    "explanatory-output-style@claude-plugins-official": true,
    "playground@claude-plugins-official": true,
    "learning-output-style@claude-plugins-official": true,
    "csharp-lsp@claude-plugins-official": true,
    "data-engineering@claude-plugins-official": true,
    "cloudflare@claude-plugins-official": true,
    "shopify-ai-toolkit@claude-plugins-official": true,
    "duckdb-skills@claude-plugins-official": true
  },
  "env": {
    "CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY": "1",
    "CLAUDE_CODE_NO_FLICKER": "1",
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1",
    "CLAUDE_CODE_SHELL": "zsh"
  }
}
EOF
)

# Deep-merge: defaults provide the base, existing file overrides any conflicts.
printf '%s' "$existing" | jq --argjson defaults "$defaults" '$defaults * .' > "${settings}.tmp"
mv "${settings}.tmp" "$settings"

echo "Claude Code settings updated at $settings"

# Baseline permission grants for ~/.claude/settings.local.json. Unioned into the
# existing allow-list (appended only if missing) so entries Claude added locally
# survive every re-run.
allow=$(cat << 'EOF'
[
  "Bash(bun:*)",
  "Bash(npx:*)",
  "Bash(node:*)",
  "Bash(git add:*)",
  "Bash(git commit:*)",
  "Bash(git status:*)",
  "Bash(git diff:*)",
  "Bash(git log:*)",
  "Bash(git branch:*)",
  "Bash(git checkout:*)",
  "Bash(git push origin:*)",
  "Bash(gh:*)",
  "Bash(mkdir:*)",
  "Bash(ls:*)",
  "Bash(grep:*)",
  "Edit(*)",
  "Write(*)",
  "WebFetch",
  "Skill(*)"
]
EOF
)

existing_local="$(cat "$local_settings" 2>/dev/null || echo '{}')"

printf '%s' "$existing_local" | jq --argjson allow "$allow" '
  .permissions.allow = reduce $allow[] as $entry (
    (.permissions.allow // []);
    if index($entry) then . else . + [$entry] end
  )
' > "${local_settings}.tmp"
mv "${local_settings}.tmp" "$local_settings"

echo "Claude Code local settings updated at $local_settings"
