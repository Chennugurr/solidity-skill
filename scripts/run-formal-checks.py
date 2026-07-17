#!/usr/bin/env python3
"""Run the suite's blocking SMTChecker and Halmos examples."""

from __future__ import annotations

import shutil
import subprocess
import sys
import tempfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
TEMPLATES = ROOT / "skills" / "formal-verification-engineer" / "templates"


class FormalCheckError(RuntimeError):
    pass


def require_tool(name: str) -> str:
    executable = shutil.which(name)
    if executable is None:
        raise FormalCheckError(f"{name} is required")
    return executable


def run_smtchecker(solc: str) -> None:
    version = subprocess.run([solc, "--version"], text=True, capture_output=True, check=True).stdout
    if "0.8.36" not in version:
        raise FormalCheckError("SMTChecker validation requires solc 0.8.36")
    completed = subprocess.run(
        [
            solc,
            "--model-checker-engine",
            "chc",
            "--model-checker-solvers",
            "z3",
            "--model-checker-targets",
            "assert",
            str(TEMPLATES / "SmtCheckerExample.sol"),
        ],
        text=True,
        capture_output=True,
        check=False,
    )
    output = completed.stdout + completed.stderr
    if completed.returncode != 0:
        raise FormalCheckError(f"SMTChecker failed:\n{output}")
    rejected = ("Assertion violation happens here", "Solver z3 was selected for SMTChecker but it is not available")
    if any(message in output for message in rejected):
        raise FormalCheckError(f"SMTChecker did not prove the example:\n{output}")
    print("SMTChecker example passed with solc 0.8.36.")


def run_halmos(forge: str, halmos: str) -> None:
    version = subprocess.run([halmos, "--version"], text=True, capture_output=True, check=True).stdout
    if version.strip() != "halmos 0.3.3":
        raise FormalCheckError(f"Halmos 0.3.3 is required, found {version.strip()}")

    with tempfile.TemporaryDirectory(prefix="solidity-skill-halmos-") as temp_name:
        project = Path(temp_name)
        for directory in ("src", "test", "script", "lib"):
            (project / directory).mkdir()
        (project / "foundry.toml").write_text(
            '[profile.default]\nsolc_version = "0.8.36"\n', encoding="utf-8"
        )
        subprocess.run(
            [forge, "install", "foundry-rs/forge-std@v1.16.2", "--no-git", "--quiet"],
            cwd=project,
            check=True,
        )
        shutil.copy2(TEMPLATES / "HalmosExample.t.sol", project / "test" / "HalmosExample.t.sol")
        subprocess.run([forge, "build"], cwd=project, check=True)
        completed = subprocess.run(
            [
                halmos,
                "--root",
                str(project),
                "--contract",
                "HalmosExampleTest",
                "--function",
                "check_AdditionIsCommutative",
                "--solver",
                "z3",
            ],
            text=True,
            capture_output=True,
            check=False,
        )
        output = completed.stdout + completed.stderr
        if completed.returncode != 0 or "PASS" not in output:
            raise FormalCheckError(f"Halmos example failed:\n{output}")
    print("Halmos example passed with Halmos 0.3.3.")


def main() -> int:
    try:
        run_smtchecker(require_tool("solc"))
        run_halmos(require_tool("forge"), require_tool("halmos"))
    except (FormalCheckError, OSError, subprocess.CalledProcessError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
