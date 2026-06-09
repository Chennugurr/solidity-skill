# Solidity Builder Skill

This folder contains the vendor-neutral `solidity-builder` skill.

## Files

- `SKILL.md`: the compact operating instructions agents should load first.
- `references/contract-patterns.md`: contract-specific rules for common Solidity systems.
- `templates/`: reusable Solidity, Foundry test, and deploy script starters.
- `../../shared/references/`: suite-wide security, Foundry, OpenZeppelin, security tooling, advanced protocol, and mainnet-readiness references.

## Template Families

- ERC20, ERC721, ERC1155, and ERC4626.
- Merkle claims, vesting, staking rewards, governance/timelock, and votes tokens.
- Foundry tests, deploy scripts, and CREATE2 deployment.

## How To Use

Point an agent at `SKILL.md`. When the task needs more detail, instruct the agent to load the relevant reference file.

Example:

```text
Use skills/solidity-builder/SKILL.md. Build a staking rewards contract using Foundry and consult references/contract-patterns.md plus ../../shared/references/security-posture.md before writing code.
```

Generated contracts still need project-specific review, testing, and security review before production use.
