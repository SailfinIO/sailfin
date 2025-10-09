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

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
