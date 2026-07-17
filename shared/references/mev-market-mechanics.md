# MEV And Market Mechanics

Use this reference when transaction ordering, external liquidity, keeper competition, or auction execution affects users.

## User Protection

- Require explicit slippage limits and deadlines.
- Bind quotes to token, direction, recipient, chain, venue, and amount.
- Avoid unlimited price impact or zero minimum output defaults.
- Explain sandwich and backrun exposure for public-mempool execution.

## Mechanism Choices

- Use commit-reveal only when reveal liveness, griefing, and collateral are defined.
- For auctions, define start/end price, duration, cancellation, partial fills, and tie-breaking.
- Choose TWAP windows based on liquidity and manipulation cost, not convenience.
- For solver systems, define competition, censorship, exclusivity, surplus ownership, and failed settlement.

## Liquidations

- Bound liquidation bonuses and close factors.
- Analyze oracle latency, gas spikes, keeper races, and bad-debt socialization.
- Prevent self-dealing or stale-price liquidations where realistic.
- Test ordering between deposits, withdrawals, price updates, funding, and liquidation.
