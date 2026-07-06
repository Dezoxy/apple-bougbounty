#!/usr/bin/env bash
# One entrypoint for the repository's safety and hygiene checks.
# Run before committing or opening a PR.
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

run() {
  echo "==> $1"
  shift
  "$@"
}

run "safety-scan"          ./scripts/safety-scan.sh
run "check-evidence-names" ./scripts/check-evidence-names.sh
run "check-agents-sync"    ./scripts/check-agents-sync.sh

if command -v shellcheck >/dev/null 2>&1; then
  run "shellcheck" shellcheck scripts/*.sh scripts/hooks/*.sh .githooks/pre-commit
else
  echo "==> shellcheck not installed, skipping"
fi

echo "all preflight checks passed"
