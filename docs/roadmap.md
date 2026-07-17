# Roadmap

## v2.0.0: Production Engineering Suite

The public interface now contains twenty independently loadable skills. This
release preserves the original nine names and adds account abstraction, oracle
integration, protocol operations, formal verification, cross-chain/L2 work, and
six protocol-specialist roles.

Delivered:

- Focused signature, oracle, cross-chain, modern EVM, reproducible-build,
  operations, and MEV references with a compatibility index.
- Compile-checked components and harnesses for every new specialist role.
- Five pinned standalone Foundry projects with unit, fuzz, and invariant tests.
- Blocking SMTChecker, Halmos `0.3.3`, and OpenZeppelin upgrade-layout checks.
- Twenty prompt evaluation cases with deterministic stored baselines.
- Twenty single-skill upload archives plus source and checksum release assets.

## Completed History

- `v0.2.0`: structure, path, manifest, package, and template CI validation.
- `v0.3.0`: core ERC, vault, claim, vesting, governance, and CREATE2 templates.
- `v0.4.0`: Slither, Echidna, SMTChecker, and property-testing guidance.
- `v0.5.0`: signatures, oracle, L2, bridge, governance, and accounting references.
- `v1.0.0`: plugin and upload distribution documentation and release packaging.
- `v1.1.0`: security configs, gas guidance, AccessManager, and modern ERC templates.

## After v2

- Keep the twenty public names stable unless a role has a genuinely distinct
  workflow, threat model, and sustained reference set.
- Expand provider-specific material only when it can be pinned and tested.
- Add opt-in deterministic fork fixtures without making RPC credentials a CI
  requirement.
- Grow evaluation quality with reviewed adversarial fixtures and adapter runs.
- Track compiler, EVM, OpenZeppelin, account-abstraction, and oracle-provider
  changes through explicit compatibility releases.

## Quality Rules

- Reusable skill content stays vendor-neutral.
- Security and operational checks precede gas optimization.
- Examples remain educational drafts, not production-complete protocols.
- Dry-run simulations precede any real deployment or privileged operation.
- Mainnet-facing work requires independent review and appropriate audits.
