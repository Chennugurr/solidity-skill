# OpenZeppelin Defaults

Use OpenZeppelin for common primitives unless the project intentionally requires a custom implementation.

## Standard Primitives

Prefer:

- `ERC20` for fungible tokens.
- `ERC20Burnable` when users need to burn their own tokens.
- `ERC20Permit` when permit support is requested.
- `ERC20Votes` when token voting power is needed.
- `ERC20FlashMint` only when ERC3156 flash loans are explicitly desired and tested.
- `ERC721` for non-fungible tokens.
- `ERC2981` when royalty metadata is requested.
- `ERC1155` for multi-token systems.
- `ERC6909` for lightweight multi-token accounting when ERC1155 receiver hooks and URI model are not needed.
- `ERC4626` for tokenized vaults when the design matches the standard.
- `Governor` and `TimelockController` for governance flows that need token voting and delayed execution.
- `Ownable` for simple admin control.
- `AccessControl` for multi-role systems.
- `AccessManager` for centralized permission management across multiple contracts.
- `Pausable` only when emergency pause is justified.
- `ReentrancyGuard` where external calls and asset transfers can interact with accounting.
- `SafeERC20` for ERC20 transfers and approvals.
- `ECDSA` and EIP-712 utilities for signature flows.
- `IERC1271` and `SignatureChecker` when validating contract-wallet signatures.
- `MerkleProof` for large pull-based allowlists or claims.
- `Create2` for deterministic deployment scripts when requested.
- Upgradeable variants only when the user explicitly requests proxy upgradeability.

## Access Control Defaults

For simple systems:

- Use `Ownable`.
- List every owner power.
- Recommend transferring ownership to a multisig before production.
- Do not give the owner withdrawal rights over user funds unless custodial control is explicit.

For role-based systems:

- Use `AccessControl`.
- Define roles clearly.
- Avoid making every role its own admin unless there is a reason.
- Avoid giving operational hot wallets `DEFAULT_ADMIN_ROLE`.
- Recommend multisig or timelock control for admin roles.

For multi-contract protocols:

- Consider `AccessManager`.
- Keep role IDs, target selectors, grant delays, execution delays, guardians, and admins documented.
- Avoid leaving the manager admin on a deployer EOA in production.

Common roles:

```solidity
bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");
bytes32 public constant TREASURY_ROLE = keccak256("TREASURY_ROLE");
bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
```

## Token Transfer Defaults

- Use `SafeERC20` for all ERC20 transfers.
- Account for fee-on-transfer, rebasing, and non-standard token behavior when relevant.
- Reset approvals where needed for non-standard tokens.
- Avoid unlimited approvals unless the trust and revocation model is documented.

## Upgradeable Defaults

Default to non-upgradeable contracts.

If upgradeability is required:

- Use OpenZeppelin upgradeable contracts.
- Use initializers instead of constructors.
- Disable initializers in the implementation contract.
- Preserve storage layout.
- Document upgrade authority.
- Recommend multisig or timelock control.
- Add upgrade and storage-layout tests.

## Governance Defaults

When using governance:

- Use a votes-compatible token such as `ERC20Votes`.
- Use a timelock for delayed execution when user funds or admin powers are material.
- Assign proposer, executor, canceller, and admin roles deliberately.
- Transfer or renounce temporary setup admin after deployment.
- Test the full proposal lifecycle.
