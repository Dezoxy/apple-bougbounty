#!/usr/bin/env bash
# Verify evidence integrity against a previously generated SHA256SUMS.txt.
# Run from the repository root. Usage: ./scripts/verify-hashes.sh [target-dir]
set -euo pipefail

target="${1:-evidence}"
sums="$target/SHA256SUMS.txt"

if [[ ! -f "$sums" ]]; then
  echo "error: no checksum file at $sums (run ./scripts/hash-artifacts.sh $target first)" >&2
  exit 1
fi

if [[ ! -s "$sums" ]]; then
  echo "no hashes recorded in $sums; nothing to verify"
  exit 0
fi

# hash-artifacts.sh records paths relative to the repository root.
if shasum -a 256 -c "$sums"; then
  echo "all artifacts match $sums"
else
  echo "integrity check FAILED against $sums" >&2
  exit 1
fi
