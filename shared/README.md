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
- `references/advanced-protocols.md`: compatibility index for the focused v2 references.
- `references/signatures.md`: typed data, permits, contract wallets, delegation, and replay.
- `references/oracle-safety.md`: normalization, freshness, confidence, sequencers, and fallback policy.
- `references/cross-chain-l2.md`: messaging, finality, replay, retries, and bridge trust.
- `references/modern-evm.md`: compiler targets, transient and namespaced storage, and delegated EOAs.
- `references/reproducible-builds.md`: compiler pins, locks, bytecode comparison, and verification.
- `references/protocol-operations.md`: roles, Safe batches, monitoring, incidents, and recovery.
- `references/mev-market-mechanics.md`: ordering, slippage, auctions, solvers, and liquidation races.
- `references/mainnet-readiness.md`: review, audit, deployment, and operational readiness checks.
