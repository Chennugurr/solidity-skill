# Tool Output Triage

Use this reference when interpreting Slither, Echidna, SMTChecker, or other automated tool output.

## Classification

Classify each item as:

- Confirmed issue: exploitable or correctness-breaking under realistic assumptions.
- Needs manual review: plausible but missing context.
- False positive: not exploitable for a clear reason.
- Informational: useful for maintenance, docs, or tests.
- Inconclusive: blocked by tool limits, timeout, or missing harness assumptions.

## Required Context

For every confirmed or dismissed item, record:

- tool and version if known;
- command/config;
- file and function;
- detector/property/rule name;
- impact and exploitability;
- reason for dismissal, if dismissed;
- recommended fix or test.

## Slither

- Start with high and medium findings.
- Filter dependency noise, but do not hide project findings.
- Review reentrancy, unchecked return, arbitrary send, delegatecall, upgrade, shadowing, and authorization findings carefully.
- Convert confirmed findings into regression tests.

## Echidna

- A failing sequence is evidence, not a final report.
- Preserve the seed, corpus, sequence, and config.
- Minimize the sequence manually when practical.
- Confirm the issue with a Foundry regression test.
- If no failure appears, state which properties were tested and which were not.

## SMTChecker

- Treat successful proofs as limited to encoded assertions.
- Treat timeouts as inconclusive.
- Inspect whether assumptions, external calls, or environment behavior were abstracted.
- Prefer small local assertions over broad vague proofs.

## Reporting

Do not say "the tool says this is safe." Say what was checked, what was found, what remains unreviewed, and what tests or manual review still matter.
