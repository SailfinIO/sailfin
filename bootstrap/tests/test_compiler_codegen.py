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
def _load_self_hosted_environment() -> dict[str, object]:
    namespace: dict[str, object] = {"__name__": "__main__"}

    def compile_module(relative: str, target: dict[str, object] | None = None) -> dict[str, object]:
        module_namespace: dict[str, object]
        if target is None:
            module_namespace = namespace
        else:
            module_namespace = target
        source = (REPO_ROOT / relative).read_text(encoding="utf-8")
        ast = parser.parse(source, lexer=base_lexer.clone())
        python_source = CodeGenerator().generate_code(ast)
        python_source = python_source.encode("utf-8").decode("unicode_escape")
        module_name = pathlib.Path(relative).with_suffix(".py").name
        module_path = REPO_ROOT / "compiler/build" / module_name
        module_path.parent.mkdir(parents=True, exist_ok=True)
        module_path.write_text(python_source, encoding="utf-8")
        compiled = compile(python_source, str(module_path), "exec")
        exec(compiled, module_namespace, module_namespace)
        return module_namespace

    for dependency in [
        "compiler/src/token.sfn",
        "compiler/src/ast.sfn",
        "compiler/src/lexer.sfn",
        "compiler/src/decorator_semantics.sfn",
        "compiler/src/effect_checker.sfn",
        "compiler/src/parser.sfn",
        "compiler/src/typecheck.sfn",
        "compiler/src/emitter_sailfin.sfn",
        "compiler/src/emit_native.sfn",
        "compiler/src/code_generator.sfn",
    ]:
        if dependency == "compiler/src/emit_native.sfn":
            native_namespace = {"__name__": "compiler.build.emit_native"}
            module = compile_module(dependency, native_namespace)
            namespace["emit_native"] = module["emit_native"]
        else:
            compile_module(dependency)

    return namespace


def _load_self_hosted_generator():
    environment = _load_self_hosted_environment()
    return environment["generate_program"]


def _parse_program(source: str):
    environment = _load_self_hosted_environment()
    parse_program = environment["parse_program"]
    return parse_program(textwrap.dedent(source).strip() + "\n")


def _emit_native(program):
    environment = _load_self_hosted_environment()
    emit_native = environment["emit_native"]
    return emit_native(program)


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
    assert namespace["greet"]("Sailfin") == "Sailfin"
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
    assert "# prompt system" in python_source
    assert "hi" in python_source


def test_function_body_emits_return_and_literals():
    generate_program = _load_self_hosted_generator()
    program = _parse_program(
        """
        fn greet(name -> string) -> string {
            return "Hello, {{ name }}";
        }
        """
    )

    python_source = generate_program(program)
    assert "return 'Hello, {{ name }}'" in python_source


def test_emit_native_produces_artifact():
    program = _parse_program(
        """
        import { print } from "sailfin/io";

        fn greet(name -> string) -> string ![io] {
            return name;
        }
        """
    )

    result = _emit_native(program)
    assert result.diagnostics == []
    assert result.module.artifacts

    artifact = result.module.artifacts[0]
    assert artifact.format == "sailfin-native-text"
    assert ".fn greet" in artifact.contents
    assert "ret name" in artifact.contents
    assert result.module.symbol_count >= 1
