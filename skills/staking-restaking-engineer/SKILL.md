---
name: staking-restaking-engineer
description: Design, implement, test, and review staking and restaking systems, delegation, shares, rewards, slashing, unbonding, withdrawal queues, validator lifecycle, and operator trust.
---

# Staking Restaking Engineer

## Purpose

Use this skill for delegated stake, operator-managed services, reward distribution, slashing, and delayed withdrawals.

Do not treat receipt tokens as immediately redeemable when underlying stake is queued, locked, slashed, or dependent on external validators.

## Reference Loading

- Load `references/delegation-accounting.md` for shares, rewards, operators, and service registration.
- Load `references/slashing-withdrawals.md` for unbonding, queues, slashing, and insolvency.
- Load `../defi-accounting-engineer/references/vault-reward-liquidation.md` for share and reward indexes.
- Load `../../shared/references/protocol-operations.md` for operator and emergency controls.

Use `templates/WithdrawalQueue.sol` and `templates/RestakingInvariantChecklist.md` as focused artifacts.

## Workflow

1. Identify stake assets, receipt shares, operators, validators, services, rewards, and slashable obligations.
2. Define deposit, delegation, redelegation, reward, slash, queue, claim, and emergency transitions.
3. State when exchange rates update and who bears slash, fee, and rounding loss.
4. Define unbonding finality, withdrawal liquidity, and external service dependencies.
5. Test ordering, slashing during queue, operator compromise, reward manipulation, and insolvency.

## Output Format

```md
## Stake And Share Model
## Delegation And Operator Lifecycle
## Rewards And Fees
## Slashing And Loss Allocation
## Unbonding And Withdrawals
## Trust Assumptions, Invariants, And Tests
```

## Safety Rule

If slash timing and queued-withdrawal loss allocation are undefined, the receipt token's value and redemption promise are undefined.
