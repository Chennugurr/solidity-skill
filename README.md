# solidity-agent-skills

`solidity-agent-skills` is a public open-source Solidity skill pack for coding agents that can consume Markdown instructions.

It is intentionally vendor-neutral. The core skills are not tied to any single agent runtime. Product-specific notes live in `adapters/`, while the reusable skills live in `skills/`.

This repository is also packaged as both a Codex plugin and a Claude Code plugin named `solidity-skill`. Product-specific plugin metadata lives in `.codex-plugin/plugin.json` and `.claude-plugin/plugin.json`; the reusable skill content remains Markdown-first and vendor-neutral.

Current suite target: `v1.1-security-and-engineering`.

## What Is Included

Core skills:

- `skills/solidity-builder/`: build and modify Solidity contracts.
- `skills/solidity-auditor/`: review contracts, specs, tests, and deployments for security issues.
- `skills/foundry-test-writer/`: write unit, fuzz, invariant, fork, and deployment tests.
- `skills/evm-deployment-engineer/`: prepare deployment scripts, verification, role setup, and runbooks.

Advanced skills:

- `skills/defi-accounting-engineer/`: design and review vault, reward, fee, liquidation, and solvency accounting.
- `skills/uniswap-v4-hook-engineer/`: design, review, and test Uniswap v4 hooks.
- `skills/upgradeable-contract-engineer/`: handle proxy patterns, storage layout, and upgrade plans.
- `skills/token-launch-builder/`: build transparent token launch mechanics and disclosure checklists.
- `skills/protocol-spec-writer/`: turn rough protocol ideas into implementation-ready specs.

Shared support:

- `shared/`: reusable security, Foundry, OpenZeppelin, gas, access-management, security tooling, advanced protocol, and mainnet-readiness references.
- `security/`: Slither and Echidna starter configs for security-tooling workflows.
- `.codex-plugin/plugin.json`: Codex plugin manifest that loads the nine skills from `./skills/`.
- `.claude-plugin/plugin.json`: Claude Code plugin manifest; Claude Code auto-discovers the root `skills/` directory.
- `adapters/`: notes for using the skill suite with different agent environments.
- `examples/`: sample prompts and expected usage patterns.
- `docs/`: design notes and roadmap.
- `scripts/validate-suite.py`: structural validation, packaging checks, manifest checks, and optional Solidity template compilation.
- `.github/workflows/ci.yml`: GitHub Actions workflow for validation and template compilation.

## Quick Start

1. Clone or copy this repository.
2. Pick the skill that matches the job.
3. Point your agent to that skill's `SKILL.md`.
4. When a task needs deeper details, have the agent load the relevant files in that skill's `references/` and `shared/references/`.
5. Use files in `templates/` as starting points when concrete artifacts are requested.

Example prompt:

```text
Use the solidity-builder skill to create a fixed-supply ERC20 with Foundry tests and a deploy script.
```

Skill handoff example:

```text
Use protocol-spec-writer to turn this idea into a spec, solidity-builder to implement it, foundry-test-writer to test it, solidity-auditor to review it, and evm-deployment-engineer to prepare deployment.
```

## Codex Plugin

The plugin manifest is intentionally small:

- It declares the plugin name, version, metadata, and UI copy.
- It points Codex at `./skills/`.
- It does not include a CLI, MCP server, app manifest, hooks, icons, screenshots, or marketplace entry.

The public skill entrypoints remain the nine `skills/<skill-name>/SKILL.md` files.

## Claude Code Plugin

The Claude Code plugin manifest is intentionally small:

- It declares the plugin name, display name, version, metadata, and repository.
- It relies on Claude Code's default root `skills/` discovery.
- It does not include commands, agents, hooks, MCP servers, LSP servers, monitors, settings, or marketplace files.

After installing or loading it in Claude Code, skills are namespaced under the plugin name, such as `/solidity-skill:solidity-builder`.

## ChatGPT Skill Uploads

Some skill upload UIs accept one skill at a time as a `.zip` with `SKILL.md` at the zip root. Generate those upload-ready archives with:

```bash
python3 scripts/package-upload-skills.py
```

This writes one zip per skill to `dist/`, including bundled shared references under `references/shared/`. For a first upload, use `dist/solidity-builder.zip`.

## Validation And Release Assets

Validate the suite locally:

```bash
python3 scripts/validate-suite.py --package --compile-templates --external-plugin-validators
```

Build GitHub release assets:

```bash
python3 scripts/build-release-assets.py
```

See `docs/distribution.md` for the compatibility matrix and upload/release notes.

## Template Coverage

The builder skill includes compile-checked starter templates for ERC20, ERC20Permit, ERC721, ERC2981, ERC1155, ERC6909, ERC4626, ERC1271, ERC3156 flash minting, AccessManager-managed ERC20, staking rewards, Merkle claims, vesting, governance/timelock, votes tokens, Foundry tests, and Foundry deploy scripts including CREATE2.

## Skill Philosophy

This repository treats skills as compact, reusable operating instructions for AI coding agents. A skill should:

- Prefer safe defaults over clever code.
- State assumptions when requirements are incomplete.
- Keep `SKILL.md` focused.
- Move longer reference material into `references/`.
- Avoid vendor-specific assumptions in the reusable skill body.
- Treat generated smart contracts as drafts that require human review, tests, and audits before mainnet.
- Keep each skill independently loadable instead of merging the suite into one giant prompt.

## Safety Notice

Generated contracts can contain bugs, incomplete assumptions, or unsafe economics. Before deploying any generated Solidity to mainnet, run tests, fuzz where useful, review access control, verify integrations, and get an independent security review or audit.

## License

MIT. See [LICENSE](LICENSE).
