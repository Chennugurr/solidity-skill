---
name: upgradeable-contract-engineer
description: Design, implement, review, and test upgradeable Solidity systems, proxy patterns, initializer safety, storage layout, upgrade authority, and migration plans.
---

# Upgradeable Contract Engineer

## Purpose

Use this skill when a Solidity system intentionally uses proxy upgradeability or needs an upgrade/migration plan.

The goal is to make upgrade authority, initializer safety, storage layout, and user trust risk explicit and testable.

## When To Use

Use this skill for:

- UUPS or Transparent proxy systems.
- Initializer and reinitializer design.
- Storage layout review.
- Upgrade authorization.
- Proxy deployment scripts.
- Upgrade tests.
- Migration plans.
- Upgrade risk disclosure.

Do not use it when immutable contracts are sufficient and upgradeability was not requested.

## Reference Loading

Load shared references as needed:

- `../_shared/references/openzeppelin-defaults.md` for upgradeable defaults.
- `../_shared/references/security-posture.md` for admin trust and initialization risks.
- `../_shared/references/mainnet-readiness.md` for production upgrade gates.

Load local references as needed:

- `references/proxy-patterns.md` for proxy choices.
- `references/storage-initializers.md` for storage and initializer safety.

Use `templates/UpgradeChecklist.md` for review and migration planning.

## Required Warning

Include this warning in upgradeability guidance:

```text
Upgradeability introduces admin trust risk. Users must trust the upgrade authority not to deploy malicious logic.
```

## Output Format

```md
## Upgrade Model

## Proxy Pattern

## Storage Layout

## Initializers

## Upgrade Authority

## Tests

## Migration/Deployment Notes

## User Trust Risks
```

## Safety Rule

Do not add upgradeability as a convenience. Use it only when the user explicitly asks for it or the existing system already requires it.

