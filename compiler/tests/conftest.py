from __future__ import annotations

import importlib
import pathlib
import sys
from typing import Iterator

import pytest

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))


@pytest.fixture()
def stage1_environment(tmp_path_factory: pytest.TempPathFactory) -> Iterator[pathlib.Path]:
    """Compile the Stage1 toolchain into an isolated directory."""

    from tools.compile_with_stage1 import Stage1CompileError, compile_stage1

    temp_root = tmp_path_factory.mktemp("stage1_build")
    output_dir = temp_root / "compiler" / "build"
    try:
        compile_stage1([REPO_ROOT / "compiler" / "src"], output_dir)
    except Stage1CompileError as exc:
        raise RuntimeError(f"stage1 compile failed during test setup: {exc}") from exc

    _clear_stage1_modules()
    sys.path.insert(0, str(temp_root))
    try:
        yield temp_root
    finally:
        sys.path.remove(str(temp_root))
        _clear_stage1_modules()


def _clear_stage1_modules() -> None:
    for name in list(sys.modules):
        if name == "compiler.build" or name.startswith("compiler.build."):
            sys.modules.pop(name, None)
    importlib.invalidate_caches()
