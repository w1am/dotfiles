from __future__ import annotations

import shutil
import subprocess
from pathlib import Path

PLAYERS = (
    ("mpv", ["--really-quiet", "--no-video", "--no-terminal"]),
    ("afplay", []),
    ("ffplay", ["-nodisp", "-autoexit", "-loglevel", "quiet"]),
    ("paplay", []),
    ("aplay", ["-q"]),
)


def player() -> tuple[str, list[str]] | None:
    for command, flags in PLAYERS:
        if path := shutil.which(command):
            return path, flags
    return None


def play(path: Path) -> None:
    found = player()
    if not found:
        raise RuntimeError(f"no audio player found, tried: {', '.join(p for p, _ in PLAYERS)}")
    command, flags = found
    subprocess.run([command, *flags, str(path)], check=False,
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
