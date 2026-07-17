#!/usr/bin/env python3
"""Validate and run vendor-neutral prompt evaluations for the skill suite."""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CASES_PATH = ROOT / "evals" / "cases.json"
BASELINES_PATH = ROOT / "evals" / "baselines.json"


class EvalError(RuntimeError):
    pass


def load_json(path: Path) -> dict:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise EvalError(f"Cannot load {path.relative_to(ROOT)}: {exc}") from exc
    if not isinstance(value, dict):
        raise EvalError(f"{path.relative_to(ROOT)} must contain a JSON object")
    return value


def load_cases() -> list[dict]:
    document = load_json(CASES_PATH)
    if document.get("schemaVersion") != 1 or not isinstance(document.get("cases"), list):
        raise EvalError("evals/cases.json must use schemaVersion 1 and contain cases")

    seen_ids: set[str] = set()
    seen_skills: set[str] = set()
    required_keys = {"id", "skill", "prompt", "requiredPatterns", "forbiddenPatterns", "fileAssertions"}
    for case in document["cases"]:
        if not isinstance(case, dict) or not required_keys.issubset(case):
            raise EvalError(f"Evaluation case is missing fields: {case!r}")
        if case["id"] in seen_ids:
            raise EvalError(f"Duplicate evaluation id: {case['id']}")
        if case["skill"] in seen_skills:
            raise EvalError(f"Duplicate skill evaluation: {case['skill']}")
        if not (ROOT / "skills" / case["skill"] / "SKILL.md").is_file():
            raise EvalError(f"Unknown skill in evaluation: {case['skill']}")
        for field in ("requiredPatterns", "forbiddenPatterns", "fileAssertions"):
            if not isinstance(case[field], list):
                raise EvalError(f"{case['id']}.{field} must be an array")
        seen_ids.add(case["id"])
        seen_skills.add(case["skill"])
    return document["cases"]


def load_baselines() -> dict[str, dict]:
    document = load_json(BASELINES_PATH)
    if document.get("schemaVersion") != 1 or not isinstance(document.get("results"), dict):
        raise EvalError("evals/baselines.json must use schemaVersion 1 and contain results")
    return document["results"]


def assert_patterns(case: dict, response: str, workspace: Path) -> None:
    failures: list[str] = []
    for pattern in case["requiredPatterns"]:
        if re.search(pattern, response, re.IGNORECASE | re.MULTILINE) is None:
            failures.append(f"missing response pattern {pattern!r}")
    for pattern in case["forbiddenPatterns"]:
        if re.search(pattern, response, re.IGNORECASE | re.MULTILINE) is not None:
            failures.append(f"forbidden response pattern {pattern!r}")

    for assertion in case["fileAssertions"]:
        if not isinstance(assertion, dict) or "path" not in assertion:
            failures.append(f"invalid file assertion {assertion!r}")
            continue
        relative = Path(assertion["path"])
        candidate = (workspace / relative).resolve()
        if workspace.resolve() not in candidate.parents:
            failures.append(f"file assertion escapes workspace: {relative}")
            continue
        if not candidate.is_file():
            failures.append(f"missing generated file {relative}")
            continue
        contents = candidate.read_text(encoding="utf-8")
        for pattern in assertion.get("requiredPatterns", []):
            if re.search(pattern, contents, re.IGNORECASE | re.MULTILINE) is None:
                failures.append(f"{relative} is missing pattern {pattern!r}")

    if failures:
        raise EvalError(f"{case['id']}: " + "; ".join(failures))


def materialize_files(workspace: Path, files: dict[str, str]) -> None:
    for relative_name, contents in files.items():
        relative = Path(relative_name)
        destination = (workspace / relative).resolve()
        if workspace.resolve() not in destination.parents:
            raise EvalError(f"Baseline file escapes workspace: {relative}")
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text(contents, encoding="utf-8")


def replay_baselines(cases: list[dict], baselines: dict[str, dict]) -> None:
    case_ids = {case["id"] for case in cases}
    if set(baselines) != case_ids:
        missing = sorted(case_ids - set(baselines))
        extra = sorted(set(baselines) - case_ids)
        raise EvalError(f"Baseline ids do not match cases; missing={missing}, extra={extra}")
    for case in cases:
        baseline = baselines[case["id"]]
        if not isinstance(baseline, dict) or not isinstance(baseline.get("response"), str):
            raise EvalError(f"Invalid baseline for {case['id']}")
        with tempfile.TemporaryDirectory(prefix=f"skill-eval-{case['id']}-") as temp:
            workspace = Path(temp)
            files = baseline.get("files", {})
            if not isinstance(files, dict):
                raise EvalError(f"Baseline files for {case['id']} must be an object")
            materialize_files(workspace, files)
            assert_patterns(case, baseline["response"], workspace)


def run_adapter(cases: list[dict], executable: str) -> None:
    for case in cases:
        with tempfile.TemporaryDirectory(prefix=f"skill-eval-{case['id']}-") as temp:
            workspace = Path(temp)
            request = {
                "id": case["id"],
                "skill": case["skill"],
                "skillPath": str(ROOT / "skills" / case["skill"] / "SKILL.md"),
                "prompt": case["prompt"],
                "workspace": str(workspace),
            }
            completed = subprocess.run(
                [executable],
                input=json.dumps(request),
                text=True,
                capture_output=True,
                check=False,
                timeout=case.get("timeoutSeconds", 180),
            )
            if completed.returncode != 0:
                raise EvalError(f"{case['id']}: adapter failed: {completed.stderr.strip()}")
            try:
                result = json.loads(completed.stdout)
            except json.JSONDecodeError as exc:
                raise EvalError(f"{case['id']}: adapter returned invalid JSON: {exc}") from exc
            if not isinstance(result, dict) or not isinstance(result.get("response"), str):
                raise EvalError(f"{case['id']}: adapter result must contain a string response")
            assert_patterns(case, result["response"], workspace)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--validate-only", action="store_true")
    mode.add_argument("--replay-baselines", action="store_true")
    mode.add_argument("--adapter", metavar="EXECUTABLE")
    parser.add_argument("--case", action="append", dest="case_ids", help="Run only a case id")
    args = parser.parse_args()

    try:
        cases = load_cases()
        baselines = load_baselines()
        if args.case_ids:
            selected = set(args.case_ids)
            cases = [case for case in cases if case["id"] in selected]
            missing = selected - {case["id"] for case in cases}
            if missing:
                raise EvalError(f"Unknown case ids: {sorted(missing)}")
        if args.replay_baselines:
            replay_baselines(cases, {case["id"]: baselines[case["id"]] for case in cases})
        elif args.adapter:
            run_adapter(cases, args.adapter)
    except (EvalError, subprocess.TimeoutExpired) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1

    print(f"Validated {len(cases)} skill evaluation case(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
