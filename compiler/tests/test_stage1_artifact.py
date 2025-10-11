from __future__ import annotations

import importlib
import pathlib
import sys
import zipfile

import pytest

from tools import package_stage1

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]


@pytest.mark.integration
def test_stage1_artifact_can_compile_stage1(tmp_path: pathlib.Path) -> None:
    artifact_path = package_stage1.build_stage1_artifact(tmp_path)

    extract_dir = tmp_path / "artifact"
    with zipfile.ZipFile(artifact_path) as archive:
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
    finally:
        sys.path.remove(str(extract_dir))
        importlib.invalidate_caches()
