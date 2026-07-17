# Distribution

The same twenty vendor-neutral skills can be loaded through several agent
surfaces. Product adapters affect discovery only; they do not fork skill content.

## Compatibility Matrix

| Surface | Load | Shared references | Package form |
| --- | --- | --- | --- |
| Codex plugin | `.codex-plugin/plugin.json` points to `./skills/` | Read from repository | Repository/plugin source |
| Claude Code plugin | `.claude-plugin/plugin.json` with root `skills/` discovery | Read from repository | Repository/plugin source |
| ChatGPT skill upload | One `dist/<skill-name>.zip` | Bundled under `references/shared/` | One zip per skill |
| Cursor/editor agent | `skills/<skill-name>/SKILL.md` | Read from repository | Repository files |
| Generic Markdown agent | `skills/<skill-name>/SKILL.md` | Read from repository | Repository files |

All surfaces can load each of the twenty public skills. Upload-only surfaces load
one independently packaged skill at a time.

## Plugins

For Codex, use the repository as the plugin source; the manifest declares
`solidity-skill` version `2.0.0` and the `./skills/` payload. For Claude Code,
load the repository as a plugin directory so the root skill folders are
discovered under the plugin namespace. Platform-specific examples live in
`adapters/codex/README.md` and `adapters/claude/README.md`.

The plugin packages contain no CLI, MCP server, app, hooks, marketplace entry,
or installer.

## Upload Archives

Build one root-`SKILL.md` archive per skill:

```bash
python3 scripts/package-upload-skills.py
```

Each archive bundles its local files and rewrites shared links to
`references/shared/`. A user uploads the archive matching the role they want;
`dist/solidity-builder.zip` is the general contract-building entrypoint.

## Release Assets

```bash
python3 scripts/build-release-assets.py
```

The command writes twenty skill archives,
`dist/solidity-agent-skills-source.zip`, and `dist/SHA256SUMS`. The source archive
excludes generated dependencies, build output, caches, and local package trees.

## Release Validation

Install `requirements-dev.txt`, install the pinned formal tools, and run:

```bash
python3 scripts/validate-suite.py --package --compile-templates --test-projects --formal-tools --upgrade-validation --external-plugin-validators
```

Operational examples use local or dry-run execution by default. Inspect archive
contents and checksums before attaching the generated files to a tagged release.
