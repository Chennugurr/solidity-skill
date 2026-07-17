#!/usr/bin/env python3
"""Validate the example UUPS storage migration with OpenZeppelin tooling."""

from __future__ import annotations

import shutil
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PROJECT = ROOT / "examples" / "projects" / "upgradeable-staking"
TOOLING = ROOT / "security" / "upgrade-validation"


def main() -> int:
    for executable in ("forge", "npm"):
        if shutil.which(executable) is None:
            print(f"error: {executable} is required", file=sys.stderr)
            return 1
    try:
        subprocess.run(["npm", "ci", "--ignore-scripts"], cwd=TOOLING, check=True)
        subprocess.run(["forge", "soldeer", "install"], cwd=PROJECT, check=True)
        subprocess.run(["forge", "clean"], cwd=PROJECT, check=True)
        subprocess.run(["forge", "build"], cwd=PROJECT, check=True)
        subprocess.run(
            [
                "npm",
                "exec",
                "--no",
                "openzeppelin-upgrades-core",
                "--",
                "validate",
                str(PROJECT / "out" / "build-info"),
                "--contract",
                "UpgradeableStakingV2",
                "--reference",
                "UpgradeableStakingV1",
            ],
            cwd=TOOLING,
            check=True,
        )
    except (OSError, subprocess.CalledProcessError) as exc:
        print(f"error: upgrade validation failed: {exc}", file=sys.stderr)
        return 1
    print("OpenZeppelin upgrade and storage-layout validation passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
