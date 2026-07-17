# Reproducible Solidity Builds

Use this reference for deployable artifacts, upgrade validation, verification, and incident reconstruction.

## Pin Everything

- Pin the Solidity compiler and EVM version.
- Pin dependency tags or revisions and commit the package-manager lockfile.
- Record optimizer runs, `via_ir`, metadata bytecode hash policy, remappings, and library addresses.
- Pin CI actions and security-tool versions where practical.

## Compare Artifacts

- Build from a clean checkout with dependencies restored from locks.
- Dry-run scripts and compare creation and runtime bytecode before broadcast.
- Explain expected differences caused by constructor arguments, immutables, linked libraries, or metadata.
- Save ABI, storage layout, compiler input/output, deployment arguments, and transaction hashes.

## Verification

- Verify the exact source and settings used for deployment.
- Confirm proxy, implementation, beacon, and admin addresses separately.
- Match the explorer-reported runtime bytecode to the intended artifact.
- Treat verification failure as a deployment blocker, not a documentation inconvenience.
