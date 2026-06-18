# Example: AccessManager

## Prompt

```text
Use skills/solidity-builder/SKILL.md and skills/evm-deployment-engineer/SKILL.md.

Create an AccessManager-managed ERC20 minting setup.
Define manager admin, minter role ID, target selector, grant delay, execution delay, deployment script notes, and post-deploy role handoff checks.
Consult shared/references/access-management.md and skills/solidity-builder/templates/AccessManagedERC20.sol.
```

## Expected Agent Behavior

- Define role IDs and target selectors explicitly.
- Recommend multisig or timelock control for manager admin.
- Include unauthorized, authorized, delayed, and handoff tests.
- Include deployment and post-deploy verification steps.
