# Review Workflow

## 1. Scope The Review

Identify:

- Contracts and scripts in scope.
- Assets held or controlled.
- Privileged roles.
- External dependencies.
- Upgradeability model.
- Oracle, AMM, bridge, and signature assumptions.
- Tests and deployment scripts available.

State anything important that is out of scope.

## 2. Build A Threat Model

List actors:

- Ordinary users.
- Admins and role holders.
- Keepers or operators.
- Integrators.
- Token contracts.
- Oracle providers.
- MEV searchers.
- Governance participants.
- Attackers with flash liquidity.

For each actor, identify permissions, incentives, and realistic attack surfaces.

## 3. Review Core Flows

Trace value and authority:

- Deposit, mint, stake, buy, bridge, or initialize.
- Withdraw, redeem, claim, unstake, sell, or exit.
- Admin configuration.
- Emergency controls.
- Reward, fee, and accounting updates.
- Upgrade and ownership transfer.

Check state updates, external calls, events, and reverts for each flow.

## 4. Review Tests

Identify missing:

- Unauthorized caller tests.
- Zero address and zero amount tests.
- Multi-user ordering tests.
- Fuzz tests for variable inputs.
- Invariant tests for accounting.
- Fork tests for external integrations.
- Upgrade and migration tests.
- Failure-mode tests for non-standard tokens or stale oracles.

## 5. Run Or Review Tooling

Use tools as supporting evidence:

- Run or request Slither output for static analysis.
- Review Foundry fuzz and invariant coverage.
- Recommend Echidna or another property tool when long stateful call sequences matter.
- Recommend SMTChecker or formal rules for small critical invariants.
- Triage findings into confirmed issues, false positives, informational items, and manual-review items.

Do not treat tool output as a complete audit.

## 6. Write Findings

Each finding should include:

- Severity.
- Location.
- Impact.
- Exploit scenario or failure path.
- Recommendation.
- Tests that would catch the issue.

Avoid vague phrasing. If the issue depends on an assumption, state the assumption.
