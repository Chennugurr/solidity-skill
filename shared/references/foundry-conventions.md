# Foundry Conventions

Use this reference when creating Foundry projects, tests, scripts, fixtures, or deployment workflows.

## Default Project Layout

For a compact project:

```text
project/
  foundry.toml
  remappings.txt
  .env.example
  src/
    ContractName.sol
  test/
    ContractName.t.sol
  script/
    DeployContractName.s.sol
  README.md
```

For larger projects:

```text
project/
  src/
    interfaces/
    libraries/
    abstract/
    tokens/
    core/
    periphery/
  test/
    unit/
    fuzz/
    invariant/
    fork/
    mocks/
  script/
    deploy/
    config/
  docs/
```

## Solidity File Ordering

Use this ordering unless the existing codebase has a clear local convention:

1. SPDX license identifier.
2. Solidity pragma.
3. Imports.
4. Interfaces.
5. Libraries.
6. Contract declaration.
7. Custom errors.
8. Events.
9. Constants.
10. Immutables.
11. Storage variables.
12. Modifiers.
13. Constructor or initializer.
14. External functions.
15. Public functions.
16. Internal functions.
17. Private helpers.
18. View and pure functions.
19. Admin functions grouped clearly if not already grouped by flow.

## Test Coverage Expectations

Every meaningful build should include:

- Unit tests for intended behavior.
- Revert tests for invalid inputs and unauthorized callers.
- Access-control tests for every privileged function.
- Multi-user tests for accounting and ordering effects.
- Edge-case tests for zero amounts, zero addresses, boundaries, and time transitions.
- Fuzz tests where inputs vary materially.
- Invariant tests where accounting matters.
- Fork tests for live protocol integrations.

## Common Foundry Cheatcodes

- `vm.prank`
- `vm.startPrank`
- `vm.stopPrank`
- `vm.expectRevert`
- `vm.expectEmit`
- `vm.warp`
- `vm.roll`
- `vm.deal`
- `deal`
- `bound`
- `makeAddr`
- `vm.createSelectFork`
- `vm.startBroadcast`
- `vm.stopBroadcast`

## Common Actors

Use readable actors unless the project already defines fixtures:

- `owner`
- `alice`
- `bob`
- `carol`
- `treasury`
- `operator`
- `attacker`

## Deployment Command Shape

Default script command:

```bash
forge script script/Deploy.s.sol --rpc-url "$RPC_URL" --broadcast --verify
```

Default `.env.example`:

```env
PRIVATE_KEY=
RPC_URL=
ETHERSCAN_API_KEY=
OWNER=
TREASURY=
CREATE2_SALT=
```

Never include real private keys, mnemonics, RPC credentials, or API keys in generated files.

## CI Command Shape

For suite or project CI, prefer:

```bash
forge build
forge test
```

Use higher fuzz or invariant run counts in CI only when runtime is acceptable and results remain reproducible.
