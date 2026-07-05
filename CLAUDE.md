# CLAUDE.md

This repository is for legitimate Apple Security Bounty research around Activation Lock behavior. Help with engineering, reverse-engineering workflow, evidence handling, and report preparation. Do not provide or automate Activation Lock bypass instructions.

## Rules

- Dynamic proof is required for any bounty claim.
- Static reverse engineering supports hypotheses and explanations only.
- Keep all work inside owned or explicitly authorized targets.
- Do not add unlock tools, credential attacks, activation server spoofing, phishing, brute force, or bypass recipes.
- Preserve evidence provenance and hashes.
- Keep diffs small and reviewable.

## Before Acting

1. Inspect `git status -sb`.
2. Read relevant files before editing.
3. Use existing scripts and templates.
4. If the request asks for bypass instructions, refuse that part and offer safe research alternatives.

## Preferred Checks

```bash
./scripts/check-tools.sh
./scripts/safety-scan.sh
./scripts/check-evidence-names.sh
```

## Safe Research Outputs

- IPSW inventories.
- Static notes and component maps.
- Supported-flow test plans.
- Evidence indexes and hashes.
- Apple-style report drafts.
- SRD-ready dynamic instrumentation plans.

## Unsafe Outputs

- Activation Lock bypass procedures.
- Unlock automation.
- Credential interception.
- Apple activation service impersonation.
- Instructions to activate a locked device without valid owner authentication.

