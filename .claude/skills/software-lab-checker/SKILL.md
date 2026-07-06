---
name: software-lab-checker
description: Use when checking or updating local reverse-engineering and evidence tooling for this repository.
---

# Software Lab Checker

## Workflow

1. Read `software-lab.md`.
2. Run `./scripts/check-tools.sh`.
3. Report installed and missing tools.
4. Recommend the smallest install set needed for the current task.
5. Keep Frida and system-level dynamic instrumentation gated behind authorized targets.

## Default Tool Order

1. Evidence tools: `jq`, `exiftool`, `libimobiledevice`.
2. Static tools: `radare2`, `binwalk`, `ghidra`, `hex-fiend`.
3. Network observation: `wireshark`.
4. Dynamic instrumentation: only when authorized.

## Boundary

Do not install or recommend unlock tools, bypass kits, credential tooling, or Apple service spoofing tools.

