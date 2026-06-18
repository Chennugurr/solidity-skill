# Example: Gas Optimization

## Prompt

```text
Use skills/solidity-builder/SKILL.md and skills/foundry-test-writer/SKILL.md.

Review this Solidity project for gas optimization opportunities after tests pass.
Use forge snapshot to measure before/after behavior.
Consult shared/references/gas-optimization.md and avoid changes that weaken access control, accounting, or readability.
```

## Expected Agent Behavior

- Measure before optimizing.
- Prioritize hot paths and storage-heavy flows.
- Keep security and correctness ahead of gas.
- Re-run tests and snapshots after changes.
- Explain tradeoffs and any readability cost.
