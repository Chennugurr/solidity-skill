# Example: EVM Deployment Engineer

## Prompt

```text
Use skills/evm-deployment-engineer/SKILL.md.

Prepare a deployment runbook for the staking rewards project on Sepolia.
Include required environment variables, constructor arguments, forge script commands, verification steps, ownership transfer to a multisig, and post-deploy smoke checks.
Consult skills/_shared/references/mainnet-readiness.md and skills/evm-deployment-engineer/references/deployment-runbook.md.
```

## Expected Agent Behavior

- Identify required inputs.
- Block deployment if critical addresses or tests are missing.
- Include dry-run and broadcast commands.
- Include verification and post-deploy checks.
- Document role and ownership setup.

