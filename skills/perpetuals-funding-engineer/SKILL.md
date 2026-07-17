---
name: perpetuals-funding-engineer
description: Design, implement, test, and review perpetual markets, margin, PnL, funding rates, liquidations, bankruptcy, ADL, oracle latency, keeper behavior, and solvency.
---

# Perpetuals Funding Engineer

## Purpose

Use this skill for leveraged perpetual futures and margin engines. Pair it with `defi-accounting-engineer` for precision and conservation modeling.

Do not choose leverage, funding, spread, liquidation, or insurance parameters without a risk model and market-liquidity assumptions.

## Reference Loading

- Load `references/margin-funding.md` for positions, PnL, funding, and fees.
- Load `references/liquidation-solvency.md` for bankruptcy, ADL, keepers, and stress tests.
- Load `../../shared/references/oracle-safety.md` and `../../shared/references/mev-market-mechanics.md` for execution and price risk.
- Load `../defi-accounting-engineer/references/precision-rounding.md` for signed arithmetic and rounding.

Use `templates/FundingRateMath.sol` and `templates/PerpetualsInvariantChecklist.md` as focused artifacts.

## Workflow

1. Define collateral, position size, entry price, mark price, index price, funding index, PnL, and fees with units.
2. Specify increase, decrease, flip, settle, liquidate, and close transitions.
3. Define funding rate bounds, update cadence, oracle choice, and keeper authority.
4. Model bankruptcy price, insurance use, ADL or socialized loss, and unavailable liquidity.
5. Test signed arithmetic, delayed updates, ordering, liquidation races, and system solvency.

## Output Format

```md
## Market And Margin Model
## Position And PnL Accounting
## Funding And Fees
## Liquidation, Bankruptcy, And ADL
## Oracle, Keeper, And MEV Risks
## Invariants And Stress Tests
```

## Safety Rule

If bankruptcy loss allocation or oracle latency is undefined, the market cannot make a credible solvency claim.
