#!/usr/bin/env bash
# PreToolUse guard: block a Write/Edit that would introduce Activation Lock
# bypass or credential-attack material into a research/output file.
#
# Policy and documentation files legitimately quote the banned vocabulary in a
# "do not do X" context, so they are exempt here; the full safety-scan.sh (run
# by the pre-commit hook, CI, and the PostToolUse hook) still covers them.
#
# Fails open (exit 0) when jq is unavailable or no content is present: this is
# defense-in-depth, not the only gate.
set -euo pipefail

command -v jq >/dev/null 2>&1 || exit 0

payload="$(cat)"
# Fail open on malformed JSON (real hook payloads are always valid): a parse
# error must not block legitimate edits. Covers Write (.content), Edit
# (.new_string), and MultiEdit (.edits[].new_string).
path="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty' 2>/dev/null || true)"
content="$(printf '%s' "$payload" | jq -r '
  .tool_input.content
  // .tool_input.new_string
  // ([.tool_input.edits[]?.new_string] | join("\n"))
  // empty' 2>/dev/null || true)"

[[ -z "$content" ]] && exit 0

# Exempt policy/documentation/config sources that must describe prohibitions.
case "$path" in
  */AGENTS.md|*/CLAUDE.md|*/README.md|*/software-lab.md|*/test-matrix.md) exit 0 ;;
  */.claude/*|*/.agents/*|*/scripts/*|*/.githooks/*|*/.github/*) exit 0 ;;
esac

pattern='activation lock bypass|unlock automation|bypass recipe|credential (capture|interception)|activation server spoof|defeat activation lock|brute[- ]force'

if printf '%s' "$content" | grep -Eiq "$pattern"; then
  echo "BLOCKED by repo safety policy: proposed content for ${path:-this file} matches prohibited Activation Lock bypass / credential-attack material." >&2
  echo "If this is legitimate 'do not do X' policy text, place it in a policy doc (AGENTS.md / CLAUDE.md / README.md) instead." >&2
  exit 2
fi

exit 0
