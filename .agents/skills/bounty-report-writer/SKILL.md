---
name: bounty-report-writer
description: Use when drafting or reviewing an Apple Security Bounty style report from verified observations.
---

# Bounty Report Writer

## Workflow

1. Start from `report-template.md`.
2. Use only verified observations and evidence IDs.
3. Separate expected behavior from actual behavior.
4. State impact as a crossed security boundary.
5. Include exact versions, build numbers, devices, and reproducibility counts.
6. Mark speculative static-analysis notes as hypotheses, not proof.

## Minimum Finding Standard

- exact starting state
- repeatable action or condition
- unexpected actual result
- clear security impact
- evidence reference and hash

## Boundary

Do not include public exploit details, bypass recipes, credentials, or instructions that help unauthorized activation.

