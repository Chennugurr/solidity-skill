# Cross-Chain And L2 Safety

Use this reference for L2 deployment, canonical bridges, cross-domain messaging, and replicated state.

## Message Identity

- Bind every message to source chain, destination chain, source sender, destination receiver, nonce, payload, and protocol version.
- Authenticate the canonical messenger and the reported cross-domain sender.
- Mark a message consumed before executing untrusted payload logic.
- Separate retryable execution from authorization so retries cannot alter the approved payload.

## Finality And Failure

- State whether acceptance depends on L1 finality, challenge periods, validity proofs, validator signatures, or an external committee.
- Define delayed, duplicated, reordered, censored, reverted, and permanently failed messages.
- Specify refund, cancellation, retry, and manual recovery authority.
- Do not assume a destination transaction implies economic finality on the source chain.

## L2 Families

- OP Stack and Base: account for L1/L2 messenger pairing, address aliasing where applicable, and withdrawal proof/finalization delays.
- Arbitrum: distinguish retryable tickets, delayed inbox paths, L1/L2 address aliasing, and outbox authentication.
- ZKsync and Scroll: verify chain-specific system contracts, proof finality, fee payment, and deployment bytecode rules.
- Polygon PoS and CDK deployments: distinguish validator/checkpoint trust from validity-proof and data-availability configurations.

## Deployment

Record chain ID, gas token, EVM version, predeploys, messenger and bridge addresses, explorer API, verification method, CREATE2 deployer, and finality assumptions. Fork tests requiring RPC credentials should remain opt-in.
