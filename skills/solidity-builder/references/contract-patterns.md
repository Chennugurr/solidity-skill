# Contract Patterns

## ERC20

Default behavior:

- Fixed supply unless minting is requested.
- No tax by default.
- No blacklist by default.
- No max wallet by default.
- No max transaction by default.
- No transfer delay by default.
- No trading enable switch by default.
- No hidden owner powers.
- Use OpenZeppelin ERC20.
- Mint initial supply in the constructor.
- Use 18 decimals unless the user requests otherwise.
- Use `Ownable` only if there are real owner functions.
- If there are no admin functions, consider no owner.

If minting exists:

- Define who can mint.
- Define whether supply is capped.
- Emit normal ERC20 transfer events through `_mint`.
- Add tests for unauthorized minting.

If burning exists:

- Define whether users can burn their own tokens.
- Define whether authorized burners can burn from others.
- Avoid owner burn-from-user unless explicitly required.

If pausing exists:

- Explain that transfers can be paused.
- Use only if there is a clear safety reason.
- Add tests for paused transfers.

If taxes exist:

- Make them explicit.
- Cap them.
- Emit update events.
- Explain who receives fees.
- Do not hide taxes.

## ERC721

When building ERC721 contracts:

- Use OpenZeppelin ERC721.
- Define max supply.
- Define mint price if any.
- Define mint limits.
- Define metadata strategy.
- Define reveal strategy if any.
- Define withdraw recipient.
- Protect withdraw with access control.
- Avoid loops that exceed gas limits.
- Add tests for minting, supply caps, payment, withdraw, and token URI.
- Use `../templates/BasicERC721.sol` for a simple capped owner-mint collection.

For allowlists:

- Prefer Merkle proofs.
- Include tests for invalid proof, double claim, and exceeded allowance.

For royalties:

- Use ERC2981 if needed.
- Explain marketplace enforcement limitations.

## ERC1155

When building ERC1155 contracts:

- Define token IDs clearly.
- Define supply tracking if supply matters.
- Define mint authority.
- Define URI strategy.
- Include batch mint only if needed.
- Add tests for minting, burning, URI, and access control.
- Use `../templates/BasicERC1155.sol` for owner-mint items with supply tracking.

## Staking

When building staking contracts:

- Track user staked balance.
- Track total staked.
- Use index-based reward accounting.
- Avoid looping over all stakers.
- Use a precision constant, usually `1e18`.
- Update rewards before changing balances.
- Use pull-based claims.
- Use `SafeERC20`.
- Protect deposit, withdraw, and claim flows if external calls exist.
- Define what happens when reward funding runs out.
- Define whether rewards are continuous, epoch-based, or fixed-duration.
- Define whether staking token and reward token can be the same.
- Include emergency withdraw only if appropriate.
- Emergency withdraw should usually forfeit rewards, not steal principal.

Required staking tests:

- Initial state.
- Deposit.
- Withdraw.
- Claim.
- Deposit zero reverts.
- Withdraw too much reverts.
- Multiple users share rewards correctly.
- Rewards update after time passes.
- Only authorized reward distributor can notify rewards.
- Fuzz deposit and withdraw where applicable.
- Invariant: sum of user balances equals total staked.

## ERC4626 Vaults

When building vaults:

- Prefer ERC4626 if the design matches tokenized vault behavior.
- Define the asset.
- Define the share.
- Use correct rounding direction.
- Prevent first-depositor inflation attacks.
- Handle zero supply carefully.
- Use `SafeERC20`.
- Do not assume the asset has 18 decimals unless checked.
- Explain deposit, mint, withdraw, and redeem flows.
- Explain fee model if any.
- Explain who can manage strategy assets if a strategy exists.
- Add tests for first deposit, second deposit, rounding, share price increase, withdrawal, and donation or inflation edge cases.
- Use `../templates/BasicERC4626Vault.sol` only for no-strategy, no-fee vault drafts.

Vault invariants:

- Total assets should be greater than or equal to assets owed unless loss is part of the design.
- Share price should not be manipulable for unfair mint or redeem.
- Users should not be able to withdraw more than their ownership share.
- Fees should not exceed configured caps.

## Reward Distribution

When building claim or reward contracts:

- Prefer pull-based claims.
- Avoid pushing funds to large user lists.
- Use Merkle proofs for large airdrops.
- Track claimed status.
- Include deadline if needed.
- Include clawback only if transparent.
- Use `SafeERC20`.
- Add tests for double claim, invalid proof, expired claim, and claim amount.

For Merkle claims:

- Leaf should include user address and amount.
- Consider including campaign ID or contract address in the leaf construction if replay is possible.
- Track claimed by address or by leaf depending on design.
- Use `../templates/MerkleClaim.sol` for a pull-based ERC20 claim draft.

## Vesting

When building vesting contracts:

- Define beneficiary.
- Define token.
- Define start time.
- Define cliff.
- Define duration.
- Define revocability.
- Define release schedule.
- Use pull-based release.
- Use `SafeERC20`.
- Add tests before cliff, during vesting, after full vesting, partial release, and revocation if supported.
- Use `../templates/TokenVesting.sol` for a single-beneficiary linear vesting draft.

## Escrow

When building escrow contracts:

- Define buyer, seller, and arbiter if any.
- Define asset and amount.
- Define release conditions.
- Define refund conditions.
- Define dispute flow.
- Prevent double release or refund.
- Use an explicit state machine.
- Emit events for deposit, release, refund, and dispute.
- Add tests for every state transition.

Use enums for state machines:

```solidity
enum EscrowState {
    Created,
    Funded,
    Released,
    Refunded,
    Disputed
}
```

## Treasury

When building treasury contracts:

- Define accepted assets.
- Define who can withdraw.
- Define spend limits if needed.
- Use a multisig recommendation for owner or admin.
- Emit withdrawal events.
- Avoid arbitrary external calls unless necessary.
- If arbitrary calls exist, explain governance or admin risk.

## Governance

When building governance-related contracts:

- Define proposal creation.
- Define voting power source.
- Define snapshot rules.
- Define quorum.
- Define voting period.
- Define execution delay if any.
- Define cancellation rules.
- Avoid vote manipulation through same-block token transfers.
- Prefer established governance frameworks where appropriate.
- Use `../templates/VotesERC20.sol`, `../templates/SimpleGovernor.sol`, and `../templates/GovernanceTimelock.sol` for a minimal votes-token, governor, and timelock draft.

Governance setup must define:

- Who can propose.
- Who can execute.
- Who can cancel.
- Who holds temporary admin rights during setup.
- When temporary admin rights are revoked.
- Whether execution is open or restricted.

## Signatures And Permits

When building signature flows:

- Use EIP-712 typed data where practical.
- Include nonce, deadline, chain ID, verifying contract, signer, and action-specific parameters.
- Consume nonces before or during execution so signatures cannot be replayed.
- Reject expired signatures.
- Support contract wallets only when ERC1271 support is intentional and tested.
- For Permit2 integrations, define spender, token, amount, expiration, and revocation expectations.

## Oracles

When building oracle-dependent contracts:

- Define source, heartbeat, decimals, and staleness threshold.
- Normalize all prices and token decimals before computing value.
- Reject zero, negative, stale, or incomplete prices.
- Avoid low-liquidity spot prices for settlement.
- Include tests for stale prices, decimal mismatches, and manipulated prices.

## Bridges And Cross-Chain

When building cross-chain systems:

- Treat bridge or messenger contracts as trusted dependencies.
- Bind messages to source chain, destination chain, sender, recipient, nonce, and payload.
- Prevent replay across deployments and chains.
- Define retry, cancellation, and finality assumptions.
- Test duplicate messages, wrong senders, wrong chains, and malformed payloads.

## Account Abstraction

When account abstraction or smart contract wallets matter:

- Do not use `tx.origin`.
- Do not assume callers are EOAs.
- Decide whether ERC1271 signatures are supported.
- Test contract-wallet callers for authorization-sensitive flows.

## AMM And DEX Integrations

When integrating with AMMs:

- Include slippage protection.
- Include deadline.
- Avoid trusting returned amounts without validation.
- Use safe approvals.
- Reset approvals when needed for non-standard tokens.
- Do not leave unlimited approvals unless justified.
- Explain MEV and sandwich risk.
- Add tests for `minOut`, expired deadline, and failed swap.

## Uniswap v4 Hooks

When building Uniswap v4 hooks:

- Define exact hook callbacks used.
- Define hook permissions.
- Explain PoolManager relationship.
- Explain PoolKey usage.
- Explain whether the hook uses before or after swap, liquidity, donate, or initialize callbacks.
- Keep hook logic minimal and gas-aware.
- Avoid manipulable same-transaction accounting.
- Avoid relying on low-liquidity spot prices.
- Define who can update hook config.
- Define fee logic.
- Define storage per pool if multiple pools are supported.
- Include pool ID derivation if needed.
- Include tests for every enabled callback.
- Include manipulation-resistance notes.
- Include hook deployment and address mining notes if relevant.

If the task is deeply v4-specific, recommend a dedicated Uniswap v4 hook skill or review pass after the builder draft.

## CREATE2 Deployment

When deterministic deployment is requested:

- Define deployer, salt, bytecode, constructor args, and target chain.
- Explain that the address changes if deployer, salt, bytecode, or constructor args change.
- Compute the address before broadcast.
- Simulate before broadcast.
- Use `../templates/Create2Deploy.s.sol` as a Foundry script starting point.

## Specialized Handoffs

This skill is the general builder. If a task becomes deeply specialized, recommend a follow-up pass with a focused skill or expert workflow:

- Solidity audit.
- Advanced Foundry tests.
- DeFi accounting.
- Uniswap v4 hooks.
- EVM deployment.
- Upgradeable contracts.
- Token launch mechanics.
- Protocol specification writing.

Do not stop just because another skill would help. Provide the best builder output possible, then suggest the specialized pass.
