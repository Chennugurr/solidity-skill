# Modern EVM Compatibility

Use this reference when selecting compiler or EVM targets, using recent opcodes, or supporting delegated accounts.

## Compiler And Target

- Pin the exact Solidity compiler, optimizer runs, `via_ir` setting, and EVM version.
- Confirm the target chain has activated every opcode emitted for that EVM version.
- Do not deploy bytecode containing unsupported opcodes even if local tests pass.
- Re-run bytecode and gas comparisons whenever compiler settings change.

## Transient Storage

- Use EIP-1153 transient storage only on chains that support it.
- Treat transient values as transaction-scoped shared state across internal call frames and delegate calls.
- Clear locks and temporary authorization along every successful path; test reentrancy and nested calls.
- Keep a persistent-storage fallback when deployment targets are mixed.

## Namespaced Storage

- Use ERC-7201-style namespaced storage for modular and upgradeable systems when supported by the framework.
- Keep namespace identifiers unique and stable.
- Validate layout changes automatically before upgrades.

## Delegated EOAs

- EIP-7702 changes assumptions about EOAs, code, storage, and signature validation.
- Bind authorizations to chain, nonce, and delegate; protect delegate initialization.
- Treat redelegation as an upgrade and check storage compatibility.
- Never use `tx.origin` or `code.length` as an authorization shortcut.
