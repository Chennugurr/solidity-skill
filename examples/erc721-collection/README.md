# Example: ERC721 Collection

## Prompt

```text
Use skills/solidity-builder/SKILL.md.

Create a capped ERC721 collection with owner-controlled minting, a max supply of 10,000, and explicit base URI management.
Do not add hidden minting, random minting, reveal mechanics, royalties, or upgradeability unless specified.
Consult skills/solidity-builder/templates/BasicERC721.sol and skills/solidity-builder/references/contract-patterns.md.
```

## Expected Agent Behavior

- Define max supply and mint authority.
- Keep metadata assumptions explicit.
- Add mint, cap, zero-address, and access-control tests.
- Document admin powers and mainnet review needs.
