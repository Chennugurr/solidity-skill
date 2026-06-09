# Finding Format

Use concise, reproducible findings.

## Required Fields

```md
### [Severity] Short Title

- **Location:** `path:line` or contract/function name
- **Impact:** What can go wrong
- **Likelihood:** Why this is realistic or constrained
- **Description:** Root cause and affected flow
- **Exploit Scenario:** Minimal attacker or failure path
- **Recommendation:** Concrete fix
- **Tests:** Tests that should fail before the fix and pass after
```

## Good Finding Titles

- "Reward rate can exceed funded rewards and make claims revert"
- "Missing nonce allows permit-style signatures to be replayed"
- "Owner can withdraw user deposits despite non-custodial documentation"

## Weak Finding Titles

- "Security issue"
- "Potential vulnerability"
- "Consider using SafeERC20"

## Notes

- Do not label speculative concerns as confirmed vulnerabilities.
- Do not bury severe findings below style issues.
- Use informational severity for documentation and hygiene.
- If the review is limited by missing tests, missing dependencies, or incomplete scope, say so.

