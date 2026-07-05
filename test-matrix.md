# Activation Lock Test Matrix

Run only Apple-supported flows. Record video from before the action starts until the final visible device state.

| ID | Test | Tool | Preconditions | Expected Result | Actual Result | Evidence | Repeatable |
| --- | --- | --- | --- | --- | --- | --- | --- |
| AL-001 | Power on to Activation Lock | Device only | Device erased or at Setup Assistant | Activation Lock appears and requests owner authentication | | | |
| AL-002 | Finder update | Finder | Device connected to Mac | Device updates and keeps Activation Lock state | | | |
| AL-003 | Finder restore | Finder | Device connected to Mac | Device restores and keeps Activation Lock state | | | |
| AL-004 | Recovery restore | Finder | Device placed in recovery mode | Device restores and keeps Activation Lock state | | | |
| AL-005 | Configurator restore | Apple Configurator | Device connected to Mac | Device restores and keeps Activation Lock state | | | |
| AL-006 | Latest public iOS baseline | Finder or Configurator | Latest public iOS available | Activation Lock behavior matches expected state | | | |
| AL-007 | Public beta comparison | Finder or Configurator | Public beta profile available and accepted risk | No security boundary regression versus stable | | | |

## Stop Conditions

Stop and write a finding draft if a supported flow causes any of these:

- Device becomes usable without valid owner authentication.
- Setup Assistant exposes private data before authentication.
- Activation Lock state disappears unexpectedly.
- Device/account ownership state becomes inconsistent in a repeatable way.
- Any privacy-sensitive data appears in logs, UI, backups, or diagnostics before authentication.

Do not continue trying to expand the behavior into a bypass. Preserve evidence and draft the report.

