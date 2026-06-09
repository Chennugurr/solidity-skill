# Example: ERC4626 Vault

## Prompt

```text
Use skills/solidity-builder/SKILL.md and skills/defi-accounting-engineer/SKILL.md.

Build a simple ERC4626 vault with no strategy and no fees.
Review share accounting, first-depositor behavior, rounding direction, donation behavior, and solvency invariants.
Consult skills/solidity-builder/templates/BasicERC4626Vault.sol and skills/defi-accounting-engineer/references/vault-reward-liquidation.md.
```

## Expected Agent Behavior

- Explain asset/share units.
- Test deposit, mint, withdraw, redeem, donation, and rounding cases.
- Avoid claiming the vault is production-ready.
- Recommend deeper accounting review before holding real funds.
