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
import subprocess
from typing import Dict, Iterable, List, Optional

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
        raise Stage1CompileError(
            "stage1 compilation failed:\n" + "\n".join(messages))

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
            destination = output_dir / relative.with_suffix(".py")
        except ValueError:
            try:
                relative_runtime = source_path.relative_to(runtime_root)
                destination = output_dir / \
                    pathlib.Path("runtime") / \
                    relative_runtime.with_suffix(".py")
            except ValueError:
                destination = output_dir / source_path.with_suffix(".py").name
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text(python_source, encoding="utf-8")

    # If a previous run left behind a package directory that conflicts with a
    # generated module (e.g. both `foo.py` and `foo/__init__.py`), Python's
    # import resolution can select the stale package. Prefer the generated
    # module file and remove the conflicting directory.
    try:
        for entry in output_dir.iterdir():
            if entry.is_file() and entry.suffix == ".py":
                conflicting_dir = output_dir / entry.stem
                if conflicting_dir.is_dir():
                    shutil.rmtree(conflicting_dir)
    except Exception as exc:
        raise Stage1CompileError(
            f"failed to clean stale output directories under {output_dir}: {exc}") from exc

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
    digest.update(
        f"python-{sys.version_info.major}.{sys.version_info.minor}".encode("utf-8"))

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
        compile_stage1([REPO_ROOT / "compiler" / "src",
                       REPO_ROOT / "runtime"], output_dir)
        (staging_dir / ".complete").write_text("ok\n", encoding="utf-8")
        if cache_dir.exists():
            shutil.rmtree(cache_dir)
        staging_dir.rename(cache_dir)
        success = True
        _STAGE1_CACHE_STATS["builds"] += 1
        if debug:
            print(f"[stage1-cache] built {cache_key} -> {cache_dir}")

        # Clean up old cache entries
        _cleanup_old_cache_entries(cache_root, max_entries=10, debug=debug)

        return cache_dir
    finally:
        if not success and staging_dir.exists():
            shutil.rmtree(staging_dir, ignore_errors=True)


def _cleanup_old_cache_entries(cache_root: pathlib.Path, max_entries: int = 10, *, debug: bool = False) -> None:
    """Remove old cache entries, keeping only the most recent max_entries."""

    if not cache_root.exists():
        return

    # Find all cache directories (those with .complete marker)
    cache_entries = []
    for entry in cache_root.iterdir():
        if entry.is_dir() and (entry / ".complete").exists():
            cache_entries.append((entry.stat().st_mtime, entry))

    # Sort by modification time (newest first)
    cache_entries.sort(reverse=True, key=lambda x: x[0])

    # Remove entries beyond max_entries
    for _, entry in cache_entries[max_entries:]:
        if debug:
            print(f"[stage1-cache] cleaning up old cache entry: {entry.name}")
        try:
            shutil.rmtree(entry)
        except Exception as exc:
            if debug:
                print(
                    f"[stage1-cache] warning: failed to remove {entry.name}: {exc}")


def stage1_cache_stats() -> Dict[str, int]:
    """Return a copy of the cache statistics collected for this process."""

    return dict(_STAGE1_CACHE_STATS)


def link_stage2_binary(
    modules: Iterable[pathlib.Path],
    output_path: pathlib.Path,
    *,
    clang: str = "clang",
    extra_flags: Optional[List[str]] = None,
) -> None:
    module_paths = [pathlib.Path(module) for module in modules]
    if not module_paths:
        raise Stage1CompileError("no Stage2 modules available to link")

    output_path = output_path.resolve()
    output_path.parent.mkdir(parents=True, exist_ok=True)

    temp_dir = pathlib.Path(tempfile.mkdtemp(prefix="stage2-link-"))
    objects: List[pathlib.Path] = []
    try:
        for module_path in module_paths:
            obj_path = temp_dir / f"{module_path.stem}.o"
            try:
                subprocess.run([clang, "-c", str(module_path), "-o", str(obj_path)],
                               check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            except FileNotFoundError as exc:
                raise Stage1CompileError(
                    f"clang not found at '{clang}': {exc}") from exc
            except subprocess.CalledProcessError as exc:
                stderr = exc.stderr.decode(
                    "utf-8", errors="ignore") if exc.stderr else ""
                raise Stage1CompileError(
                    f"failed to compile {module_path.name}: {stderr}") from exc
            objects.append(obj_path)

        link_cmd = [clang, "-o", str(output_path)] + [str(obj)
                                                      for obj in objects]
        if extra_flags:
            link_cmd.extend(extra_flags)
        elif sys.platform == "darwin":
            link_cmd.extend(["-Wl,-undefined,dynamic_lookup"])

        try:
            subprocess.run(link_cmd, check=True,
                           stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        except subprocess.CalledProcessError as exc:
            stderr = exc.stderr.decode(
                "utf-8", errors="ignore") if exc.stderr else ""
            raise Stage1CompileError(
                f"failed to link Stage2 binary: {stderr}") from exc

        print(f"[stage2] linked compiler binary to {output_path}")
    finally:
        shutil.rmtree(temp_dir, ignore_errors=True)


def _parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Compile Sailfin sources with the stage1 pipeline")
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
    parser.add_argument("--stage2", action="store_true",
                        help="Also bootstrap Stage2 LLVM artefacts after compiling Stage1.")
    parser.add_argument("--stage2-out", dest="stage2_output", type=pathlib.Path,
                        default=REPO_ROOT / "build" / "stage2",
                        help="Directory to receive Stage2 LLVM artefacts (default: build/stage2)")
    parser.add_argument("--stage2-binary", dest="stage2_binary", type=pathlib.Path,
                        help="Optional path to link a Stage2 compiler executable using clang.")
    parser.add_argument("--stage2-clang", dest="stage2_clang", default=os.environ.get("SAILFIN_STAGE2_CLANG", "clang"),
                        help="clang executable to use when linking Stage2 binaries (default: clang or SAILFIN_STAGE2_CLANG).")
    parser.add_argument("--stage2-ldflag", dest="stage2_ldflags", action="append",
                        help="Extra linker flag to pass to clang when producing the Stage2 binary (can be specified multiple times).")
    parser.add_argument("--stage2-quiet", dest="stage2_quiet", action="store_true",
                        help="Silence Stage2 bootstrap logging.")
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = _parse_args(argv)
    cache_dir = args.cache_dir
    if cache_dir is None:
        env_override = os.environ.get("PYTEST_STAGE1_CACHE_DIR")
        cache_dir = pathlib.Path(env_override) if env_override else (
            REPO_ROOT / ".pytest-stage1")

    if args.warm_cache:
        cache_path = ensure_stage1_cache(cache_dir, debug=args.debug_cache)
        if args.debug_cache:
            stats = stage1_cache_stats()
            hits = stats.get("hits", 0)
            misses = stats.get("misses", 0)
            builds = stats.get("builds", 0)
            print(
                f"[stage1-cache] warmed {cache_path} (hits={hits}, misses={misses}, builds={builds})")
        else:
            print(f"[stage1-cache] warmed {cache_path}")
        return 0

    try:
        compile_stage1(args.paths, args.output)
    except Stage1CompileError as exc:
        print(f"[stage1][error] {exc}", file=sys.stderr)
        return 1

    stage2_requested = args.stage2 or args.stage2_binary is not None
    if stage2_requested:
        from scripts import bootstrap_stage2

        stage2_output = args.stage2_output.resolve()
        capture_results = True  # always capture for potential linking/tests
        compilation_result = bootstrap_stage2.compile_compiler_to_stage2(
            stage2_output,
            debug=not args.stage2_quiet,
            quiet=args.stage2_quiet,
            capture_results=capture_results,
        )

        if len(compilation_result) == 3:
            compiled_modules, aggregator, _lowered_map = compilation_result
        else:
            compiled_modules, aggregator = compilation_result

        fatal_count = getattr(aggregator, "fatal_count", 0)
        if fatal_count:
            raise Stage1CompileError(
                f"stage2 bootstrap produced {fatal_count} fatal diagnostic(s)")

        module_count = len(compiled_modules)
        print(
            f"[stage2] generated {module_count} LLVM module(s) in {stage2_output}")

        if args.stage2_binary:
            ldflags = args.stage2_ldflags or []
            link_stage2_binary(compiled_modules, args.stage2_binary,
                               clang=args.stage2_clang, extra_flags=ldflags)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
