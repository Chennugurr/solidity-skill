# Acceptance Criteria

Acceptance criteria should be testable.

## Good Criteria

- "Only `REWARD_DISTRIBUTOR_ROLE` can call `notifyRewardAmount`."
- "A user cannot withdraw more staking tokens than their recorded balance."
- "Total staked always equals the sum of user balances."
- "Claims revert after `claimDeadline`."
- "Upgrade authorization reverts for non-admin callers."

## Weak Criteria

- "The contract should be secure."
- "Rewards should work."
- "The admin should manage things."
- "The protocol should be gas efficient."

## Required Categories

Include acceptance criteria for:

- Initial state.
- Access control.
- Core user flows.
- Admin flows.
- Revert conditions.
- Events.
- Accounting invariants.
- External integrations.
- Deployment or initialization.

