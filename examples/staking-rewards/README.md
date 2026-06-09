# Example: Staking Rewards

This example shows how to prompt an agent to build a staking rewards contract with safer defaults.

## Prompt

```text
Use skills/solidity-builder/SKILL.md.

Create a Foundry project for a staking rewards contract.
Users stake an ERC20 staking token and earn a separate ERC20 reward token over a fixed 7-day reward period.
Rewards should use index-based accounting, not loops over stakers.
Claims should be pull-based.
The owner can notify new rewards only after reward tokens are funded.
Include Foundry tests for multiple users, staggered deposits, partial withdrawals, reward claiming, and access control.
Consult shared/references/security-posture.md, skills/solidity-builder/references/contract-patterns.md, and shared/references/foundry-conventions.md before writing files.
```

## Expected Agent Behavior

The agent should:

- Avoid looping over all stakers.
- Use `SafeERC20`.
- Update rewards before balance changes.
- Prevent reward rates that exceed funded rewards.
- Include multi-user reward accounting tests.
- Document owner powers and remaining assumptions.

## Useful Template

Start from:

```text
skills/solidity-builder/templates/StakingRewards.sol
```
