# Uniswap v4 Hook Design Checklist

## Inputs

- [ ] Uniswap v4 package/version confirmed.
- [ ] PoolManager address confirmed.
- [ ] PoolKey shape confirmed.
- [ ] Hook callbacks listed.
- [ ] Hook permissions listed.
- [ ] Deployment/address requirements documented.

## Storage

- [ ] Single-pool or multi-pool support is explicit.
- [ ] Pool-specific storage uses pool IDs where needed.
- [ ] Admin config is access controlled.
- [ ] Events exist for config changes.

## Security

- [ ] Same-transaction manipulation reviewed.
- [ ] Low-liquidity behavior reviewed.
- [ ] MEV/sandwich risks documented.
- [ ] External calls minimized.
- [ ] PoolManager caller assumptions tested.

## Tests

- [ ] Every enabled callback tested.
- [ ] Disabled callbacks not relied on.
- [ ] Permission/address flags tested.
- [ ] Multi-pool isolation tested if applicable.
- [ ] Deployment notes included.

