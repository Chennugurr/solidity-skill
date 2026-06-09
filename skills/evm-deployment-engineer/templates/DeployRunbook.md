# Deployment Runbook

## Deployment Summary

- Project:
- Commit:
- Target chain:
- Chain ID:
- Deployer:
- Owner/admin:
- Treasury:

## Required Environment Variables

```env
PRIVATE_KEY=
RPC_URL=
ETHERSCAN_API_KEY=
OWNER=
TREASURY=
```

## Constructor Or Initializer Arguments

| Contract | Argument | Value | Source |
| --- | --- | --- | --- |
|  |  |  |  |

## Pre-Deploy Checklist

- [ ] Tests pass.
- [ ] Fork tests pass if integrations exist.
- [ ] Deployment script reviewed.
- [ ] Constructor or initializer arguments reviewed.
- [ ] Deployer funded.
- [ ] Admin and treasury addresses confirmed.
- [ ] Secrets are not committed.
- [ ] Audit or review status documented.

## Commands

```bash
forge script script/Deploy.s.sol --rpc-url "$RPC_URL"
forge script script/Deploy.s.sol --rpc-url "$RPC_URL" --broadcast --verify
```

## Post-Deploy Checklist

- [ ] Addresses recorded.
- [ ] Transaction hashes recorded.
- [ ] Source verified.
- [ ] Constructor arguments confirmed.
- [ ] Owner and roles confirmed.
- [ ] Treasury and integration addresses confirmed.
- [ ] Read-only smoke checks passed.
- [ ] Ownership or roles transferred if needed.
- [ ] Temporary deployer permissions revoked.
- [ ] Downstream config updated.

## Risks And Rollback

Describe known risks, pause options, upgrade options, migration plan, and communication path.

