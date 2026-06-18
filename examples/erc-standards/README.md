# Example: ERC Standards

## Prompt

```text
Use skills/solidity-builder/SKILL.md.

Compare whether this product needs ERC20Permit, ERC2981, ERC3156, ERC6909, or ERC1271 support.
Recommend the smallest standard surface that fits the requirements, then scaffold the chosen template with tests and security notes.
Consult shared/references/openzeppelin-defaults.md and skills/solidity-builder/references/contract-patterns.md.
```

## Expected Agent Behavior

- Explain why each standard is or is not needed.
- Avoid adding standards only because they are available.
- Include replay, permission, receiver, operator, or royalty tests where relevant.
- Flag draft/tooling support risks for newer standards.
