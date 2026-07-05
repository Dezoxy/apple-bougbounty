# Apple Activation Lock Security Research

This project is for legitimate Apple Security Bounty research around Activation Lock behavior on owned test devices.

It is not an unlock project. The goal is to find and document reproducible security defects through Apple-supported flows, then submit them privately to Apple if they are real.

## Scope

Allowed research:

- Observe Activation Lock and Setup Assistant behavior on owned hardware.
- Test normal Finder restore/update flows.
- Test normal Apple Configurator restore/prepare flows.
- Compare latest public iOS and public beta behavior.
- Document inconsistent device/account/activation states.
- Record evidence for unexpected behavior.

Out of scope:

- Bypass instructions.
- Credential guessing, phishing, or Apple Account abuse.
- Paid unlock services or third-party bypass tools.
- Activation server spoofing or production service abuse.
- Stolen-device workflows.
- Any attempt to access another person's data or account.

## Useful Official Links

- Apple Security Bounty: https://security.apple.com/bounty/
- Guidelines: https://security.apple.com/bounty/guidelines/
- Categories: https://security.apple.com/bounty/categories/
- Security Research Device Program: https://security.apple.com/research-device/

## Research Flow

1. Record the current device state.
2. Build a clean baseline using normal Apple-supported flows.
3. Run one test at a time.
4. Save video/photo/log evidence with stable filenames.
5. Hash important evidence files.
6. Only write a bounty report if behavior crosses a real security boundary.

## Evidence Naming

Use names like:

```text
evidence/2026-07-05-test-001-power-on-to-activation-lock.mov
evidence/2026-07-05-test-002-finder-restore-result.mov
evidence/2026-07-05-test-003-configurator-restore-result.mov
```

After saving evidence:

```bash
shasum -a 256 evidence/* > evidence/SHA256SUMS.txt
```

## Bounty-Worthy Signals

Potentially reportable examples:

- Activation Lock disappears after a normal supported flow without valid owner authentication.
- Setup Assistant exposes private data before authentication.
- Device activation state becomes inconsistent with Apple Account ownership state.
- A supported MDM/ABM flow breaks an ownership boundary, only if the organization account is controlled by you.
- A restore/setup path causes repeatable privacy or security impact.

Expected behavior is not a bug. If every official restore path returns to Activation Lock, that is normal.

