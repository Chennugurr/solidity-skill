# Security Tooling

Use tools to support review, not replace review. Tool findings need triage, exploitability analysis, and targeted tests.

## Slither

Use Slither for fast static analysis and code comprehension.

Good uses:

- Run `slither .` from the project root after dependencies compile.
- Review high and medium detector output first.
- Use printers for inheritance, authorization, storage, and function summaries.
- Treat noisy findings as triage work, not automatic dismissals.
- Add regression tests for confirmed findings.

Common pitfalls:

- A clean Slither run does not prove safety.
- False positives still need explicit rationale.
- Generated or dependency code may need filtering so project findings remain readable.

## Echidna

Use Echidna when properties need long stateful call sequences or independent fuzzing beyond the normal unit test suite.

Good uses:

- Encode value-preservation, solvency, authorization, and supply invariants.
- Prefer small harnesses with explicit actors and bounded setup.
- Save counterexample sequences and convert important ones into regression tests.
- Run against the project build when dependencies matter.

Common pitfalls:

- Weak properties can pass while the protocol is still broken.
- Harness-only assumptions can hide real attack paths.
- Long campaigns need stable seeds and documented config.

## Solidity SMTChecker

Use the Solidity SMTChecker for local assertions and arithmetic or state-machine properties that fit solver limits.

Good uses:

- Add `assert` statements for small, local invariants.
- Use model-checker targets deliberately, especially for arithmetic checks.
- Keep checked examples small and deterministic.
- Treat solver timeouts and unsupported features as inconclusive.

Common pitfalls:

- Solver success only covers the encoded property.
- External calls and complex environment behavior may be abstracted.
- A failed proof may mean a real bug, an under-specified assumption, or a solver limitation.

## Optional Advanced Tools

Consider specialized tools when risk justifies the effort:

- Medusa for high-throughput fuzzing campaigns.
- Halmos for symbolic tests over Foundry-style properties.
- Certora or similar rule-based verification for high-value protocols with stable specs.
- Differential testing for upgrades, refactors, and accounting rewrites.

## Output Expectations

When reporting tool results:

- State command/config used.
- Separate confirmed issues, likely false positives, and inconclusive results.
- Include affected files/functions.
- Explain exploitability or why it is not exploitable.
- Recommend code fixes and tests.
- Never summarize a tool run as an audit.
