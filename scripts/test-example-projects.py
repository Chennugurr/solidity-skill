#!/usr/bin/env python3
"""Install locked dependencies and test every standalone Foundry project."""

from __future__ import annotations

import os
import shutil
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PROJECTS_ROOT = ROOT / "examples" / "projects"
PROJECTS = (
    "erc4626-vault",
    "upgradeable-staking",
    "erc4337-smart-account",
    "oracle-lending-market",
    "governance-timelock",
)


def main() -> int:
    if shutil.which("forge") is None:
        print("error: forge is required", file=sys.stderr)
        return 1
    try:
        for name in PROJECTS:
            project = PROJECTS_ROOT / name
            print(f"Installing locked dependencies for {name}...")
            subprocess.run(["forge", "soldeer", "install"], cwd=project, check=True)
            if (project / "package-lock.json").is_file():
                if shutil.which("npm") is None:
                    raise RuntimeError(f"npm is required for {name}")
                npm_env = os.environ.copy()
                npm_env.update(
                    {
                        "GIT_CONFIG_COUNT": "1",
                        "GIT_CONFIG_KEY_0": "url.https://github.com/.insteadOf",
                        "GIT_CONFIG_VALUE_0": "ssh://git@github.com/",
                    }
                )
                subprocess.run(["npm", "ci", "--ignore-scripts"], cwd=project, env=npm_env, check=True)
            print(f"Testing {name}...")
            subprocess.run(["forge", "test"], cwd=project, check=True)
    except (OSError, RuntimeError, subprocess.CalledProcessError) as exc:
        print(f"error: example project tests failed: {exc}", file=sys.stderr)
        return 1
    print(f"All {len(PROJECTS)} standalone Foundry projects passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
