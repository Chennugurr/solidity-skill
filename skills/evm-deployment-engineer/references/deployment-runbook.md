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

