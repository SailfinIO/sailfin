"""Smoke tests for the Sailfin compiler (self-hosting) sources.

We compile selected files under `compiler/` with the bootstrap compiler to
ensure the Sailfin sources stay syntactically valid during early development.
"""

from __future__ import annotations

import pathlib
import sys

import pytest
pytestmark = pytest.mark.integration

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from bootstrap.code_generator import CodeGenerator
from bootstrap.lexer import lexer as base_lexer
from bootstrap.parser import parser


COMPILER_SOURCES = [
    pathlib.Path("compiler/src/main.sfn"),
    pathlib.Path("compiler/src/lexer.sfn"),
    pathlib.Path("compiler/src/token.sfn"),
]


@pytest.mark.parametrize("source_path", COMPILER_SOURCES)
def test_compile_compiler_source(source_path: pathlib.Path) -> None:
    full_path = REPO_ROOT / source_path
    source = full_path.read_text(encoding="utf-8")
    lexer = base_lexer.clone()
    ast = parser.parse(source, lexer=lexer)

    generator = CodeGenerator()
    python_source = generator.generate_code(ast)

    compiled = compile(python_source, str(full_path.with_suffix(".py")), "exec")

    # Only run selected modules; the others are validated by successful code
    # generation.
    if source_path.name == "main.sfn":
        namespace: dict[str, object] = {"__name__": "__main__"}
        exec(compiled, namespace, namespace)
    elif source_path.name == "lexer.sfn":
        namespace = {"__name__": "__main__"}

        token_source = (REPO_ROOT / "compiler/src/token.sfn").read_text(encoding="utf-8")
        token_ast = parser.parse(token_source, lexer=base_lexer.clone())
        token_python = CodeGenerator().generate_code(token_ast)
        token_compiled = compile(token_python, str((REPO_ROOT / "compiler/src/token.py")), "exec")
        exec(token_compiled, namespace, namespace)

        exec(compiled, namespace, namespace)
        lex_fn = namespace["lex"]

        sample = "let title = 3.14; // number\n/* done */ const answer = 42;"
        tokens = lex_fn(sample)

        comments = [token for token in tokens if token.kind.variant == "Comment"]
        assert comments and comments[0].lexeme.startswith("//")
        assert len(comments) >= 2 and comments[1].lexeme.startswith("/*")

        meaningful = [token for token in tokens if token.kind.variant not in {"Whitespace", "Comment"}]
        variants = [token.kind.variant for token in meaningful]
        assert variants[0] == "Identifier"
        assert any(token.kind.variant == "NumberLiteral" and token.kind.value == "3.14" for token in meaningful)
        assert any(token.kind.variant == "Identifier" and token.kind.value == "const" for token in meaningful)
        assert any(token.kind.variant == "NumberLiteral" and token.kind.value == "42" for token in meaningful)
