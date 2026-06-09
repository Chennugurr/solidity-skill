# Launch Mechanics

## Token Defaults

- Fixed supply unless minting is requested.
- No taxes by default.
- No blacklist by default.
- No max wallet by default.
- No max transaction by default.
- No transfer delay by default.
- No trading enable switch by default.
- No upgradeability by default.
- No owner if there are no owner functions.

## If Minting Exists

- Define who can mint.
- Define whether supply is capped.
- Define when minting can happen.
- Add unauthorized mint tests.
- Disclose mint authority.

## If Taxes Exist

- Make taxes explicit.
- Cap tax rates.
- Emit events for tax changes.
- Explain recipient and use of fees.
- Test fee limits and excluded addresses.

## If Transfer Restrictions Exist

- Explain why restrictions exist.
- List who can change them.
- Test restricted and unrestricted transfers.
- Avoid owner bypasses unless disclosed.

## Allocations

Define allocations for:

- Community.
- Liquidity.
- Treasury.
- Team.
- Investors.
- Advisors.
- Ecosystem incentives.

Define vesting or lock terms for privileged allocations.

