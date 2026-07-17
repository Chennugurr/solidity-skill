# Oracle-Backed Lending Market Project

This standalone Foundry project demonstrates a single-collateral lending market behind a normalized oracle interface, plus compile-checked Chainlink, Pyth, and RedStone adapter patterns.

```bash
npm ci
forge soldeer install
forge test
```

The pinned provider packages require Node.js 22 or newer. The suite project
runner also rewrites transitive GitHub SSH fetches to HTTPS for unattended CI.

Use `oracle-integration-engineer`, `lending-liquidation-engineer`, `defi-accounting-engineer`, and `solidity-auditor` when adapting it. Risk parameters and provider configuration are illustrative only.
