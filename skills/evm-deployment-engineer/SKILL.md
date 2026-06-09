---
name: evm-deployment-engineer
description: Prepare, review, and execute EVM smart contract deployment plans, Foundry scripts, verification steps, role setup, and post-deploy runbooks.
---

# EVM Deployment Engineer

## Purpose

Use this skill to turn tested Solidity contracts into safe deployment plans and operational runbooks.

The goal is controlled, reproducible deployment with clear environment variables, constructor arguments, verification, role setup, and post-deploy checks.

## When To Use

Use this skill for:

- Foundry deployment scripts.
- Environment variable planning.
- Constructor and initializer argument review.
- Broadcast and verification commands.
- Multisig, timelock, and role setup.
- Testnet or mainnet deployment runbooks.
- Post-deploy smoke checks.
- Deployment incident rollback or mitigation planning.

Do not use it to decide protocol economics or implement contract logic unless deployment depends on it.

## Reference Loading

Load shared references as needed:

- `../../shared/references/foundry-conventions.md` for script conventions.
- `../../shared/references/mainnet-readiness.md` for deployment gates.
- `../../shared/references/security-posture.md` for privileged role and secret handling.
- `../../shared/references/advanced-protocols.md` for CREATE2, L2, bridge, oracle, and governance deployment assumptions.

Load local references as needed:

- `references/deployment-runbook.md` for end-to-end deploy flow.
- `references/verification-postdeploy.md` for verification and checks.

Use `templates/DeployRunbook.md` for deployment documentation.

## Deployment Rules

- Never include private keys or secrets in committed files.
- Prefer `.env.example` with empty placeholders.
- Require chain ID, RPC URL, deployer, owner/admin, treasury, and integration addresses to be explicit.
- Simulate deployment before broadcasting.
- Verify source code after deployment.
- Transfer ownership or admin roles to multisig/timelock when production requires it.
- Revoke temporary deployer permissions.
- Save addresses, transaction hashes, arguments, and verification status.

## Output Format

```md
## Deployment Summary

## Required Inputs

## Pre-Deploy Checks

## Commands

## Post-Deploy Checks

## Role/Ownership Setup

## Risks And Rollback
```

## Safety Rule

If tests, audit status, constructor arguments, or admin addresses are unclear, mark deployment as blocked rather than pretending it is ready.
