# Audit Notes

- Provider addresses, feed IDs, decimals, heartbeat, confidence, and sequencer checks must be configured per chain.
- The market is intentionally isolated and omits interest, pooled liquidity, reserves, and bad-debt socialization.
- Liquidation and oracle tests demonstrate failure paths but do not establish safe market parameters.
- Provider packages are compile-time dependencies; review their transitive npm audit output and avoid shipping unused package code.
