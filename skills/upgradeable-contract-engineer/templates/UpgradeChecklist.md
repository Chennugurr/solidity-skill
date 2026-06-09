# Upgrade Checklist

## Upgrade Model

- [ ] Proxy pattern selected.
- [ ] Upgrade authority documented.
- [ ] Required warning included.
- [ ] User trust assumptions documented.

## Initializer Safety

- [ ] Implementation disables initializers.
- [ ] Initializer can run only once.
- [ ] Parent initializers are called.
- [ ] Reinitializer versioning is deliberate.

## Storage Layout

- [ ] Existing variable order preserved.
- [ ] Existing types unchanged.
- [ ] New variables appended.
- [ ] Storage gaps handled consistently.
- [ ] Storage layout check or snapshot completed.

## Tests

- [ ] Unauthorized upgrade reverts.
- [ ] Upgrade preserves state.
- [ ] New behavior works after upgrade.
- [ ] Reinitialization blocked.
- [ ] Rollback or mitigation plan documented.

