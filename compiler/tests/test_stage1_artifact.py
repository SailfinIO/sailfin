from __future__ import annotations

import importlib
import os
import pathlib
import sys
import zipfile
import subprocess

import pytest

from tools import package_stage1

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]


@pytest.mark.integration
def test_stage1_artifact_can_compile_stage1(tmp_path: pathlib.Path) -> None:
    artifact_path = package_stage1.build_stage1_artifact(tmp_path)

    extract_dir = tmp_path / "artifact"
    with zipfile.ZipFile(artifact_path) as archive:
        info = archive.getinfo("bin/sailfin-stage1")
        assert (info.external_attr >> 16) & 0o111, "CLI launcher lacks execute bit in archive"
        archive.extractall(extract_dir)

    sys.path.insert(0, str(extract_dir))
    try:
        stage1_main = importlib.import_module("compiler.build.main")
        sources = sorted((REPO_ROOT / "compiler" / "src").glob("*.sfn"))
        result = stage1_main.compile_project([str(path) for path in sources])
        diagnostics = getattr(result, "diagnostics", [])
        fatal = [entry for entry in diagnostics if getattr(entry, "fatal", False)]
        assert not fatal, f"fatal diagnostics reported: {fatal}"
        modules = getattr(result, "modules", [])
        assert modules, "stage1 compiler returned no modules"
        for module in modules:
            python_source = getattr(module, "python_source", None)
            assert python_source, f"module missing python_source: {module}"

        launcher = extract_dir / "bin" / "sailfin-stage1"
        assert launcher.exists(), "CLI launcher missing from artifact"
        if not os.access(launcher, os.X_OK):
            launcher.chmod(launcher.stat().st_mode | 0o111)

        cli_output_dir = tmp_path / "stage1-cli-out"
        subprocess.check_call(
            [str(launcher), str(REPO_ROOT / "compiler" / "src"), "--out", str(cli_output_dir)]
        )
        generated = list(cli_output_dir.glob("*.py"))
        assert generated, "CLI launcher did not generate any Python modules"
    finally:
        sys.path.remove(str(extract_dir))
        importlib.invalidate_caches()
