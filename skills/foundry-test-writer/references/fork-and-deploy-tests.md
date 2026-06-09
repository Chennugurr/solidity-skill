# Fork And Deployment Tests

## Fork Tests

Use fork tests when behavior depends on deployed contracts or live protocol state.

Cover:

- Token decimals and non-standard token behavior.
- Router, pool, or vault integration.
- Oracle responses and staleness.
- Allowance and approval flows.
- Slippage and deadline behavior.
- Chain-specific addresses.

Keep fork tests deterministic:

- Pin block numbers when possible.
- Avoid relying on current mempool or volatile state.
- Use known whale or fixture accounts only when appropriate.
- Document required RPC environment variables.

## Deployment Script Tests

Deployment scripts should be tested when constructor arguments, role setup, or post-deploy configuration matter.

Cover:

- Required env vars.
- Constructor arguments.
- Initial owner and roles.
- Treasury and integration addresses.
- Verification metadata assumptions.
- Ownership transfer or role revocation flow.

Use local broadcast simulation where possible before mainnet deployment.

