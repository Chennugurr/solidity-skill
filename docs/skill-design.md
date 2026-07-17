# Skill Design

The suite uses a vendor-neutral, progressively disclosed Markdown format:

```text
skills/<skill-name>/
  SKILL.md
  README.md
  references/
  templates/
shared/references/
examples/<skill-name>/README.md
```

## Public Contract

Every public `SKILL.md` must start with valid YAML frontmatter whose `name`
matches its directory and whose `description` states when the skill should be
selected. The body must include when to use it, when not to use it, conditional
reference loading, a bounded workflow, expected output, and role-appropriate
safety language.

`SKILL.md` stays concise. Detailed rules belong in local references; guidance
used by several skills belongs in `shared/references/`. Templates are concrete
starting artifacts, not hidden instructions or claims of production readiness.

## Role Boundaries

The twenty skills are grouped into foundation, protocol engineering, production
engineering, and protocol-specialist roles. Keep them independently loadable and
use explicit handoffs when work crosses ownership boundaries. Shared references
are internal support files, not standalone skills.

Add a public skill only when the role has a distinct workflow and threat model.
Narrow ERCs, EVM opcodes, tools, or provider notes normally remain references or
templates.

## Vendor Neutrality

Reusable skill content may assume Markdown, project file access, Solidity, and
the tools named by the workflow. It must not assume a particular agent vendor,
installation path, chat surface, or plugin runtime. Product-specific loading
instructions belong in `adapters/` or the relevant plugin manifest.

## Security Posture

Skills must expose assumptions and trust boundaries, use established libraries,
test authorization and accounting, distinguish evidence from inference, and
avoid claiming that tests or formal tools prove complete safety. Real deployment
steps begin with simulation or dry-run output and require explicit human review.

## Validation

The suite validator enforces the exact public set, YAML frontmatter, reference
paths, examples, structured assets, evaluation coverage, project pins, plugin
manifests, vendor neutrality, packaging, and optional compile/tool checks.

Plugin manifests remain thin. No app, MCP server, hooks, marketplace metadata,
or installer belongs in the suite unless that integration is actually shipped.
