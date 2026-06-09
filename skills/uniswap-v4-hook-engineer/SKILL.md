---
name: uniswap-v4-hook-engineer
description: Design, implement, review, and test Uniswap v4 hooks, hook permissions, PoolManager interactions, pool-specific storage, and hook deployment assumptions.
---

# Uniswap v4 Hook Engineer

## Purpose

Use this skill for Uniswap v4 hook architecture, implementation, review, and tests.

The goal is minimal, permission-correct hook logic that is explicit about PoolManager trust boundaries, pool-specific accounting, manipulation risks, and deployment requirements.

## When To Use

Use this skill for:

- Uniswap v4 hook design.
- Hook permission selection.
- Before/after initialize, liquidity, swap, donate, or other callback logic.
- PoolManager and PoolKey interactions.
- Pool-specific storage and accounting.
- Dynamic fees or hook-controlled fees.
- Hook tests and address-permission deployment.
- Review of same-transaction manipulation risks.

Do not use it for generic AMM integration unless hook-specific behavior is involved.

## Reference Loading

Load shared references as needed:

- `../_shared/references/security-posture.md` for manipulation, oracle, and accounting risks.
- `../_shared/references/foundry-conventions.md` for test structure.

Load local references as needed:

- `references/hook-design.md` for architecture and permissions.
- `references/hook-testing.md` for callback and manipulation tests.

Use `templates/HookDesignChecklist.md` for design reviews.

## Hook Rules

- Confirm the exact installed Uniswap v4 package and interfaces before coding.
- Define enabled callbacks and permissions before implementation.
- Keep hook logic minimal and gas-aware.
- Use pool-specific storage when supporting multiple pools.
- Avoid relying on manipulable same-transaction spot data.
- Validate caller assumptions around PoolManager.
- Document deployment address requirements for hook permissions.
- Test every enabled callback.

## Output Format

```md
## Hook Goal

## Enabled Permissions

## PoolManager/PoolKey Assumptions

## Storage Model

## Callback Behavior

## Manipulation Risks

## Tests

## Deployment Notes
```

## Safety Rule

If the hook's economics depend on price, liquidity, or volume data, treat same-block and same-transaction manipulation as a first-class risk.

