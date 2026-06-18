# Deployment Runbook

## Required Inputs

Collect:

- Target chain and chain ID.
- RPC URL environment variable.
- Deployer address.
- Deployment private key handling approach.
- Owner or admin address.
- Treasury address.
- Token addresses.
- Oracle, router, pool, bridge, or external integration addresses.
- Constructor or initializer arguments.
- Verification API key.
- Expected ownership transfer target.

## Pre-Deploy

- Confirm tests pass from a clean checkout.
- Confirm fork simulations pass for integrations.
- Confirm audit or review status.
- Confirm deployer has enough native token.
- Confirm all addresses are for the target chain.
- Confirm constructor arguments are final.
- Confirm no secrets are committed.
- Confirm deployment script broadcasts the expected contracts only.

## Broadcast

Use an explicit command, for example:

```bash
forge script script/Deploy.s.sol --rpc-url "$RPC_URL" --broadcast --verify
```

Use dry-run or simulation before `--broadcast` when possible.

## CREATE2 Deployments

For deterministic addresses:

- Record deployer address.
- Record salt.
- Record bytecode hash.
- Record constructor or initializer arguments.
- Compute the predicted address before broadcast.
- Confirm the target address has no code before deploy.
- Explain that address changes if deployer, salt, bytecode, or constructor arguments change.
- Keep salt values non-secret unless the deployment flow intentionally requires coordination.

Use `skills/solidity-builder/templates/Create2Deploy.s.sol` as a starting point when a Foundry script is requested.

## L2 Deployments

For L2s and appchains:

- Confirm chain ID, gas token, block time, finality, explorer, and verification flow.
- Confirm bridge, messenger, oracle, and predeploy addresses against target-chain docs.
- Account for sequencer downtime assumptions when oracle or liquidation logic depends on liveness.
- Run fork or simulation tests against the target chain for live integrations.

## AccessManager Setup

For AccessManager deployments:

- Deploy or identify the manager before managed targets.
- Record manager admin, role IDs, role labels, target function selectors, grant delays, and execution delays.
- Configure target function roles after targets deploy.
- Grant roles to multisigs, keepers, operators, or emergency responders.
- Run authorized and unauthorized smoke checks for every restricted selector.
- Transfer or revoke temporary deployer authority.

## Post-Deploy

- Save deployed addresses.
- Save transaction hashes.
- Verify source code.
- Confirm constructor arguments.
- Confirm owner and roles.
- Confirm treasury and integration addresses.
- Run read-only smoke checks.
- Execute one small live transaction if safe.
- Transfer ownership or roles to multisig/timelock.
- Revoke temporary permissions.
- Update downstream configs.
