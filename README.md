# dotfiles

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## New machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply w1am
```

This installs everything and applies the configs. During the run, `gh auth login`
prompts you to authenticate with GitHub (over HTTPS — no SSH key to set up); after
it finishes, open a new terminal.

## What's inside

- **zsh** + Oh My Zsh, **tmux**, **Neovim**
- Toolchains: **Node** (via fnm), **pnpm**, **bun**, **Rust**
- Apps: **VS Code**, **GitHub CLI**, **Claude Code**

## Daily use

```sh
chezmoi edit ~/.zshrc   # edit a config
chezmoi apply           # apply changes locally
update                  # commit + push to GitHub
```
