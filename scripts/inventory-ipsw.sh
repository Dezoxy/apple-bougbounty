#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 path/to/file.ipsw" >&2
  exit 2
fi

ipsw="$1"

if [[ ! -f "$ipsw" ]]; then
  echo "error: file not found: $ipsw" >&2
  exit 1
fi

case "$ipsw" in
  *.ipsw) ;;
  *)
    echo "error: expected an .ipsw file" >&2
    exit 1
    ;;
esac

base="$(basename "$ipsw" .ipsw)"
outdir="research/ipsw-inventory/$base"
mkdir -p "$outdir"

shasum -a 256 "$ipsw" > "$outdir/SHA256SUMS.txt"
unzip -l "$ipsw" > "$outdir/zip-list.txt"

if unzip -p "$ipsw" BuildManifest.plist > "$outdir/BuildManifest.plist" 2>/dev/null; then
  if command -v plutil >/dev/null 2>&1; then
    plutil -convert json -o "$outdir/BuildManifest.json" "$outdir/BuildManifest.plist" 2>/dev/null || true
  fi
fi

if unzip -p "$ipsw" Restore.plist > "$outdir/Restore.plist" 2>/dev/null; then
  if command -v plutil >/dev/null 2>&1; then
    plutil -convert json -o "$outdir/Restore.json" "$outdir/Restore.plist" 2>/dev/null || true
  fi
fi

{
  echo "# IPSW Inventory"
  echo
  echo "Source: $ipsw"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo
  echo "## Files"
  echo
  sed -n '1,80p' "$outdir/zip-list.txt"
} > "$outdir/README.md"

echo "wrote $outdir"

