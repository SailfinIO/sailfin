from __future__ import annotations

import importlib
import os
import pathlib
import shutil
import sys
import tempfile
from typing import Iterator

import pytest

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

_CACHE_DIR_ENV = "PYTEST_STAGE1_CACHE_DIR"
_DISABLE_CACHE_ENV = "PYTEST_STAGE1_NO_CACHE"
_DEBUG_ENV = "PYTEST_STAGE1_DEBUG"
_DEFAULT_CACHE_DIR = REPO_ROOT / ".pytest-stage1"


@pytest.fixture(scope="session")
def _session_stage1_environment() -> Iterator[pathlib.Path]:
    """Prepare a Stage1 toolchain build once per test session (with caching)."""

    from tools.compile_with_stage1 import Stage1CompileError, compile_stage1, ensure_stage1_cache

    disable_cache = os.environ.get(_DISABLE_CACHE_ENV) == "1"
    debug = bool(os.environ.get(_DEBUG_ENV))
    cleanup_path: pathlib.Path | None = None

    if disable_cache:
        temp_dir = pathlib.Path(tempfile.mkdtemp(prefix="stage1-build-session-"))
        output_dir = temp_dir / "compiler" / "build"
        try:
            compile_stage1([REPO_ROOT / "compiler" / "src", REPO_ROOT / "runtime"], output_dir)
        except Stage1CompileError as exc:
            shutil.rmtree(temp_dir, ignore_errors=True)
            raise RuntimeError(f"stage1 compile failed during test setup: {exc}") from exc
        build_root = temp_dir
        cleanup_path = temp_dir
        if debug:
            print(f"[stage1-environment] compiled stage1 without cache into {build_root}")
    else:
        cache_dir = pathlib.Path(os.environ.get(_CACHE_DIR_ENV, _DEFAULT_CACHE_DIR))
        try:
            build_root = ensure_stage1_cache(cache_dir, debug=debug)
        except Stage1CompileError as exc:
            raise RuntimeError(f"stage1 compile failed during test setup: {exc}") from exc

    _clear_stage1_modules()
    sys.path.insert(0, str(build_root))
    try:
        yield build_root
    finally:
        if str(build_root) in sys.path:
            sys.path.remove(str(build_root))
        _clear_stage1_modules()
        if cleanup_path is not None and cleanup_path.exists():
            shutil.rmtree(cleanup_path, ignore_errors=True)


@pytest.fixture()
def stage1_environment(_session_stage1_environment: pathlib.Path) -> Iterator[pathlib.Path]:
    """Expose the session-scoped Stage1 build while clearing imports per test."""

    _clear_stage1_modules()
    try:
        yield _session_stage1_environment
    finally:
        _clear_stage1_modules()


def _clear_stage1_modules() -> None:
    for name in list(sys.modules):
        if name == "compiler.build" or name.startswith("compiler.build."):
            sys.modules.pop(name, None)
    importlib.invalidate_caches()


def pytest_sessionfinish(session: pytest.Session, exitstatus: int) -> None:  # pragma: no cover - debug logging
    if not os.environ.get(_DEBUG_ENV):
        return

    from tools.compile_with_stage1 import stage1_cache_stats

    stats = stage1_cache_stats()
    hits = stats.get("hits", 0)
    misses = stats.get("misses", 0)
    builds = stats.get("builds", 0)
    print(f"[stage1-cache] summary hits={hits} misses={misses} builds={builds}")
