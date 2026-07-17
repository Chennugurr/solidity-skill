# Oracle Safety

Use this reference whenever contract behavior depends on external prices, rates, reserves, volatility, or sequencer state.

## Source Contract

- Record the provider, feed identifier, contract address, network, decimals, heartbeat, and update model.
- Read through the documented proxy or consumer interface rather than an implementation address.
- Treat source ownership, upgrades, publisher sets, and offchain delivery as trust assumptions.
- Do not silently substitute a feed for a similarly named but economically different asset.

## Validation

- Reject zero, negative, incomplete, future-dated, or stale values.
- Normalize feed and token decimals before arithmetic and make overflow bounds explicit.
- For pull oracles, authenticate and apply the update before reading it; account for update fees.
- For confidence-bearing feeds, define an acceptable confidence-to-price ratio.
- On supported L2s, reject use during sequencer downtime and enforce a post-recovery grace period.

## Fallbacks And Circuit Breakers

- A fallback must be independently sourced or it may reproduce the same failure.
- Define divergence limits, which source wins, and whether the safe action is pause, cap, or delayed settlement.
- Never use a low-liquidity spot price for final settlement without manipulation analysis.
- Monitor freshness, deviation, feed configuration, and failed updates offchain.

## Tests

Test decimal mismatches, stale and future timestamps, negative values, wide confidence, sequencer outage, fallback divergence, manipulated spot markets, delayed updates, and recovery behavior.
