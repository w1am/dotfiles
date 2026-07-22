#!/usr/bin/env bash
set -uo pipefail

TTS="$HOME/.claude/bin/claude-tts"
LOCKFILE="/tmp/cc-tts-$(id -u).lock"

[ -x "$TTS" ] || exit 0

payload=$(cat)
[ -n "${payload// /}" ] || exit 0

setsid bash -c '
  exec 9>"$3"
  flock -n 9 || exit 0
  printf "%s" "$2" | exec "$1" speak
' _ "$TTS" "$payload" "$LOCKFILE" >/dev/null 2>&1 < /dev/null &

exit 0
