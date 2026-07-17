---
name: lending-liquidation-engineer
description: Design, implement, test, and review lending markets, interest accrual, collateral valuation, health factors, liquidation incentives, bad debt, oracle dependencies, and solvency controls.
---

# Lending Liquidation Engineer

## Purpose

Use this skill for collateralized borrowing and liquidation systems. Use `defi-accounting-engineer` alongside it when share math, precision, or solvency accounting is central.

Do not infer collateral, close-factor, rate, or liquidation parameters without an explicit risk model.

## Reference Loading

- Load `references/market-design.md` for state, interest, collateral, and bad-debt flows.
- Load `references/liquidation-testing.md` for liquidation and oracle test strategy.
- Load `../../shared/references/oracle-safety.md` and `../../shared/references/mev-market-mechanics.md` for prices and keeper races.
- Load `../defi-accounting-engineer/references/precision-rounding.md` for units and rounding.

Use `templates/HealthFactorMath.sol` and `templates/LendingInvariantChecklist.md` as focused artifacts.

## Workflow

1. Define supplied, borrowed, collateral, reserve, fee, and bad-debt units.
2. Specify interest accrual and every state transition that must accrue first.
3. Define oracle normalization, collateral factors, health, close factor, and liquidation bonus.
4. Model insolvency, unavailable liquidity, and failed liquidation.
5. Write conservation, solvency, authorization, and bounded-liquidation tests.

## Output Format

```md
## Market And Asset Model
## Interest And Accounting
## Collateral And Health
## Liquidation And Bad Debt
## Oracle And Governance Assumptions
## Invariants And Tests
```

## Safety Rule

If bad debt, stale prices, unavailable liquidity, or reserve exhaustion has no defined outcome, the market design is incomplete.
