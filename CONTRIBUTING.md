# Contributing

Thanks for helping improve `solidity-agent-skills`.

This repository welcomes new skills, reference material, templates, examples, and adapter notes. Keep contributions vendor-neutral unless you are editing a file under `adapters/`.

## Adding a Skill

Create a new folder under `skills/`:

```text
skills/
  _shared/
    references/
  your-skill-name/
    SKILL.md
    README.md
    references/
    templates/
```

Every `SKILL.md` must:

- Start with valid YAML frontmatter.
- Include `name` and `description`.
- Use a lowercase hyphenated skill name.
- Explain when the skill should be used.
- Keep instructions focused and practical.
- Link to reference files instead of becoming a long manual.
- Avoid assuming a specific agent vendor or runtime.

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
- Put guidance that applies to several skills in `skills/_shared/references/`.
- Keep product-specific instructions in `adapters/`.
- Add sample prompts under `examples/` when a new workflow would benefit from them.
- Add templates only when they are broadly reusable.

## Pull Request Checklist

- `SKILL.md` has valid YAML frontmatter.
- The skill name matches its folder name.
- The content is vendor-neutral outside `adapters/`.
- Security assumptions are explicit.
- Long reusable details are in `references/`.
- Templates compile or are clearly marked as templates.
- Example prompts are realistic and do not request deceptive behavior.

## Reporting Problems

For security-sensitive issues, follow [SECURITY.md](SECURITY.md). For ordinary bugs, typos, missing references, or template improvements, open an issue or pull request.
