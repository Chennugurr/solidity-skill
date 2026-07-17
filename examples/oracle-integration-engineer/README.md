# Oracle Integration Example Prompts

Use `oracle-integration-engineer` for prompts such as:

```text
Build a normalized ETH/USD oracle adapter that can be configured for Chainlink or Pyth, rejects stale and invalid data, handles L2 sequencer downtime, and exposes a mockable 18-decimal interface. Add failure-path tests.
```

Expected behavior: identify provider update semantics, decimals, freshness, confidence, sequencer grace period, fallback policy, and monitoring requirements.
