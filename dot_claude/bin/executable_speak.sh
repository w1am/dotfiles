#!/usr/bin/env bash
set -uo pipefail

PATH="$HOME/.local/bin:$PATH"
export PATH

VOICE="${CC_TTS_VOICE:-en-US-AvaMultilingualNeural}"
RATE="${CC_TTS_RATE:-+25%}"
MAX_CHARS="${CC_TTS_MAX_CHARS:-1000}"
LOCKFILE="/tmp/cc-tts-$(id -u).lock"

speakable() {
  sed -E '
    /^[[:space:]]*```/,/^[[:space:]]*```/d
    /^[[:space:]]*\|/d
    /^[[:space:]]*[─━=*_-]{3,}[[:space:]]*$/d
    /^[[:space:]]*[0-9]+\.[[:space:]]*$/d
  ' \
  | sed -E '
    s/`([^`]*)`/\1/g
    s/\[([^]]*)\]\([^)]*\)/\1/g
    s#https?://[^[:space:]]+#a link#g
    s#[^[:space:]]*/([[:alnum:]._-]+)#\1#g
    s/^[[:space:]]*[-*+][[:space:]]+//
    s/^[[:space:]]*#+[[:space:]]*//
    s/[*_#>`|]//g
  '
}

media_playing() {
  local svc status
  for svc in $(busctl --user list 2>/dev/null | awk '/^org\.mpris\.MediaPlayer2\./{print $1}'); do
    status=$(busctl --user get-property "$svc" /org/mpris/MediaPlayer2 \
      org.mpris.MediaPlayer2.Player PlaybackStatus 2>/dev/null)
    case "$status" in
      *Playing*) return 0 ;;
    esac
  done
  return 1
}

if [ -z "${CC_TTS_IGNORE_MEDIA:-}" ] && media_playing; then
  exit 0
fi

text=$(jq -r '.last_assistant_message // empty' \
  | speakable \
  | tr -s '[:space:]' ' ' \
  | head -c "$MAX_CHARS")

[ -n "${text// /}" ] || exit 0

setsid bash -c '
  exec 9>"$4"
  flock -n 9 || exit 0

  out=$(mktemp -t cc-tts-XXXXXX.mp3)
  trap "rm -f \"$out\"" EXIT

  edge-tts --voice "$2" --rate="$3" --text "$1" --write-media "$out" || exit 1
  mpv --really-quiet --no-video --no-terminal "$out"
' _ "$text" "$VOICE" "$RATE" "$LOCKFILE" >/dev/null 2>&1 < /dev/null &

exit 0
