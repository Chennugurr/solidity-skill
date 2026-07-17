# Transfer Controls

- Model policy as an explicit, testable contract or authority rather than scattered token checks.
- Define who issues and revokes eligibility, its scope, expiry, and evidence identifier.
- Apply restrictions consistently to transfer, transferFrom, mint, burn, permit, bridge, and administrative movement.
- Distinguish pause, freeze, seize, force transfer, mint, burn, and policy-update powers.
- Emit events that allow holders and auditors to reconstruct policy and privileged actions.
- Minimize personal data onchain; use privacy-reviewed attestations or identifiers.
- Ensure contract wallets, custody accounts, and recovery addresses have deliberate treatment.
