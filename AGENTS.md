# Agent instructions

This repo is a **chezmoi source directory** (`~/.local/share/chezmoi`) managing the
user's dotfiles. `CLAUDE.md` and `README.md` symlink here. Read the tree to learn the
specifics — this file is only the rules for operating it.

## Rules

- **Never commit secrets.** No private keys, tokens, or credentials — SSH keys are
  per-machine and generated at bootstrap, never synced.
- **Edit the source, never the target.** Change `dot_zshrc`, not `~/.zshrc`; then
  `chezmoi apply`. If a live file drifted, `chezmoi add <path>` first.
- **Filename prefixes are behavior.** `dot_`, `private_`, `run_once_`, `run_onchange_`
  all mean something — don't rename to make things "tidy" without understanding them.
- **Unignored files land in `$HOME`.** Any repo-only file (docs, CI, notes) must go in
  `.chezmoiignore` or chezmoi will install it into the home directory.
- **`sudo` isn't passwordless here.** Anything needing apt/chsh belongs in a bootstrap
  script (run interactively during `chezmoi apply`), not run directly by the agent.

## Philosophy

- Keep the source tree clean and accurately named; prefer correct structure over the
  quick patch. The user cares about this.
- Bootstrap scripts must be idempotent and no-op gracefully off-target (non-apt).
  Choose `run_once_` vs `run_onchange_` by whether re-running on change is desired.
- Verify before claiming done: `chezmoi verify`, plus a syntax/parse check for whatever
  you touched (`zsh -n`, `sh -n`, etc.).
