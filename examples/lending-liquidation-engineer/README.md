# Lending Liquidation Example Prompts

Use `lending-liquidation-engineer` for prompts such as:

```text
Specify and review an isolated collateral market with utilization-based interest, 80% liquidation threshold, partial liquidation, reserve fees, and explicit bad-debt handling. Produce invariants and stale-oracle tests.
```

Expected behavior: define units and accrual ordering, refuse to invent unprovided risk parameters, and model liquidation, liquidity, and insolvency together.
