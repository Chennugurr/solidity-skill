# Delegation, Modules, And Recovery

## ERC-7579 Modules

- Classify validator, executor, hook, and fallback modules.
- Authenticate installation and removal and prevent a module from escalating its own authority.
- Define behavior when a module reverts, becomes unavailable, or is compromised.
- Test module ordering, selector collisions, uninstall cleanup, and upgrade compatibility.

## EIP-7702

- Bind authorizations to chain, nonce, and delegate implementation.
- Protect initialization because delegated code executes in the EOA storage context.
- Treat redelegation as an upgrade and use namespaced storage to prevent collisions.
- Revocation changes code delegation but does not erase account storage.

## Session Keys And Recovery

- Limit session keys by target, selector, token, amount, rate, chain, and expiry.
- Prevent nested calls or delegate calls from bypassing policy.
- Give recovery a delay, cancellation path, and observable guardian threshold.
- Test owner compromise, guardian compromise, stale sessions, concurrent recovery, and cancellation.
