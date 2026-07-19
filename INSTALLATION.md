# Installation

Bootstrap a new machine from this repo. Written for an agent driving the install with
a human on hand to answer prompts.

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply w1am
```

`curl` is the only prerequisite. chezmoi vendors git, so the source repo clones without
a system git.

## It blocks on a human four times

Run this in a foreground terminal the user can see and type into. Piping it,
backgrounding it, or running it with stdin closed will hang or fail partway, leaving a
half-provisioned machine.

| Step | Wants | Notes |
|------|-------|-------|
| `10-install-packages` | sudo password | also `40`, `41`, `43` |
| `20-set-default-shell` | sudo password | `chsh` to zsh |
| `30-setup-github-auth` | browser device flow | `gh auth login --web`, cannot be scripted |
| `43-install-apps` | sudo password | adds docker, third-party apt sources |

If you have no TTY, hand the command to the user and wait rather than trying to
automate around the prompts. Everything is idempotent, so re-running after a failure
resumes cleanly.

## What it installs beyond dotfiles

On Debian this is not a minimal set. Confirm the user wants it on a laptop:

- **cockpit**, a web server-admin UI on port 9090
- **samba** for file sharing
- **docker**, plus the user added to the `docker` group
- ~338MB speech model, downloaded once

## Order

`before_` scripts, then files and externals, then `after_` scripts. Within each phase,
numeric order, regardless of `run_once_` vs `run_onchange_`.

```
before  10 packages · 20 mise · 21 claude-code · 40 cockpit · 41 samba · 43 apps · 50 brew
files   dotfiles, externals (oh-my-zsh, fonts, speech model)
after   20 shell · 30 github · 45 mise · 48 claude settings · 49 speech · 50-56 desktop
```

## Verify

```sh
chezmoi doctor | grep -v '^ok'   # health, hardlink and version warnings are benign
chezmoi status                   # empty means target matches source
claude-tts doctor                # speech engines, resolved config, credits
gh auth status                   # token for push, this remote is HTTPS
exec zsh                         # shell change needs a new session
```

`claude-tts doctor` should report a chain and a player. No player means audio silently
never plays, which is the one failure with no visible symptom.

## Platform

| | Debian/Ubuntu | macOS | Other |
|---|---|---|---|
| packages | apt | Brewfile | skipped, warns |
| speech | full | full | works if mpv or ffmpeg present |
| sudo askpass helper | zenity | **unsupported** | unsupported |

Non-apt systems skip package installs and continue. Dotfiles, speech, and runtimes
still land.

## Per-machine, never synced

Secrets stay off the repo by design. After bootstrap:

- **GitHub**, handled by `30-setup-github-auth`, token lives in the keyring
- **ElevenLabs**, optional, speech falls back to the local engine without it

```sh
umask 077 && printf '%s' 'sk_...' > ~/.claude/.elevenlabs-key
```

## Speech

Claude Code replies are read aloud by a Stop hook. Three engines in a fallback chain:
ElevenLabs if a key is present, then Kokoro locally, then edge-tts. Bootstrap installs
everything the local engine needs, so this works offline and unmetered out of the box.

```sh
claude-tts voices -e kokoro -g british   # -u hides plan-gated voices
claude-tts audition -e kokoro bm_daniel  # hear one before committing
claude-tts say -v "test"                 # -e pins an engine, -v names the one used
CC_TTS_DEBUG=1                           # log which engine ran, to ~/.claude/tts.log
```

Adding an engine is one file in `~/.claude/tts/providers/` implementing `check` and
`synthesize`. It is discovered automatically and works everywhere the others do.

## Afterwards

```sh
chezmoi edit ~/.zshrc
chezmoi apply
update                           # add -A, commit, push
```

Editing rules, prefix meanings, and the secrets policy are in `CLAUDE.md` at the repo
root. Read it before changing anything here.
