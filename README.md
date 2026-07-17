# Solidity Agent Skills

`solidity-agent-skills` is a public, MIT-licensed suite of twenty independently
loadable Solidity skills for coding agents that consume Markdown instructions.
The reusable content is vendor-neutral; product-specific metadata and loading
notes live only in plugin manifests and `adapters/`.

The repository is both a Markdown skill pack and a plugin package named
`solidity-skill` for supported Codex and Claude Code environments.

Current release: `v2.0.0`.

## Skills

Foundation:

- `solidity-builder`: contracts and bounded protocol components.
- `solidity-auditor`: evidence-based security reviews and findings.
- `foundry-test-writer`: unit, fuzz, invariant, fork, and deployment tests.
- `evm-deployment-engineer`: simulations, verification, role setup, and runbooks.

Protocol engineering:

- `defi-accounting-engineer`: shares, rewards, fees, liquidations, and solvency.
- `uniswap-v4-hook-engineer`: hook permissions, callbacks, and PoolManager tests.
- `upgradeable-contract-engineer`: proxies, initialization, storage, and migrations.
- `token-launch-builder`: transparent distribution, vesting, liquidity, and disclosure; begin with a dry-run plan.
- `protocol-spec-writer`: actors, flows, invariants, assumptions, and acceptance criteria.

Production engineering:

- `account-abstraction-engineer`: ERC-4337 v0.9, ERC-7579, EIP-7702, paymasters, and signers.
- `oracle-integration-engineer`: provider adapters, normalization, freshness, L2 checks, and fallbacks.
- `protocol-operations-engineer`: Safe batches, roles, address books, monitoring, and incidents.
- `formal-verification-engineer`: SMTChecker, Halmos, optional Certora, and counterexample triage.
- `cross-chain-l2-engineer`: major L2 families, bridge assumptions, finality, replay, retries, and recovery.

Protocol specialists:

- `lending-liquidation-engineer`: interest, collateral, health, liquidation, bad debt, and solvency.
- `stablecoin-engineer`: collateral models, peg controls, reserves, shutdown, and governance risk.
- `perpetuals-funding-engineer`: margin, PnL, funding, bankruptcy, ADL, oracles, and keepers.
- `intent-solver-engineer`: EIP-712 intents, Permit2, fills, settlement, replay, and MEV.
- `staking-restaking-engineer`: delegation, shares, rewards, slashing, unbonding, and withdrawals.
- `rwa-token-engineer`: restricted transfers, attestations, freezes, disclosures, and auditability.

Every public entrypoint is `skills/<skill-name>/SKILL.md`. Shared references are
loaded conditionally from `shared/references/`; they are not standalone skills.

## Quick Start

1. Choose the narrowest skill that owns the task.
2. Give the agent access to its `SKILL.md`, `references/`, and `templates/`.
3. Keep `shared/references/` readable and load only the files the skill requests.
4. Hand work between skills when the task crosses role boundaries.

```text
Use protocol-spec-writer to define this lending market, lending-liquidation-engineer
to review its economics, foundry-test-writer to build invariants, and
solidity-auditor to report residual risk.
```

## Engineering Assets

- `security/`: Slither, Echidna, and pinned upgrade-validation tooling.
- `evals/`: one vendor-neutral prompt case and stored baseline per public skill.
- `examples/projects/`: five standalone Foundry projects with exact dependency locks.
- `scripts/`: suite validation, project tests, formal checks, packaging, and release assets.
- `.github/workflows/ci.yml`: blocking structure, compile, project, upgrade, SMTChecker, and Halmos checks; Slither remains non-blocking for triage.

The standalone projects cover an ERC4626 vault, UUPS staking migration, ERC-4337
smart account, multi-provider oracle lending component, and Governor/Timelock
workflow. They pin Solidity `0.8.36`, OpenZeppelin `5.6.1`, and forge-std `1.16.2`.

## Validate

Install the Python validation dependency, then run the complete local checks.
Operational examples use dry-run or local execution unless explicitly configured.

```bash
python3 -m pip install -r requirements-dev.txt
python3 scripts/validate-suite.py --package --compile-templates --test-projects --formal-tools --upgrade-validation --external-plugin-validators
```

Run deterministic skill evaluations separately when iterating on prompts:

```bash
python3 scripts/run-skill-evals.py --replay-baselines
```

## Distribution

- Codex plugin metadata: `.codex-plugin/plugin.json`
- Claude Code plugin metadata: `.claude-plugin/plugin.json`
- Cursor and generic loading notes: `adapters/`
- Single-skill upload archives: `python3 scripts/package-upload-skills.py`
- GitHub release assets and checksums: `python3 scripts/build-release-assets.py`

The package intentionally has no CLI product, MCP server, app, hooks,
marketplace entry, or installer. See `docs/distribution.md` for the compatibility
matrix.

## Safety

Templates, generated contracts, and example projects are educational drafts.
Before production or mainnet use, pin the intended chain environment, run unit,
fuzz, invariant, fork, and integration tests as applicable, review operational
controls, obtain independent security review, and commission an audit when value
or users are at risk. RWA work also requires qualified legal review.

See `SECURITY.md`, `CONTRIBUTING.md`, and the [MIT license](LICENSE).
