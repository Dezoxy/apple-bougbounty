#!/usr/bin/env bash
set -euo pipefail

check_cmd() {
  local name="$1"
  local cmd="$2"

  if command -v "$cmd" >/dev/null 2>&1; then
    printf "OK   %-22s %s\n" "$name" "$(command -v "$cmd")"
  else
    printf "MISS %-22s %s\n" "$name" "$cmd"
  fi
}

check_brew_formula() {
  local formula="$1"

  if brew list --formula "$formula" >/dev/null 2>&1; then
    printf "OK   brew formula         %s\n" "$formula"
  else
    printf "MISS brew formula         %s\n" "$formula"
  fi
}

check_brew_cask() {
  local cask="$1"

  if brew list --cask "$cask" >/dev/null 2>&1; then
    printf "OK   brew cask            %s\n" "$cask"
  else
    printf "MISS brew cask            %s\n" "$cask"
  fi
}

echo "Command checks"
check_cmd "git" "git"
check_cmd "jq" "jq"
check_cmd "exiftool" "exiftool"
check_cmd "ideviceinfo" "ideviceinfo"
check_cmd "idevicesyslog" "idevicesyslog"
check_cmd "radare2" "r2"
check_cmd "binwalk" "binwalk"
check_cmd "frida" "frida"

echo
echo "Homebrew formula checks"
check_brew_formula "jq"
check_brew_formula "exiftool"
check_brew_formula "libimobiledevice"
check_brew_formula "radare2"
check_brew_formula "binwalk"

echo
echo "Homebrew cask checks"
check_brew_cask "ghidra"
check_brew_cask "hex-fiend"
check_brew_cask "wireshark"

echo
echo "Suggested default install"
echo "brew install jq exiftool libimobiledevice radare2 binwalk"
echo "brew install --cask ghidra hex-fiend"
