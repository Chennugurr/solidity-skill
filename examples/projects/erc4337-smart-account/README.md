# ERC-4337 Smart Account Project

This standalone Foundry project demonstrates an ERC-4337 v0.9 account, deterministic factory, owner signatures, EntryPoint-only validation, replay checks, and a deliberately limited test paymaster.

```bash
forge soldeer install
forge test
```

Use `account-abstraction-engineer`, `foundry-test-writer`, and `solidity-auditor` when adapting it. Verify the target EntryPoint address and code hash; never use the test paymaster with real funds.
