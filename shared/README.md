# Shared Solidity Skill References

This folder contains reusable guidance for the Solidity agent skill suite.

It is not a standalone skill. Do not load it by itself as a public entrypoint. Individual skills should link to the smallest relevant shared reference file.

## Files

- `references/security-posture.md`: safety defaults, forbidden patterns, and security language.
- `references/foundry-conventions.md`: Foundry project, test, and script conventions.
- `references/openzeppelin-defaults.md`: default use of OpenZeppelin primitives.
- `references/security-tooling.md`: Slither, Echidna, SMTChecker, and tool-result triage guidance.
- `references/tool-output-triage.md`: classification rules for automated tool findings.
- `references/gas-optimization.md`: gas measurement and optimization guidance.
- `references/access-management.md`: AccessManager, role-delay, admin handoff, and emergency-role guidance.
- `references/advanced-protocols.md`: signatures, oracles, account abstraction, bridges, L2s, and governance operations.
- `references/mainnet-readiness.md`: review, audit, deployment, and operational readiness checks.
