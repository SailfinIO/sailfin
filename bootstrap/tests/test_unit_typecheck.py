"""Unit tests for the Sailfin self-hosted typecheck module.

These tests compile the Sailfin sources to Python on-the-fly so the latest
stage1 semantics are validated without relying on pre-generated artifacts.
"""

from __future__ import annotations

import pathlib
import sys
from typing import Dict

import pytest

from bootstrap.code_generator import CodeGenerator
from bootstrap.lexer import lexer as base_lexer
from bootstrap.parser import parser

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

ModuleNamespace = Dict[str, object]


@pytest.fixture()
def typecheck_namespace() -> ModuleNamespace:
    namespace: ModuleNamespace = {"__name__": "__main__"}

    def compile_module(relative: str) -> None:
        source_path = REPO_ROOT / relative
        source = source_path.read_text(encoding="utf-8")
        module_ast = parser.parse(source, lexer=base_lexer.clone())
        module_python = CodeGenerator().generate_code(module_ast)
        compiled = compile(module_python, str(source_path.with_suffix(".py")), "exec")
        exec(compiled, namespace, namespace)

    for dependency in [
        "compiler/src/token.sfn",
        "compiler/src/ast.sfn",
        "compiler/src/typecheck.sfn",
    ]:
        compile_module(dependency)

    return namespace


def _messages(result) -> list[str]:
    return [diagnostic.message for diagnostic in result.diagnostics]


def _make_annotation(namespace: ModuleNamespace, text: str):
    return namespace["TypeAnnotation"](text=text)


def _empty_block(namespace: ModuleNamespace):
    return namespace["Block"](tokens=[], text="", statements=[])


def _make_type_param(namespace: ModuleNamespace, name: str):
    return namespace["TypeParameter"](name=name, bound=None)


def _make_string_literal(namespace: ModuleNamespace, value: str):
    return namespace["Expression"].StringLiteral(value=value)


def test_typecheck_reports_duplicate_struct_fields(typecheck_namespace: ModuleNamespace) -> None:
    Program = typecheck_namespace["Program"]
    Statement = typecheck_namespace["Statement"]
    FieldDeclaration = typecheck_namespace["FieldDeclaration"]
    typecheck_program = typecheck_namespace["typecheck_program"]

    struct_stmt = Statement.StructDeclaration(
        name="User",
        type_parameters=[],
        implements_types=[],
        fields=[
            FieldDeclaration(name="id", type_annotation=_make_annotation(typecheck_namespace, "string"), mutable=False),
            FieldDeclaration(name="id", type_annotation=_make_annotation(typecheck_namespace, "string"), mutable=False),
        ],
        methods=[],
        decorators=[],
    )

    program = Program(statements=[struct_stmt])
    messages = _messages(typecheck_program(program))

    assert any("duplicate struct field `id` declared" in message for message in messages)


def test_typecheck_reports_duplicate_struct_methods(typecheck_namespace: ModuleNamespace) -> None:
    Program = typecheck_namespace["Program"]
    Statement = typecheck_namespace["Statement"]
    MethodDeclaration = typecheck_namespace["MethodDeclaration"]
    FunctionSignature = typecheck_namespace["FunctionSignature"]
    typecheck_program = typecheck_namespace["typecheck_program"]

    method_signature = FunctionSignature(
        name="render",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=[],
        type_parameters=[],
    )
    method_body = _empty_block(typecheck_namespace)
    duplicate_method = MethodDeclaration(signature=method_signature, body=method_body, decorators=[])

    struct_stmt = Statement.StructDeclaration(
        name="Presenter",
        type_parameters=[],
        implements_types=[],
        fields=[],
        methods=[duplicate_method, duplicate_method],
        decorators=[],
    )

    program = Program(statements=[struct_stmt])
    messages = _messages(typecheck_program(program))

    assert any("duplicate method `render` declared" in message for message in messages)


def test_typecheck_reports_duplicate_enum_variants(typecheck_namespace: ModuleNamespace) -> None:
    Program = typecheck_namespace["Program"]
    Statement = typecheck_namespace["Statement"]
    EnumVariant = typecheck_namespace["EnumVariant"]
    typecheck_program = typecheck_namespace["typecheck_program"]

    variant = EnumVariant(name="Ready", fields=[])
    enum_stmt = Statement.EnumDeclaration(
        name="Status",
        type_parameters=[],
        variants=[variant, variant],
        decorators=[],
    )

    program = Program(statements=[enum_stmt])
    messages = _messages(typecheck_program(program))

    assert any("duplicate enum variant `Ready` declared" in message for message in messages)


def test_typecheck_reports_duplicate_interface_members(typecheck_namespace: ModuleNamespace) -> None:
    Program = typecheck_namespace["Program"]
    Statement = typecheck_namespace["Statement"]
    FunctionSignature = typecheck_namespace["FunctionSignature"]
    typecheck_program = typecheck_namespace["typecheck_program"]

    member = FunctionSignature(
        name="handle",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=[],
        type_parameters=[],
    )

    interface_stmt = Statement.InterfaceDeclaration(
        name="Service",
        type_parameters=[],
        members=[member, member],
        decorators=[],
    )

    program = Program(statements=[interface_stmt])
    messages = _messages(typecheck_program(program))

    assert any("duplicate interface member `handle` declared" in message for message in messages)


def test_typecheck_reports_duplicate_model_properties(typecheck_namespace: ModuleNamespace) -> None:
    Program = typecheck_namespace["Program"]
    Statement = typecheck_namespace["Statement"]
    typecheck_program = typecheck_namespace["typecheck_program"]

    model_stmt = Statement.ModelDeclaration(
        name="Summarizer",
        model_type=_make_annotation(typecheck_namespace, "Model<Text, Summary>"),
        properties=[
            typecheck_namespace["ModelProperty"](name="engine", value=_make_string_literal(typecheck_namespace, "gpt")),
            typecheck_namespace["ModelProperty"](name="engine", value=_make_string_literal(typecheck_namespace, "gpt")),
        ],
        effects=["model"],
        decorators=[],
    )

    program = Program(statements=[model_stmt])
    messages = _messages(typecheck_program(program))

    assert any("duplicate model property `engine` declared" in message for message in messages)


def test_typecheck_reports_duplicate_struct_type_parameters(typecheck_namespace: ModuleNamespace) -> None:
    Program = typecheck_namespace["Program"]
    Statement = typecheck_namespace["Statement"]
    FieldDeclaration = typecheck_namespace["FieldDeclaration"]
    typecheck_program = typecheck_namespace["typecheck_program"]

    struct_stmt = Statement.StructDeclaration(
        name="Box",
        type_parameters=[_make_type_param(typecheck_namespace, "T"), _make_type_param(typecheck_namespace, "T")],
        implements_types=[],
        fields=[
            FieldDeclaration(name="value", type_annotation=_make_annotation(typecheck_namespace, "T"), mutable=False)
        ],
        methods=[],
        decorators=[],
    )

    program = Program(statements=[struct_stmt])
    messages = _messages(typecheck_program(program))

    assert any("duplicate type parameter `T` declared" in message for message in messages)


def test_typecheck_reports_duplicate_function_type_parameters(typecheck_namespace: ModuleNamespace) -> None:
    Program = typecheck_namespace["Program"]
    Statement = typecheck_namespace["Statement"]
    FunctionSignature = typecheck_namespace["FunctionSignature"]
    typecheck_program = typecheck_namespace["typecheck_program"]

    signature = FunctionSignature(
        name="identity",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=[],
        type_parameters=[_make_type_param(typecheck_namespace, "T"), _make_type_param(typecheck_namespace, "T")],
    )

    function_stmt = Statement.FunctionDeclaration(
        signature=signature,
        body=_empty_block(typecheck_namespace),
        decorators=[],
    )

    program = Program(statements=[function_stmt])
    messages = _messages(typecheck_program(program))

    assert any("duplicate type parameter `T` declared" in message for message in messages)
