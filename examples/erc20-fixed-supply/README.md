# Example: Fixed-Supply ERC20

This example shows how to prompt an agent to use the `solidity-builder` skill for a simple ERC20.

## Prompt

```text
Use skills/solidity-builder/SKILL.md.

Create a Foundry project for a fixed-supply ERC20 named Example Token with symbol EXAMPLE.
Mint 1,000,000 tokens to the deployer at deployment.
Use OpenZeppelin ERC20.
Do not include owner functions, taxes, blacklists, pausing, or upgradeability.
Include unit tests and a deploy script.
Consult skills/_shared/references/security-posture.md and skills/_shared/references/foundry-conventions.md before writing files.
```

## Expected Agent Behavior

The agent should:

- Use a no-owner fixed-supply ERC20.
- State that the token has no minting after deployment.
- Avoid transfer taxes, blacklists, hidden controls, or trading switches.
- Create Foundry tests for initial supply and basic transfers.
- Include deployment notes and verification commands.

## Useful Template

Start from:

```text
skills/solidity-builder/templates/BasicERC20.sol
```
