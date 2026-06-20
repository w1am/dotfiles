# dotfiles

Fetch the agent guide and follow it:

```sh
curl -s https://raw.githubusercontent.com/w1am/dotfiles/main/CLAUDE.md
```

To bootstrap a new machine:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply w1am
```
