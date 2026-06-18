# Roadmap

## Current Suite

Core:

- `solidity-builder`
- `solidity-auditor`
- `foundry-test-writer`
- `evm-deployment-engineer`

Advanced:

- `defi-accounting-engineer`
- `uniswap-v4-hook-engineer`
- `upgradeable-contract-engineer`
- `token-launch-builder`
- `protocol-spec-writer`

## Release Phases

### v1.1 Security And Engineering

- Add runnable security tool configs for Slither and Echidna.
- Add a non-blocking Slither CI scan over a temporary Foundry template project.
- Add gas optimization, AccessManager, and tool-output triage references.
- Add compile-checked ERC20Permit, ERC2981, ERC1271, ERC3156, ERC6909, and AccessManager templates.
- Keep the public nine-skill interface stable.

### v0.2.0 Quality Foundation

- Add suite validation for skill frontmatter, paths, examples, manifests, upload zips, and vendor-neutral reusable content.
- Add CI that runs suite validation and Foundry template compilation.
- Keep generated `dist/` artifacts ignored.

### v0.3.0 Core Solidity Templates

- Add compile-checked templates for ERC721, ERC1155, ERC4626, Merkle claims, vesting, governance/timelock, votes tokens, and CREATE2 deployment.
- Link those templates from the relevant skills, references, and examples.

### v0.4.0 Security Tooling Expansion

- Add reusable guidance for Slither, Echidna, Solidity SMTChecker, and optional advanced tools.
- Add property-testing escalation guidance and tool-finding triage templates.

### v0.5.0 Advanced Protocol Coverage

- Add references for EIP-712/permit, Permit2, oracle safety, account abstraction, bridges, L2 deployment differences, and governance operations.
- Expand DeFi accounting guidance for oracle normalization, exchange-rate manipulation, fee accrual, liquidation edge cases, and ERC4626 inflation risk.
- Add multi-skill workflow examples.

### v1.0.0 Release And Distribution Polish

- Add release asset packaging for upload zips, source archive, and checksums.
- Document Codex, Claude Code, ChatGPT upload, Cursor, and generic Markdown-agent compatibility.
- Freeze the public nine-skill interface unless a new skill is clearly justified.

### v1.2 Account Abstraction

- Add `account-abstraction-engineer` as a new tenth skill.
- Cover ERC-4337 smart accounts, EntryPoint assumptions, bundlers, paymasters, EIP-7702, and EOA delegation.

### v1.3 Oracle, L2, Cross-Chain, And MEV

- Add oracle integration references for Chainlink, Pyth, RedStone, stale prices, decimals, and L2 sequencer checks.
- Add L2/cross-chain deployment references for bridge trust, verification differences, CREATE2, and replay protection.
- Add MEV and market-mechanics guidance for slippage, deadlines, sandwich risk, TWAP windows, auctions, commit-reveal, and liquidations.

### v1.4 Full Example Projects

- Add complete Foundry example projects under `examples/projects/`.
- Include ERC20 launch, ERC4626 vault, staking rewards, upgradeable proxy, and governance/timelock examples.
- Each project should include contracts, tests, scripts, README, and audit notes.

### v1.5 Public Release

- Publish a GitHub release with upload zips, source zip, checksums, and release notes.

## Quality Goals

- Keep reusable skills vendor-neutral.
- Keep templates minimal, transparent, and auditable.
- Compile Solidity templates with Foundry.
- Document security assumptions without implying generated code is automatically safe.
- Keep shared references small, reusable, and directly linked from each skill.
