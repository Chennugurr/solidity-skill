---
name: token-launch-builder
description: Design and review transparent ERC20 token launches, supply allocation, vesting, liquidity, ownership, admin powers, and anti-scam disclosure.
---

# Token Launch Builder

## Purpose

Use this skill for transparent token launch mechanics and launch-readiness planning.

The goal is to build or review token launches with explicit supply, admin powers, liquidity handling, vesting, and user-facing risk disclosure.

## When To Use

Use this skill for:

- ERC20 launch contracts.
- Fixed or capped supply design.
- Mint, burn, pause, tax, blacklist, or limit disclosure.
- Vesting and allocations.
- Liquidity lock, burn, or treasury flows.
- Launch checklists.
- Anti-scam review of token mechanics.

Do not use it to create deceptive launch mechanics, hidden owner powers, honeypots, or misleading renounce/burn flows.

## Reference Loading

Load shared references as needed:

- `../../shared/references/security-posture.md` for forbidden patterns and launch safety.
- `../../shared/references/openzeppelin-defaults.md` for token primitives.
- `../../shared/references/mainnet-readiness.md` for deployment readiness.
- `../../shared/references/advanced-protocols.md` for permit, vesting governance, L2 launch, and cross-chain launch assumptions.

- `../../shared/references/signatures.md` for permit, nonce, signer, and replay assumptions.
- `../../shared/references/cross-chain-l2.md` for L2 and cross-domain distribution assumptions.
- `../../shared/references/protocol-operations.md` for role handoff, Safe batches, dry-runs, and incident controls.
- `../../shared/references/mev-market-mechanics.md` for liquidity, ordering, slippage, and auction risk.

Load local references as needed:

- `references/launch-mechanics.md` for token and launch design.
- `references/disclosure-liquidity.md` for transparency and liquidity handling.

Use `templates/TokenLaunchChecklist.md` for launch planning.

## Launch Rules

- Default to fixed supply unless minting is requested.
- Do not add transfer taxes, blacklists, trading switches, or wallet limits unless explicitly requested and disclosed.
- Cap mutable fees.
- Document every owner/admin power.
- Recommend multisig ownership for production.
- Make liquidity handling explicit.
- Make vesting and allocations explicit.
- Do not fake burns, locks, or renounces.

## Output Format

```md
## Launch Design

## Token Mechanics

## Supply And Allocations

## Admin Powers

## Liquidity Plan

## Vesting/Locks

## Disclosure And Risks

## Tests
```

## Safety Rule

Refuse hidden or deceptive token mechanics. Offer transparent alternatives that users, wallets, and auditors can understand.
