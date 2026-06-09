#!/usr/bin/env python3
"""Validate the Solidity agent skill suite."""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import zipfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SKILLS_DIR = ROOT / "skills"
SHARED_DIR = ROOT / "shared"
DIST_DIR = ROOT / "dist"

SKILL_NAME_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
PATH_RE = re.compile(r"`([^`]+(?:\.md|\.sol|\.json|\.yml|\.yaml|\.py))`")
VENDOR_TERMS = ("Codex", "Claude", "Cursor", "ChatGPT")


class SuiteError(Exception):
    pass


def parse_frontmatter(path: Path) -> dict[str, str]:
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        raise SuiteError(f"{path.relative_to(ROOT)} missing YAML frontmatter")

    try:
        _, raw, _ = text.split("---", 2)
    except ValueError as exc:
        raise SuiteError(f"{path.relative_to(ROOT)} has invalid YAML frontmatter fence") from exc

    data: dict[str, str] = {}
    for line in raw.strip().splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        if ":" not in line:
            raise SuiteError(f"{path.relative_to(ROOT)} has invalid frontmatter line: {line}")
        key, value = line.split(":", 1)
        data[key.strip()] = value.strip().strip('"').strip("'")
    return data


def skill_dirs() -> list[Path]:
    return sorted(path for path in SKILLS_DIR.iterdir() if (path / "SKILL.md").is_file())


def validate_skills() -> set[str]:
    names: set[str] = set()
    for skill_dir in skill_dirs():
        name = skill_dir.name
        if not SKILL_NAME_RE.fullmatch(name):
            raise SuiteError(f"Invalid skill folder name: {name}")

        metadata = parse_frontmatter(skill_dir / "SKILL.md")
        if metadata.get("name") != name:
            raise SuiteError(f"{skill_dir / 'SKILL.md'} name does not match folder")
        if not metadata.get("description"):
            raise SuiteError(f"{skill_dir / 'SKILL.md'} missing description")
        names.add(name)

    expected = {
        "solidity-builder",
        "solidity-auditor",
        "foundry-test-writer",
        "evm-deployment-engineer",
        "defi-accounting-engineer",
        "uniswap-v4-hook-engineer",
        "upgradeable-contract-engineer",
        "token-launch-builder",
        "protocol-spec-writer",
    }
    if names != expected:
        missing = ", ".join(sorted(expected - names)) or "none"
        extra = ", ".join(sorted(names - expected)) or "none"
        raise SuiteError(f"Unexpected skill set. Missing: {missing}. Extra: {extra}.")
    return names


def resolve_reference(source: Path, reference: str) -> Path | None:
    if "://" in reference or reference.startswith("#"):
        return None
    if "<" in reference or ">" in reference:
        return None
    if reference.startswith("./"):
        reference = reference[2:]
    if reference.startswith("../") or reference.startswith("references/") or reference.startswith("templates/"):
        return (source.parent / reference).resolve()
    if reference.startswith(("skills/", "shared/", "adapters/", "examples/", "docs/", "scripts/", ".github/")):
        return (ROOT / reference).resolve()
    if reference.startswith((".codex-plugin/", ".claude-plugin/")):
        return (ROOT / reference).resolve()
    return None


def validate_referenced_paths() -> None:
    checked_files = [
        *ROOT.glob("*.md"),
        *ROOT.glob(".*-plugin/*.json"),
        *ROOT.glob("adapters/*/*.md"),
        *ROOT.glob("docs/*.md"),
        *ROOT.glob("examples/*/*.md"),
        *ROOT.glob("skills/*/SKILL.md"),
        *ROOT.glob("skills/*/README.md"),
        *ROOT.glob("skills/*/references/*.md"),
        *ROOT.glob("shared/*.md"),
        *ROOT.glob("shared/references/*.md"),
    ]

    missing: list[str] = []
    for source in checked_files:
        text = source.read_text(encoding="utf-8")
        for match in PATH_RE.finditer(text):
            ref = match.group(1).strip()
            target = resolve_reference(source, ref)
            if target is None:
                continue
            try:
                target.relative_to(ROOT)
            except ValueError:
                continue
            if not target.exists():
                missing.append(f"{source.relative_to(ROOT)} -> {ref}")

    if missing:
        raise SuiteError("Missing referenced paths:\n" + "\n".join(sorted(missing)))


def validate_examples(skill_names: set[str]) -> None:
    for readme in sorted((ROOT / "examples").glob("*/README.md")):
        text = readme.read_text(encoding="utf-8")
        if not any(name in text for name in skill_names):
            raise SuiteError(f"{readme.relative_to(ROOT)} does not mention an existing skill")


def validate_vendor_neutral_core() -> None:
    violations: list[str] = []
    for base in (SKILLS_DIR, SHARED_DIR):
        for path in base.rglob("*"):
            if not path.is_file() or path.suffix not in {".md", ".sol"}:
                continue
            text = path.read_text(encoding="utf-8")
            for term in VENDOR_TERMS:
                if term in text:
                    violations.append(f"{path.relative_to(ROOT)} contains {term}")
    if violations:
        raise SuiteError("Vendor-specific language in reusable skill content:\n" + "\n".join(violations))


def validate_plugin_manifests() -> None:
    codex_path = ROOT / ".codex-plugin" / "plugin.json"
    claude_path = ROOT / ".claude-plugin" / "plugin.json"
    for path in (codex_path, claude_path):
        data = json.loads(path.read_text(encoding="utf-8"))
        for field in ("name", "version", "description", "repository", "license"):
            if not data.get(field):
                raise SuiteError(f"{path.relative_to(ROOT)} missing {field}")
        if data["name"] != "solidity-skill":
            raise SuiteError(f"{path.relative_to(ROOT)} has unexpected plugin name")

    codex = json.loads(codex_path.read_text(encoding="utf-8"))
    if codex.get("skills") != "./skills/":
        raise SuiteError(".codex-plugin/plugin.json must point skills to ./skills/")
    if not (ROOT / codex["skills"]).resolve().is_dir():
        raise SuiteError(".codex-plugin/plugin.json skills path does not exist")

    unsupported = {"hooks", "mcpServers", "apps"}
    present = unsupported.intersection(codex)
    if present:
        raise SuiteError(f".codex-plugin/plugin.json has unsupported fields: {sorted(present)}")


def validate_packaged_zips() -> None:
    subprocess.run([sys.executable, "scripts/package-upload-skills.py"], cwd=ROOT, check=True)
    expected = {f"{path.name}.zip" for path in skill_dirs()}
    actual = {path.name for path in DIST_DIR.glob("*.zip") if path.name != "solidity-agent-skills-source.zip"}
    if actual != expected:
        raise SuiteError(f"Unexpected upload zips. Expected {sorted(expected)}, got {sorted(actual)}")

    for zip_path in sorted(DIST_DIR.glob("*.zip")):
        if zip_path.name == "solidity-agent-skills-source.zip":
            continue
        with zipfile.ZipFile(zip_path) as archive:
            names = set(archive.namelist())
            if "SKILL.md" not in names:
                raise SuiteError(f"{zip_path.relative_to(ROOT)} missing root SKILL.md")
            skill_text = archive.read("SKILL.md").decode("utf-8")
            if "../../shared/references/" in skill_text or "shared/references/" in skill_text:
                raise SuiteError(f"{zip_path.relative_to(ROOT)} has stale shared reference paths")
            if not any(name.startswith("references/shared/") for name in names):
                raise SuiteError(f"{zip_path.relative_to(ROOT)} missing packaged shared references")


def copy_templates_for_foundry(project: Path) -> None:
    for template in sorted(ROOT.glob("skills/*/templates/*.sol")):
        if template.name.endswith(".t.sol"):
            destination = project / "test" / template.name
        elif template.name.endswith(".s.sol"):
            destination = project / "script" / template.name
        else:
            destination = project / "src" / template.name
        shutil.copy2(template, destination)


def compile_templates() -> None:
    if shutil.which("forge") is None:
        raise SuiteError("forge is required for --compile-templates")

    with tempfile.TemporaryDirectory(prefix="solidity-skill-foundry-") as temp_name:
        project = Path(temp_name)
        subprocess.run(["forge", "init", "--no-git", "--quiet", "."], cwd=project, check=True)
        subprocess.run(
            ["forge", "install", "OpenZeppelin/openzeppelin-contracts", "--no-git", "--quiet"],
            cwd=project,
            check=True,
        )
        copy_templates_for_foundry(project)
        subprocess.run(["forge", "test"], cwd=project, check=True)


def run_external_plugin_validators() -> None:
    codex_validator = Path.home() / ".codex" / "skills" / ".system" / "plugin-creator" / "scripts" / "validate_plugin.py"
    if codex_validator.exists():
        subprocess.run([sys.executable, str(codex_validator), str(ROOT)], check=True)
    else:
        print("warning: Codex plugin validator not found; structural validation already ran")

    claude = shutil.which("claude")
    if claude:
        subprocess.run([claude, "plugin", "validate", ".", "--strict"], cwd=ROOT, check=True)
    else:
        print("warning: Claude CLI not found; structural validation already ran")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--package", action="store_true", help="rebuild and inspect ChatGPT upload zips")
    parser.add_argument("--compile-templates", action="store_true", help="compile Solidity templates in a temp Foundry project")
    parser.add_argument(
        "--external-plugin-validators",
        action="store_true",
        help="run local Codex/Claude plugin validators when available",
    )
    args = parser.parse_args()

    try:
        skill_names = validate_skills()
        validate_referenced_paths()
        validate_examples(skill_names)
        validate_vendor_neutral_core()
        validate_plugin_manifests()
        if args.package:
            validate_packaged_zips()
        if args.compile_templates:
            compile_templates()
        if args.external_plugin_validators:
            run_external_plugin_validators()
    except (SuiteError, subprocess.CalledProcessError, json.JSONDecodeError, OSError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1

    print("Suite validation passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
