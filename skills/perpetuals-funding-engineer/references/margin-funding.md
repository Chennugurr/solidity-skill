# Margin And Funding

- Distinguish isolated and cross margin and define collateral haircuts.
- Realize PnL and funding before changing position size or collateral.
- Use signed fixed-point math with explicit rounding and overflow bounds.
- Define mark, index, execution, and liquidation prices independently.
- Cap funding velocity and cumulative rate where needed.
- Prevent same-block or stale-index manipulation around funding settlement.
- Account for maker/taker fees, rebates, referral fees, and protocol reserves exactly once.
