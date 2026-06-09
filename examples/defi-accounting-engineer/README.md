# Example: DeFi Accounting Engineer

## Prompt

```text
Use skills/defi-accounting-engineer/SKILL.md.

Review this ERC4626-style vault design.
Check share conversion rounding, first-depositor inflation, donation behavior, fee accounting, and solvency invariants.
Consult skills/defi-accounting-engineer/references/precision-rounding.md and skills/defi-accounting-engineer/references/vault-reward-liquidation.md.
```

## Expected Agent Behavior

- Define units and precision.
- State rounding direction.
- Identify manipulation risks.
- Propose invariants and tests.
- Flag missing assumptions that affect solvency.

