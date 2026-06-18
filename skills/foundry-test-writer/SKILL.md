---
name: foundry-test-writer
description: Write, expand, and review Foundry test suites for Solidity contracts, including unit, revert, fuzz, invariant, fork, and deployment-script tests.
---

# Foundry Test Writer

## Purpose

Use this skill to create or improve Foundry tests for Solidity contracts and EVM protocol systems.

The goal is to prove intended behavior, catch regressions, and encode security assumptions as executable tests.

## When To Use

Use this skill for:

- Writing Foundry tests from scratch.
- Expanding test coverage for existing contracts.
- Adding fuzz tests.
- Adding invariant tests.
- Adding fork tests for integrations.
- Testing deployment scripts.
- Reviewing test gaps after implementation or audit.

Do not use it for frontend tests, non-EVM tests, or generic Solidity implementation unless the output is primarily tests.

## Reference Loading

Load shared references as needed:

- `../../shared/references/foundry-conventions.md` for project layout and cheatcodes.
- `../../shared/references/security-posture.md` for security-relevant edge cases.
- `../../shared/references/mainnet-readiness.md` for production test expectations.
- `../../shared/references/security-tooling.md` for when Foundry fuzz/invariants should be escalated to external property or formal tools.
- `../../shared/references/gas-optimization.md` when adding gas snapshots or preventing gas regressions.

Load local references as needed:

- `references/unit-fuzz-invariant.md` for test strategy.
- `references/fork-and-deploy-tests.md` for integration and script tests.

Use templates in `templates/` when the user asks for test files or examples, including `templates/SecurityInvariantHarness.t.sol` for value-flow invariant harnesses.

## Test Design Rules

- Read the contract before writing tests.
- Test public behavior, not implementation details, unless internal accounting is the risk.
- Include positive-path and revert-path tests.
- Include unauthorized caller tests for every privileged function.
- Include multi-user ordering tests for accounting systems.
- Use fuzzing for variable amounts, durations, addresses, and configuration boundaries.
- Use invariants for conservation, solvency, and share/reward accounting.
- Use fork tests when external protocol behavior matters.
- Escalate from unit tests to fuzz tests, invariant tests, fork tests, and external property tools as protocol value and state-space complexity increase.

## Output Format

```md
## Test Strategy

## Test Files

## Key Cases

## Fuzz Tests

## Invariants

## Fork/Integration Tests

## Remaining Gaps
```

When editing a repo, add focused tests and explain what they cover.

## Safety Rule

Tests should catch unsafe assumptions, not merely confirm the current implementation. If the implementation looks wrong, call it out instead of writing tests that bless the bug.
