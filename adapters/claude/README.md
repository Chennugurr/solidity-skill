# Claude Adapter

Use this adapter when working with a Claude environment that can read project files, knowledge files, or Markdown instructions.

This repository also includes a Claude Code plugin manifest at `.claude-plugin/plugin.json`. Claude Code discovers the root `skills/` directory and exposes skills under the `solidity-skill:` namespace when the plugin is loaded.

## Recommended Use

1. Choose the skill that matches the task, such as `solidity-builder`, `solidity-auditor`, or `foundry-test-writer`.
2. Add or attach that skill's `SKILL.md` to the relevant project or conversation context.
3. Keep the skill's `references/`, `templates/`, and `shared/references/` available.
4. Ask Claude to load only the reference files needed for the task.

For Claude Code plugin testing:

```bash
claude --plugin-dir .
```

Then invoke a namespaced skill, for example:

```text
/solidity-skill:solidity-builder Build a fixed-supply ERC20 with Foundry tests.
```

Example prompt:

```text
Use the solidity-auditor skill in skills/solidity-auditor/SKILL.md.
Review these contracts and consult shared/references/security-posture.md before writing findings.
```

## Notes

- The core skills are not Claude-specific.
- Do not paste every reference file into context unless the task needs it.
- For long-running projects, keep this repository checked into the workspace so references and templates remain available.
