# Proxy Patterns

## Default

Default to non-upgradeable contracts unless upgradeability is explicitly required.

## UUPS

Use UUPS when:

- The implementation controls upgrade authorization.
- The project wants a lighter proxy.
- Tests cover `_authorizeUpgrade`.

Risks:

- Bad authorization can allow malicious upgrades.
- Implementation initialization mistakes can be severe.
- Storage layout must be preserved.

## Transparent Proxy

Use Transparent proxy when:

- Proxy admin separation is desired.
- The team prefers admin-managed upgrades.

Risks:

- Proxy admin compromise controls upgrades.
- Admin/user function selector confusion must be understood.
- Operational complexity is higher.

## Beacon Proxy

Use Beacon only when many proxies intentionally share an implementation source.

Risks:

- Beacon compromise affects many instances.
- Upgrade blast radius is large.

## Authority

Production upgrade authority should usually be a multisig or timelock. Document emergency upgrade powers and user trust assumptions.

## Governance-Controlled Upgrades

When upgrades are governed:

- Define proposer, voter, executor, canceller, and emergency roles.
- Confirm the proxy admin or upgrade role is controlled by the governance executor or timelock.
- Test proposal, queue, execute, and cancellation flows.
- Test unauthorized upgrades through the proxy and implementation.
- Document whether emergency upgrades bypass normal governance.

## L2 And Cross-Chain Upgrades

For L2 or cross-chain systems:

- Define which chain controls upgrade authority.
- Define bridge or messenger trust assumptions.
- Include replay protection for cross-chain upgrade messages.
- Account for delayed finality and message cancellation rules.
- Test wrong-chain, wrong-sender, duplicate-message, and stale-message failures.
