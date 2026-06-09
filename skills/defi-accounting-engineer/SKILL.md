---
name: defi-accounting-engineer
description: Design, review, and test precision-sensitive DeFi accounting for vaults, rewards, shares, fees, liquidations, solvency, and protocol invariants.
---

# DeFi Accounting Engineer

## Purpose

Use this skill for DeFi systems where math, accounting, precision, solvency, or economic invariants are central to correctness.

The goal is to make value flows explicit, choose safe rounding behavior, identify manipulation risks, and define tests and invariants that protect funds.

## When To Use

Use this skill for:

- ERC4626 vaults and share accounting.
- Staking and reward distribution math.
- Fee accrual and fee shares.
- Liquidations and collateral ratios.
- AMM, oracle, and price normalization logic.
- Precision, decimal, and rounding review.
- Solvency and conservation invariants.
- DeFi test design.

Do not use it for token branding, generic deployment, or non-financial contract logic.

## Reference Loading

Load shared references as needed:

- `../../shared/references/security-posture.md` for accounting and value-flow risks.
- `../../shared/references/openzeppelin-defaults.md` for ERC4626 and token transfer defaults.
- `../../shared/references/foundry-conventions.md` for invariant test conventions.

Load local references as needed:

- `references/precision-rounding.md` for decimal and rounding rules.
- `references/vault-reward-liquidation.md` for common DeFi accounting patterns.

Use `templates/InvariantChecklist.md` when drafting accounting checks.

## Accounting Rules

- Define units for every value.
- Normalize decimals deliberately.
- State rounding direction for every conversion.
- Avoid loops over users.
- Update reward or share indexes before balance changes.
- Ensure funded rewards can cover promised rewards.
- Use pull-based claims.
- Treat first-depositor, donation, and dust cases as adversarial.
- Write invariants before optimizing gas.

## Output Format

```md
## Accounting Model

## Units And Precision

## State Transitions

## Rounding Choices

## Invariants

## Manipulation Risks

## Tests
```

## Safety Rule

If the accounting model cannot be made solvent from the provided spec, stop and explain the missing funding, oracle, or invariant requirement.

