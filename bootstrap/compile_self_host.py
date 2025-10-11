"""Utility to compile the Sailfin self-hosting sources using the bootstrap compiler.

This script parses the `.sfn` files under `compiler/src/` with the Python
bootstrap compiler and emits Python modules into `compiler/build/`. It mirrors
what our eventual Sailfin-native pipeline will do, but keeps the workflow handy
while we finish porting the backend.
"""

from __future__ import annotations

import argparse
import pathlib
import shutil
import importlib
import sys
from typing import Iterable

from bootstrap.code_generator import CodeGenerator
from bootstrap.lexer import lexer as base_lexer
from bootstrap.parser import parser as bootstrap_parser

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]
DEFAULT_SOURCE_DIR = REPO_ROOT / "compiler" / "src"
DEFAULT_OUTPUT_DIR = REPO_ROOT / "compiler" / "build"


def _iter_sources(explicit: Iterable[str] | None) -> list[pathlib.Path]:
    if explicit:
        result: list[pathlib.Path] = []
        for value in explicit:
            path = pathlib.Path(value)
            if not path.is_absolute():
                path = (REPO_ROOT / path).resolve()
            else:
                path = path.resolve()
            if path.is_dir():
                for candidate in sorted(path.rglob("*.sfn")):
                    result.append(candidate.resolve())
            else:
                result.append(path)
        return result
    return sorted(candidate.resolve() for candidate in DEFAULT_SOURCE_DIR.glob("*.sfn"))


def compile_module(source_path: pathlib.Path, output_dir: pathlib.Path) -> pathlib.Path:
    try:
        relative = source_path.relative_to(DEFAULT_SOURCE_DIR)
    except ValueError:
        try:
            relative = source_path.relative_to(REPO_ROOT)
        except ValueError:
            relative = pathlib.Path(source_path.name)
    else:
        relative = pathlib.Path(relative)
    destination = (output_dir / relative).with_suffix(".py")
    destination.parent.mkdir(parents=True, exist_ok=True)

    source_text = source_path.read_text(encoding="utf-8")
    lexer = base_lexer.clone()
    ast = bootstrap_parser.parse(source_text, lexer=lexer)
    python_source = CodeGenerator().generate_code(ast)
    python_source = python_source.encode("utf-8").decode("unicode_escape")
    destination.write_text(python_source, encoding="utf-8")
    return destination


def main(argv: Iterable[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Compile Sailfin *.sfn files using the bootstrap compiler")
    parser.add_argument(
        "paths",
        nargs="*",
        help="Specific files or directories to compile. Defaults to compiler/src/*.sfn",
    )
    parser.add_argument(
        "--out",
        dest="output",
        type=pathlib.Path,
        default=DEFAULT_OUTPUT_DIR,
        help="Output directory for generated Python modules (default: compiler/build)",
    )
    args = parser.parse_args(argv)

    sources = _iter_sources(args.paths)
    if not sources:
        print("No source files matched; nothing to do.")
        return 0

    output_dir = args.output.resolve()
    if not args.paths and output_dir == DEFAULT_OUTPUT_DIR.resolve():
        if output_dir.exists():
            shutil.rmtree(output_dir)

    output_dir.mkdir(parents=True, exist_ok=True)

    for path in sources:
        output_path = compile_module(path, output_dir)
        try:
            display_source = path.relative_to(REPO_ROOT)
        except ValueError:
            display_source = path
        try:
            display_output = output_path.relative_to(REPO_ROOT)
        except ValueError:
            display_output = output_path
        print(f"[sfn] {display_source} -> {display_output}")

    _run_self_hosted_pipeline(sources, output_dir)

    return 0


def _run_self_hosted_pipeline(sources: list[pathlib.Path], output_dir: pathlib.Path) -> None:
    if str(REPO_ROOT) not in sys.path:
        sys.path.insert(0, str(REPO_ROOT))

    try:
        stage1_main = importlib.import_module("compiler.build.main")
    except ModuleNotFoundError as exc:  # pragma: no cover - defensive
        raise RuntimeError(
            "Stage1 compiler modules are missing; bootstrap compilation phase must succeed first"
        ) from exc

    compile_project = getattr(stage1_main, "compile_project", None)
    if compile_project is None:
        raise RuntimeError("compile_project function not found in compiler.build.main")

    absolute_sources = [str(path) for path in sources]
    result = compile_project(absolute_sources)
    diagnostics = getattr(result, "diagnostics", [])
    fatal_entries = [entry for entry in diagnostics if getattr(entry, "fatal", False)]
    if fatal_entries:
        for entry in fatal_entries:
            source_path = getattr(entry, "source_path", "<unknown>")
            for message in getattr(entry, "messages", []):
                print(f"[stage1][error] {source_path}: {message}")
        raise SystemExit("Self-hosted compilation aborted due to diagnostics")

    for entry in diagnostics:
        if getattr(entry, "fatal", False):
            continue
        source_path = getattr(entry, "source_path", "<unknown>")
        for message in getattr(entry, "messages", []):
            print(f"[stage1][warn] {source_path}: {message}")

    modules = getattr(result, "modules", [])
    modules_by_source = {
        pathlib.Path(getattr(module, "source_path")).resolve(): module for module in modules
    }

    for source_path in sources:
        module = modules_by_source.get(source_path.resolve())
        if module is None:
            raise SystemExit(f"Stage1 compiler did not produce output for {source_path}")
        try:
            relative = source_path.relative_to(DEFAULT_SOURCE_DIR)
        except ValueError:
            relative = source_path.name
        destination = (output_dir / pathlib.Path(relative)).with_suffix(".py")
        destination.parent.mkdir(parents=True, exist_ok=True)
        python_source = getattr(module, "python_source", None)
        if python_source is None:
            raise SystemExit(f"Stage1 compiler module missing python_source for {source_path}")
        destination.write_text(python_source, encoding="utf-8")
        try:
            display_source = source_path.relative_to(REPO_ROOT)
        except ValueError:
            display_source = source_path
        try:
            display_destination = destination.relative_to(REPO_ROOT)
        except ValueError:
            display_destination = destination
        print(f"[stage1] {display_source} -> {display_destination}")


if __name__ == "__main__":
    raise SystemExit(main())
