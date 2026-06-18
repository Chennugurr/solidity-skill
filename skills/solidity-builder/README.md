# Solidity Builder Skill

This folder contains the vendor-neutral `solidity-builder` skill.

## Files

- `SKILL.md`: the compact operating instructions agents should load first.
- `references/contract-patterns.md`: contract-specific rules for common Solidity systems.
- `references/security-defaults.md`: builder-local index for security defaults.
- `references/foundry-patterns.md`: builder-local index for Foundry defaults.
- `templates/`: reusable Solidity, Foundry test, and deploy script starters.
- `../../shared/references/`: suite-wide security, Foundry, OpenZeppelin, security tooling, advanced protocol, and mainnet-readiness references.

## Template Families

- ERC20, ERC721, ERC1155, and ERC4626.
- Merkle claims, vesting, staking rewards, governance/timelock, and votes tokens.
- Foundry tests, deploy scripts, and CREATE2 deployment.

## When To Use

Use this skill when an agent needs to build, modify, scaffold, explain, refactor, test, or deploy Solidity/EVM contracts with safer defaults.

Good fits:

- ERC20, ERC721, ERC1155, and ERC4626 contracts.
- Staking, rewards, vesting, airdrops, treasuries, escrows, and governance.
- Foundry tests and deploy scripts.
- Security-minded Solidity refactors.

Do not use it as a substitute for a full audit or for non-Solidity product, legal, or marketing work.

## How To Use

Point an agent at `SKILL.md`. When the task needs more detail, instruct the agent to load the relevant reference file.

Example prompts:

```text
Use skills/solidity-builder/SKILL.md. Build a staking rewards contract using Foundry and consult references/contract-patterns.md plus ../../shared/references/security-posture.md before writing code.
```

```text
Use skills/solidity-builder/SKILL.md. Create a fixed-supply ERC20 with no owner, no taxes, no blacklist, Foundry tests, and a deploy script.
```

```text
Use skills/solidity-builder/SKILL.md. Refactor this Solidity contract to use safer OpenZeppelin defaults and add missing access-control tests.
```

Generated contracts still need project-specific review, testing, and security review before production use.
