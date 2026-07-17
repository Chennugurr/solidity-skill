# Account Abstraction Example Prompts

Use `account-abstraction-engineer` for prompts such as:

```text
Design an ERC-4337 v0.9 smart account with deterministic factory deployment, owner signatures, keyed nonces, recovery delay, and a narrowly scoped test paymaster. Include Foundry tests for replay, invalid EntryPoint callers, sponsorship griefing, and recovery cancellation.
```

Expected behavior: verify the EntryPoint version and trust model, separate account/factory/paymaster roles, load signature and delegation guidance, and avoid claiming the account is ready for funded use.
