---
name: formal-verification-engineer
description: Convert Solidity requirements and invariants into executable formal properties using SMTChecker, Halmos, and optional Certora workflows, with explicit assumptions, coverage, and counterexample triage.
---

# Formal Verification Engineer

## Purpose

Use this skill when critical properties need stronger evidence than example and fuzz testing can provide.

Do not use formal-tool success as proof that an incomplete or incorrect specification expresses the intended system.

## Reference Loading

- Load `references/property-workflow.md` for deriving and reviewing properties.
- Load `references/tool-workflows.md` for SMTChecker, Halmos, and Certora selection.
- Load `../../shared/references/security-tooling.md` for escalation from tests to analysis tools.
- Load `../../shared/references/tool-output-triage.md` for counterexample handling.
- Load the relevant domain skill before specifying protocol-specific accounting or authorization.

Use `templates/SmtCheckerExample.sol`, `templates/HalmosExample.t.sol`, `templates/Example.spec`, and `templates/certora.conf` as minimal tool fixtures.

## Workflow

1. Extract assets, actors, state transitions, trust assumptions, and candidate invariants.
2. Separate assumptions, preconditions, safety properties, liveness expectations, and environmental bounds.
3. Choose the smallest tool capable of exploring the required state space.
4. Run positive and intentionally failing controls before trusting a property.
5. Triage counterexamples, unsupported behavior, timeouts, and vacuous proofs.
6. Report proven scope and unverified behavior explicitly.

## Output Format

```md
## Verification Goal
## Formal Model And Assumptions
## Properties
## Tool And Bounds
## Results And Counterexamples
## Coverage Gaps
## Recommended Tests Or Design Changes
```

## Safety Rule

Never claim a contract is correct because a bounded model, symbolic test, or formal specification passed. State exactly what was checked and under which assumptions.
