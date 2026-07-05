# Pre-Commit Hook

Installed hook path: `.githooks/pre-commit`

## Checks

- `./scripts/safety-scan.sh`
- `./scripts/check-evidence-names.sh`

## Install

```bash
./scripts/install-hooks.sh
```

## Notes

The hook blocks obvious unsafe prompt/script additions and malformed evidence filenames. It is not a replacement for human review.

