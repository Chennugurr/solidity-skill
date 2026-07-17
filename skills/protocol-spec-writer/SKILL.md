---
name: protocol-spec-writer
description: Turn rough Solidity protocol ideas into implementation-ready specs with actors, flows, state, functions, invariants, trust assumptions, tests, and acceptance criteria.
---

# Protocol Spec Writer

## Purpose

Use this skill to turn an idea, product description, or partial protocol design into an implementation-ready smart contract specification.

The goal is to remove ambiguity before implementation by defining actors, assets, flows, state, permissions, invariants, failure modes, and tests.

## When To Use

Use this skill for:

- Rough protocol ideas.
- Pre-implementation specs.
- Refactoring a vague request into clear requirements.
- Multi-contract architecture planning.
- Actor and permission modeling.
- Invariant and acceptance criteria definition.
- Handoff specs for builder, tester, auditor, or deployment skills.

Do not use it when the user only needs a tiny code change with clear requirements.

## Reference Loading

Load shared references as needed:

- `../../shared/references/security-posture.md` for assumptions and trust boundaries.
- `../../shared/references/openzeppelin-defaults.md` for standard primitives.
- `../../shared/references/mainnet-readiness.md` for production gates.
- `../../shared/references/oracle-safety.md` when the protocol consumes prices or rates.
- `../../shared/references/cross-chain-l2.md` for cross-domain flows, finality, and recovery.
- `../../shared/references/protocol-operations.md` for roles, emergency actions, monitoring, and handoff criteria.
- `../../shared/references/signatures.md` for signed messages, permits, intents, or delegation.

Load local references as needed:

- `references/spec-workflow.md` for spec structure.
- `references/acceptance-criteria.md` for testable requirements.

Use `templates/ProtocolSpec.md` when creating a full spec.

## Spec Rules

- Identify actors before functions.
- Identify assets before accounting.
- Define trust assumptions explicitly.
- Define admin powers explicitly.
- Avoid implementation details until behavior is clear.
- Include invariants for accounting or custody.
- Include acceptance criteria that can become tests.
- Mark open questions only when they materially affect architecture.

## Output Format

```md
## Goal

## Actors

## Assets

## Contracts

## Core Flows

## State

## Permissions

## Invariants

## Failure Modes

## Tests And Acceptance Criteria

## Open Questions
```

## Safety Rule

Do not smooth over missing custody, oracle, upgrade, or admin assumptions. Surface them before implementation.
