#!/usr/bin/env python3
"""Run Slither against a temporary Foundry project built from bundled templates."""

from __future__ import annotations

import shutil
import subprocess
import sys
import tempfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def copy_templates(project: Path) -> None:
    for template in sorted(ROOT.glob("skills/*/templates/*.sol")):
        if template.name.endswith(".t.sol"):
            destination = project / "test" / template.name
        elif template.name.endswith(".s.sol"):
            destination = project / "script" / template.name
        else:
            destination = project / "src" / template.name
        shutil.copy2(template, destination)


def main() -> int:
    slither = shutil.which("slither")
    if slither is None:
        print("Slither is not installed; skipping template scan.")
        return 0

    with tempfile.TemporaryDirectory(prefix="solidity-skill-slither-") as temp_name:
        project = Path(temp_name)
        subprocess.run(["forge", "init", "--no-git", "--quiet", "."], cwd=project, check=True)
        subprocess.run(
            ["forge", "install", "OpenZeppelin/openzeppelin-contracts", "--no-git", "--quiet"],
            cwd=project,
            check=True,
        )
        copy_templates(project)
        subprocess.run(["forge", "build"], cwd=project, check=True)

        result = subprocess.run(
            [
                slither,
                ".",
                "--config-file",
                str(ROOT / "security" / "slither.config.json"),
            ],
            cwd=project,
            check=False,
        )
        return result.returncode


if __name__ == "__main__":
    raise SystemExit(main())
