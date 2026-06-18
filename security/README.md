# Security Tooling Configs

This folder contains starter configs for optional security-tooling workflows.

## Slither

```bash
slither . --config-file security/slither.config.json
```

Use this after the project compiles. Treat findings as review inputs that need triage, exploitability analysis, and tests.

## Echidna

```bash
echidna . --config security/echidna.yaml
```

Use this after writing explicit property or assertion harnesses. Preserve seeds, counterexamples, and configs when reporting results.

## Template Scan

```bash
python3 scripts/run-slither-template-check.py
```

This builds a temporary Foundry project from bundled Solidity templates and runs Slither when Slither is installed.
