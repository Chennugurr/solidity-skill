# Example: Security Tooling

## Prompt

```text
Use skills/solidity-auditor/SKILL.md and skills/foundry-test-writer/SKILL.md.

Run or prepare a security-tooling pass for this Foundry project.
Use security/slither.config.json for Slither, security/echidna.yaml for Echidna-style property campaigns, and skills/foundry-test-writer/templates/SecurityInvariantHarness.t.sol as a starting invariant harness.
Classify tool findings using shared/references/tool-output-triage.md.
```

## Expected Agent Behavior

- Compile the project before static or property analysis.
- Separate confirmed findings, false positives, and inconclusive results.
- Preserve seeds, command lines, configs, and counterexample sequences.
- Convert confirmed findings into regression tests.
- Avoid claiming automated tools are equivalent to an audit.
