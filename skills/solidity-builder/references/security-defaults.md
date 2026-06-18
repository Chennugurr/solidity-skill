# Security Defaults

This compatibility reference keeps the Solidity Builder skill easy to inspect as a standalone folder.

For the canonical suite-wide guidance, load:

- `../../../shared/references/security-posture.md`
- `../../../shared/references/openzeppelin-defaults.md`
- `../../../shared/references/mainnet-readiness.md`

## Builder Defaults

- Prefer simple, non-upgradeable contracts unless upgradeability is explicitly requested.
- Prefer OpenZeppelin primitives for standard token, access-control, governance, and security patterns.
- Use `SafeERC20` for ERC20 transfers.
- Use custom errors for important validation failures.
- Emit events for meaningful state changes.
- Avoid hidden owner powers, hidden minting, hidden taxes, fake burns, fake renounce flows, honeypots, and backdoors.
- Avoid `tx.origin`, unsafe low-level calls, and unbounded loops over user-controlled arrays.
- Treat generated contracts as drafts that need tests, review, and security review before production.
