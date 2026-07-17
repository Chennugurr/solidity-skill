# Contributing

Thanks for helping improve `solidity-agent-skills`.

This repository welcomes new skills, reference material, templates, examples, and adapter notes. Keep contributions vendor-neutral unless you are editing a file under `adapters/`.

## Adding a Skill

Create a new folder under `skills/`:

```text
skills/
  your-skill-name/
    SKILL.md
    README.md
    references/
    templates/
shared/
  references/
```

Every `SKILL.md` must:

- Start with valid YAML frontmatter.
- Include `name` and `description`.
- Use a lowercase hyphenated skill name.
- Explain when the skill should be used.
- Keep instructions focused and practical.
- Link to reference files instead of becoming a long manual.
- Avoid assuming a specific agent vendor or runtime.
- Define its expected output and role-appropriate safety rules.
- Have a matching `examples/<skill-name>/README.md` prompt example and evaluation case.

The twenty-skill public interface is frozen for v2. Propose a new public skill
only when it has a distinct workflow, threat model, and enough focused material
to justify an independently loaded role. Narrow standards and tool notes usually
belong in references or templates.

Example frontmatter:

```yaml
---
name: solidity-builder
description: Build and test secure Solidity smart contracts with safer defaults.
---
```

## Contribution Guidelines

- Use clear Markdown.
- Prefer security-conscious defaults.
- Document assumptions and trust boundaries.
- Avoid instructions that produce hidden owner powers, honeypots, deceptive token behavior, or backdoors.
- Keep reusable content in `skills/`.
- Put guidance that applies to several skills in `shared/references/`.
- Keep product-specific instructions in `adapters/`.
- Add sample prompts under `examples/` when a new workflow would benefit from them.
- Add templates only when they are broadly reusable.
- Pin compiler and dependencies in standalone projects and commit their locks.
- Keep protocol-specialist templates bounded; do not present them as complete protocols.

## Pull Request Checklist

- `SKILL.md` has valid YAML frontmatter.
- The skill name matches its folder name.
- The content is vendor-neutral outside `adapters/`.
- Security assumptions are explicit.
- Long reusable details are in `references/`.
- Templates compile or are clearly marked as templates.
- Example prompts are realistic and do not request deceptive behavior.
- `python3 scripts/validate-suite.py --package --compile-templates` passes.
- Standalone project changes pass `python3 scripts/test-example-projects.py`.
- Evaluation changes pass `python3 scripts/run-skill-evals.py --replay-baselines`.

## Reporting Problems

For security-sensitive issues, follow [SECURITY.md](SECURITY.md). For ordinary bugs, typos, missing references, or template improvements, open an issue or pull request.
