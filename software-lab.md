# Software Lab

This lab is for legitimate Apple Security Bounty research around Activation Lock behavior. It supports static analysis, evidence collection, and authorized dynamic analysis. It must not be used to unlock devices, attack Apple Accounts, spoof Apple services, or bypass Activation Lock.

For an Activation Lock bounty claim, dynamic evidence is required. Static reverse engineering can explain why a behavior might exist, but it is not proof by itself. A credible report needs repeatable behavior on a real affected build, captured through video, notes, logs where available, and exact expected-versus-actual results.

## Tooling Tiers

### Tier 1 - Required Evidence Tools

These tools support reproducible documentation and device-state evidence.

```bash
brew install jq exiftool libimobiledevice
```

Apple apps:

- Finder
- Apple Configurator
- Console.app
- QuickTime Player

Use this tier to record:

- device identifiers
- exact iOS version/build when visible
- restore/update flow
- Activation Lock screen behavior
- logs available without bypassing trust or authentication
- evidence hashes

### Tier 2 - Static Reverse Engineering

These tools help inspect public firmware, binaries, strings, plists, and Mach-O metadata.

```bash
brew install --cask ghidra hex-fiend
brew install radare2 binwalk
```

Recommended use:

- inspect public IPSW contents
- inspect Mach-O headers and metadata
- compare strings/configuration between versions
- document likely components and state machines
- build hypotheses for Apple-supported tests

Static analysis output should feed `test-matrix.md`. It should not be treated as a finding unless dynamic testing proves a security boundary failure.

Do not modify firmware, bypass signing, or publish exploit details.

### Tier 3 - Network Observation

These tools support high-level traffic observation.

```bash
brew install --cask wireshark
```

Allowed use:

- connection timing
- DNS names
- destination IPs
- packet counts
- failure timing

Do not intercept Apple credentials, install hostile certificates, bypass TLS protections, or impersonate Apple activation services.

### Tier 4 - Dynamic Instrumentation

Dynamic instrumentation on iOS system components requires a legitimate research target, usually an Apple Security Research Device or another explicitly authorized lab device.

```bash
python3 -m pip install --user frida-tools
```

Use only where authorized:

- your own apps
- lab apps
- Security Research Device workflows
- approved test environments

Do not use dynamic tools to produce or automate an Activation Lock bypass. On a normal locked production iPhone, expect system-level dynamic instrumentation to be blocked; that is part of the platform security model, not a lab setup problem.

## Proof Strategy

Use three layers, in this order:

1. Dynamic black-box testing as primary proof.
2. Static reverse engineering as support for hypotheses and report explanation.
3. SRD-based or otherwise authorized dynamic instrumentation only when the research target supports it.

Black-box dynamic tests are the default for this device:

- power-on to Activation Lock baseline
- Finder update or restore
- recovery-mode restore
- Apple Configurator restore
- latest public iOS comparison
- public beta comparison when acceptable

The expected result for these flows is that Activation Lock remains enforced. A bounty lead starts only if a supported flow creates repeatable unexpected behavior, such as exposed private data, incorrect ownership state, or setup completion without valid owner authentication.

## Recommended Default Install

For this project, install Tier 1 and Tier 2 first, then use them to support dynamic black-box tests:

```bash
brew install jq exiftool libimobiledevice radare2 binwalk
brew install --cask ghidra hex-fiend
```

Install Wireshark only when we need network timing evidence:

```bash
brew install --cask wireshark
```

Delay Frida until there is an authorized dynamic target, ideally an Apple Security Research Device:

```bash
python3 -m pip install --user frida-tools
```

## Research Workflow

1. Verify the exact iOS build.
2. Record baseline Activation Lock behavior.
3. Collect supported-flow evidence using Finder and Apple Configurator.
4. Use static analysis to understand likely components and version differences.
5. Turn hypotheses into safe tests in `test-matrix.md`.
6. Write findings in `report-template.md` only when a real security boundary is crossed.

## Sources

- Apple Security Bounty: https://security.apple.com/bounty/
- Apple Security Research Device Program: https://security.apple.com/research-device/
- Ghidra: https://github.com/NationalSecurityAgency/ghidra
- Frida iOS documentation: https://frida.re/docs/ios/
