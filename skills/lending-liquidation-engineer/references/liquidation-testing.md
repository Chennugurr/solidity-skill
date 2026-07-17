# Liquidation Testing

Test healthy boundaries, one-unit-underwater positions, stale and manipulated prices, maximum close factor, bonus rounding, self-liquidation, partial liquidation, insufficient collateral, unavailable repay assets, fee-on-transfer tokens, liquidation races, bad debt, and recovery after oracle resumption.

Useful invariants include debt shares matching total debt, assets covering redeemable claims within the declared loss model, liquidation never improving borrower extractable value, and healthy positions rejecting liquidation.
