# Verification And Post-Deploy Checks

## Verification

Record:

- Compiler version.
- Optimizer settings.
- EVM version.
- Constructor arguments.
- Library addresses.
- Proxy and implementation addresses if applicable.

If automatic verification fails:

- Save the failure output.
- Confirm constructor argument encoding.
- Confirm compiler and optimizer settings.
- Retry with explicit verifier options.
- Do not redeploy solely because verification failed unless the deployed bytecode is wrong.

## Smoke Checks

Run read-only checks:

- Contract name, symbol, decimals, and total supply for tokens.
- Owner and role holders.
- Treasury address.
- Oracle address and latest price validity.
- Reward rate and period finish.
- Pause status.
- Upgrade admin or implementation address.
- Critical configuration values.

## Operational Notes

- Document how emergency pause works if present.
- Document who can upgrade or change config.
- Document monitoring thresholds.
- Document how to rotate roles.
- Document how to recover from failed verification or misconfiguration.

