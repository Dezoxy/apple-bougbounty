# AGENTS.md

You are working in a private Apple Security Bounty research repository for Activation Lock behavior.

The purpose is legitimate vulnerability research: build evidence, study software artifacts, plan safe tests, and prepare high-quality reports. This repository must not contain instructions, tools, or prompts that bypass Activation Lock, attack Apple Accounts, spoof Apple services, or automate unauthorized access.

## Operating Rules

- Keep changes tight and reviewable.
- Prefer scripts for repeatable checks and evidence handling.
- Treat dynamic evidence as required for any bounty claim.
- Treat static reverse engineering as hypothesis-building and explanation, not proof.
- Record provenance for every artifact: source, date, hash, and notes.
- Never commit credentials, account details, unlock-service output, or large raw evidence files.
- Do not add exploit steps, bypass workflows, credential interception, activation server spoofing, or paid unlock tooling.

## Research Boundary

Allowed:

- IPSW hashing and inventory.
- Static metadata, strings, plist, and Mach-O inspection.
- Version comparison for hypothesis generation.
- Black-box dynamic tests using supported Apple flows.
- Evidence indexing, hashing, and report drafting.
- SRD-ready instrumentation plans when the target is authorized.

Not allowed:

- Activation Lock bypass instructions.
- Unlock automation.
- Apple Account attacks.
- Phishing, brute force, or credential capture.
- Impersonating or spoofing Apple activation services.
- Jailbreak/bypass kits for locked production devices.
- Attempts to access another person's data.

## Default Workflow

1. Check current branch and diff.
2. Run `./scripts/check-tools.sh` when software-lab state matters.
3. Run `./scripts/preflight.sh` before committing (runs safety-scan, evidence-name, agent-sync, and shellcheck).
4. Commit only the files required by the task.
5. Never commit `notes.private.md` or any `*.private.md`; keep raw device identifiers out of tracked files.
6. Use a branch and draft PR for non-trivial changes.

## File Roles

- `software-lab.md`: local RE/tooling setup and proof strategy.
- `test-matrix.md`: supported-flow dynamic test plan.
- `notes.md`: device state and baseline notes.
- `evidence-index.md`: evidence provenance and references.
- `report-template.md`: Apple-style finding report template.
- `research/`: hypotheses, component map, and static notes.
- `.claude/agents/`: active Claude Code subagents (auto-discovered; carry YAML frontmatter).
- `.claude/skills/`: active Claude Code skills (auto-discovered).
- `.claude/settings.json`: permission allowlist and PreToolUse/PostToolUse safety hooks.
- `.agents/skills/`, `.agents/subagents/`: portable AGENTS.md mirror of the above; kept in sync by `scripts/check-agents-sync.sh`.
- `.githooks/`: local repository hooks.
- `notes.private.md`: gitignored raw device identifiers referenced by redacted tracked files.

## Reporting Standard

A reportable lead needs:

- exact affected device and iOS build,
- starting state,
- supported action or observed condition,
- expected result,
- actual security boundary failure,
- repeatability notes,
- evidence references and hashes.

Expected Activation Lock enforcement is not a vulnerability.

