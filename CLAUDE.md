# Agent instructions

This repo is a **chezmoi source directory** (`~/.local/share/chezmoi`) managing the
user's dotfiles. Read the tree to learn the specifics. This file is only the rules for
operating it. For bootstrapping a new machine, read `INSTALLATION.md` instead.

## Rules

- **Never commit secrets.** No private keys, tokens, or credentials. GitHub auth is
  per-machine via `gh auth login --web` at bootstrap and the token lives in the
  keyring. The ElevenLabs key is a per-machine file, never added.
- **Edit the source, never the target.** Change `dot_zshrc`, not `~/.zshrc`, then
  `chezmoi apply`. If a live file drifted, `chezmoi add <path>` first.
- **Check which side of a drift is newer before reconciling.** `chezmoi status` shows
  that something differs, not who is right. Diff both ways and read the change before
  picking a direction. Syncing the wrong way silently discards the user's edits.
- **Filename prefixes are behavior.** `dot_`, `private_`, `run_once_`, `run_onchange_`,
  `symlink_`, `empty_`, `executable_` all mean something. Don't rename to make things
  "tidy" without understanding them.
- **Unignored files land in `$HOME`.** Any repo-only file (docs, CI, notes) must go in
  `.chezmoiignore` or chezmoi will install it into the home directory.
- **`sudo` isn't passwordless here.** Anything needing apt or chsh belongs in a
  bootstrap script, run interactively during `chezmoi apply`, not run by the agent.
- **A tool the user has isn't a tool a new machine has.** Before relying on a binary in
  a script or hook, confirm it is installed by `10-install-packages` or the Brewfile.
  Several outages here were a helper that only existed on the original machine.

## Philosophy

- Keep the source tree clean and accurately named. Prefer correct structure over the
  quick patch. The user cares about this.
- Bootstrap scripts must be idempotent and no-op gracefully off-target (non-apt).
  Choose `run_once_` vs `run_onchange_` by whether re-running on change is desired.
- Verify before claiming done: `chezmoi verify`, plus a syntax or parse check for
  whatever you touched (`zsh -n`, `sh -n`, etc.). For anything a fresh machine runs,
  test the cold path by removing the artifact and re-running the script.
