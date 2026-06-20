#!/usr/bin/env python3
"""PreToolUse hook: route sudo through a native GUI askpass helper.

Claude Code's Bash tool has no interactive tty, so `sudo` normally fails with
"a terminal is required to read the password". This hook rewrites any
command-position `sudo` into `SUDO_ASKPASS=<helper> sudo -A ...`, so sudo asks
for the password via the GUI helper instead of a tty.

It does NOT set permissionDecision, so Claude Code's normal permission prompt
for the (rewritten) command still applies.
"""
import json
import os
import re
import sys

HELPER = os.path.expanduser("~/.claude/bin/sudo-askpass.sh")

# `sudo` only when it starts a command: at the very start, or right after a
# shell separator/opening paren. Avoids matching `sudo` inside strings/args.
SUDO_AT_CMD = re.compile(r"(^|[\n;&|(]\s*)\bsudo\b")


def shquote(s):
    return "'" + s.replace("'", "'\\''") + "'"


def rewrite(cmd):
    changed = False

    def repl(m):
        nonlocal changed
        following = re.split(r"[\n;&|]", cmd[m.end():], maxsplit=1)[0]
        # leave alone if the user already chose askpass (-A) or no-prompt (-n)
        if re.search(r"(^|\s)-A(\s|$)", following) or re.search(r"(^|\s)-n(\s|$)", following):
            return m.group(0)
        changed = True
        return f"{m.group(1)}SUDO_ASKPASS={shquote(HELPER)} sudo -A"

    new = SUDO_AT_CMD.sub(repl, cmd)
    return new if changed else None


def main():
    try:
        data = json.load(sys.stdin)
    except Exception:
        return
    if data.get("tool_name") != "Bash":
        return
    tool_input = data.get("tool_input") or {}
    cmd = tool_input.get("command")
    if not isinstance(cmd, str) or "sudo" not in cmd:
        return

    new = rewrite(cmd)
    if new is None:
        return

    json.dump({
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "updatedInput": {**tool_input, "command": new},
            "additionalContext": "sudo rewritten to prompt for the password via the native GUI askpass helper.",
        }
    }, sys.stdout)


if __name__ == "__main__":
    main()
