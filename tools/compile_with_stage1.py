#!/usr/bin/env python3
"""Compile Sailfin sources using the checked-in stage1 compiler modules."""

from __future__ import annotations

import argparse
import hashlib
import importlib
import os
import pathlib
import shutil
import sys
import tempfile
from typing import Dict, Iterable, List

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]

if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))


class Stage1CompileError(RuntimeError):
    pass


def _collect_sources(values: Iterable[pathlib.Path]) -> List[pathlib.Path]:
    collected: List[pathlib.Path] = []
    for value in values:
        if value.is_dir():
            collected.extend(sorted(value.rglob("*.sfn")))
        else:
            collected.append(value)
    return [path.resolve() for path in collected]


def compile_stage1(sources: Iterable[pathlib.Path], output_dir: pathlib.Path) -> None:
    stage1_main = importlib.import_module("compiler.build.main")
    inputs = _collect_sources(sources)
    if not inputs:
        raise Stage1CompileError("no Sailfin sources provided to compile")

    compiler_src_root = (REPO_ROOT / "compiler" / "src").resolve()
    runtime_root = (REPO_ROOT / "runtime").resolve()

    result = stage1_main.compile_project([str(path) for path in inputs])
    diagnostics = getattr(result, "diagnostics", [])
    fatal = [entry for entry in diagnostics if getattr(entry, "fatal", False)]
    if fatal:
        messages = []
        for entry in fatal:
            source_path = getattr(entry, "source_path", "<unknown>")
            for message in getattr(entry, "messages", []):
                messages.append(f"{source_path}: {message}")
        raise Stage1CompileError("stage1 compilation failed:\n" + "\n".join(messages))

    modules = getattr(result, "modules", [])
    if not modules:
        raise Stage1CompileError("stage1 returned no modules")

    output_dir.mkdir(parents=True, exist_ok=True)
    for module in modules:
        source_path = pathlib.Path(getattr(module, "source_path")).resolve()
        python_source = getattr(module, "python_source", None)
        if python_source is None:
            raise Stage1CompileError(f"module missing python_source: {module}")
        destination = output_dir / source_path.with_suffix(".py").name
        try:
            relative = source_path.relative_to(compiler_src_root)
            destination = output_dir / relative.with_suffix(".py").name
        except ValueError:
            try:
                relative_runtime = source_path.relative_to(runtime_root)
                destination = output_dir / pathlib.Path("runtime") / relative_runtime.with_suffix(".py")
            except ValueError:
                destination = output_dir / source_path.with_suffix(".py").name
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text(python_source, encoding="utf-8")

    for entry in diagnostics:
        if getattr(entry, "fatal", False):
            continue
        source_path = getattr(entry, "source_path", "<unknown>")
        for message in getattr(entry, "messages", []):
            print(f"[stage1][warn] {source_path}: {message}")


_STAGE1_CACHE_VERSION = "stage1-cache-v1"
_STAGE1_CACHE_STATS: Dict[str, int] = {"hits": 0, "misses": 0, "builds": 0}


def _iter_stage1_inputs() -> Iterable[pathlib.Path]:
    compiler_src = (REPO_ROOT / "compiler" / "src").resolve()
    runtime_src = (REPO_ROOT / "runtime").resolve()
    generated_src = (REPO_ROOT / "compiler" / "build").resolve()

    if compiler_src.exists():
        yield from sorted(compiler_src.rglob("*.sfn"))
    if runtime_src.exists():
        yield from sorted(runtime_src.rglob("*.sfn"))
    if generated_src.exists():
        yield from sorted(generated_src.rglob("*.py"))

    yield pathlib.Path(__file__).resolve()


def _compute_stage1_cache_key() -> str:
    digest = hashlib.sha256()
    digest.update(_STAGE1_CACHE_VERSION.encode("utf-8"))
    digest.update(f"python-{sys.version_info.major}.{sys.version_info.minor}".encode("utf-8"))

    for path in _iter_stage1_inputs():
        try:
            relative = path.relative_to(REPO_ROOT)
        except ValueError:
            relative = path
        digest.update(str(relative).encode("utf-8"))
        digest.update(b"\0")
        try:
            with path.open("rb") as handle:
                while True:
                    chunk = handle.read(8192)
                    if not chunk:
                        break
                    digest.update(chunk)
        except FileNotFoundError:
            # Inputs may disappear mid-run (e.g., cleaning build artifacts).
            digest.update(b"<missing>")
        digest.update(b"\0")
    return digest.hexdigest()


def ensure_stage1_cache(cache_root: pathlib.Path, *, debug: bool = False) -> pathlib.Path:
    """Ensure a cached stage1 build is available and return its root directory."""

    cache_root = cache_root.expanduser().resolve()
    cache_root.mkdir(parents=True, exist_ok=True)

    cache_key = _compute_stage1_cache_key()
    cache_dir = cache_root / cache_key
    marker = cache_dir / ".complete"

    if cache_dir.exists() and marker.exists():
        _STAGE1_CACHE_STATS["hits"] += 1
        if debug:
            print(f"[stage1-cache] hit {cache_key} -> {cache_dir}")
        return cache_dir

    _STAGE1_CACHE_STATS["misses"] += 1
    if debug:
        print(f"[stage1-cache] miss {cache_key}; compiling stage1")

    staging_dir = pathlib.Path(
        tempfile.mkdtemp(prefix=f"stage1-{cache_key[:12]}-", dir=cache_root)
    )
    success = False
    try:
        output_dir = staging_dir / "compiler" / "build"
        compile_stage1([REPO_ROOT / "compiler" / "src", REPO_ROOT / "runtime"], output_dir)
        (staging_dir / ".complete").write_text("ok\n", encoding="utf-8")
        if cache_dir.exists():
            shutil.rmtree(cache_dir)
        staging_dir.rename(cache_dir)
        success = True
        _STAGE1_CACHE_STATS["builds"] += 1
        if debug:
            print(f"[stage1-cache] built {cache_key} -> {cache_dir}")
        return cache_dir
    finally:
        if not success and staging_dir.exists():
            shutil.rmtree(staging_dir, ignore_errors=True)


def stage1_cache_stats() -> Dict[str, int]:
    """Return a copy of the cache statistics collected for this process."""

    return dict(_STAGE1_CACHE_STATS)


def _parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Compile Sailfin sources with the stage1 pipeline")
    parser.add_argument(
        "paths",
        nargs="*",
        default=[REPO_ROOT / "compiler" / "src", REPO_ROOT / "runtime"],
        type=pathlib.Path,
        help="Files or directories of .sfn sources (default: compiler/src and runtime)",
    )
    parser.add_argument("--out", dest="output", type=pathlib.Path, default=REPO_ROOT / "compiler" / "build",
                        help="Directory to receive generated Python modules (default: compiler/build)")
    parser.add_argument("--warm-cache", action="store_true",
                        help="Populate the stage1 build cache and exit without compiling sources.")
    parser.add_argument("--cache-dir", dest="cache_dir", type=pathlib.Path,
                        help="Override the stage1 cache directory (defaults to PYTEST_STAGE1_CACHE_DIR or .pytest-stage1/)")
    parser.add_argument("--debug-cache", action="store_true",
                        help="Print cache hit/miss information while warming the cache.")
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = _parse_args(argv)
    cache_dir = args.cache_dir
    if cache_dir is None:
        env_override = os.environ.get("PYTEST_STAGE1_CACHE_DIR")
        cache_dir = pathlib.Path(env_override) if env_override else (REPO_ROOT / ".pytest-stage1")

    if args.warm_cache:
        cache_path = ensure_stage1_cache(cache_dir, debug=args.debug_cache)
        if args.debug_cache:
            stats = stage1_cache_stats()
            hits = stats.get("hits", 0)
            misses = stats.get("misses", 0)
            builds = stats.get("builds", 0)
            print(f"[stage1-cache] warmed {cache_path} (hits={hits}, misses={misses}, builds={builds})")
        else:
            print(f"[stage1-cache] warmed {cache_path}")
        return 0

    try:
        compile_stage1(args.paths, args.output)
    except Stage1CompileError as exc:
        print(f"[stage1][error] {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
