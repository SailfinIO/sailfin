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
pytestmark = pytest.mark.integration

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from bootstrap.ast_nodes import FunctionDeclaration, TestDeclaration
from bootstrap.code_generator import CodeGenerator
from bootstrap.effect_checker import EffectValidationError
from bootstrap.lexer import lexer as base_lexer
from bootstrap.parser import parser


EXAMPLE_ROOT = pathlib.Path(__file__).resolve().parents[2] / "examples"

EXAMPLE_FILES = sorted(EXAMPLE_ROOT.rglob("*.sfn"))


def test_parse_effect_annotations() -> None:
    source = "\n".join(
        [
            "fn foo() ![io, net] { return 1; }",
            "test example ![model] { assert foo() == 1; }",
        ]
    )
    lexer = base_lexer.clone()
    ast = parser.parse(source, lexer=lexer)

    functions = [stmt for stmt in ast.statements if isinstance(stmt, FunctionDeclaration)]
    tests = [stmt for stmt in ast.statements if isinstance(stmt, TestDeclaration)]

    assert functions and functions[0].effects == ["io", "net"]
    assert tests and tests[0].effects == ["model"]


def test_prompt_requires_model_effect() -> None:
    source = "\n".join(
        [
            "fn demo() {",
            "    prompt system { \"Hello\"; };",
            "}",
        ]
    )
    lexer = base_lexer.clone()
    ast = parser.parse(source, lexer=lexer)

    with pytest.raises(EffectValidationError):
        CodeGenerator().generate_code(ast)


def test_fs_requires_io_effect() -> None:
    source = "\n".join(
        [
            "fn write() {",
            "    fs.writeFile(\"out.txt\", \"hello\");",
            "}",
        ]
    )
    lexer = base_lexer.clone()
    ast = parser.parse(source, lexer=lexer)

    with pytest.raises(EffectValidationError):
        CodeGenerator().generate_code(ast)


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
