# Vaults, Rewards, And Liquidations

## Vaults

For ERC4626-like systems:

- Define asset and share tokens.
- Explain deposit, mint, withdraw, and redeem conversions.
- Protect against first-depositor inflation.
- Test donations and share price changes.
- Test zero supply.
- Test rounding at small amounts.
- Do not assume strategy assets are instantly liquid unless the design says so.

## Rewards

For staking or reward distribution:

- Prefer index-based reward accounting.
- Track total staked.
- Track user balances.
- Track reward-per-token index.
- Update rewards before changing balances.
- Use pull-based claims.
- Ensure reward rate does not exceed funded rewards.
- Test multiple users entering and exiting at different times.

## Liquidations

For lending and liquidation systems:

- Define collateral value.
- Define debt value.
- Define oracle source and staleness checks.
- Define liquidation threshold.
- Define close factor.
- Define liquidation bonus.
- Bound liquidation incentive.
- Test borderline health factors.
- Test stale or manipulated oracle data.

## Invariants

Common invariants:

- Sum of user balances equals total accounting balance.
- Assets owed are less than or equal to assets held plus strategy assets.
- Total rewards paid plus claimable rewards never exceed funded rewards.
- Users cannot redeem more than their pro-rata share.
- Fees never exceed configured caps.
- Liquidations improve or close unhealthy positions according to the spec.

