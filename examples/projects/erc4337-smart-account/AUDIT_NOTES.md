# Audit Notes

- The example validates a single ECDSA owner and omits recovery, modules, batching policy, and upgrades.
- The local EntryPoint mock only exercises the account boundary and is not a bundler-conformance test.
- Sponsorship fixtures omit stake, deposit, `postOp`, reputation, and denial-of-service controls.
