"""Smoke tests for the Sailfin self-hosted compiler sources.

We compile selected files under `self_hosted/` with the bootstrap compiler to
ensure the Sailfin sources stay syntactically valid during early development.
"""

from __future__ import annotations

import pathlib
import sys

import pytest

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from bootstrap.code_generator import CodeGenerator
from bootstrap.lexer import lexer as base_lexer
from bootstrap.parser import parser


SELF_HOSTED_SOURCES = [
    pathlib.Path("self_hosted/src/main.sfn"),
    pathlib.Path("self_hosted/src/lexer.sfn"),
    pathlib.Path("self_hosted/src/token.sfn"),
]


@pytest.mark.parametrize("source_path", SELF_HOSTED_SOURCES)
def test_compile_self_hosted_source(source_path: pathlib.Path) -> None:
    full_path = REPO_ROOT / source_path
    source = full_path.read_text(encoding="utf-8")
    lexer = base_lexer.clone()
    ast = parser.parse(source, lexer=lexer)

    generator = CodeGenerator()
    python_source = generator.generate_code(ast)

    compiled = compile(python_source, str(full_path.with_suffix(".py")), "exec")

    # Only run the entry point module; other sources may rely on imports the
    # bootstrap emitter does not materialise yet.
    if source_path.name == "main.sfn":
        namespace: dict[str, object] = {"__name__": "__main__"}
        exec(compiled, namespace, namespace)
