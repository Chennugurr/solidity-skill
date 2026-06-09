#!/usr/bin/env python3
"""Build ChatGPT single-skill upload zips from the suite skills."""

from __future__ import annotations

import shutil
import subprocess
import tempfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SKILLS_DIR = ROOT / "skills"
SHARED_REFERENCES = ROOT / "shared" / "references"
DIST_DIR = ROOT / "dist"


def rewrite_links(path: Path) -> None:
    if path.suffix not in {".md", ".sol"}:
        return
    text = path.read_text(encoding="utf-8")
    text = text.replace("../../shared/references/", "references/shared/")
    text = text.replace("shared/references/", "references/shared/")
    path.write_text(text, encoding="utf-8")


def build_skill_zip(skill_dir: Path) -> Path:
    skill_name = skill_dir.name
    zip_path = DIST_DIR / f"{skill_name}.zip"
    if zip_path.exists():
        zip_path.unlink()

    with tempfile.TemporaryDirectory(prefix=f"{skill_name}-upload-") as temp_name:
        package_root = Path(temp_name) / skill_name
        shutil.copytree(skill_dir, package_root)
        shared_dest = package_root / "references" / "shared"
        shared_dest.mkdir(parents=True, exist_ok=True)

        for source in sorted(SHARED_REFERENCES.glob("*.md")):
            shutil.copy2(source, shared_dest / source.name)

        for packaged_file in package_root.rglob("*"):
            if packaged_file.is_file():
                rewrite_links(packaged_file)

        subprocess.run(
            ["zip", "-qr", str(zip_path), "."],
            cwd=package_root,
            check=True,
        )

    return zip_path


def main() -> None:
    DIST_DIR.mkdir(exist_ok=True)
    for old_zip in DIST_DIR.glob("*.zip"):
        old_zip.unlink()

    skill_dirs = sorted(path for path in SKILLS_DIR.iterdir() if (path / "SKILL.md").is_file())
    for skill_dir in skill_dirs:
        zip_path = build_skill_zip(skill_dir)
        print(zip_path.relative_to(ROOT))


if __name__ == "__main__":
    main()
