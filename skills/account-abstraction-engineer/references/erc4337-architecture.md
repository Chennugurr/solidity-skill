# ERC-4337 Architecture

## EntryPoint And Versions

- Treat the EntryPoint as a privileged singleton dependency.
- Record the supported version, address, code hash, chain, and audit source.
- ERC-4337 v0.9 is ABI-compatible with v0.8 for existing accounts and paymasters, but bundlers must support v0.9 behavior.
- Do not assume `initCode` implies first execution; v0.9 may ignore it for an already deployed account.

## Validation

- Only the selected EntryPoint may call `validateUserOp`.
- Signature failure should return validation data as required by the interface rather than create inconsistent simulation behavior.
- Keep validation deterministic and compatible with ERC-7562 storage and opcode rules.
- Bound verification gas and avoid loops over unbounded owners, guardians, or permissions.

## Factories And Nonces

- Bind deterministic account addresses to owner and initialization data.
- Prevent factory initialization front-running and verify the expected SenderCreator flow.
- Define sequential versus keyed nonces and test independent nonce lanes.

## Paymasters And Bundlers

- Separate validation from settlement and account for `postOp` failure.
- Bound sponsorship by user, target, selector, value, time, and budget.
- Protect deposits and stake withdrawals with delayed, reviewed administration.
- Model bundler censorship, simulation differences, reputation rules, and gas griefing.
