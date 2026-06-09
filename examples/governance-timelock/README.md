# Example: Governance And Timelock

## Prompt

```text
Use skills/solidity-builder/SKILL.md and skills/evm-deployment-engineer/SKILL.md.

Create a basic ERC20Votes, Governor, and TimelockController setup.
Define voting delay, voting period, quorum, proposal threshold, timelock delay, role setup, and deployment handoff.
Consult skills/solidity-builder/templates/VotesERC20.sol, skills/solidity-builder/templates/SimpleGovernor.sol, and skills/solidity-builder/templates/GovernanceTimelock.sol.
```

## Expected Agent Behavior

- Explain governance trust assumptions.
- Define timelock proposer, executor, canceller, and admin roles.
- Include role handoff and renounce steps.
- Add proposal lifecycle and authorization tests.
