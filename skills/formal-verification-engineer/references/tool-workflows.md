# Formal Tool Workflows

## SMTChecker

Use `assert` properties for focused arithmetic and state-transition checks. Select BMC or CHC deliberately, pin solver and compiler versions, and treat warnings or unsupported constructs as coverage gaps.

## Halmos

Reuse small Foundry-style symbolic tests. Bound dynamic data, avoid unsupported cheatcodes, control path explosion, and reproduce counterexamples as concrete tests.

## Certora

Use CVL for multi-contract and parametric rules when the project has access to the external prover. Keep credentials outside the repository. Check rules with positive examples, ghosts, hooks, and explicit method summaries.

Tool disagreement is a reason to investigate modeling differences, not to select the preferred result.
