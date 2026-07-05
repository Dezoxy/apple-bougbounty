#!/usr/bin/env bash
set -euo pipefail

target="${1:-evidence}"
output="${2:-}"

if [[ ! -d "$target" ]]; then
  echo "error: target directory does not exist: $target" >&2
  exit 1
fi

if [[ -z "$output" ]]; then
  output="$target/SHA256SUMS.txt"
fi

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

find "$target" -type f \
  ! -name 'SHA256SUMS.txt' \
  ! -name '.gitkeep' \
  -print0 \
  | sort -z \
  | xargs -0 shasum -a 256 > "$tmp" || true

if [[ ! -s "$tmp" ]]; then
  echo "no artifacts found under $target"
  : > "$output"
  exit 0
fi

mv "$tmp" "$output"
echo "wrote $output"

