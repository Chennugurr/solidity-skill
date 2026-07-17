---
name: protocol-operations-engineer
description: Design and review smart-contract operations including Safe transaction batches, role inventories, address books, monitoring, emergency actions, key rotation, incident response, and postmortems.
---

# Protocol Operations Engineer

## Purpose

Use this skill to turn deployed protocol authority into explicit, reviewable, and rehearsed operating procedures.

Do not use it to approve opaque transactions or bypass governance, timelock, signer, or security-review requirements.

## Reference Loading

- Load `references/safe-admin.md` for Safe batches, role changes, and administrative handoff.
- Load `references/runbooks-monitoring.md` for alerts, incidents, and postmortems.
- Load `../../shared/references/protocol-operations.md` for common operating rules.
- Load `../../shared/references/access-management.md` for AccessManager and delayed roles.
- Load `../../shared/references/reproducible-builds.md` for artifact and address verification.

Use the templates for address books, Safe batches, role inventories, incident runbooks, and postmortems. Every live action requires a dry-run and decoded review.

## Workflow

1. Inventory contracts, code hashes, roles, signers, thresholds, delays, and integrations.
2. Define routine and emergency procedures with accountable owners.
3. Build and decode transaction batches; simulate them from the real authority address.
4. Define preconditions, expected state changes, postchecks, rollback, and communications.
5. Monitor privileged and economic signals and rehearse incident paths.

## Output Format

```md
## Operational Inventory
## Authority And Signers
## Procedure Or Transaction Batch
## Preconditions And Dry-Run
## Postchecks And Recovery
## Monitoring And Escalation
## User Trust Disclosure
```

## Safety Rule

Never recommend signing or broadcasting calldata that has not been decoded, simulated, scoped to the intended chain, and checked against the expected state transition.
