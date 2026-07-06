#!/usr/bin/env bash
set -euo pipefail

status=0

if [[ ! -e "AGENTS.md" ]]; then
  echo "error: run from repository root" >&2
  exit 2
fi

# Emit the null-delimited list of text files to scan. Prefer tracked files so
# gitignored private notes and evidence are never scanned; fall back to find.
# safety-scan.sh and guard-write.sh are skipped because they contain the banned
# phrases as detection strings, not as content.
list_files() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git ls-files -z -- '*.md' '*.sh' \
      ':(exclude)scripts/safety-scan.sh' \
      ':(exclude)scripts/hooks/guard-write.sh'
  else
    find . -type f \( -name '*.md' -o -name '*.sh' \) \
      -not -path './.git/*' \
      -not -path './evidence/*' \
      -not -path './logs/*' \
      -not -path './research/ipsw-inventory/*' \
      -not -path './scripts/safety-scan.sh' \
      -not -path './scripts/hooks/guard-write.sh' \
      -print0 2>/dev/null
  fi
}

pattern='(activation server spoof|credential capture|phishing|brute force|paid unlock|unlock automation|bypass recipe|defeat Activation Lock)'
allow_context='(not allowed|do not|must not|never|blocked|boundary|unsafe|out of scope|refuse|prohibited|forbid|does not|without adding|avoid)'
safe_heading='^(#+[[:space:]]*)?(not allowed|unsafe outputs|blocked|boundary|out of scope|unsafe|scope and safety)'
# Interrogative checklist lines ("- Does it include phishing...?") legitimately
# enumerate prohibitions; treat a leading "does it" as safe context.
question_context='^([[:space:]]*[-*][[:space:]]+)?does it '

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
      if [[ "$safe_section" -eq 1 || "$lower" =~ $allow_context || "$lower" =~ $question_context ]]; then
        continue
      fi

      echo "safety review needed: $file:$line_no:$line"
      status=1
    fi
  done < "$file"
done < <(list_files)

exit "$status"
