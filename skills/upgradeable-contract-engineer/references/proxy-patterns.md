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

