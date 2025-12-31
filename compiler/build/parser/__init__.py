import asyncio
from runtime import runtime_support as runtime

from compiler.build.lexer import lex
from compiler.build.token import Token, TokenKind
from compiler.build.ast import Program, Statement
from compiler.build.parser.types import Parser, StatementParseResult
from compiler.build.parser.token_utils import parser_peek_raw, parser_advance_raw, skip_trivia, is_end_of_file, identifier_matches
from compiler.build.parser.declarations import (
    parse_decorators,
    parse_import,
    parse_export,
    parse_variable,
    parse_model,
    parse_pipeline,
    parse_tool,
    parse_test,
    parse_function,
    parse_extern_function,
    parse_struct,
    parse_type_alias,
    parse_interface,
    parse_enum,
    parse_unknown,
)

print = runtime.console
sleep = runtime.sleep
channel = runtime.channel
parallel = runtime.parallel
spawn = runtime.spawn
fs = runtime.fs
serve = runtime.serve
http = runtime.http
websocket = runtime.websocket
logExecution = runtime.logExecution
array_map = runtime.array_map
array_filter = runtime.array_filter
array_reduce = runtime.array_reduce
substring_unchecked = runtime.substring_unchecked
is_decimal_digit = runtime.is_decimal_digit
is_whitespace_char = runtime.is_whitespace_char
is_alpha_char = runtime.is_alpha_char
globals()['t' + 'rue'] = True
globals()['f' + 'alse'] = False

def parse_program(source):
    tokens = lex(source)
    return parse_tokens(tokens)

def parse_tokens(tokens):
    parser = Parser(tokens=tokens, index=0)
    statements = []
    parser = skip_trivia(parser)
    while True:
        token = parser_peek_raw(parser)
        if is_end_of_file(parser, token):
            break
        result = parse_statement(parser)
        parser = result.parser
        statements = append_statement(statements, result.statement)
        parser = skip_trivia(parser)
    return Program(statements=statements)

def parse_statement(initial_parser):
    parser = initial_parser
    original = parser
    parser = skip_trivia(parser)
    decorator_result = parse_decorators(parser)
    parser = decorator_result.parser
    decorators = decorator_result.decorators
    parser = skip_trivia(parser)
    token = parser_peek_raw(parser)
    if identifier_matches(token, "import"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_import(parser)
    if identifier_matches(token, "export"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_export(parser)
    if identifier_matches(token, "let"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_variable(parser)
    if identifier_matches(token, "model"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_model(parser, decorators)
    if identifier_matches(token, "pipeline"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_pipeline(parser, decorators)
    if identifier_matches(token, "tool"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_tool(parser, decorators)
    if identifier_matches(token, "test"):
        if len(decorators) > 0:
            return parse_unknown(original)
        return parse_test(parser, decorators)
    if identifier_matches(token, "fn"):
        return parse_function(parser, False, decorators)
    if identifier_matches(token, "async"):
        lookahead = skip_trivia(parser_advance_raw(parser))
        if identifier_matches(parser_peek_raw(lookahead), "fn"):
            return parse_function(parser, True, decorators)
    if identifier_matches(token, "extern"):
        return parse_extern_function(parser, False, decorators)
    if identifier_matches(token, "unsafe"):
        lookahead = skip_trivia(parser_advance_raw(parser))
        if identifier_matches(parser_peek_raw(lookahead), "extern"):
            return parse_extern_function(parser, True, decorators)
    if identifier_matches(token, "struct"):
        return parse_struct(parser, decorators)
    if identifier_matches(token, "type"):
        return parse_type_alias(parser, decorators)
    if identifier_matches(token, "interface"):
        return parse_interface(parser, decorators)
    if identifier_matches(token, "enum"):
        return parse_enum(parser, decorators)
    if len(decorators) > 0:
        return parse_unknown(original)
    return parse_unknown(parser)

def append_statement(statements, statement):
    return (statements) + ([statement])
