# Example: Upgradeable Contract Engineer

## Prompt

```text
Use skills/upgradeable-contract-engineer/SKILL.md.

Review this UUPS upgrade plan.
Check initializer safety, implementation initialization, storage layout, upgrade authorization, admin trust risk, migration steps, and upgrade tests.
Consult shared/references/openzeppelin-defaults.md and skills/upgradeable-contract-engineer/references/storage-initializers.md.
```

## Expected Agent Behavior

- Include the required upgradeability warning.
- Check initializer and storage layout risks.
- Define upgrade authority.
- Add unauthorized upgrade and state-preservation tests.
- Document user trust assumptions.

