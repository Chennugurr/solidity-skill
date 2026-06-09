# Cursor Adapter

Use this adapter when working in Cursor or another editor-based agent that can read repository files or rules.

## Recommended Use

1. Keep this repository in the workspace, or copy the relevant skill folders into the project.
2. Reference the chosen skill's `SKILL.md` from your chat or rule system.
3. Ask the agent to load specific shared or local reference files when generating contracts, tests, specs, reviews, or deployment scripts.

Example prompt:

```text
Use the Protocol Spec Writer instructions in skills/protocol-spec-writer/SKILL.md.
Turn this staking idea into an implementation-ready spec before writing Solidity.
```

## Notes

- The core skills are not Cursor-specific.
- If you convert a skill into editor rules, preserve the YAML frontmatter in the source `SKILL.md`.
- Keep long reference details as separate files so routine prompts stay small.
