#!/bin/sh
set -eu

# onnxruntime has no wheels past 3.12, and uv fetches that interpreter itself,
# so the system python version is irrelevant. Editing this file re-runs it.

PYTHON_VERSION=3.12
PACKAGES="kokoro-onnx soundfile"
VENV="$HOME/.claude/tts-venv"

PATH="$HOME/.local/bin:$PATH"
export PATH

if ! command -v uv >/dev/null 2>&1; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

if ! command -v uv >/dev/null 2>&1; then
    echo "TTS: uv unavailable, skipping speech setup." >&2
    exit 0
fi

if ! command -v edge-tts >/dev/null 2>&1; then
    echo "Installing edge-tts..."
    uv tool install --quiet edge-tts
fi

echo "Building TTS environment ($PACKAGES)..."
uv venv --quiet --allow-existing --python "$PYTHON_VERSION" "$VENV"
uv pip install --quiet --python "$VENV/bin/python" $PACKAGES

if "$VENV/bin/python" -c 'import kokoro_onnx' 2>/dev/null; then
    echo "TTS: local engine ready."
else
    echo "TTS: kokoro import failed, chain will fall back to edge-tts." >&2
fi

if [ ! -s "$HOME/.claude/.elevenlabs-key" ]; then
    cat <<'MSG'

TTS: no ElevenLabs key present, so speech uses the local engine.
     To enable ElevenLabs (keys are per-machine and never synced):

       umask 077 && printf '%s' 'sk_...' > ~/.claude/.elevenlabs-key

     Then check everything with: claude-tts doctor
MSG
fi
