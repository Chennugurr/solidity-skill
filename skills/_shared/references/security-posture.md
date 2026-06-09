# Security Posture

Use this reference for any Solidity task involving user funds, privileged roles, external integrations, signatures, oracle data, upgradeability, launch mechanics, or mainnet-readiness claims.

## Default Priorities

1. Correctness.
2. Security.
3. Simplicity.
4. Testability.
5. Explicit assumptions.
6. Gas efficiency after correctness.
7. Extensibility only when needed.

## Forbidden Patterns

Do not generate or endorse:

- Hidden mint functions.
- Hidden owner drains.
- Hidden transfer taxes.
- Hidden blacklists.
- Hidden max-wallet bypasses.
- Fake burns.
- Fake ownership renounce flows.
- Honeypot logic.
- Owner-only sell switches.
- Undisclosed transfer restrictions.
- Proxy upgrade backdoors.
- Obfuscated assembly.
- Misleading comments or events.
- Unreachable withdrawal logic.
- Admin functions that can steal user deposits unless explicitly documented as custodial control.
- Arbitrary external calls without a clear, disclosed purpose.
- Code designed to deceive users, auditors, block explorers, or wallets.

If a user asks for deceptive or harmful mechanics, refuse that part and offer a transparent alternative.

## Security Review Checklist

Before finalizing code, specs, tests, reviews, or deployment notes, check:

- Can funds get stuck?
- Can anyone steal user funds?
- Can admins steal funds unexpectedly?
- Are privileged roles too broad?
- Are restricted functions callable by unauthorized users?
- Can reentrancy break accounting?
- Do external calls happen before state updates?
- Do ERC20 transfers use `SafeERC20`?
- Can fee-on-transfer, rebasing, callback, or non-returning tokens break assumptions?
- Can rounding or precision loss be abused?
- Can a first depositor manipulate share price?
- Can users grief, block, or permanently lock other users?
- Can arrays grow until functions become unusable?
- Are signatures replayable?
- Are messages replayable across chains or domains?
- Are nonces, deadlines, and domain separation present where needed?
- Can oracle prices be stale, invalid, or manipulated?
- Can flash loans manipulate state?
- Can MEV exploit the flow?
- Can initialization happen twice?
- Can upgradeable storage be corrupted?
- Can emergency controls be abused?
- Can pausing permanently trap users?
- Can reward emissions exceed funded rewards?
- Can withdrawals fail because of external dependencies?
- Can ownership transfer or renounce break maintenance?

Fix the risk in the artifact or document the assumption clearly.

## Assumption Defaults

When requirements are incomplete and it is safe to proceed:

- Admin is the deployer unless stated otherwise.
- Token supply is fixed unless minting is requested.
- No transfer tax, blacklist, max wallet, or trading switch unless explicitly requested and disclosed.
- No upgradeability unless requested.
- No owner withdrawal of user funds unless explicitly part of the design.
- Rewards and claims are pull-based.
- Time-based logic uses `block.timestamp` only for approximate scheduling, not randomness.
- Randomness requires VRF or commit-reveal.
- Signatures require nonce, deadline, signer validation, and domain separation.
- Bridges and cross-chain messages require replay protection and chain or domain separation.
- DeFi accounting must avoid looping over users.

Always include assumptions when ambiguity affects security, economics, custody, or deployment.

## Security Language

Avoid saying:

- "This is completely safe."
- "No bugs."
- "Audit ready" without qualification.
- "Guaranteed secure."
- "Unhackable."

Use:

- "This follows safer defaults, but still needs testing and review before mainnet."
- "Mainnet deployment should use a multisig for admin roles."
- "The main remaining risks are..."
- "This assumes..."

