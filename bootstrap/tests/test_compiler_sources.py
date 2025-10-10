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
        assert signature.parameters[0].name == "name"
        assert signature.parameters[0].type_annotation is not None
        assert signature.type_parameters == []
        assert fn_stmt.body.text.strip().startswith("{")

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
        compile_module("compiler/src/code_generator.sfn")
        generate_program = namespace["generate_program"]
        loop_python = generate_program(loop_program)
        assert "for item in items:" in loop_python

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
