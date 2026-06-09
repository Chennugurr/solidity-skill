# Generic Agent Adapter

Use this adapter for any coding agent that can read Markdown files.

## Minimum Integration

Provide the agent with:

- The chosen `skills/<skill-name>/SKILL.md`
- The ability to read that skill's `references/`
- The ability to read `skills/_shared/references/`
- The ability to copy or adapt that skill's `templates/`

Example prompt:

```text
You have access to Markdown skills under skills/.
Use skills/evm-deployment-engineer/SKILL.md for this deployment task. Load only the reference files that are relevant.
```

## Suggested Loading Strategy

1. Choose the skill that matches the task.
2. Load that skill's `SKILL.md`.
2. Identify whether the task is a new build, refactor, test-writing task, or deployment task.
3. Load the smallest relevant reference file.
4. Use templates only when concrete files are requested.
5. State assumptions and remaining risks in the final output.

## Compatibility

This skill pack should work with agents that support:

- Markdown instructions.
- Local file access.
- Project-aware code editing.
- Optional template copying.
