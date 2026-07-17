---
name: account-abstraction-engineer
description: Design, implement, test, and review ERC-4337 smart accounts, factories, EntryPoint integrations, bundlers, paymasters, ERC-7579 modules, EIP-7702 delegation, recovery, and session-key authorization.
---

# Account Abstraction Engineer

## Purpose

Use this skill for programmable account systems whose authorization or gas flow depends on ERC-4337 or EIP-7702.

Do not use it for ordinary protocol support of contract wallets; use signature and access-control guidance unless the account itself is being designed.

## Reference Loading

- Load `references/erc4337-architecture.md` for UserOperation, EntryPoint, factory, bundler, and paymaster design.
- Load `references/delegation-modules.md` for ERC-7579, EIP-7702, recovery, and session keys.
- Load `../../shared/references/signatures.md` for typed-data and replay safety.
- Load `../../shared/references/modern-evm.md` for delegated EOA and storage assumptions.
- Load `../../shared/references/security-posture.md` before reviewing custody or privileged recovery.

Use `templates/AccountSecurityChecklist.md` for designs and reviews. Treat `templates/TestOnlyPaymaster.sol` as a test fixture, never a live paymaster.

## Workflow

1. Identify the supported EntryPoint version and verify its address and code hash.
2. Define account creation, ownership, validation, execution, nonce, upgrade, and recovery flows.
3. Separate account, factory, bundler, paymaster, module, and relayer trust assumptions.
4. Check ERC-7562 validation constraints and gas-denial paths.
5. Test signatures, replay, undeployed accounts, nonce keys, deposits, sponsorship, modules, recovery, and redelegation.

## Output Format

```md
## Account Model
## EntryPoint And UserOperation Flow
## Authorization And Recovery
## Factory, Bundler, And Paymaster Assumptions
## Modules And Delegation
## Security Properties
## Tests And Operational Risks
```

## Safety Rule

Never describe a custom account, paymaster, recovery system, or delegate as safe without adversarial tests, independent review, and explicit loss-of-control analysis.
