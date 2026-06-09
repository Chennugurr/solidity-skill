# Example: Token Vesting

## Prompt

```text
Use skills/solidity-builder/SKILL.md and skills/token-launch-builder/SKILL.md.

Create a single-beneficiary linear ERC20 vesting contract with a start time, cliff, duration, and pull-based release.
Include tests before cliff, during vesting, after full vesting, repeated release, and zero releasable amount.
Consult skills/solidity-builder/templates/TokenVesting.sol and skills/token-launch-builder/templates/TokenLaunchChecklist.md.
```

## Expected Agent Behavior

- Define beneficiary, token, start, cliff, and duration.
- Use pull-based release.
- Avoid owner seizure unless explicitly requested and disclosed.
- Include schedule and allocation disclosure notes.
