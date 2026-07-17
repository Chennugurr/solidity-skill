# Intent Security Checklist

- [ ] Chain and settlement contract included in EIP-712 domain
- [ ] Assets, limits, recipient, fees, nonce, and deadline signed
- [ ] Token approval separated from intent validity
- [ ] Partial fills round against the solver and cannot overfill
- [ ] Cancellation and fill races tested
- [ ] Arbitrary callbacks and approval escalation blocked
- [ ] Solver competition, surplus, censorship, and failure disclosed
