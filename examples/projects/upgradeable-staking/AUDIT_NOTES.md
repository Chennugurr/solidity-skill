# Audit Notes

- UUPS authority is a direct owner in this example; funded systems should evaluate Safe, timelock, and AccessManager controls.
- V2 appends storage and uses a reinitializer. CI must compare layouts against V1.
- The staking model omits reward accounting, slashing, and external validator integration.
