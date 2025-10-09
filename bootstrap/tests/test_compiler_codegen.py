"""Tests for the self-hosted Sailfin code generator prototype."""

from __future__ import annotations

import pathlib
import sys
import textwrap
from functools import lru_cache

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]

if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from bootstrap.code_generator import CodeGenerator
from bootstrap.lexer import lexer as base_lexer
from bootstrap.parser import parser


@lru_cache(maxsize=None)
def _load_self_hosted_environment() -> tuple[object, object]:
    namespace: dict[str, object] = {"__name__": "__main__"}

    def compile_module(relative: str) -> None:
        source = (REPO_ROOT / relative).read_text(encoding="utf-8")
        ast = parser.parse(source, lexer=base_lexer.clone())
        python_source = CodeGenerator().generate_code(ast)
        python_source = python_source.encode("utf-8").decode("unicode_escape")
        module_name = pathlib.Path(relative).with_suffix(".py").name
        module_path = REPO_ROOT / "compiler/build" / module_name
        module_path.parent.mkdir(parents=True, exist_ok=True)
        module_path.write_text(python_source, encoding="utf-8")
        compiled = compile(python_source, str(module_path), "exec")
        exec(compiled, namespace, namespace)

    for dependency in [
        "compiler/src/token.sfn",
        "compiler/src/ast.sfn",
        "compiler/src/lexer.sfn",
        "compiler/src/decorator_semantics.sfn",
        "compiler/src/effect_checker.sfn",
        "compiler/src/parser.sfn",
        "compiler/src/code_generator.sfn",
    ]:
        compile_module(dependency)

    return namespace["generate_program"], namespace["parse_program"]


def _load_self_hosted_generator():
    generate_program, _ = _load_self_hosted_environment()
    return generate_program


def _parse_program(source: str):
    _, parse_program = _load_self_hosted_environment()
    return parse_program(textwrap.dedent(source).strip() + "\n")


def test_generate_program_produces_python():
    generate_program = _load_self_hosted_generator()
    program = _parse_program(
        """
        fn greet(name -> string) -> string {
            return name;
        }

        struct User {
            id -> number;
            name -> string;
        }
        """
    )

    python_source = generate_program(program)
    assert "def greet(name):" in python_source
    assert "class User:" in python_source

    namespace: dict[str, object] = {}
    compiled = compile(python_source, "<self-hosted>", "exec")
    exec(compiled, namespace, namespace)

    assert "greet" in namespace
    assert namespace["greet"]("Sailfin") is None
    assert "User" in namespace
    user_cls = namespace["User"]
    instance = user_cls()
    assert hasattr(instance, "id")
    assert hasattr(instance, "name")


def test_block_stub_includes_original_source():
    generate_program = _load_self_hosted_generator()
    program = _parse_program(
        """
        fn wave() {
            prompt system { "hi"; };
        }
        """
    )

    python_source = generate_program(program)
    assert "# original Sailfin block omitted" in python_source
