#!/usr/bin/env python3
"""Build release assets for GitHub uploads."""

from __future__ import annotations

import hashlib
import subprocess
import sys
import zipfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DIST_DIR = ROOT / "dist"
SOURCE_ZIP = DIST_DIR / "solidity-agent-skills-source.zip"
EXCLUDED_DIRS = {".git", "dist", "out", "cache", "broadcast", "node_modules", "lib"}


def should_include(path: Path) -> bool:
    rel = path.relative_to(ROOT)
    return not any(part in EXCLUDED_DIRS for part in rel.parts)


def build_source_zip() -> Path:
    if SOURCE_ZIP.exists():
        SOURCE_ZIP.unlink()

    with zipfile.ZipFile(SOURCE_ZIP, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for path in sorted(ROOT.rglob("*")):
            if path.is_file() and should_include(path):
                archive.write(path, path.relative_to(ROOT))
    return SOURCE_ZIP


def write_checksums() -> Path:
    checksum_path = DIST_DIR / "SHA256SUMS"
    lines = []
    for path in sorted(DIST_DIR.glob("*.zip")):
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        lines.append(f"{digest}  {path.name}")
    checksum_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return checksum_path


def main() -> int:
    DIST_DIR.mkdir(exist_ok=True)
    subprocess.run([sys.executable, "scripts/package-upload-skills.py"], cwd=ROOT, check=True)
    build_source_zip()
    checksum_path = write_checksums()
    print(f"Wrote release assets to {DIST_DIR.relative_to(ROOT)}")
    print(checksum_path.relative_to(ROOT))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
