# Intent Solver Example Prompts

Use `intent-solver-engineer` for prompts such as:

```text
Design an EIP-712 swap intent with Permit2, unordered nonces, partial fills, fee limits, cancellation, open solver competition, and user-owned surplus. Add replay and malicious-callback tests.
```

Expected behavior: bind all user constraints in signed data, separate token approval from settlement authority, and analyze solver and MEV behavior.
