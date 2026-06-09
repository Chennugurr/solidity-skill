# Mainnet Readiness

Use this reference before describing any contract, test suite, launch, upgrade, or deployment as production ready.

## Minimum Readiness Checklist

- Unit tests exist.
- Revert tests exist.
- Access-control tests exist.
- Fuzz tests exist where inputs vary.
- Invariant tests exist where accounting matters.
- Fork tests exist for external integrations.
- Admin roles and owner powers are documented.
- Emergency controls are documented.
- Oracle assumptions are documented.
- Upgradeability risks are documented if applicable.
- Deployment script exists.
- Contract source can be verified.
- Constructor or initializer arguments are recorded.
- Ownership or admin roles are transferred to intended production accounts.
- No hidden owner powers exist.
- No unbounded user loops exist.
- No obvious stuck-funds path exists.
- No unsafe token transfer assumptions exist.
- No replay protection is missing for signatures or messages.
- No unchecked arithmetic exists without explanation.

## Deployment Review

Before broadcast:

1. Confirm chain ID and RPC endpoint.
2. Confirm deployer address and balance.
3. Confirm private key handling.
4. Confirm constructor or initializer arguments.
5. Confirm token, treasury, oracle, router, and admin addresses.
6. Run tests from a clean checkout.
7. Run fork simulation where integrations exist.
8. Record expected deployed addresses if deterministic deployment is used.

After broadcast:

1. Save transaction hashes and deployed addresses.
2. Verify source code.
3. Confirm constructor or initializer arguments.
4. Confirm owner and roles.
5. Confirm treasury and integration addresses.
6. Run read-only smoke checks.
7. Execute one small live transaction if safe.
8. Transfer ownership or admin roles to multisig or timelock when appropriate.
9. Revoke temporary deployer permissions.
10. Update downstream configuration.

## Audit And Review Language

Use cautious wording:

```text
This is a production-readiness checklist, not a guarantee of safety. Mainnet deployment should still include independent review and, for value-bearing systems, an audit.
```

Do not imply an audit is complete unless the user provides an audit report or asks you to summarize one.

