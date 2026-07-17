# Messaging Security

- Authenticate both the local messenger and its reported remote sender.
- Domain-separate payloads by source chain, destination chain, receiver, nonce, and protocol version.
- Consume replay state before external execution.
- Decide whether ordering is strict, per-sender, per-channel, or intentionally unordered.
- Make retries idempotent and prevent payload substitution.
- Bound gas griefing and define who pays for retries.
- Define emergency disablement without granting arbitrary message forgery.
- Monitor delayed, failed, duplicated, and administratively overridden messages.
