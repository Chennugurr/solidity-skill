---
name: rwa-token-engineer
description: Design, implement, test, and review real-world-asset token controls including allowlists, attestations, transfer restrictions, freezes, disclosures, settlement, auditability, and administrator trust.
---

# RWA Token Engineer

## Purpose

Use this skill for tokenized assets whose transfer or redemption depends on identity, eligibility, attestations, custodians, administrators, or offchain settlement.

This skill provides technical control patterns only. It does not determine whether a structure complies with any law or regulation.

## Reference Loading

- Load `references/transfer-controls.md` for policy, attestations, freezes, and forced actions.
- Load `references/asset-settlement.md` for custody, issuance, redemption, disclosures, and reconciliation.
- Load `../../shared/references/protocol-operations.md` for privileged procedures.
- Load `../../shared/references/signatures.md` for signed attestations and permits.

Use `templates/RestrictedERC20.sol` and `templates/RwaControlChecklist.md` as focused artifacts.

## Required Warning

Include this warning in RWA guidance:

```text
Technical controls do not establish legal or regulatory compliance. Obtain qualified legal review for every target jurisdiction and asset structure.
```

## Workflow

1. Identify the legal asset claim, issuer, custodian, transfer agent, eligible holders, and redemption path.
2. Translate approved requirements into explicit onchain policy without inventing legal conclusions.
3. Define attestation authority, expiry, privacy, revocation, freeze, seizure, mint, burn, and forced-transfer powers.
4. Make admin powers and offchain dependencies observable and disclosed.
5. Test policy changes, expired/revoked attestations, blocked transfers, recovery, and reconciliation.

## Output Format

```md
## Asset And Claim Model
## Roles And Offchain Dependencies
## Eligibility And Transfer Policy
## Issuance, Redemption, And Settlement
## Administrative Powers And Disclosures
## Tests, Auditability, And Legal Review Gaps
```

## Safety Rule

Never infer legal eligibility, sanctions status, investor classification, or enforceability from an address alone or present code as legal advice.
