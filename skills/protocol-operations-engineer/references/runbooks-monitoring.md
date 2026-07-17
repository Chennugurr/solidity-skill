# Runbooks And Monitoring

## Runbook Fields

Include trigger, severity, decision owner, affected contracts, safe actions, forbidden actions, communications owner, evidence, recovery criteria, and follow-up tests.

## Signals

Monitor upgrades, role changes, pauses, ownership transfers, abnormal mint/burn, oracle freshness, insolvency, bridge failures, keeper inactivity, Safe owner changes, and unexpected balance movements.

## Incident Discipline

- Preserve logs and avoid destroying evidence during containment.
- Prefer reversible, narrowly scoped action.
- State user impact and uncertainty promptly without speculation.
- Require a second review for emergency calldata whenever time permits.
- Follow containment with root-cause remediation, regression tests, and a postmortem.
