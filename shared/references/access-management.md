# Access Management

Use this reference when a system has more than simple ownership or when admin powers span multiple contracts.

## Choosing The Pattern

- Use `Ownable` or `Ownable2Step` for one clear admin role.
- Use `AccessControl` when roles are local to one contract and simple to reason about.
- Use `AccessControlDefaultAdminRules` when a default admin role remains and delayed two-step admin transfer is useful.
- Use `TimelockController` when users need time to react before privileged operations execute.
- Use `AccessManager` when a protocol needs centralized permission management across multiple contracts.

## AccessManager Defaults

When using OpenZeppelin `AccessManager`:

- Treat the manager admin as highly privileged.
- Prefer multisig or governance control for the manager admin.
- Use numeric role IDs consistently and label roles for operator tooling.
- Assign function selectors deliberately with `setTargetFunctionRole`.
- Use grant delays and execution delays for powerful roles.
- Use guardians or cancellers for emergency cancellation where appropriate.
- Document target contracts, restricted selectors, role IDs, admins, guardians, grant delays, and execution delays.

## Role Delay Design

Use delays when a role can:

- mint or burn meaningful supply;
- pause, unpause, or freeze user flows;
- upgrade implementations;
- change oracle, fee, treasury, bridge, router, or hook configuration;
- rescue tokens or move protocol-owned liquidity.

Short delays may be suitable for routine operations. Longer delays are appropriate for upgrades, treasury moves, minting, and configuration that affects user funds.

## Admin Handoff

Before production:

- Transfer temporary deployer powers to the intended multisig, timelock, or manager.
- Verify every owner, role admin, proxy admin, pauser, upgrader, minter, operator, and treasury role.
- Revoke temporary roles from deployers and hot wallets.
- Save transaction hashes and role state.
- Run post-handoff smoke checks from both authorized and unauthorized callers.

## Emergency Roles

Emergency powers should be narrow and transparent:

- pauser can pause, not upgrade or withdraw;
- guardian can cancel delayed operations, not schedule arbitrary operations;
- operator can run keepers, not change core accounting;
- treasury can receive funds, not seize user deposits.

Every emergency role needs tests, disclosure, and an explicit removal or rotation plan.
