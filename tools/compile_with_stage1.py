#!/usr/bin/env python3
"""Compile Sailfin sources using the checked-in stage1 compiler modules."""

from __future__ import annotations

import argparse
import importlib
import pathlib
import sys
from typing import Iterable, List

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
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = _parse_args(argv)
    try:
        compile_stage1(args.paths, args.output)
    except Stage1CompileError as exc:
        print(f"[stage1][error] {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
