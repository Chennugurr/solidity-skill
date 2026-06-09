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
- Test first-depositor inflation and donation behavior.
- Define whether virtual shares/assets or minimum liquidity are used.
- Treat exchange-rate jumps as adversarial unless caused by expected yield.

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
- Track rewards paid, rewards claimable, and rewards remaining.
- Test fee-on-transfer or rebasing reward tokens only if supported.
- Define dust handling and final-period rounding behavior.

## Fees

For fee accounting:

- Define fee recipient.
- Define fee base: assets, shares, yield, profit, notional, or debt.
- Cap fee rates.
- State rounding direction.
- Test fee updates, maximum fees, zero fees, and fee accrual timing.
- Ensure fees cannot make the system insolvent.

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
- Test partial liquidation, full liquidation, dust debt, and underwater positions.
- Ensure liquidation incentives cannot exceed configured bounds.
- Ensure liquidation improves the position or closes it according to the spec.

## Oracles And Normalization

For price-dependent accounting:

- Normalize token decimals and oracle decimals before computing value.
- Reject stale, zero, negative, or incomplete prices.
- Define heartbeat and staleness thresholds.
- Avoid using manipulable spot prices for critical solvency decisions.
- Include sequencer or liveness checks where the target chain requires them.

## Invariants

Common invariants:

- Sum of user balances equals total accounting balance.
- Assets owed are less than or equal to assets held plus strategy assets.
- Total rewards paid plus claimable rewards never exceed funded rewards.
- Users cannot redeem more than their pro-rata share.
- Fees never exceed configured caps.
- Liquidations improve or close unhealthy positions according to the spec.
- Exchange-rate changes are explained by deposits, withdrawals, fees, donations, losses, or yield.
- Oracle-normalized values use consistent precision.
