# Example: Solidity Auditor

## Prompt

```text
Use skills/solidity-auditor/SKILL.md.

Review the contracts in src/ and tests in test/.
Focus on user-fund loss, access control, reward accounting, unsafe ERC20 assumptions, and missing tests.
Consult shared/references/security-posture.md and skills/solidity-auditor/references/vulnerability-classes.md.
Return findings ordered by severity.
```

## Expected Agent Behavior

- Lead with findings.
- Include concrete locations.
- Separate confirmed issues from assumptions.
- Recommend fixes and tests.
- Avoid claiming the system is safe.

