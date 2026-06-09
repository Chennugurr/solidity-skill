# Disclosure And Liquidity

## Required Disclosure

Document:

- Total supply.
- Mint authority.
- Burn behavior.
- Pause authority.
- Tax authority.
- Blacklist or allowlist authority.
- Wallet or transaction limits.
- Upgrade authority.
- Treasury control.
- Liquidity ownership.
- Vesting schedules.

## Liquidity Handling

If launching with liquidity:

- Define initial liquidity amount.
- Define pool or router.
- Define LP token recipient.
- Define whether LP tokens are locked, burned, or treasury-held.
- Do not claim liquidity is locked or burned unless the mechanism proves it.
- Document unlock dates and lock contract if applicable.

## Ownership

For production:

- Use multisig for owner/admin when admin powers remain.
- Avoid renouncing ownership if maintenance or emergency controls are needed.
- Do not present renounce as safety if other privileged controls remain.

