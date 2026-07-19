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

## Speech

Claude Code replies are read aloud by a Stop hook. Bootstrap installs everything the
local engine needs, including a ~338MB voice model, so speech works with no account
and no per-reply network calls.

ElevenLabs is preferred when a key is present. Keys are per-machine and never synced,
matching the GitHub auth approach:

```sh
umask 077 && printf '%s' 'sk_...' > ~/.claude/.elevenlabs-key
```

Inspect and drive it with `claude-tts`:

```sh
claude-tts doctor                        # engine status, resolved config, credits left
claude-tts voices -e kokoro -g british   # -u hides plan-gated voices
claude-tts audition -e kokoro bm_daniel  # hear one before committing to it
claude-tts say -v "test"                 # -e pins an engine, -v names the one used
```

Adding an engine means one file in `~/.claude/tts/providers/` implementing `check`
and `synthesize`. It is discovered automatically and works everywhere the others do.

Edit a config, apply it, push it:

```sh
chezmoi edit ~/.zshrc
chezmoi apply
update
```
