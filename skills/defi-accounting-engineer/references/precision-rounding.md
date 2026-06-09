# Precision And Rounding

## Units

Document units for:

- Token decimals.
- Internal precision constants.
- Oracle decimals.
- Share decimals.
- Reward rate time unit.
- Fee basis points or fixed-point scale.

Use explicit names like `assets`, `shares`, `rewardPerToken`, `price`, and `feeBps`.

## Rounding Direction

Choose rounding direction based on who receives value:

- Deposits/mints should not over-mint shares.
- Withdrawals/redeems should not overpay assets.
- Fees should not exceed configured caps.
- Liquidations should not give liquidators more than the intended incentive.
- Reward claims should not exceed accrued rewards.

State rounding choices in the design and test boundary cases.

## Decimal Normalization

Do not assume every token has 18 decimals. When mixing assets:

- Read decimals if available.
- Normalize oracle prices and token amounts deliberately.
- Avoid double scaling.
- Avoid division before multiplication unless overflow risk requires it.
- Use well-tested math helpers where appropriate.

## Dust

Define how dust is handled:

- Left in contract.
- Claimable by users later.
- Swept by admin only for non-user funds.
- Included in final withdrawal.

Dust handling must not let admins take user funds unexpectedly.

