# Unit, Fuzz, And Invariant Tests

## Unit Tests

Cover:

- Initial state.
- Constructor or initializer validation.
- Core user flows.
- Admin flows.
- Events for important state changes.
- Reverts for invalid input.
- Unauthorized caller failures.
- Multi-user behavior.

Use clear names:

```solidity
function testInitialState() public {}
function testDeposit() public {}
function testCannotDepositZero() public {}
function testOnlyOwnerCanSetConfig() public {}
```

## Fuzz Tests

Use fuzz tests when a value range matters:

- Amounts.
- Durations.
- Prices.
- Shares.
- Reward rates.
- Fees.
- User ordering.

Constrain values with `bound` or assumptions. Prefer meaningful bounds over unconstrained fuzzing that mostly explores impossible values.

## Invariant Tests

Use invariants for:

- Sum of balances equals total.
- Contract solvency.
- Shares cannot redeem more than proportional assets.
- Rewards paid plus claimable rewards do not exceed funded rewards.
- No user can withdraw more principal than deposited.
- Role changes do not grant unauthorized powers.

Use handlers when users need to call multiple functions in arbitrary order.

## Regression Tests

When fixing a bug, write a test that fails before the fix and passes after. Name it after the behavior, not the bug number.

