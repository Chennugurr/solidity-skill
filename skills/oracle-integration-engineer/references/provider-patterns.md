# Provider Integration Patterns

## Chainlink

- Read the documented proxy through `AggregatorV3Interface`.
- Validate a positive answer and an acceptable `updatedAt` timestamp.
- Use the feed's configured decimals and application-specific freshness threshold.
- On supported L2s, check sequencer uptime and enforce a recovery grace period.

## Pyth

- Treat Pyth Core as a pull oracle unless using a documented sponsored push feed.
- Accept update data, pay the quoted fee, update feeds, then call a freshness-bounded read.
- Normalize the signed exponent safely and consider confidence relative to price.
- Reject caller-selected historical updates that satisfy age but are economically inappropriate.

## RedStone

- Use the documented consumer base and data-service identifier.
- Verify signer count, feed identifiers, timestamp rules, and payload extraction assumptions.
- Treat calldata-attached data and relayer availability as explicit trust and liveness dependencies.

Provider packages and deployed addresses change. Confirm current official documentation and pin the exact dependency used by the project.
