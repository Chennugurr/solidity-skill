# Hook Design

## Design Inputs

Define:

- Target Uniswap v4 package version.
- PoolManager address.
- PoolKey fields.
- Enabled hook callbacks.
- Whether the hook supports one pool or many pools.
- Hook-controlled fee behavior if any.
- Admin-controlled configuration.
- External dependencies.

## Permissions

Hook permissions must match the callbacks implemented and the deployed hook address requirements.

Document:

- Enabled before callbacks.
- Enabled after callbacks.
- Return data expectations.
- Whether callbacks can modify deltas or fees.
- Address mining or deployment constraints.

## Storage

For multi-pool hooks:

- Use pool ID keyed storage.
- Avoid global config when pool-specific config is required.
- Document how config is initialized.
- Protect config updates with access control.

## Manipulation Resistance

Review:

- Same-transaction price manipulation.
- Low-liquidity pool behavior.
- Flash-loan effects.
- Donation callback assumptions.
- MEV and sandwich risk.
- Reentrancy or callback ordering assumptions.

