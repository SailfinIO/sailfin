from __future__ import annotations

import importlib
import os
import pathlib
import shutil
import sys
import tempfile
from typing import Dict, Iterator, Tuple

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
        temp_dir = pathlib.Path(tempfile.mkdtemp(
            prefix="stage1-build-session-"))
        output_dir = temp_dir / "compiler" / "build"
        try:
            compile_stage1([REPO_ROOT / "compiler" / "src",
                           REPO_ROOT / "runtime"], output_dir)
        except Stage1CompileError as exc:
            shutil.rmtree(temp_dir, ignore_errors=True)
            raise RuntimeError(
                f"stage1 compile failed during test setup: {exc}") from exc
        build_root = temp_dir
        cleanup_path = temp_dir
        if debug:
            print(
                f"[stage1-environment] compiled stage1 without cache into {build_root}")
    else:
        cache_dir = pathlib.Path(os.environ.get(
            _CACHE_DIR_ENV, _DEFAULT_CACHE_DIR))
        try:
            build_root = ensure_stage1_cache(cache_dir, debug=debug)
        except Stage1CompileError as exc:
            raise RuntimeError(
                f"stage1 compile failed during test setup: {exc}") from exc

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


class Stage2Harness:
    """Compile Sailfin sources through the native and LLVM backends with caching."""

    def __init__(self) -> None:
        self._native_cache: Dict[Tuple[str, str], object] = {}
        self._llvm_cache: Dict[Tuple[str, str], object] = {}
        self._python_cache: Dict[Tuple[str, str], object] = {}

    def compile_to_native(self, source: str, *, module_name: str = "<memory>") -> object:
        key = (module_name, source)
        cached = self._native_cache.get(key)
        if cached is not None:
            return cached
        stage1_main = importlib.import_module("compiler.build.main")
        result = stage1_main.compile_to_native(source)
        self._native_cache[key] = result
        return result

    def compile_to_native_from_path(self, path: pathlib.Path) -> object:
        source = path.read_text(encoding="utf-8")
        return self.compile_to_native(source, module_name=str(path))

    def compile_to_native_llvm(self, source: str, *, module_name: str = "<memory>") -> object:
        key = (module_name, source)
        cached = self._llvm_cache.get(key)
        if cached is not None:
            return cached
        stage1_main = importlib.import_module("compiler.build.main")
        result = stage1_main.compile_to_native_llvm(source)
        self._llvm_cache[key] = result
        return result

    def compile_to_native_llvm_from_path(self, path: pathlib.Path) -> object:
        source = path.read_text(encoding="utf-8")
        return self.compile_to_native_llvm(source, module_name=str(path))

    def compile_to_native_llvm_full(self, source: str, *, module_name: str = "<memory>") -> object:
        key = (module_name, source)
        cached = self._llvm_cache.get(key)
        if cached is not None:
            return cached
        stage1_main = importlib.import_module("compiler.build.main")
        result = stage1_main.compile_to_native_llvm_full(source)
        self._llvm_cache[key] = result
        return result

    def compile_to_native_llvm_full_from_path(self, path: pathlib.Path) -> object:
        source = path.read_text(encoding="utf-8")
        return self.compile_to_native_llvm_full(source, module_name=str(path))

    def compile_to_native_python(self, source: str, *, module_name: str = "<memory>") -> object:
        key = (module_name, source)
        cached = self._python_cache.get(key)
        if cached is not None:
            return cached
        stage1_main = importlib.import_module("compiler.build.main")
        result = stage1_main.compile_to_native_python(source)
        self._python_cache[key] = result
        return result

    def compile_to_native_python_from_path(self, path: pathlib.Path) -> object:
        source = path.read_text(encoding="utf-8")
        return self.compile_to_native_python(source, module_name=str(path))


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
    print(
        f"[stage1-cache] summary hits={hits} misses={misses} builds={builds}")


@pytest.fixture(scope="session")
def _stage2_harness() -> Stage2Harness:
    return Stage2Harness()


@pytest.fixture()
def stage2_environment(stage1_environment: pathlib.Path, _stage2_harness: Stage2Harness) -> Stage2Harness:
    """Provide cached helpers for compiling Sailfin sources to Stage2 outputs."""

    return _stage2_harness
