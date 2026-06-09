# Codex Adapter

Use this adapter when working with an agent environment that supports local Markdown skills or repository files.

## Recommended Use

1. Copy or expose the `skills/` folder to the agent workspace.
2. Choose the skill for the job.
3. Ensure that skill's `SKILL.md`, `references/`, `templates/`, and `shared/references/` are readable.
4. Ask the agent to use the chosen `SKILL.md` first, then load references as needed.

Example prompt:

```text
Use skills/foundry-test-writer/SKILL.md to add tests for this staking contract.
Consult shared/references/foundry-conventions.md for Foundry conventions.
```

## Notes

- The core skills are not Codex-specific.
- Keep product-specific installation paths outside the skill body.
- If your runtime has a formal skill directory, copy the individual skill folders there without changing their content.
