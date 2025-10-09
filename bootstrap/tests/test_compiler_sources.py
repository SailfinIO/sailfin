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
    pathlib.Path("compiler/src/token.sfn"),
    pathlib.Path("compiler/src/lexer.sfn"),
    pathlib.Path("compiler/src/ast.sfn"),
    pathlib.Path("compiler/src/parser.sfn"),
    pathlib.Path("compiler/src/decorator_semantics.sfn"),
    pathlib.Path("compiler/src/main.sfn"),
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

        sample = (
            'let title = "Sailfin"; // string literal\n'
            "let ready = true;\n"
            "/* done */ const answer = 42;\n"
            "let ratio = 3.14;\n"
            "let debug = false;"
        )
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
        has_string_literal = any(
            token.kind.variant == "StringLiteral" and token.kind.value == "Sailfin" for token in meaningful
        )
        has_identifier_string = any(
            token.kind.variant == "Identifier" and token.kind.value == "Sailfin" for token in meaningful
        )
        assert has_string_literal or has_identifier_string
        assert any(token.kind.variant == "BooleanLiteral" and token.kind.value is True for token in meaningful)
        assert any(token.kind.variant == "BooleanLiteral" and token.kind.value is False for token in meaningful)
    elif source_path.name == "ast.sfn":
        namespace = {"__name__": "__main__"}
        exec(compiled, namespace, namespace)

        program_class = namespace["Program"]
        statement_enum = namespace["Statement"]

        program = program_class(statements=[])
        assert isinstance(program.statements, list)

        variable = statement_enum.VariableDeclaration(
            name="x",
            mutable=False,
            type_annotation=None,
            initializer=None,
        )
        assert variable.variant == "VariableDeclaration"
    elif source_path.name == "parser.sfn":
        namespace = {"__name__": "__main__"}

        def compile_module(relative: str) -> None:
            module_source = (REPO_ROOT / relative).read_text(encoding="utf-8")
            module_ast = parser.parse(module_source, lexer=base_lexer.clone())
            module_python = CodeGenerator().generate_code(module_ast)
            module_compiled = compile(
                module_python,
                str((REPO_ROOT / relative).with_suffix(".py")),
                "exec",
            )
            exec(module_compiled, namespace, namespace)

        for dependency in ["compiler/src/token.sfn", "compiler/src/ast.sfn", "compiler/src/lexer.sfn"]:
            compile_module(dependency)

        exec(compiled, namespace, namespace)
        parse_program = namespace["parse_program"]

        sample = (
            'import { print } from "sailfin/io";\n'
            "const answer -> number = 42;\n"
            "fn greet(name -> string) -> string ![io] {\n"
            "    return name;\n"
            "}\n"
        )
        program = parse_program(sample)
        assert len(program.statements) == 3
        assert all(stmt.variant != "Unknown" for stmt in program.statements)

        import_stmt = program.statements[0]
        assert import_stmt.variant == "ImportDeclaration"
        assert import_stmt.items == ["print"]
        assert import_stmt.source == "sailfin/io"

        const_stmt = program.statements[1]
        assert const_stmt.variant == "ConstantDeclaration"
        assert const_stmt.initializer is not None

        fn_stmt = program.statements[2]
        assert fn_stmt.variant == "FunctionDeclaration"
        signature = fn_stmt.signature
        assert signature.name == "greet"
        assert signature.effects == ["io"]
        assert signature.parameters[0].name == "name"
        assert signature.parameters[0].type_annotation is not None
        assert fn_stmt.body.text.strip().startswith("{")

        struct_program = parse_program(
            "struct User {\n"
            "    id -> number;\n"
            "    mut name -> string;\n"
            "}\n"
        )
        assert len(struct_program.statements) == 1
        struct_stmt = struct_program.statements[0]
        assert struct_stmt.variant == "StructDeclaration"
        assert struct_stmt.name == "User"
        assert len(struct_stmt.fields) == 2
        first_field = struct_stmt.fields[0]
        assert first_field.name == "id"
        assert first_field.type_annotation.text == "number"
        assert first_field.mutable is False
        second_field = struct_stmt.fields[1]
        assert second_field.name == "name"
        assert second_field.type_annotation.text == "string"
        assert second_field.mutable is True

        generic_program = parse_program(
            "@entity\n"
            "struct Collection<T> implements Iterable<T>, Debug {\n"
            "    size -> number;\n"
            "    @trace(level: \"debug\", enabled: false)\n"
            "    fn get(self) -> T {\n"
            "        return self;\n"
            "    }\n"
            "}\n"
        )
        assert len(generic_program.statements) == 1
        collection_struct = generic_program.statements[0]
        assert collection_struct.variant == "StructDeclaration"
        assert collection_struct.name == "Collection"
        assert collection_struct.type_parameters == ["T"]
        assert [impl.text for impl in collection_struct.implements_types] == ["Iterable<T>", "Debug"]
        assert len(collection_struct.decorators) == 1
        assert collection_struct.decorators[0].name == "entity"
        assert collection_struct.decorators[0].arguments == []
        assert len(collection_struct.fields) == 1
        assert len(collection_struct.methods) == 1
        method = collection_struct.methods[0]
        assert method.signature.name == "get"
        assert method.signature.return_type is not None and method.signature.return_type.text == "T"
        assert method.signature.effects == []
        assert method.body.text.strip().startswith("{")
        assert len(method.decorators) == 1
        trace_decorator = method.decorators[0]
        assert trace_decorator.name == "trace"
        assert len(trace_decorator.arguments) == 2
        level_arg = trace_decorator.arguments[0]
        assert level_arg.name == "level"
        if level_arg.expression.variant == "StringLiteral":
            assert level_arg.expression.value == "debug"
        else:
            assert level_arg.expression.variant == "Raw"
            assert level_arg.expression.text.strip() == '"debug"'
        enabled_arg = trace_decorator.arguments[1]
        assert enabled_arg.name == "enabled"
        assert enabled_arg.expression.variant == "BooleanLiteral"
        assert enabled_arg.expression.value is False
    elif source_path.name == "decorator_semantics.sfn":
        namespace = {"__name__": "__main__"}

        def compile_module(relative: str) -> None:
            module_source = (REPO_ROOT / relative).read_text(encoding="utf-8")
            module_ast = parser.parse(module_source, lexer=base_lexer.clone())
            module_python = CodeGenerator().generate_code(module_ast)
            module_compiled = compile(
                module_python,
                str((REPO_ROOT / relative).with_suffix(".py")),
                "exec",
            )
            exec(module_compiled, namespace, namespace)

        for dependency in [
            "compiler/src/token.sfn",
            "compiler/src/ast.sfn",
            "compiler/src/lexer.sfn",
            "compiler/src/parser.sfn",
        ]:
            compile_module(dependency)

        exec(compiled, namespace, namespace)
        parse_program = namespace["parse_program"]
        evaluate_decorators = namespace["evaluate_decorators"]
        infer_effects = namespace["infer_effects"]

        sample = (
            "@policy(level: \"restricted\")\n"
            "@trace(level: \"debug\", enabled: false)\n"
            "fn decorated() {\n"
            "    return;\n"
            "}\n"
        )

        program = parse_program(sample)
        fn_stmt = program.statements[0]
        decorator_info = evaluate_decorators(fn_stmt.decorators)
        assert [info.name for info in decorator_info] == ["policy", "trace"]

        policy_args = decorator_info[0].arguments
        assert len(policy_args) == 1
        assert policy_args[0].name == "level"
        if policy_args[0].value.variant == "String":
            assert policy_args[0].value.value == "restricted"

        trace_args = decorator_info[1].arguments
        assert len(trace_args) == 2
        level_arg = trace_args[0]
        assert level_arg.name == "level"
        if level_arg.value.variant == "String":
            assert level_arg.value.value == "debug"
        enabled_arg = trace_args[1]
        assert enabled_arg.name == "enabled"
        assert enabled_arg.value.variant == "Boolean"
        assert enabled_arg.value.value is False

        inferred_effects = infer_effects(fn_stmt.signature.effects, decorator_info)
        assert "io" in inferred_effects
