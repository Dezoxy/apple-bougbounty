#!/usr/bin/env bash
# PostToolUse hook: after any Write/Edit, run the repo safety scanner and surface
# violations back to the agent so they are corrected before commit. This cannot
# undo the edit, but the pre-commit hook and CI remain the enforcing gates.
set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0
[[ -x ./scripts/safety-scan.sh ]] || exit 0

if ! out="$(./scripts/safety-scan.sh 2>&1)"; then
  {
    echo "safety-scan.sh flagged the repository after this edit:"
    echo "$out"
    echo "Resolve the flagged lines before committing."
  } >&2
  exit 2
fi

exit 0
