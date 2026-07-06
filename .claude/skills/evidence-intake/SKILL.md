---
name: evidence-intake
description: Use when adding, indexing, hashing, or reviewing evidence files for Activation Lock research.
---

# Evidence Intake

## Workflow

1. Confirm the evidence source, date, and test ID.
2. Store raw media under `evidence/` only when it is small enough and intended for git; otherwise reference the external path in `evidence-index.md`.
3. Use stable filenames: `YYYY-MM-DD-test-NNN-short-description.ext`.
4. Run `./scripts/check-evidence-names.sh`.
5. Run `./scripts/hash-artifacts.sh evidence`.
6. Update `evidence-index.md` with path, source date, hash file, and notes.

## Required Fields

- test ID
- source path
- capture date
- device/iOS build if known
- expected result
- actual result
- hash reference

## Boundary

Do not add credentials, private Apple Account details, paid unlock-service output, or bypass instructions.

