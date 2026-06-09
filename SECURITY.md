# Security Policy

This repository contains agent instructions and starter templates. It does not make generated smart contracts safe by default.

## Mainnet Warning

Any contract generated with these skills must still go through:

- Human engineering review.
- Unit tests.
- Revert and access-control tests.
- Fuzz tests where inputs vary.
- Invariant tests where accounting matters.
- Fork tests for external protocol integrations.
- Deployment rehearsal on testnets or local forks.
- Independent security review or audit before mainnet.

Generated Solidity should be treated as a draft until reviewed and tested. Never assume a generated contract is production-ready because it followed this skill.

## What To Report

Please report security issues in this repository when they involve:

- A template with a dangerous bug.
- Skill instructions that encourage unsafe defaults.
- Guidance that enables hidden owner powers, honeypots, backdoors, or deceptive token behavior.
- Misleading security language.
- A reference pattern that could cause user funds to be lost.

Do not report every bug in a downstream generated contract as a vulnerability in this repository unless the bug comes from a template or instruction here.

## How To Report

If GitHub private vulnerability reporting is enabled for the repository, use it. Otherwise, open a minimal public issue that describes the affected file and risk without publishing exploit steps for live systems.

## Disclosure Expectations

The maintainers should acknowledge reports when possible, assess the affected instruction or template, and publish a fix with clear notes. Security fixes should avoid implying that generated contracts are now guaranteed safe.
