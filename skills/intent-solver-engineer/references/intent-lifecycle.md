# Intent Lifecycle

- Domain-separate by chain and settlement contract.
- Sign input/output assets, maximum input, minimum output, recipient, fee limits, nonce, deadline, and allowed execution scope.
- Track cumulative fill and round against the solver when enforcing user limits.
- Consume or update fill state before external calls.
- Define cancellation authorization, propagation, race behavior, and whether nonces may be invalidated in batches.
- Treat Permit2 allowance and intent validity as separate capabilities with separate expiry and revocation.
- Make settlement atomic or define escrow and recovery explicitly.
