---
name: cross-chain-l2-engineer
description: Design, implement, test, and review Solidity applications across major L2 families and canonical bridges, including finality, authenticated messaging, replay protection, retries, verification, and failure recovery.
---

# Cross-Chain L2 Engineer

## Purpose

Use this skill when assets, messages, deployments, or trust assumptions cross chains or depend on rollup-specific behavior.

Do not use it for chain-node operation or bridge-provider implementation beyond the application integration boundary.

## Reference Loading

- Load `references/messaging-security.md` for message authentication, replay, retries, and recovery.
- Load `references/l2-matrix.md` for OP Stack/Base, Arbitrum, ZKsync/Scroll, and Polygon-family differences.
- Load `../../shared/references/cross-chain-l2.md` for common trust and finality rules.
- Load `../../shared/references/oracle-safety.md` for L2 sequencer and oracle dependencies.
- Load `../../shared/references/reproducible-builds.md` for chain-specific artifacts and verification.

Use `templates/MessageReplayGuard.sol` as a focused replay component, not a complete bridge.

## Workflow

1. Identify source/destination chains, canonical contracts, finality, and upgrade authorities.
2. Define the full message identity and authenticated sender path.
3. Specify success, duplicate, delay, retry, cancellation, refund, and permanent-failure behavior.
4. Record chain-specific bytecode, gas token, address aliasing, predeploy, and verification assumptions.
5. Test wrong source, wrong sender, replay, ordering, delayed finality, failed execution, and recovery.

## Output Format

```md
## Chains And Trust Model
## Message Or Asset Flow
## Authentication And Replay Protection
## Finality And Failure Handling
## Chain-Specific Deployment
## Tests, Monitoring, And Recovery
```

## Safety Rule

Never treat a cross-chain message as authenticated merely because the immediate caller is a messenger. Verify the reported source chain and source sender through the documented canonical path.
