"""Integration tests for the bootstrap compiler.

These tests parse selected Sailfin examples, run them through the
code generator, and execute the resulting Python module to ensure the
end-to-end toolchain remains functional as the language evolves.
"""

from __future__ import annotations

import pathlib
import sys

import pytest

pytest.importorskip("ply")

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from bootstrap.code_generator import CodeGenerator
from bootstrap.lexer import lexer as base_lexer
from bootstrap.parser import parser


EXAMPLE_ROOT = pathlib.Path(__file__).resolve().parents[2] / "examples"

EXAMPLE_FILES = [
    EXAMPLE_ROOT / "basics" / "variables.sfn",
    EXAMPLE_ROOT / "basics" / "functions.sfn",
    EXAMPLE_ROOT / "basics" / "conditionals.sfn",
    EXAMPLE_ROOT / "basics" / "hello-world.sfn",
    EXAMPLE_ROOT / "basics" / "basic-enum.sfn",
    EXAMPLE_ROOT / "basics" / "error-handling.sfn",
    EXAMPLE_ROOT / "basics" / "try-catch-finally.sfn",
    EXAMPLE_ROOT / "basics" / "structs.sfn",
    EXAMPLE_ROOT / "basics" / "interfaces.sfn",
    EXAMPLE_ROOT / "basics" / "struct-composition.sfn",
    EXAMPLE_ROOT / "concurrency" / "channels.sfn",
    EXAMPLE_ROOT / "advanced" / "encapsulation-struct.sfn",
]


@pytest.mark.parametrize("source_path", EXAMPLE_FILES)
def test_compile_and_execute_example(source_path: pathlib.Path) -> None:
    source = source_path.read_text(encoding="utf-8")
    lexer = base_lexer.clone()
    ast = parser.parse(source, lexer=lexer)
    assert ast is not None, f"Failed to parse {source_path}"

    generator = CodeGenerator()
    python_source = generator.generate_code(ast)

    compiled = compile(python_source, str(source_path.with_suffix(".py")), "exec")
    namespace: dict[str, object] = {"__name__": "__main__"}
    exec(compiled, namespace, namespace)
