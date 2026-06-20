# dotfiles

My config.

New machine — one command (needs only `curl`; chezmoi's builtin git clones the repo,
then `run_*_before_` scripts install packages + mise, externals download as archives):

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply w1am
```

Language runtimes (node, rust, bun, python, uv, dotnet, neovim, awscli) are declared in
`~/.config/mise/config.toml`. Edit that file + `chezmoi apply` to add/bump versions.

Edit a config, apply it, push it:

```sh
chezmoi edit ~/.zshrc
chezmoi apply
update
```
