#!/usr/bin/env bash
set -euo pipefail

status=0

while IFS= read -r -d '' file; do
  name="$(basename "$file")"

  case "$name" in
    .gitkeep|SHA256SUMS.txt)
      continue
      ;;
  esac

  if [[ ! "$name" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-test-[0-9]{3}-[a-z0-9][a-z0-9-]*\.[A-Za-z0-9]+$ ]]; then
    echo "bad evidence filename: $file"
    status=1
  fi
done < <(find evidence -type f -print0)

exit "$status"

