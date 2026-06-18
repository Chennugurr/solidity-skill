# Foundry Patterns

This compatibility reference keeps the Solidity Builder skill easy to inspect as a standalone folder.

For the canonical suite-wide guidance, load:

- `../../../shared/references/foundry-conventions.md`

## Builder Defaults

- Use `src/` for contracts, `test/` for Foundry tests, and `script/` for deployment scripts.
- Use `forge build` and `forge test` before calling templates ready.
- Include happy-path tests, revert tests, access-control tests, and multi-user tests where accounting matters.
- Add fuzz tests when inputs vary materially.
- Add invariant tests for solvency, share accounting, reward accounting, or balance conservation.
- Use `.env.example` for required environment variable names, never real secrets.
- Use deployment scripts with explicit constructor arguments, owner/admin addresses, and verification notes.
