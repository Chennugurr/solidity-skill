# Gas Optimization

Use this reference after correctness, security, and test coverage are in place. Do not trade away readability or safety for small gas wins unless the user explicitly accepts the risk.

## Measurement First

- Use `forge snapshot` before and after optimization.
- Keep representative tests stable so snapshots compare the same paths.
- Record optimizer settings, `via-ir`, compiler version, and EVM version.
- Optimize hot paths first: loops, repeated storage access, frequently called user flows, and deployment-size pressure.
- Treat gas snapshots as regression signals, not proof of security.

## Storage

- Pack smaller values together when they are read and written together.
- Avoid packing values that are updated independently if extra masking makes writes more expensive.
- Cache storage reads in local variables when a function reads the same slot repeatedly.
- Prefer immutable constructor-set values when they never change.
- Avoid unbounded arrays and mappings that require iteration for core flows.

## Data Location

- Prefer `calldata` for external function parameters that are read-only.
- Use `memory` when data must be mutated or passed to APIs that require memory.
- Avoid copying large arrays or structs between memory and storage.
- For events and custom errors, include enough data for debugging without bloating every path.

## Errors And Events

- Prefer custom errors over long revert strings.
- Emit events for important state changes even if events cost gas.
- Do not remove critical events just to reduce gas.
- Do not use ambiguous errors that make production debugging harder.

## Compiler Settings

- Use optimizer settings deliberately and document them.
- Consider `via-ir` for complex contracts after tests and snapshots pass.
- Re-run all tests, fuzz tests, and invariant tests after changing optimizer or `via-ir`.
- Do not assume a setting is cheaper on every chain or compiler version.

## Safety Rules

- Do not replace safe math/accounting with unchecked math unless the bound is obvious and tested.
- Do not use low-level calls solely for gas unless the failure behavior is fully handled.
- Do not compress access control, signature validation, or accounting in ways that obscure trust assumptions.
- Security before gas, always.
