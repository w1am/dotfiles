# dotfiles

My config.

New machine:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply w1am
```

Edit a config, apply it, push it:

```sh
chezmoi edit ~/.zshrc
chezmoi apply
update
```
