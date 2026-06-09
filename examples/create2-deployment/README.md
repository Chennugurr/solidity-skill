# Example: CREATE2 Deployment

## Prompt

```text
Use skills/evm-deployment-engineer/SKILL.md and skills/solidity-builder/SKILL.md.

Prepare a CREATE2 deployment script for a capped OwnableERC20.
Include salt handling, bytecode determinism, predicted address calculation, deployment simulation, verification, and post-deploy ownership transfer.
Consult skills/solidity-builder/templates/Create2Deploy.s.sol and skills/evm-deployment-engineer/references/deployment-runbook.md.
```

## Expected Agent Behavior

- Make deployer, salt, constructor args, and bytecode explicit.
- Warn that address changes if deployer or bytecode changes.
- Include dry-run and post-deploy verification steps.
- Avoid committing secrets.
