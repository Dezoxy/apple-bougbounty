#!/usr/bin/env bash
set -euo pipefail

git_root="$(git rev-parse --show-toplevel)"
git -C "$git_root" config core.hooksPath .githooks
echo "configured git hooks path: .githooks"

