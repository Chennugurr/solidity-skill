# Example: ERC1155 Items

## Prompt

```text
Use skills/solidity-builder/SKILL.md.

Create an ERC1155 item contract with supply tracking, owner-controlled minting, batch minting, and updateable metadata URI.
Include tests for single mint, batch mint, URI updates, total supply, and unauthorized minting.
Consult skills/solidity-builder/templates/BasicERC1155.sol.
```

## Expected Agent Behavior

- Define token ID assumptions.
- Use ERC1155 supply tracking when supply matters.
- Avoid unnecessary custom transfer hooks.
- Include access-control and batch-length tests.
