# Example: Protocol Spec Writer

## Prompt

```text
Use skills/protocol-spec-writer/SKILL.md.

Turn this idea into an implementation-ready spec:
Users deposit an ERC20 asset into a vault, receive shares, and earn streamed rewards from a treasury.
Admins can update reward duration but cannot withdraw user deposits.
Include actors, assets, contracts, flows, state, permissions, invariants, failure modes, tests, and open questions.
Consult skills/protocol-spec-writer/templates/ProtocolSpec.md and skills/_shared/references/security-posture.md.
```

## Expected Agent Behavior

- Produce a clear spec before code.
- Define custody and admin powers.
- Include accounting invariants.
- Include testable acceptance criteria.
- Ask only architecture-changing questions.

