# Example: Full Protocol Workflow

## Prompt

```text
Use protocol-spec-writer, solidity-builder, foundry-test-writer, solidity-auditor, and evm-deployment-engineer.

Turn this idea into a production-minded draft:
An ERC4626 vault accepts USDC, issues shares, streams rewards, has a multisig-owned reward manager, and deploys first to Sepolia.
First write the spec, then build contracts, then write tests, then review the result, then prepare deployment notes.
Consult shared/references/security-posture.md, shared/references/security-tooling.md, and shared/references/mainnet-readiness.md.
```

## Expected Agent Behavior

- Produce the spec before code.
- Keep assumptions and trust boundaries visible.
- Add unit, fuzz, invariant, and deployment-script tests where useful.
- Review security and accounting risks before deployment notes.
- State remaining review and audit needs.
