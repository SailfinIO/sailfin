"""Smoke tests for the Sailfin compiler (self-hosting) sources.

We compile selected files under `compiler/` with the bootstrap compiler to
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


COMPILER_SOURCES = [
    pathlib.Path("compiler/src/token.sfn"),
    pathlib.Path("compiler/src/lexer.sfn"),
    pathlib.Path("compiler/src/ast.sfn"),
    pathlib.Path("compiler/src/parser.sfn"),
    pathlib.Path("compiler/src/emitter_sailfin.sfn"),
    pathlib.Path("compiler/src/code_generator.sfn"),
    pathlib.Path("compiler/src/decorator_semantics.sfn"),
    pathlib.Path("compiler/src/effect_checker.sfn"),
    pathlib.Path("compiler/src/main.sfn"),
    pathlib.Path("compiler/runtime/prelude.sfn"),
]


def test_self_hosted_decorator_logexecution_infers_io() -> None:
    from compiler.build.ast import Decorator
    from compiler.build.decorator_semantics import evaluate_decorators, infer_effects

    info = evaluate_decorators([Decorator("logExecution", [])])
    effects = infer_effects([], info)

    assert "io" in effects


def _make_token(kind, lexeme, line=1, column=1):
    from compiler.build.token import Token

    return Token(kind=kind, lexeme=lexeme, line=line, column=column)


def _validate_effects(program):
    import compiler.build.effect_checker as effect_checker_module
    from compiler.build.decorator_semantics import evaluate_decorators as _eval_decorators

    effect_checker_module.evaluate_decorators = _eval_decorators
    return effect_checker_module.validate_effects(program)


def test_self_hosted_effect_checker_requires_io_for_console_usage() -> None:
    from compiler.build.ast import Block, FunctionSignature, Program, Statement
    from compiler.build.token import TokenKind

    tokens = [
        _make_token(TokenKind.Identifier(value="print"), "print", column=1),
        _make_token(TokenKind.Symbol(value="."), ".", column=6),
        _make_token(TokenKind.Identifier(value="info"), "info", column=7),
        _make_token(TokenKind.Symbol(value="("), "(", column=11),
        _make_token(TokenKind.StringLiteral(value="msg"), '"msg"', column=12),
        _make_token(TokenKind.Symbol(value=")"), ")", column=17),
        _make_token(TokenKind.Symbol(value=";"), ";", column=18),
    ]

    body = Block(tokens=tokens, text="print.info(\"msg\");", statements=[])
    signature = FunctionSignature(
        name="demo",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=[],
        type_parameters=[],
    )
    function = Statement.FunctionDeclaration(signature=signature, body=body, decorators=[])
    program = Program(statements=[function])

    violations = _validate_effects(program)
    assert any("io" in violation.missing_effects for violation in violations)

    signature_with_io = FunctionSignature(
        name="demo_io",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=["io"],
        type_parameters=[],
    )
    function_io = Statement.FunctionDeclaration(signature=signature_with_io, body=body, decorators=[])
    program_io = Program(statements=[function_io])

    assert not _validate_effects(program_io)


def test_self_hosted_effect_checker_requires_clock_for_sleep_usage() -> None:
    from compiler.build.ast import Block, FunctionSignature, Program, Statement
    from compiler.build.token import TokenKind

    tokens = [
        _make_token(TokenKind.Identifier(value="runtime"), "runtime", column=1),
        _make_token(TokenKind.Symbol(value="."), ".", column=8),
        _make_token(TokenKind.Identifier(value="sleep"), "sleep", column=9),
        _make_token(TokenKind.Symbol(value="("), "(", column=14),
        _make_token(TokenKind.NumberLiteral(value="42"), "42", column=15),
        _make_token(TokenKind.Symbol(value=")"), ")", column=17),
        _make_token(TokenKind.Symbol(value=";"), ";", column=18),
    ]

    body = Block(tokens=tokens, text="runtime.sleep(42);", statements=[])
    signature = FunctionSignature(
        name="tick",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=[],
        type_parameters=[],
    )
    function = Statement.FunctionDeclaration(signature=signature, body=body, decorators=[])
    program = Program(statements=[function])

    violations = _validate_effects(program)
    assert any("clock" in violation.missing_effects for violation in violations)

    signature_with_clock = FunctionSignature(
        name="tick_clock",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=["clock"],
        type_parameters=[],
    )
    function_clock = Statement.FunctionDeclaration(signature=signature_with_clock, body=body, decorators=[])
    program_clock = Program(statements=[function_clock])

    assert not _validate_effects(program_clock)


def test_self_hosted_effect_checker_requires_io_for_runtime_fs_usage() -> None:
    from compiler.build.ast import Block, FunctionSignature, Program, Statement
    from compiler.build.token import TokenKind

    tokens = [
        _make_token(TokenKind.Identifier(value="runtime"), "runtime", column=1),
        _make_token(TokenKind.Symbol(value="."), ".", column=8),
        _make_token(TokenKind.Identifier(value="fs"), "fs", column=9),
        _make_token(TokenKind.Symbol(value="."), ".", column=11),
        _make_token(TokenKind.Identifier(value="writeFile"), "writeFile", column=12),
        _make_token(TokenKind.Symbol(value="("), "(", column=21),
        _make_token(TokenKind.StringLiteral(value="out.txt"), '"out.txt"', column=22),
        _make_token(TokenKind.Symbol(value=","), ",", column=31),
        _make_token(TokenKind.StringLiteral(value="hi"), '"hi"', column=33),
        _make_token(TokenKind.Symbol(value=")"), ")", column=37),
        _make_token(TokenKind.Symbol(value=";"), ";", column=38),
    ]

    body = Block(tokens=tokens, text='runtime.fs.writeFile("out.txt", "hi");', statements=[])
    signature = FunctionSignature(
        name="store",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=[],
        type_parameters=[],
    )
    program = Program(statements=[Statement.FunctionDeclaration(signature=signature, body=body, decorators=[])])

    violations = _validate_effects(program)
    assert any("io" in violation.missing_effects for violation in violations)

    signature_with_io = FunctionSignature(
        name="store_io",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=["io"],
        type_parameters=[],
    )
    program_io = Program(
        statements=[Statement.FunctionDeclaration(signature=signature_with_io, body=body, decorators=[])]
    )

    assert not _validate_effects(program_io)


def test_self_hosted_effect_checker_requires_io_for_runtime_spawn_usage() -> None:
    from compiler.build.ast import Block, FunctionSignature, Program, Statement
    from compiler.build.token import TokenKind

    tokens = [
        _make_token(TokenKind.Identifier(value="runtime"), "runtime", column=1),
        _make_token(TokenKind.Symbol(value="."), ".", column=8),
        _make_token(TokenKind.Identifier(value="spawn"), "spawn", column=9),
        _make_token(TokenKind.Symbol(value="("), "(", column=14),
        _make_token(TokenKind.Identifier(value="worker"), "worker", column=15),
        _make_token(TokenKind.Symbol(value=")"), ")", column=21),
        _make_token(TokenKind.Symbol(value=";"), ";", column=22),
    ]

    body = Block(tokens=tokens, text="runtime.spawn(worker);", statements=[])
    signature = FunctionSignature(
        name="launch",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=[],
        type_parameters=[],
    )
    program = Program(statements=[Statement.FunctionDeclaration(signature=signature, body=body, decorators=[])])

    violations = _validate_effects(program)
    assert any("io" in violation.missing_effects for violation in violations)

    signature_with_io = FunctionSignature(
        name="launch_io",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=["io"],
        type_parameters=[],
    )
    program_io = Program(
        statements=[Statement.FunctionDeclaration(signature=signature_with_io, body=body, decorators=[])]
    )

    assert not _validate_effects(program_io)


def test_self_hosted_effect_checker_requires_net_for_runtime_serve_usage() -> None:
    from compiler.build.ast import Block, FunctionSignature, Program, Statement
    from compiler.build.token import TokenKind

    tokens = [
        _make_token(TokenKind.Identifier(value="runtime"), "runtime", column=1),
        _make_token(TokenKind.Symbol(value="."), ".", column=8),
        _make_token(TokenKind.Identifier(value="serve"), "serve", column=9),
        _make_token(TokenKind.Symbol(value="("), "(", column=14),
        _make_token(TokenKind.Identifier(value="handler"), "handler", column=15),
        _make_token(TokenKind.Symbol(value=")"), ")", column=22),
        _make_token(TokenKind.Symbol(value=";"), ";", column=23),
    ]

    body = Block(tokens=tokens, text="runtime.serve(handler);", statements=[])
    signature = FunctionSignature(
        name="boot",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=[],
        type_parameters=[],
    )
    program = Program(statements=[Statement.FunctionDeclaration(signature=signature, body=body, decorators=[])])

    violations = _validate_effects(program)
    assert any("net" in violation.missing_effects for violation in violations)

    signature_with_net = FunctionSignature(
        name="boot_net",
        is_async=False,
        parameters=[],
        return_type=None,
        effects=["net"],
        type_parameters=[],
    )
    program_net = Program(
        statements=[Statement.FunctionDeclaration(signature=signature_with_net, body=body, decorators=[])]
    )

    assert not _validate_effects(program_net)


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

        for dependency in [
            "compiler/src/token.sfn",
            "compiler/src/ast.sfn",
            "compiler/src/lexer.sfn",
            "compiler/src/decorator_semantics.sfn",
        ]:
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

        guarded_sample = (
            "fn classify(value -> number) -> number {\n"
            "    match value {\n"
            "        case value if value > 0 => {\n"
            "            return value;\n"
            "        }\n"
            "        case _ => {\n"
            "            return 0;\n"
            "        }\n"
            "    }\n"
            "}\n"
        )
        guarded_program = parse_program(guarded_sample)
        classify_fn = guarded_program.statements[0]
        assert classify_fn.variant == "FunctionDeclaration"
        match_stmt = classify_fn.body.statements[0]
        assert match_stmt.variant == "MatchStatement"
        assert len(match_stmt.cases) == 2
        first_case = match_stmt.cases[0]
        assert first_case.guard is not None
        assert first_case.guard.variant == "Binary"
        assert first_case.guard.operator == ">"
        assert first_case.guard.left.variant == "Identifier"
        assert first_case.guard.right.variant == "NumberLiteral"
        second_case = match_stmt.cases[1]
        assert second_case.guard is None

        inline_sample = (
            "fn adjust(value -> number) -> number {\n"
            "    match value {\n"
            "        case score => score + 1;\n"
            "        case _ => return 0;\n"
            "    }\n"
            "}\n"
        )
        inline_program = parse_program(inline_sample)
        adjust_fn = inline_program.statements[0]
        inline_match = adjust_fn.body.statements[0]
        assert inline_match.variant == "MatchStatement"
        expr_case = inline_match.cases[0]
        expr_block = expr_case.body
        assert len(expr_block.statements) == 1
        expr_stmt = expr_block.statements[0]
        assert expr_stmt.variant == "ExpressionStatement"
        expr_expression = expr_stmt.expression
        assert expr_expression.variant == "Binary"
        assert expr_expression.operator == "+"
        assert expr_expression.left.variant == "Identifier"
        assert expr_expression.right.variant == "NumberLiteral"
        return_case = inline_match.cases[1]
        return_block = return_case.body
        assert len(return_block.statements) == 1
        return_stmt = return_block.statements[0]
        assert return_stmt.variant == "ReturnStatement"
        assert return_stmt.expression is not None
        assert return_stmt.expression.variant == "NumberLiteral"
        assert signature.parameters[0].name == "name"
        assert signature.parameters[0].type_annotation is not None
        assert signature.type_parameters == []
        assert fn_stmt.body.text.strip().startswith("{")

        postfix_sample = (
            "fn window(values -> number[]) -> number {\n"
            "    values[0];\n"
            "    0..values.length;\n"
            "    return values[0];\n"
            "}\n"
        )
        postfix_program = parse_program(postfix_sample)
        window_fn = postfix_program.statements[0]
        assert window_fn.variant == "FunctionDeclaration"
        assert len(window_fn.body.statements) >= 3
        first_stmt = window_fn.body.statements[0]
        assert first_stmt.variant == "ExpressionStatement"
        assert first_stmt.expression.variant == "Index"
        assert first_stmt.expression.sequence.variant == "Identifier"
        assert first_stmt.expression.sequence.name == "values"
        assert first_stmt.expression.index.variant == "NumberLiteral"
        assert first_stmt.expression.index.value == "0"
        span_stmt = window_fn.body.statements[1]
        assert span_stmt.variant == "ExpressionStatement"
        assert span_stmt.expression.variant == "Range"
        assert span_stmt.expression.start.variant == "NumberLiteral"
        assert span_stmt.expression.start.value == "0"
        assert span_stmt.expression.end.variant == "Member"

        lambda_sample = (
            "fn transform(values -> number[]) -> number[] {\n"
            "    return values.map(fn (value -> number) -> number {\n"
            "        return value + 1;\n"
            "    });\n"
            "}\n"
        )
        lambda_program = parse_program(lambda_sample)
        transform_fn = lambda_program.statements[0]
        assert transform_fn.variant == "FunctionDeclaration"
        transform_body = transform_fn.body
        assert transform_body.statements
        transform_return = transform_body.statements[0]
        assert transform_return.variant == "ReturnStatement"
        call_expr = transform_return.expression
        assert call_expr is not None
        assert call_expr.variant == "Call"
        assert call_expr.arguments
        lambda_expr = call_expr.arguments[0]
        assert lambda_expr.variant == "Lambda"
        assert len(lambda_expr.parameters) == 1
        assert lambda_expr.parameters[0].name == "value"
        assert lambda_expr.parameters[0].type_annotation is not None
        assert lambda_expr.parameters[0].type_annotation.text == "number"
        assert lambda_expr.body.statements
        lambda_body_stmt = lambda_expr.body.statements[0]
        assert lambda_body_stmt.variant == "ReturnStatement"
        assert lambda_body_stmt.expression is not None
        assert lambda_body_stmt.expression.variant == "Binary"

        traced_program = parse_program(
            "@trace(level: \"debug\")\n"
            "fn traced() {\n"
            "    return;\n"
            "}\n"
        )
        assert len(traced_program.statements) == 1
        traced_fn = traced_program.statements[0]
        assert traced_fn.variant == "FunctionDeclaration"
        assert "io" in traced_fn.signature.effects

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


        conditional_program = parse_program(
            "fn check(flag -> boolean) {\n"
            "    if flag {\n"
            "        return;\n"
            "    } else {\n"
            "        return;\n"
            "    }\n"
            "}\n"
        )
        assert len(conditional_program.statements) == 1
        conditional_fn = conditional_program.statements[0]
        assert conditional_fn.variant == "FunctionDeclaration"
        assert len(conditional_fn.body.statements) == 1
        conditional_if = conditional_fn.body.statements[0]
        assert conditional_if.variant == "IfStatement"
        assert conditional_if.then_block.statements[0].variant == "ReturnStatement"
        assert conditional_if.else_branch is not None
        assert conditional_if.else_branch.body is not None
        assert conditional_if.else_branch.body.statements[0].variant == "ReturnStatement"

        loop_program = parse_program(
            "fn iterate(items -> Array<string>) {\n"
            "    for item in items {\n"
            "        print.info(item);\n"
            "    }\n"
            "}\n"
        )
        assert len(loop_program.statements) == 1
        loop_fn = loop_program.statements[0]
        assert loop_fn.variant == "FunctionDeclaration"
        assert len(loop_fn.body.statements) == 1
        loop_stmt = loop_fn.body.statements[0]
        assert loop_stmt.variant == "ForStatement"
        assert loop_stmt.clause.target.variant == "Identifier"
        assert loop_stmt.clause.iterable.variant == "Identifier"
        assert len(loop_stmt.body.statements) == 1
        loop_expression_stmt = loop_stmt.body.statements[0]
        assert loop_expression_stmt.variant == "ExpressionStatement"
        call_expr = loop_expression_stmt.expression
        assert call_expr.variant == "Call"
        assert call_expr.callee.variant == "Member"
        assert call_expr.callee.object.variant == "Identifier"
        assert call_expr.callee.member == "info"
        assert len(call_expr.arguments) == 1
        assert call_expr.arguments[0].variant == "Identifier"
        compile_module("compiler/src/code_generator.sfn")
        generate_program = namespace["generate_program"]
        loop_python = generate_program(loop_program)
        assert "for item in items:" in loop_python

        lambda_python = generate_program(lambda_program)
        assert "lambda value" in lambda_python or "lambda:" in lambda_python

        literal_program = parse_program(
            "fn config() {\n"
            "    return { name: \"Sailfin\", version: 1 };\n"
            "}\n"
            "fn items() {\n"
            "    return [1, 2, 3];\n"
            "}\n"
            "fn capsule() {\n"
            "    return Capsule { id: 1 };\n"
            "}\n"
        )
        assert len(literal_program.statements) == 3

        config_fn = literal_program.statements[0]
        assert config_fn.variant == "FunctionDeclaration"
        config_return = config_fn.body.statements[0]
        assert config_return.variant == "ReturnStatement"
        assert config_return.expression is not None
        config_expr = config_return.expression
        assert config_expr.variant == "Object"
        assert len(config_expr.fields) == 2
        assert {field.name for field in config_expr.fields} == {"name", "version"}

        items_fn = literal_program.statements[1]
        assert items_fn.variant == "FunctionDeclaration"
        items_return = items_fn.body.statements[0]
        assert items_return.variant == "ReturnStatement"
        assert items_return.expression is not None
        items_expr = items_return.expression
        assert items_expr.variant == "Array"
        assert len(items_expr.elements) == 3
        assert all(element.variant == "NumberLiteral" for element in items_expr.elements)

        capsule_fn = literal_program.statements[2]
        assert capsule_fn.variant == "FunctionDeclaration"
        capsule_return = capsule_fn.body.statements[0]
        assert capsule_return.variant == "ReturnStatement"
        assert capsule_return.expression is not None
        capsule_expr = capsule_return.expression
        assert capsule_expr.variant == "Struct"
        assert capsule_expr.type_name == ["Capsule"]
        assert len(capsule_expr.fields) == 1
        assert capsule_expr.fields[0].name == "id"
        assert capsule_expr.fields[0].value.variant == "NumberLiteral"

        literal_python = generate_program(literal_program)
        assert "runtime.make_object" in literal_python
        assert "Capsule(" in literal_python
        assert "[1, 2, 3]" in literal_python

        match_program = parse_program(
            "fn classify(score -> number) {\n"
            "    match score {\n"
            "        case 0 -> {\n"
            "            return;\n"
            "        },\n"
            "        case _ -> {\n"
            "            return;\n"
            "        }\n"
            "    }\n"
            "}\n"
        )
        assert len(match_program.statements) == 1
        match_fn = match_program.statements[0]
        assert match_fn.variant == "FunctionDeclaration"
        assert len(match_fn.body.statements) == 1
        match_stmt = match_fn.body.statements[0]
        assert match_stmt.variant == "MatchStatement"
        assert len(match_stmt.cases) == 2
        first_case = match_stmt.cases[0]
        assert first_case.pattern.variant in {"NumberLiteral", "Raw"}
        assert len(first_case.body.statements) == 1
        assert first_case.body.statements[0].variant == "ReturnStatement"
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
        assert [param.name for param in collection_struct.type_parameters] == ["T"]
        assert [impl.text for impl in collection_struct.implements_types] == ["Iterable<T>", "Debug"]
        assert len(collection_struct.decorators) == 1
        assert collection_struct.decorators[0].name == "entity"
        assert collection_struct.decorators[0].arguments == []
        assert len(collection_struct.fields) == 1
        assert len(collection_struct.methods) == 1
        method = collection_struct.methods[0]
        assert method.signature.name == "get"
        assert method.signature.return_type is not None and method.signature.return_type.text == "T"
        assert "io" in method.signature.effects
        assert [param.name for param in method.signature.type_parameters] == []
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

        model_program = parse_program(
            "model Summarizer : Model<Text, Summary> ![model] {\n"
            "    engine = \"gpt\";\n"
            "    cost = 0.05;\n"
            "}\n"
        )
        assert len(model_program.statements) == 1
        model_stmt = model_program.statements[0]
        assert model_stmt.variant == "ModelDeclaration"
        assert model_stmt.name == "Summarizer"
        assert model_stmt.model_type.text == "Model<Text, Summary>"
        assert model_stmt.effects == ["model"]
        assert len(model_stmt.properties) == 2
        assert model_stmt.properties[0].name == "engine"
        first_property_value = model_stmt.properties[0].value
        if first_property_value.variant == "StringLiteral":
            assert first_property_value.value == "gpt"
        else:
            assert first_property_value.variant == "Raw"
            assert '"gpt"' in first_property_value.text

        pipeline_program = parse_program(
            "pipeline ingest(data -> string) -> string {\n"
            "    return data;\n"
            "}\n"
        )
        assert len(pipeline_program.statements) == 1
        pipeline_stmt = pipeline_program.statements[0]
        assert pipeline_stmt.variant == "PipelineDeclaration"
        assert pipeline_stmt.signature.name == "ingest"
        assert pipeline_stmt.signature.parameters[0].name == "data"
        assert pipeline_stmt.signature.return_type is not None
        assert pipeline_stmt.signature.type_parameters == []

        tool_program = parse_program(
            "tool fetch(request -> string) -> string ![io] {\n"
            "    return request;\n"
            "}\n"
        )
        assert len(tool_program.statements) == 1
        tool_stmt = tool_program.statements[0]
        assert tool_stmt.variant == "ToolDeclaration"
        assert tool_stmt.signature.name == "fetch"
        assert "io" in tool_stmt.signature.effects
        assert tool_stmt.signature.type_parameters == []

        type_alias_program = parse_program(
            "type Result<T> = Response | T;\n"
        )
        assert len(type_alias_program.statements) == 1
        type_alias = type_alias_program.statements[0]
        assert type_alias.variant == "TypeAliasDeclaration"
        assert type_alias.name == "Result"
        assert [param.name for param in type_alias.type_parameters] == ["T"]
        assert type_alias.aliased_type.text == "Response | T"

        interface_program = parse_program(
            "interface Service<T> {\n"
            "    fn handle(request -> T) -> T;\n"
            "}\n"
        )
        assert len(interface_program.statements) == 1
        interface_decl = interface_program.statements[0]
        assert interface_decl.variant == "InterfaceDeclaration"
        assert interface_decl.name == "Service"
        assert [param.name for param in interface_decl.type_parameters] == ["T"]
        assert len(interface_decl.members) == 1
        signature_member = interface_decl.members[0]
        assert signature_member.name == "handle"
        assert signature_member.parameters[0].name == "request"
        assert signature_member.return_type is not None
        assert signature_member.type_parameters == []

        enum_program = parse_program(
            "enum Response {\n"
            "    Ok;\n"
            "    Error { message -> string; }\n"
            "}\n"
        )
        assert len(enum_program.statements) == 1
        enum_decl = enum_program.statements[0]
        assert enum_decl.variant == "EnumDeclaration"
        assert enum_decl.name == "Response"
        assert len(enum_decl.variants) == 2
        assert enum_decl.variants[0].name == "Ok"
        error_variant = enum_decl.variants[1]
        assert error_variant.name == "Error"
        assert len(error_variant.fields) == 1
        assert error_variant.fields[0].name == "message"
        assert error_variant.fields[0].type_annotation.text == "string"

        with_program = parse_program(
            "fn run() {\n"
            "    with seed(42) {\n"
            "        prompt system { \"hello\"; };\n"
            "    }\n"
            "}\n"
        )
        assert len(with_program.statements) == 1
        with_fn = with_program.statements[0]
        assert with_fn.variant == "FunctionDeclaration"
        assert with_fn.body.statements
        with_stmt = with_fn.body.statements[0]
        assert with_stmt.variant == "WithStatement"
        assert len(with_stmt.clauses) == 1
        inner_prompt = with_stmt.body.statements[0]
        assert inner_prompt.variant == "PromptStatement"
        assert inner_prompt.channel == "system"

        test_program = parse_program(
            "test \"runs pipeline\" ![model] {\n"
            "    prompt system { \"ok\"; };\n"
            "}\n"
        )
        assert len(test_program.statements) == 1
        test_stmt = test_program.statements[0]
        assert test_stmt.variant == "TestDeclaration"
        assert test_stmt.name == "runs pipeline"
        assert test_stmt.effects == ["model"]

        bare_test_program = parse_program(
            "test regression {\n"
            "    prompt system { \"ok\"; };\n"
            "}\n"
        )
        bare_test = bare_test_program.statements[0]
        assert bare_test.variant == "TestDeclaration"
        assert bare_test.effects == []
        assert bare_test.body.statements
        prompt_stmt = bare_test.body.statements[0]
        assert prompt_stmt.variant == "PromptStatement"
        assert prompt_stmt.channel == "system"
    elif source_path.name == "emitter_sailfin.sfn":
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
            "compiler/src/decorator_semantics.sfn",
        ]:
            compile_module(dependency)

        exec(compiled, namespace, namespace)
        parse_program = namespace["parse_program"]
        emit_program = namespace["emit_program"]

        sample = (
            'fn greet(name -> string) -> string ![io] {\n'
            '    return name;\n'
            '}\n'
            '\n'
            'test "works" {\n'
            '    return;\n'
            '}\n'
        )
        program = parse_program(sample)
        assert all(stmt.variant != "Unknown" for stmt in program.statements)

        sailfin_output = emit_program(program)
        assert sailfin_output.startswith("// Generated by Sailfin self-hosted emitter")
        assert 'import { sleep, channel, parallel' in sailfin_output
        assert 'fn greet(name -> string) -> string ![io]' in sailfin_output
        assert (
            'test "works"' in sailfin_output
            or 'test \\"works\\"' in sailfin_output
        )

        stage0_ast = parser.parse(sailfin_output, lexer=base_lexer.clone())
        assert stage0_ast is not None

        regenerated = parse_program(sailfin_output)
        assert all(stmt.variant != "Unknown" for stmt in regenerated.statements)

        lambda_source = (
            "fn apply(values -> number[]) -> number[] {\n"
            "    return values.map(fn (value -> number) -> number {\n"
            "        return value * 2;\n"
            "    });\n"
            "}\n"
        )
        lambda_program = parse_program(lambda_source)
        lambda_output = emit_program(lambda_program)
        assert "fn (value -> number) -> number" in lambda_output
        stage0_lambda = parser.parse(lambda_output, lexer=base_lexer.clone())
        assert stage0_lambda is not None
    elif source_path.name == "prelude.sfn":
        namespace = {"__name__": "__main__"}
        exec(compiled, namespace, namespace)

        assert "console" in namespace
        console_obj = namespace["console"]
        assert hasattr(console_obj, "info")

        sleep_fn = namespace["sleep"]
        sleep_fn(0)

        channel_fn = namespace["channel"]
        channel_obj = channel_fn(1)
        assert hasattr(channel_obj, "send")

        parallel_fn = namespace["parallel"]
        results = parallel_fn([lambda: 1, lambda: 2])
        assert results == [1, 2]

        log_execution = namespace["logExecution"]
        wrapped = log_execution(lambda: "wrapped")
        assert callable(wrapped)
        assert wrapped() == "wrapped"

        scheduler_obj = namespace["scheduler"]
        assert hasattr(scheduler_obj, "spawn")

        fs_obj = namespace["fs"]
        assert hasattr(fs_obj, "readFile")

        serve_fn = namespace["serve"]

        def _handler(request, response):
            response.send("ok")

        serve_fn(_handler)
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
    elif source_path.name == "effect_checker.sfn":
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
            "compiler/src/decorator_semantics.sfn",
            "compiler/src/parser.sfn",
        ]:
            compile_module(dependency)

        exec(compiled, namespace, namespace)
        parse_program = namespace["parse_program"]
        validate_effects = namespace["validate_effects"]

        missing_sample = (
            "fn summarize() {\n"
            "    prompt system { \"hi\"; };\n"
            "}\n"
        )
        violations = validate_effects(parse_program(missing_sample))
        assert violations and violations[0].missing_effects == ["model"]

        network_sample = (
            "fn serve_api() {\n"
            "    serve(request -> request);\n"
            "}\n"
        )
        net_violations = validate_effects(parse_program(network_sample))
        assert net_violations and "net" in net_violations[0].missing_effects

        ok_sample = (
            "fn summarize_ok() ![model] {\n"
            "    prompt system { \"hi\"; };\n"
            "}\n"
            "@trace(level: \"debug\")\n"
            "fn traced_ok() {\n"
            "    fs.writeFile(\"out.txt\", \"data\");\n"
            "}\n"
        )
        ok_violations = validate_effects(parse_program(ok_sample))
        assert not ok_violations

        pipeline_missing = (
            "pipeline summarize_pipeline(doc -> string) {\n"
            "    prompt system { \"hi\"; };\n"
            "}\n"
        )
        pipeline_violations = validate_effects(parse_program(pipeline_missing))
        assert pipeline_violations
        assert "model" in pipeline_violations[0].missing_effects

        pipeline_ok = (
            "pipeline summarize_pipeline_ok() ![model] {\n"
            "    prompt system { \"hi\"; };\n"
            "}\n"
        )
        assert not validate_effects(parse_program(pipeline_ok))

        test_missing = (
            "test \"needs model\" {\n"
            "    prompt system { \"hi\"; };\n"
            "}\n"
        )
        test_violations = validate_effects(parse_program(test_missing))
        assert test_violations
        assert "model" in test_violations[0].missing_effects

        test_ok = (
            "test regression ![model] {\n"
            "    prompt system { \"hi\"; };\n"
            "}\n"
        )
        assert not validate_effects(parse_program(test_ok))
