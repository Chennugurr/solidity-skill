# Hook Testing

## Required Tests

Test every enabled callback:

- before initialize.
- after initialize.
- before add/remove liquidity.
- after add/remove liquidity.
- before swap.
- after swap.
- before donate.
- after donate.

Only include callbacks that the hook actually enables.

## Permission Tests

- Hook address has expected permission flags.
- Disabled callbacks are not relied on.
- PoolManager caller assumptions are enforced.
- Unsupported pools revert or no-op as designed.

## Accounting Tests

- Single-pool behavior.
- Multi-pool isolation.
- Fee updates.
- State updates before and after swaps.
- Edge cases around zero liquidity and tiny amounts.

## Manipulation Tests

- Same-block swap ordering.
- Low-liquidity pool.
- Price movement around callback.
- Flash-liquidity style state changes.
- Unauthorized config changes.

