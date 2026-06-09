# Example: Foundry Test Writer

## Prompt

```text
Use skills/foundry-test-writer/SKILL.md.

Add Foundry tests for this staking contract.
Cover initial state, deposits, withdrawals, claiming, unauthorized reward notification, zero amounts, multiple users, fuzzed deposit amounts, and an invariant that totalStaked equals the sum of user balances.
Consult shared/references/foundry-conventions.md and skills/foundry-test-writer/references/unit-fuzz-invariant.md.
```

## Expected Agent Behavior

- Read contract behavior before writing tests.
- Add positive and revert tests.
- Add multi-user accounting tests.
- Add fuzz and invariant coverage where useful.
- Call out implementation bugs rather than blessing them.

