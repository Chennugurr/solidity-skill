# solidity-agent-skills

`solidity-agent-skills` is a public open-source Solidity skill pack for coding agents that can consume Markdown instructions.

It is intentionally vendor-neutral. The core skills are not tied to any single agent runtime. Product-specific notes live in `adapters/`, while the reusable skills live in `skills/`.

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

- `skills/_shared/`: reusable security, Foundry, OpenZeppelin, and mainnet-readiness references.
- `adapters/`: notes for using the skill suite with different agent environments.
- `examples/`: sample prompts and expected usage patterns.
- `docs/`: design notes and roadmap.

## Quick Start

1. Clone or copy this repository.
2. Pick the skill that matches the job.
3. Point your agent to that skill's `SKILL.md`.
4. When a task needs deeper details, have the agent load the relevant files in that skill's `references/` and `skills/_shared/references/`.
5. Use files in `templates/` as starting points when concrete artifacts are requested.

Example prompt:

```text
Use the solidity-builder skill to create a fixed-supply ERC20 with Foundry tests and a deploy script.
```

Skill handoff example:

```text
Use protocol-spec-writer to turn this idea into a spec, solidity-builder to implement it, foundry-test-writer to test it, solidity-auditor to review it, and evm-deployment-engineer to prepare deployment.
```

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
