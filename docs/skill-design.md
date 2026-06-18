# Skill Design

This repository uses a simple, vendor-neutral skill format:

```text
shared/
  references/
skills/
  skill-name/
    SKILL.md
    README.md
    references/
    templates/
```

## Required Frontmatter

Every `SKILL.md` must start with valid YAML frontmatter:

```yaml
---
name: skill-name
description: Clear description of when and why to use the skill.
---
```

The `name` should match the folder name.

## Progressive Disclosure

Keep `SKILL.md` short enough to load frequently. Put longer reusable material in `references/` and link to those files from the skill body.

Recommended split:

- `SKILL.md`: when to use the skill, core workflow, defaults, safety posture, output expectations.
- `references/`: detailed domain rules, checklists, and patterns.
- `templates/`: source files an agent can copy or adapt.
- `examples/`: sample prompts and expected behavior.
- `adapters/`: product-specific usage notes.
- `shared/references/`: reusable guidance that applies to more than one skill.
- `security/`: optional tool configs and security-analysis helpers used by the suite.

## Vendor Neutrality

Core skills should avoid product names and runtime assumptions. Product-specific instructions belong in `adapters/`.

Acceptable in `SKILL.md`:

- "Load this reference file when needed."
- "Use Foundry by default for Solidity tests."
- "State assumptions before writing code."

Avoid in `SKILL.md`:

- References to a single agent vendor.
- Hardcoded local skill install paths.
- Instructions that only work in one chat product.

## Security Posture

Solidity skills should assume real funds may depend on generated code. Skills should:

- Prefer established libraries.
- Avoid hidden controls.
- Explain trust assumptions.
- Require tests for access control and accounting.
- Avoid overclaiming security.
- Recommend review and audits before mainnet.

## Suite Organization

The repository keeps related Solidity skills together but independently loadable:

- Core: builder, auditor, Foundry test writer, deployment engineer.
- Advanced: DeFi accounting, Uniswap v4 hooks, upgradeability, token launches, protocol specs.

Use shared references for common rules. Do not duplicate long safety or Foundry guidance inside each skill.

Security tool configs live outside individual skills so the suite can reuse them without turning any one skill into a project scaffold.

## Plugin Packaging

The repository can be installed as a Codex plugin through `.codex-plugin/plugin.json` and as a Claude Code plugin through `.claude-plugin/plugin.json`.

Plugin manifests should stay thin:

- Codex-specific metadata belongs in `.codex-plugin/plugin.json`.
- Claude-specific metadata belongs in `.claude-plugin/plugin.json`.
- Claude Code discovers the root `skills/` directory automatically.
- The Markdown skills should remain reusable by non-Codex agents.
- Do not add apps, MCP servers, hooks, agents, icons, logos, screenshots, settings, or marketplace files unless those assets or integrations actually exist.
