# Oracle Failure Modes

- Stale or frozen feed during active markets.
- Incorrect asset, denomination, network, or decimals.
- Sequencer outage followed by unfair liquidation access.
- Pull update omitted, underfunded, delayed, or selected from a favorable timestamp.
- Confidence too wide for the protocol's executable price.
- Fallback source sharing the same upstream market or operator.
- AMM spot manipulation, thin-liquidity TWAP, or short observation window.
- Arithmetic overflow, truncation, sign conversion, or double normalization.
- Governance replacing a feed without updating limits and monitoring.

For each failure, define detection, onchain response, offchain alert, recovery authority, and tests.
