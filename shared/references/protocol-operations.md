# Protocol Operations

Use this reference for privileged execution, monitoring, emergency response, and administrative handoff.

## Operational Inventory

- Maintain a chain-scoped address book with code hashes and deployment transactions.
- Record every owner, role, guardian, timelock, Safe threshold, module, and signer responsibility.
- Separate proposer, executor, canceller, pauser, upgrader, treasury, and oracle powers where useful.
- Verify role handoffs onchain and revoke temporary deployer access.

## Safe Execution

- Decode every transaction in a batch and verify target, value, calldata, operation type, and chain ID.
- Dry-run the complete batch from the Safe address before collecting approvals.
- Record expected state changes and post-execution checks.
- Never ask signers to approve opaque calldata.

## Monitoring And Incidents

- Monitor privileged events, upgrades, pauses, oracle freshness, solvency, bridge failures, and unexpected balance changes.
- Define severity, decision authority, communication owner, and escalation paths before go-live.
- Prefer the narrowest effective response: cap, pause one function, rotate a key, or disable an integration.
- Preserve evidence and produce a blameless timeline, impact statement, root cause, remediation, and follow-up tests.
