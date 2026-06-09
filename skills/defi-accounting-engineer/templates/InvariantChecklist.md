# DeFi Invariant Checklist

## Value Conservation

- [ ] Sum of user balances equals tracked total.
- [ ] Contract assets cover user liabilities.
- [ ] Rewards paid plus rewards claimable do not exceed funded rewards.
- [ ] Fees collected do not exceed configured fee caps.

## Share And Vault Safety

- [ ] First deposit cannot manipulate later share price unfairly.
- [ ] Donation edge cases are tested.
- [ ] Zero-supply conversions are tested.
- [ ] Rounding direction is documented and tested.

## Reward Safety

- [ ] Rewards update before balance changes.
- [ ] Multiple users with staggered deposits are tested.
- [ ] Partial withdrawals are tested.
- [ ] Reward exhaustion is tested.

## Oracle And Liquidation Safety

- [ ] Stale price handling is tested.
- [ ] Decimal normalization is tested.
- [ ] Borderline health factors are tested.
- [ ] Liquidation incentive bounds are tested.

## Admin And Emergency Safety

- [ ] Admin cannot sweep user funds unexpectedly.
- [ ] Pause behavior does not permanently trap funds.
- [ ] Emergency withdrawal behavior is documented.

