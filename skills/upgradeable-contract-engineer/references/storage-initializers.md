# Storage And Initializers

## Initializers

Check:

- Constructor logic is moved into initializer functions.
- Initializers are protected with initializer modifiers.
- Reinitializers use deliberate versioning.
- Implementation contracts disable initializers.
- Parent initializers are called exactly once.
- Initialization order matches inheritance order.

## Storage Layout

Check:

- Existing storage variable order is preserved.
- Types are not changed in place.
- Variables are not removed from existing slots.
- New variables are appended.
- Gaps are used consistently when the project uses gaps.
- Inherited storage layout is understood.
- Mappings and arrays are not repurposed unsafely.

## Upgrade Tests

Test:

- Deploy proxy.
- Initialize once.
- Reinitialization reverts.
- Upgrade from old implementation to new implementation.
- Existing state is preserved.
- New functions work.
- Unauthorized upgrade reverts.
- Storage layout tooling or snapshots pass when available.

