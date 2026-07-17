# Signature And Replay Safety

Use this reference for EIP-712 messages, permits, delegated execution, smart-account signatures, and intent settlement.

## Domain Binding

- Bind signatures to the chain ID and verifying contract.
- Include the action, signer, recipient, value, nonce, deadline, and relevant configuration in typed data.
- Recompute the domain separator safely after a chain-ID change.
- Do not accept opaque hashes when typed structured data can describe the action.

## Nonces And Lifetimes

- Consume a nonce exactly once and before any untrusted external interaction.
- Choose sequential, bitmap, or unordered nonces deliberately; document cancellation behavior.
- Reject expired signatures and define whether a zero deadline means no expiry.
- Bind partial fills to the original amount and track cumulative fill without rounding past the signed limit.

## Signer Types

- Use a signature checker that supports ERC1271 when contract wallets are intentionally supported.
- Treat EIP-7702 delegated EOAs as code-bearing accounts; never infer signer type from `code.length` alone.
- Reject malleable ECDSA signatures and invalid `s` or `v` values.
- Define threshold, recovery, guardian, and session-key authority independently.

## Tests

Test wrong chain, wrong contract, wrong caller, reused nonce, expired deadline, malformed signature, ERC1271 failure, partial-fill overflow, cancellation, and delegation changes.
