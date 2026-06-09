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

## Airdrops And Claims

For launch airdrops:

- Prefer pull-based Merkle claims over pushing to a large list.
- Define the leaf format and publish it for reproducibility.
- Track claimed accounts or claimed leaves.
- Include a deadline if unclaimed funds may be clawed back.
- Disclose who can claw back and where funds go.
- Test invalid proof, duplicate claim, expired claim, and clawback timing.

Use `../../solidity-builder/templates/MerkleClaim.sol` as a draft pattern when the builder skill is also available.

## Vesting

For team, investor, advisor, or treasury vesting:

- Define beneficiary, token, start, cliff, duration, and release cadence.
- Prefer pull-based release.
- Avoid revocation unless it is explicitly disclosed.
- If revocation exists, define who receives unvested tokens.
- Test before cliff, partial vesting, full vesting, repeated release, and edge timestamps.

Use `../../solidity-builder/templates/TokenVesting.sol` as a draft pattern when the builder skill is also available.

## Governance Or Timelock Launches

If admin powers remain after launch:

- Prefer multisig or timelock ownership.
- Disclose upgrade, mint, pause, tax, blacklist, rescue, and liquidity powers.
- Document when temporary deployer powers are revoked.
- Include post-launch verification steps for ownership and roles.
