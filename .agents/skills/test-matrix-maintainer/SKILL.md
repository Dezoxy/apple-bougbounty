---
name: test-matrix-maintainer
description: Use when adding or revising supported-flow dynamic tests in test-matrix.md.
---

# Test Matrix Maintainer

## Workflow

1. Add only Apple-supported or explicitly authorized test flows.
2. Keep each test to one action and one expected result.
3. State preconditions precisely: device state, iOS build, network, tool, and account ownership state.
4. Define stop conditions for unexpected security-boundary behavior.
5. Link evidence IDs after a test is run.

## Allowed Test Types

- power-on to Activation Lock baseline
- Finder update or restore
- recovery-mode restore
- Apple Configurator restore
- latest public iOS comparison
- public beta comparison when accepted
- SRD-only instrumentation plan when authorized

## Boundary

Do not add bypass steps, unlock tools, activation service spoofing, credential attacks, or instructions to defeat Activation Lock.

