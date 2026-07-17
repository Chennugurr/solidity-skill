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
import tomllib
import zipfile
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[1]
SKILLS_DIR = ROOT / "skills"
SHARED_DIR = ROOT / "shared"
DIST_DIR = ROOT / "dist"

SKILL_NAME_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
PATH_RE = re.compile(r"`([^`]+(?:\.md|\.sol|\.json|\.yml|\.yaml|\.toml|\.lock|\.spec|\.conf|\.py))`")
MARKDOWN_LINK_RE = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
VENDOR_TERMS = ("Codex", "Claude", "Cursor", "ChatGPT")
EXCLUDED_PARTS = {".git", "dist", "out", "cache", "broadcast", "node_modules", "dependencies", "lib"}
EXPECTED_PROJECTS = {
    "erc4626-vault",
    "upgradeable-staking",
    "erc4337-smart-account",
    "oracle-lending-market",
    "governance-timelock",
}


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

    data = yaml.safe_load(raw)
    if not isinstance(data, dict):
        raise SuiteError(f"{path.relative_to(ROOT)} frontmatter must be a YAML mapping")
    return {str(key): str(value) for key, value in data.items()}


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
        "account-abstraction-engineer",
        "oracle-integration-engineer",
        "protocol-operations-engineer",
        "formal-verification-engineer",
        "cross-chain-l2-engineer",
        "lending-liquidation-engineer",
        "stablecoin-engineer",
        "perpetuals-funding-engineer",
        "intent-solver-engineer",
        "staking-restaking-engineer",
        "rwa-token-engineer",
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
    if reference.startswith(("skills/", "shared/", "security/", "adapters/", "examples/", "evals/", "docs/", "scripts/", ".github/")):
        return (ROOT / reference).resolve()
    if reference.startswith((".codex-plugin/", ".claude-plugin/")):
        return (ROOT / reference).resolve()
    return None


def validate_referenced_paths() -> None:
    checked_files = [
        path
        for path in ROOT.rglob("*")
        if path.is_file()
        and not EXCLUDED_PARTS.intersection(path.relative_to(ROOT).parts)
        and path.suffix in {".md", ".json", ".yaml", ".yml", ".toml", ".conf"}
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
        for match in MARKDOWN_LINK_RE.finditer(text):
            ref = match.group(1).strip().split("#", 1)[0]
            if not ref or "://" in ref or ref.startswith(("mailto:", "#")):
                continue
            target = (source.parent / ref).resolve()
            try:
                target.relative_to(ROOT)
            except ValueError:
                continue
            if not target.exists():
                missing.append(f"{source.relative_to(ROOT)} -> {ref}")

    if missing:
        raise SuiteError("Missing referenced paths:\n" + "\n".join(sorted(missing)))


def validate_examples(skill_names: set[str]) -> None:
    covered: set[str] = set()
    for name in skill_names:
        readme = ROOT / "examples" / name / "README.md"
        if not readme.is_file():
            raise SuiteError(f"Missing prompt example for {name}")
        if name not in readme.read_text(encoding="utf-8"):
            raise SuiteError(f"{readme.relative_to(ROOT)} does not mention {name}")
        covered.add(name)
    if covered != skill_names:
        raise SuiteError("Example prompt coverage does not match the public skills")


def validate_structured_assets() -> None:
    for path in sorted(ROOT.rglob("*")):
        if not path.is_file() or EXCLUDED_PARTS.intersection(path.relative_to(ROOT).parts):
            continue
        text = path.read_text(encoding="utf-8")
        try:
            if path.suffix == ".json" or path.name == "certora.conf":
                json.loads(text)
            elif path.suffix in {".yaml", ".yml"}:
                yaml.safe_load(text)
            elif path.suffix == ".toml" or path.name.endswith(".lock"):
                tomllib.loads(text)
        except (json.JSONDecodeError, yaml.YAMLError, tomllib.TOMLDecodeError) as exc:
            raise SuiteError(f"Invalid structured asset {path.relative_to(ROOT)}: {exc}") from exc


def validate_evaluations(skill_names: set[str]) -> None:
    cases = json.loads((ROOT / "evals" / "cases.json").read_text(encoding="utf-8"))
    baselines = json.loads((ROOT / "evals" / "baselines.json").read_text(encoding="utf-8"))
    case_names = {case["skill"] for case in cases.get("cases", [])}
    case_ids = {case["id"] for case in cases.get("cases", [])}
    if case_names != skill_names:
        raise SuiteError("Evaluation cases must cover each public skill exactly once")
    if set(baselines.get("results", {})) != case_ids:
        raise SuiteError("Stored evaluation baselines do not match case ids")
    subprocess.run([sys.executable, "scripts/run-skill-evals.py", "--validate-only"], cwd=ROOT, check=True)
    subprocess.run([sys.executable, "scripts/run-skill-evals.py", "--replay-baselines"], cwd=ROOT, check=True)


def validate_example_projects() -> None:
    projects_root = ROOT / "examples" / "projects"
    actual = {path.name for path in projects_root.iterdir() if path.is_dir()}
    if actual != EXPECTED_PROJECTS:
        raise SuiteError(f"Unexpected standalone project set: {sorted(actual)}")

    for name in sorted(EXPECTED_PROJECTS):
        project = projects_root / name
        required = ("README.md", "AUDIT_NOTES.md", "foundry.toml", "soldeer.lock", "src", "test", "script")
        for relative in required:
            if not (project / relative).exists():
                raise SuiteError(f"{project.relative_to(ROOT)} is missing {relative}")
        config = tomllib.loads((project / "foundry.toml").read_text(encoding="utf-8"))
        profile = config.get("profile", {}).get("default", {})
        dependencies = config.get("dependencies", {})
        if profile.get("solc_version") != "0.8.36":
            raise SuiteError(f"{name} must pin Solidity 0.8.36")
        if dependencies.get("forge-std") != "1.16.2":
            raise SuiteError(f"{name} must pin forge-std 1.16.2")

        test_text = "\n".join(path.read_text(encoding="utf-8") for path in (project / "test").glob("*.sol"))
        for pattern, label in (
            (r"function test", "unit"),
            (r"function testFuzz", "fuzz"),
            (r"function invariant(?:_|[A-Z])", "invariant"),
        ):
            if re.search(pattern, test_text) is None:
                raise SuiteError(f"{name} is missing {label} test coverage")
        if not any((project / "src").glob("*.sol")) or not any((project / "script").glob("*.sol")):
            raise SuiteError(f"{name} must include contracts and scripts")

    oracle_package = json.loads(
        (projects_root / "oracle-lending-market" / "package.json").read_text(encoding="utf-8")
    )["dependencies"]
    expected_provider_versions = {
        "@chainlink/contracts": "1.5.0",
        "@openzeppelin/contracts": "5.6.1",
        "@pythnetwork/pyth-sdk-solidity": "4.3.1",
        "@redstone-finance/evm-connector": "0.9.0",
    }
    if oracle_package != expected_provider_versions:
        raise SuiteError("Oracle example provider dependencies are not pinned to the v2 set")


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
        if data["version"] != "2.0.0":
            raise SuiteError(f"{path.relative_to(ROOT)} must use plugin version 2.0.0")

    codex = json.loads(codex_path.read_text(encoding="utf-8"))
    if codex.get("skills") != "./skills/":
        raise SuiteError(".codex-plugin/plugin.json must point skills to ./skills/")
    if not (ROOT / codex["skills"]).resolve().is_dir():
        raise SuiteError(".codex-plugin/plugin.json skills path does not exist")

    unsupported = {"hooks", "mcpServers", "apps"}
    present = unsupported.intersection(codex)
    if present:
        raise SuiteError(f".codex-plugin/plugin.json has unsupported fields: {sorted(present)}")


def validate_security_configs() -> None:
    slither_config = ROOT / "security" / "slither.config.json"
    echidna_config = ROOT / "security" / "echidna.yaml"
    if not slither_config.is_file():
        raise SuiteError("security/slither.config.json is missing")
    if not echidna_config.is_file():
        raise SuiteError("security/echidna.yaml is missing")
    json.loads(slither_config.read_text(encoding="utf-8"))


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
        for directory in ("src", "test", "script", "lib"):
            (project / directory).mkdir()
        (project / "foundry.toml").write_text(
            '[profile.default]\nsolc_version = "0.8.36"\nevm_version = "cancun"\n', encoding="utf-8"
        )
        subprocess.run(
            ["forge", "install", "foundry-rs/forge-std@v1.16.2", "--no-git", "--quiet"],
            cwd=project,
            check=True,
        )
        subprocess.run(
            ["forge", "install", "OpenZeppelin/openzeppelin-contracts@v5.6.1", "--no-git", "--quiet"],
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
    parser.add_argument("--test-projects", action="store_true", help="install and test standalone Foundry projects")
    parser.add_argument("--formal-tools", action="store_true", help="run blocking SMTChecker and Halmos examples")
    parser.add_argument("--upgrade-validation", action="store_true", help="run OpenZeppelin upgrade validation")
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
        validate_structured_assets()
        validate_evaluations(skill_names)
        validate_example_projects()
        validate_vendor_neutral_core()
        validate_plugin_manifests()
        validate_security_configs()
        if args.package:
            validate_packaged_zips()
        if args.compile_templates:
            compile_templates()
        if args.test_projects:
            subprocess.run([sys.executable, "scripts/test-example-projects.py"], cwd=ROOT, check=True)
        if args.formal_tools:
            subprocess.run([sys.executable, "scripts/run-formal-checks.py"], cwd=ROOT, check=True)
        if args.upgrade_validation:
            subprocess.run([sys.executable, "scripts/run-upgrade-validation.py"], cwd=ROOT, check=True)
        if args.external_plugin_validators:
            run_external_plugin_validators()
    except (
        SuiteError,
        subprocess.CalledProcessError,
        json.JSONDecodeError,
        yaml.YAMLError,
        tomllib.TOMLDecodeError,
        OSError,
    ) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1

    print("Suite validation passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
