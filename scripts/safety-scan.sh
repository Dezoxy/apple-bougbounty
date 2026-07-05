#!/usr/bin/env bash
set -euo pipefail

status=0

if [[ ! -e "AGENTS.md" ]]; then
  echo "error: run from repository root" >&2
  exit 2
fi

pattern='(activation server spoof|credential capture|phishing|brute force|paid unlock|unlock automation|bypass recipe|defeat Activation Lock)'
allow_context='(not allowed|do not|blocked|boundary|unsafe|out of scope|must not|avoid|without adding|refuse|no |does it )'
safe_heading='^(#+[[:space:]]*)?(not allowed|unsafe outputs|blocked|boundary|out of scope|unsafe|scope and safety)'

while IFS= read -r -d '' file; do
  safe_section=0
  line_no=0

  while IFS= read -r line || [[ -n "$line" ]]; do
    line_no=$((line_no + 1))
    lower="$(printf '%s' "$line" | LC_ALL=C tr '[:upper:]' '[:lower:]')"

    if [[ "$lower" =~ ^#+[[:space:]] && ! "$lower" =~ $safe_heading ]]; then
      safe_section=0
    fi

    if [[ "$lower" =~ $safe_heading ]]; then
      safe_section=1
      continue
    fi

    if [[ "$lower" =~ $pattern ]]; then
      if [[ "$safe_section" -eq 1 || "$lower" =~ $allow_context ]]; then
        continue
      fi

      echo "safety review needed: $file:$line_no:$line"
      status=1
    fi
  done < "$file"
done < <(
  find AGENTS.md CLAUDE.md README.md software-lab.md test-matrix.md report-template.md .agents scripts research \
    -type f \
    ! -path 'scripts/safety-scan.sh' \
    -print0 2>/dev/null
)

exit "$status"
