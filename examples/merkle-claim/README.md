# Example: Merkle Claim

## Prompt

```text
Use skills/solidity-builder/SKILL.md and skills/token-launch-builder/SKILL.md.

Create a pull-based ERC20 Merkle claim contract for a token launch allocation.
Include deadline, double-claim prevention, invalid-proof tests, and transparent clawback after the deadline.
Consult skills/solidity-builder/templates/MerkleClaim.sol and skills/token-launch-builder/references/launch-mechanics.md.
```

## Expected Agent Behavior

- Define the exact leaf format.
- Track claimed accounts or leaves.
- Test invalid proofs, duplicate claims, deadline behavior, and clawback.
- Disclose clawback authority.
