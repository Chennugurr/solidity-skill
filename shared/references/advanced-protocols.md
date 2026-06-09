# Advanced Protocol Patterns

Use this reference when a task involves signatures, oracles, account abstraction, bridges, L2 deployment, or governance operations.

## EIP-712, Permit, And Permit2

- Include chain ID, verifying contract, nonce, deadline, and signer in the signed domain or typed data.
- Consume nonces exactly once.
- Reject expired signatures.
- Bind signatures to the intended action and value.
- Avoid signatures that can be replayed across contracts, chains, campaigns, or users.
- For Permit2, document allowance scope, spender, token, amount, expiry, and revocation expectations.

## Oracle Safety

- Define source, decimals, heartbeat, staleness threshold, and fallback behavior.
- Normalize prices and token decimals before arithmetic.
- Reject zero, negative, stale, or incomplete prices.
- Do not use low-liquidity spot prices as final settlement prices.
- Test stale data, decimal mismatches, paused feeds, and manipulated AMM prices.

## Account Abstraction

- Decide whether smart contract accounts can call every user flow.
- Avoid `tx.origin`.
- Do not assume `msg.sender` is an EOA.
- For signature flows, support ERC1271 only when the project intentionally supports contract wallets.
- Test bundler-like and contract-wallet callers for authorization-sensitive flows.

## Bridges And Cross-Chain Messaging

- Treat bridge or messenger contracts as explicit trust assumptions.
- Bind messages to source chain, destination chain, sender, recipient, nonce, and payload.
- Prevent replay across chains and deployments.
- Define finality, failure, retry, and cancellation behavior.
- Test duplicate messages, wrong source, wrong sender, malformed payload, and delayed execution.

## L2 Deployment Differences

- Confirm chain-specific block time, gas token, predeploy addresses, bridge addresses, and verification flow.
- Do not assume mainnet gas costs, finality, or opcode pricing applies.
- Check sequencer downtime and oracle liveness assumptions where relevant.
- Run fork or simulation tests against the target chain when integrations depend on live addresses.

## Governance And Admin Operations

- Prefer multisig or timelock ownership for production admin powers.
- Separate proposer, executor, canceller, pauser, upgrader, and treasury powers where useful.
- Document emergency powers and user trust assumptions.
- Test role handoff, timelock delay, proposal execution, cancellation, and privilege revocation.
- Avoid deploying with permanent EOA admin control unless the user explicitly accepts that risk.
