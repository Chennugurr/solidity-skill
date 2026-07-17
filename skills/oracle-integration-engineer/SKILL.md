---
name: oracle-integration-engineer
description: Design, implement, test, and review Solidity oracle integrations for Chainlink, Pyth, RedStone, normalization, freshness, confidence, sequencer uptime, fallbacks, circuit breakers, and manipulation resistance.
---

# Oracle Integration Engineer

## Purpose

Use this skill when contract safety or accounting depends on external price, rate, reserve, volatility, or sequencer data.

Do not use it to choose economic risk parameters without a protocol risk model and accountable owners.

## Reference Loading

- Load `references/provider-patterns.md` for Chainlink, Pyth, and RedStone integration differences.
- Load `references/failure-modes.md` for fallbacks, circuit breakers, and adversarial tests.
- Load `../../shared/references/oracle-safety.md` for common validation rules.
- Load `../../shared/references/cross-chain-l2.md` for sequencer and chain-specific assumptions.
- Load `../../shared/references/mev-market-mechanics.md` when prices affect liquidation or settlement.

Use `templates/NormalizedOracleAdapter.sol` and `templates/MockPriceSource.sol` as bounded adapter and test fixtures.

## Workflow

1. Identify the economic quantity, source, update model, decimals, heartbeat, confidence, and target chain.
2. Define normalization, freshness, sequencer, divergence, and fallback behavior.
3. Separate source failure from consumer policy and make pause/cap behavior explicit.
4. Implement a narrow adapter and mockable interface.
5. Test stale, invalid, delayed, manipulated, divergent, and outage states.

## Output Format

```md
## Oracle Requirement
## Provider And Feed Configuration
## Normalization And Validation
## Fallback And Circuit Breaker
## Trust And Liveness Assumptions
## Tests And Monitoring
```

## Safety Rule

Never accept a feed solely because its address is valid. Verify its asset, denomination, chain, proxy, update behavior, freshness, and operational ownership.
