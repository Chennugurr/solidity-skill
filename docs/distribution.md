# Distribution

This repository can be consumed as Markdown skills, plugin metadata, or upload-ready skill archives.

## Compatibility Matrix

| Surface | What To Use | Notes |
| --- | --- | --- |
| Codex plugin | `.codex-plugin/plugin.json` plus `skills/` | Loads the nine public skill entrypoints from `./skills/`. |
| Claude Code plugin | `.claude-plugin/plugin.json` plus root `skills/` | Skills are discovered from the repository skills directory. |
| ChatGPT skill upload | `dist/<skill-name>.zip` | Upload one skill archive at a time; each zip has `SKILL.md` at the root. |
| Cursor/editor agents | `skills/<skill-name>/SKILL.md` | Keep `references/`, `templates/`, and `shared/references/` readable. |
| Generic Markdown agents | `skills/<skill-name>/SKILL.md` | Load one skill first, then load references only as needed. |

## Build Upload Archives

```bash
python3 scripts/package-upload-skills.py
```

This creates one upload-ready archive per skill in `dist/`.

## Build Release Assets

```bash
python3 scripts/build-release-assets.py
```

This creates:

- one upload-ready zip per skill;
- `dist/solidity-agent-skills-source.zip`;
- `dist/SHA256SUMS`.

Attach the contents of `dist/` to a GitHub release when publishing a tagged version.

## Validate Before Release

```bash
python3 scripts/validate-suite.py --package --compile-templates --external-plugin-validators
```

If a local product-specific validator is unavailable, the suite validator still checks the manifest structure.
