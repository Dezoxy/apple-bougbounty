#!/usr/bin/env bash
# Ensure the active Claude Code agent layer (.claude/) stays in sync with the
# portable AGENTS.md mirror (.agents/). Skills must be byte-identical; every
# portable subagent must have a matching active agent (frontmatter differs, so
# only presence is checked, not content).
set -euo pipefail

status=0

# Skills: byte-identical between mirror and active copy.
for src in .agents/skills/*/SKILL.md; do
  [[ -e "$src" ]] || continue
  name="$(basename "$(dirname "$src")")"
  dst=".claude/skills/$name/SKILL.md"
  if [[ ! -f "$dst" ]]; then
    echo "missing active skill: $dst (present in mirror $src)"
    status=1
  elif ! diff -q "$src" "$dst" >/dev/null; then
    echo "skill out of sync: $src != $dst"
    status=1
  fi
done

# Subagents: every portable role must have an active agent of the same name.
for src in .agents/subagents/*.md; do
  [[ -e "$src" ]] || continue
  name="$(basename "$src")"
  dst=".claude/agents/$name"
  if [[ ! -f "$dst" ]]; then
    echo "missing active agent: $dst (present in mirror $src)"
    status=1
  fi
done

if [[ "$status" -eq 0 ]]; then
  echo "agent layer in sync"
fi

exit "$status"
