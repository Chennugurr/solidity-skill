---
name: intent-solver-engineer
description: Design, implement, test, and review EIP-712 intent and solver systems, Permit2 authorization, nonces, deadlines, partial fills, settlement, replay protection, competition, and MEV.
---

# Intent Solver Engineer

## Purpose

Use this skill for signed user intents executed by third-party solvers or settlement contracts.

Do not use it for a simple direct transaction where no solver, offchain order, or delegated settlement exists.

## Reference Loading

- Load `references/intent-lifecycle.md` for signing, filling, cancellation, and settlement.
- Load `references/solver-security.md` for solver permissions, competition, and MEV.
- Load `../../shared/references/signatures.md` for domain and nonce safety.
- Load `../../shared/references/mev-market-mechanics.md` for ordering, auctions, and surplus.

Use `templates/IntentVerifier.sol` and `templates/IntentSecurityChecklist.md` as focused artifacts.

## Workflow

1. Define the signed objective, constraints, assets, recipients, fees, nonce, deadline, and chain scope.
2. Define exact, partial, repeated, cancelled, expired, and failed fill behavior.
3. Separate token authorization from intent authorization and settlement.
4. Define solver eligibility, exclusivity, competition, surplus, and censorship assumptions.
5. Test replay, cross-chain/domain mismatch, partial-fill rounding, malicious callbacks, and adverse ordering.

## Output Format

```md
## Intent Schema And Domain
## Authorization And Nonces
## Fill And Settlement Lifecycle
## Solver And Surplus Model
## Failure, Cancellation, And Recovery
## MEV Risks And Tests
```

## Safety Rule

Never let a solver choose unconstrained targets, calldata, recipients, fees, or token approvals outside the exact signed intent.
