---
name: stablecoin-engineer
description: Design, implement, test, and review stablecoin systems including collateral models, mint and redemption controls, peg mechanisms, reserves, liquidations, shutdown, and governance risk.
---

# Stablecoin Engineer

## Purpose

Use this skill when a token promises stable value, redemption, collateral backing, or monetary controls.

Do not describe price stability, backing, or redemption as guaranteed. Separate contract behavior from offchain reserve and market assumptions.

## Reference Loading

- Load `references/stability-models.md` for issuance, collateral, reserves, and peg mechanisms.
- Load `references/failure-and-shutdown.md` for depeg, insolvency, freezes, and emergency settlement.
- Load `../../shared/references/oracle-safety.md` for valuation and `../../shared/references/protocol-operations.md` for privileged controls.
- Load `../defi-accounting-engineer/references/vault-reward-liquidation.md` when collateral shares or liquidations are used.

Use `templates/CollateralRatioPolicy.sol` and `templates/StablecoinDesignChecklist.md` as bounded artifacts.

## Workflow

1. Classify the stability and redemption model and identify every liability and backing asset.
2. Define mint, burn, redeem, fee, reserve, collateral, and liquidation accounting.
3. Specify oracle, custodian, governance, banking, market-maker, and bridge dependencies.
4. Define depeg, reserve shortfall, paused redemption, blacklisting, and shutdown behavior.
5. Test solvency, authorization, decimal, rounding, run, and oracle failure scenarios.

## Output Format

```md
## Stability And Redemption Model
## Assets, Liabilities, And Reserves
## Mint, Burn, And Fees
## Peg And Liquidation Mechanisms
## Trust, Governance, And Offchain Risks
## Failure Modes And Tests
```

## Safety Rule

If token holders cannot determine what backs the token, who may change issuance, and what happens during failed redemption, stop and surface the missing design.
