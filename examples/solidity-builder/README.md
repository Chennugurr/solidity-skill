# Example: Solidity Builder

## Prompt

```text
Use skills/solidity-builder/SKILL.md.

Build a non-upgradeable ERC20 staking rewards contract.
Users stake an ERC20 staking token and earn a separate ERC20 reward token over a 7-day period.
Use OpenZeppelin, SafeERC20, pull-based claims, and Foundry tests.
Consult skills/_shared/references/security-posture.md, skills/_shared/references/foundry-conventions.md, and skills/solidity-builder/references/contract-patterns.md before writing files.
```

## Expected Agent Behavior

- State assumptions.
- Use simple non-upgradeable architecture.
- Avoid loops over stakers.
- Include code, tests, and deployment notes.
- Explain admin powers and mainnet risks.

