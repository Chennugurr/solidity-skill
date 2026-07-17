---
name: solidity-auditor
description: Review Solidity smart contracts, protocol specs, tests, and deployment plans for security issues, broken assumptions, missing tests, and mainnet risks.
---

# Solidity Auditor

## Purpose

Use this skill to perform an adversarial security review of Solidity code, protocol designs, Foundry tests, deployment scripts, upgrade plans, and launch mechanics.

The goal is to find concrete risks, explain exploitability, and recommend practical fixes. Do not rewrite the whole system unless the user asks for remediation.

## When To Use

Use this skill for:

- Solidity security reviews.
- Protocol architecture reviews.
- Pre-deployment checklists.
- Test gap analysis.
- Access-control and admin-power review.
- DeFi accounting and invariant review.
- Oracle, signature, bridge, upgradeability, and integration review.
- Audit-report drafting or finding triage.

Do not use it for first-pass implementation unless the user asks for review while building.

## Reference Loading

Load shared references as needed:

- `../../shared/references/security-posture.md` for forbidden patterns, assumptions, and security language.
- `../../shared/references/openzeppelin-defaults.md` for standard primitive expectations.
- `../../shared/references/mainnet-readiness.md` for production-readiness claims.
- `../../shared/references/security-tooling.md` when reviewing or recommending Slither, Echidna, SMTChecker, or formal/property tooling.
- `../../shared/references/tool-output-triage.md` when classifying automated analysis findings.
- `../../shared/references/access-management.md` when reviewing role, AccessManager, timelock, or admin handoff risk.
- `../../shared/references/signatures.md` for typed-data, contract-wallet, delegation, nonce, and replay review.
- `../../shared/references/oracle-safety.md` for source, freshness, confidence, sequencer, and fallback review.
- `../../shared/references/cross-chain-l2.md` for authenticated messaging, finality, replay, and bridge trust.
- `../../shared/references/modern-evm.md` for compiler-target, transient-storage, namespace, and delegated-EOA assumptions.
- `../../shared/references/mev-market-mechanics.md` for ordering, slippage, auctions, liquidations, and solver risk.
- `../../shared/references/protocol-operations.md` for privileged execution, monitoring, and incident readiness.

Load local references as needed:

- `references/review-workflow.md` for audit process.
- `references/vulnerability-classes.md` for issue categories.
- `references/finding-format.md` for report structure.

Use `templates/AuditReport.md` when the user asks for a written report. Use `templates/ToolFindingsTriage.md` and `templates/FalsePositiveTriage.md` for tool-output review.

## Review Posture

Be skeptical, specific, and evidence-based.

- Prioritize exploitable issues over style.
- Lead with findings, ordered by severity.
- Include file/function references when reviewing code.
- Explain attacker capability and impact.
- Distinguish confirmed bugs from assumptions and questions.
- Avoid claiming a system is safe.
- Avoid audit theater: do not fill space with low-signal observations.

## Severity Model

- **Critical**: direct or near-direct loss of funds, permanent insolvency, unauthorized upgrades to malicious logic, or protocol-wide compromise.
- **High**: theft or freezing of meaningful funds, major accounting break, bypass of core authorization, exploitable oracle or signature failure.
- **Medium**: material griefing, bounded fund loss, broken core behavior under realistic conditions, missing replay protection in limited contexts.
- **Low**: minor risk, hard-to-exploit edge case, missing event, misleading comment, incomplete validation with limited impact.
- **Informational**: maintainability, documentation, test coverage, or operational improvements.

## Output Format

For code reviews:

```md
## Findings

### [Severity] Title
- Location:
- Impact:
- Exploit Scenario:
- Recommendation:

## Open Questions

## Test Gaps

## Summary
```

If no issues are found, say so clearly and list remaining review limits.

## Safety Rule

Do not provide exploit instructions for live vulnerable systems beyond what is needed for defensive remediation. Prefer minimal proof-of-concept reasoning and concrete fixes.
