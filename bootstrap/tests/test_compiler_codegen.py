"""Tests for the self-hosted Sailfin code generator prototype."""

from __future__ import annotations

import pathlib
import sys
import textwrap
import types
def _register_module(name: str, module_dict: dict[str, object]) -> None:
    module = types.ModuleType(name)
    module.__dict__.update(module_dict)
    sys.modules[name] = module

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
        "compiler/src/native_ir.sfn",
        "compiler/src/native_lowering.sfn",
        "compiler/src/native_llvm_lowering.sfn",
        "compiler/src/code_generator.sfn",
    ]:
        if dependency == "compiler/src/emit_native.sfn":
            native_namespace = {"__name__": "compiler.build.emit_native"}
            module = compile_module(dependency, native_namespace)
            _register_module(native_namespace["__name__"], module)
            namespace["emit_native"] = module["emit_native"]
        elif dependency == "compiler/src/native_ir.sfn":
            ir_namespace = {"__name__": "compiler.build.native_ir"}
            module = compile_module(dependency, ir_namespace)
            _register_module(ir_namespace["__name__"], module)
        elif dependency == "compiler/src/native_lowering.sfn":
            lowering_namespace = {"__name__": "compiler.build.native_lowering"}
            module = compile_module(dependency, lowering_namespace)
            _register_module(lowering_namespace["__name__"], module)
            namespace["lower_to_python"] = module["lower_to_python"]
        elif dependency == "compiler/src/native_llvm_lowering.sfn":
            llvm_namespace = {"__name__": "compiler.build.native_llvm_lowering"}
            module = compile_module(dependency, llvm_namespace)
            _register_module(llvm_namespace["__name__"], module)
            namespace["lower_to_llvm"] = module["lower_to_llvm"]
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


def _lower_native_to_python(native_module):
    environment = _load_self_hosted_environment()
    lower_to_python = environment["lower_to_python"]
    return lower_to_python(native_module)


def _lower_native_to_llvm(native_module):
    environment = _load_self_hosted_environment()
    lower_to_llvm = environment["lower_to_llvm"]
    return lower_to_llvm(native_module)


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
    assert ".meta return string" in artifact.contents
    assert ".meta effects io" in artifact.contents
    assert ".param name -> string" in artifact.contents
    assert "ret name" in artifact.contents
    assert result.module.symbol_count >= 1


def test_lower_native_pipeline_executes_function():
    program = _parse_program(
        """
        fn answer() -> number {
            return 42;
        }
        """
    )

    native_result = _emit_native(program)
    assert native_result.diagnostics == []

    lower_result = _lower_native_to_python(native_result.module)
    assert lower_result.diagnostics == []
    assert "def answer()" in lower_result.source

    namespace: dict[str, object] = {"__name__": "__native_exec__"}
    compiled = compile(lower_result.source, "<native-lowering>", "exec")
    exec(compiled, namespace, namespace)

    assert "answer" in namespace
    answer_fn = namespace["answer"]
    assert callable(answer_fn)
    assert answer_fn() == 42


def test_lower_native_to_llvm_emits_ir():
    program = _parse_program(
        """
        fn answer() -> number {
            return 42;
        }
        """
    )

    native_result = _emit_native(program)
    assert native_result.diagnostics == []

    llvm_result = _lower_native_to_llvm(native_result.module)
    assert llvm_result.diagnostics == []
    assert "define double @answer()" in llvm_result.ir
    assert "ret double 42.0" in llvm_result.ir


def test_lower_native_handles_parameter_round_trip():
    program = _parse_program(
        """
        fn identity(value -> number) -> number {
            return value;
        }
        """
    )

    native_result = _emit_native(program)
    assert native_result.diagnostics == []

    python_result = _lower_native_to_python(native_result.module)
    assert python_result.diagnostics == []
    assert "def identity(value):" in python_result.source

    llvm_result = _lower_native_to_llvm(native_result.module)
    assert llvm_result.diagnostics == []
    assert "define double @identity(double %value)" in llvm_result.ir
    assert "ret double %value" in llvm_result.ir


def test_lower_native_emits_if_else_blocks():
    program = _parse_program(
        """
        fn choose(value -> number, flag -> boolean) -> number {
            let mut result -> number = 0;
            if flag {
                result = value;
            } else {
                result = -value;
            }
            return result;
        }
        """
    )

    native_result = _emit_native(program)
    assert native_result.diagnostics == []

    python_result = _lower_native_to_python(native_result.module)
    assert python_result.diagnostics == []

    namespace: dict[str, object] = {"__name__": "__native_exec__"}
    compiled = compile(python_result.source, "<native-lowering>", "exec")
    exec(compiled, namespace, namespace)

    choose = namespace["choose"]
    assert choose(5, True) == 5
    assert choose(5, False) == -5


def test_lower_native_emits_for_loop_blocks():
    program = _parse_program(
        """
        fn accumulate(values -> number[]) -> number {
            let mut total -> number = 0;
            for value in values {
                total = total + value;
            }
            return total;
        }
        """
    )

    native_result = _emit_native(program)
    assert native_result.diagnostics == []

    python_result = _lower_native_to_python(native_result.module)
    assert python_result.diagnostics == []

    namespace: dict[str, object] = {"__name__": "__native_exec__"}
    compiled = compile(python_result.source, "<native-lowering>", "exec")
    exec(compiled, namespace, namespace)

    accumulate = namespace["accumulate"]
    assert accumulate([1, 2, 3]) == 6


def test_lower_native_emits_match_statements():
    program = _parse_program(
        """
        fn describe(value -> number) -> string {
            match value {
                case 0 => {
                    return "zero";
                }
                case _ if value > 0 => {
                    return "positive";
                }
                case _ => {
                    return "other";
                }
            }
        }
        """
    )

    native_result = _emit_native(program)
    assert native_result.diagnostics == []

    python_result = _lower_native_to_python(native_result.module)
    assert python_result.diagnostics == []

    namespace: dict[str, object] = {"__name__": "__native_exec__"}
    compiled = compile(python_result.source, "<native-lowering>", "exec")
    exec(compiled, namespace, namespace)

    describe = namespace["describe"]
    assert describe(-5) == "other"
    assert describe(0) == "zero"
    assert describe(3) == "positive"


def test_lower_native_emits_inline_match_cases():
    program = _parse_program(
        """
        fn classify(value -> number) -> string {
            match value {
                case value if value > 0 => print.info("positive");
                case 0 => return "zero";
                case _ => return "other";
            }
            return "done";
        }
        """
    )

    native_result = _emit_native(program)
    assert native_result.diagnostics == []

    text_artifact = None
    for artifact in native_result.module.artifacts:
        if artifact.format == "sailfin-native-text":
            text_artifact = artifact
            break
    assert text_artifact is not None
    contents = text_artifact.contents
    assert 'value if value > 0 => print.info("positive"),' in contents
    assert '0 => return "zero",' in contents
    assert '_ => return "other",' in contents

    python_result = _lower_native_to_python(native_result.module)
    assert python_result.diagnostics == []

    namespace: dict[str, object] = {"__name__": "__native_exec__"}
    compiled = compile(python_result.source, "<inline-match>", "exec")
    exec(compiled, namespace, namespace)

    classify = namespace["classify"]
    assert classify(-1) == "other"
    assert classify(0) == "zero"
    assert classify(5) == "done"


def test_lower_native_emits_structs_and_literals():
    program = _parse_program(
        """
        struct Pair {
            left -> number;
            right -> number;
        }

        fn make_pair(value -> number) -> Pair {
            return Pair { left: value, right: value };
        }
        """
    )

    native_result = _emit_native(program)
    assert native_result.diagnostics == []

    python_result = _lower_native_to_python(native_result.module)
    assert python_result.diagnostics == []
    assert "class Pair:" in python_result.source
    assert "def __init__(self, left, right):" in python_result.source
    assert "self.left = left" in python_result.source
    assert "self.right = right" in python_result.source
    assert "return Pair(left=value, right=value)" in python_result.source

    namespace: dict[str, object] = {"__name__": "__native_exec__"}
    compiled = compile(python_result.source, "<native-lowering>", "exec")
    exec(compiled, namespace, namespace)

    pair_cls = namespace["Pair"]
    make_pair = namespace["make_pair"]
    result = make_pair(3)
    assert isinstance(result, pair_cls)
    assert result.left == 3
    assert result.right == 3


def test_lower_native_emits_enums():
    program = _parse_program(
        """
        enum Color {
            Red;
            Green;
            Blue;
        }

        fn identity(color -> Color) -> Color {
            return color;
        }
        """
    )

    native_result = _emit_native(program)
    assert native_result.diagnostics == []

    python_result = _lower_native_to_python(native_result.module)
    assert python_result.diagnostics == []
    assert "Color = runtime.EnumType('Color')" in python_result.source
    assert "Color.Red = Color.variant('Red', [])" in python_result.source

    namespace: dict[str, object] = {"__name__": "__native_exec__"}
    compiled = compile(python_result.source, "<native-lowering>", "exec")
    exec(compiled, namespace, namespace)

    color_type = namespace["Color"]
    value = color_type.Green()
    assert getattr(value, "variant") == "Green"
