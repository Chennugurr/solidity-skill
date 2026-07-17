# Safe And Administrative Operations

- Verify Safe chain ID, address, implementation, threshold, owners, modules, guards, and fallback handler.
- Decode target, value, calldata, operation type, and nonce for every batch item.
- Simulate from the Safe and include prior batch items in state.
- Compare role grants, revocations, ownership acceptance, and timelock scheduling against an approved role inventory.
- Separate preparation, independent review, signing, execution, and postcheck responsibilities.
- Use two-step ownership transfers where supported and verify acceptance before revoking the old owner.
- Preserve transaction hashes, decoded calls, approvals, simulation output, and resulting state.
