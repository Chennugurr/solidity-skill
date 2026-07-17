# Perpetuals Invariant Checklist

- [ ] Position, collateral, realized PnL, fees, and funding reconcile
- [ ] Funding transfers value between sides without creating value
- [ ] Healthy positions reject liquidation
- [ ] Bankruptcy loss follows the declared insurance or ADL path
- [ ] Oracle delay and keeper ordering are bounded
- [ ] Signed arithmetic, rounding, and caps are tested
- [ ] Withdrawable profit does not exceed available system assets
