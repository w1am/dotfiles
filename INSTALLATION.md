# Installation

New machine, one command. Needs only `curl`:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply w1am
```

chezmoi clones the repo (builtin git, no system git needed), applies dotfiles, and runs
provisioning scripts in two phases: `before_` installs system packages and tools,
`after_` installs language runtimes via mise and configures the environment.

Language runtimes are declared in `~/.config/mise/config.toml` — edit that file to
add or bump versions.

Edit a config, apply it, push it:

```sh
chezmoi edit ~/.zshrc
chezmoi apply
update
```
