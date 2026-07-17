# Account Security Checklist

- [ ] EntryPoint version, address, chain, code hash, and audit source verified
- [ ] Only EntryPoint can validate user operations
- [ ] Signature domain, nonce lanes, expiry, and ERC1271 behavior tested
- [ ] Factory initialization and deterministic address inputs bound
- [ ] Bundler simulation and ERC-7562 restrictions tested
- [ ] Paymaster sponsorship scope, budget, deposit, stake, and `postOp` failure bounded
- [ ] Module installation, execution, hooks, and removal authorized
- [ ] Session keys limited by target, selector, value, token, rate, and expiry
- [ ] Recovery delay, cancellation, threshold, and replay behavior tested
- [ ] EIP-7702 initialization, storage namespace, redelegation, and revocation tested
- [ ] Dry-run and independent review completed before any funded use
