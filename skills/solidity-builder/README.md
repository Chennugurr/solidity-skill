# Solidity Builder Skill

This folder contains the vendor-neutral `solidity-builder` skill.

## Files

- `SKILL.md`: the compact operating instructions agents should load first.
- `references/contract-patterns.md`: contract-specific rules for common Solidity systems.
- `templates/`: reusable Solidity, Foundry test, and deploy script starters.
- `../_shared/references/`: suite-wide security, Foundry, OpenZeppelin, and mainnet-readiness references.

## How To Use

Point an agent at `SKILL.md`. When the task needs more detail, instruct the agent to load the relevant reference file.

Example:

```text
Use skills/solidity-builder/SKILL.md. Build a staking rewards contract using Foundry and consult references/contract-patterns.md plus ../_shared/references/security-posture.md before writing code.
```

Generated contracts still need project-specific review, testing, and security review before production use.
