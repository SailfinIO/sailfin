import asyncio
from runtime import runtime_support as runtime

from compiler.build.lexer import lex
from compiler.build.token import Token, TokenKind
from compiler.build.ast import Program, Statement
from compiler.build.parser.types import Parser, StatementParseResult
from compiler.build.parser.token_utils import parser_peek_raw, parser_advance_raw, skip_trivia, is_end_of_file, identifier_matches
from compiler.build.parser.declarations import parse_decorators, parse_import, parse_export, parse_variable, parse_model, parse_pipeline, parse_tool, parse_test, parse_function, parse_extern_function, parse_struct, parse_type_alias, parse_interface, parse_enum, parse_unknown
from compiler.build.types import Parser, StatementParseResult, BlockStatementParseResult, BlockParseResult, ParameterParseResult, ParameterListParseResult, StructFieldParseResult, ModelPropertyParseResult, MethodParseResult, InterfaceMemberParseResult, EnumVariantParseResult, TypeParameterParseResult, ImplementsParseResult, DecoratorParseResult, EffectParseResult, TypeSeparatorParseResult, SpecifierListParseResult, NamedSpecifier, CaptureResult, ParenthesizedParseResult, PatternCaptureResult, MatchCasesParseResult, MatchCaseParseResult, MatchCaseTokenSplit, ExpressionTokens, ExpressionParseResult, ExpressionTypeSeparatorParseResult, ExpressionCollectResult, ExpressionBlockParseResult, LambdaParameterParseResult, LambdaParameterListParseResult, CallArgumentsParseResult, ArrayLiteralParseResult, ObjectLiteralParseResult, StructTypeNameResult
from compiler.build.utils import trim_text, is_trim_whitespace, strip_surrounding_quotes, strip_loose_quotes, decode_string_literal_escapes, normalize_test_name, looks_like_number, is_decimal_digit, string_array_contains, append_string
from compiler.build.token_utils import parser_peek_raw, parser_advance_raw, skip_trivia, is_end_of_file, identifier_matches, symbol_matches, identifier_text, string_literal_value, consume_keyword, consume_symbol, advance_to_symbol, is_trivia_token, is_whitespace_lexeme, token_slice, trim_token_edges, trim_block_tokens, filter_trivia, tokens_to_text, source_span_from_tokens, collect_until, collect_parenthesized, collect_pattern_until_arrow, split_tokens_by_comma, split_token_slices_by_comma, find_top_level_symbol, find_top_level_identifier, find_top_level_colon, skip_struct_member, skip_enum_variant_entry, skip_trailing_comma, append_token, append_token_array
from compiler.build.expressions import expression_tokens_is_at_end, expression_tokens_peek, expression_tokens_advance, expression_parse_failure, expression_tokens_consume_type_separator, expression_tokens_collect_until, collect_expression_block, expression_from_tokens, expression_from_single_token, parse_expression_bp, parse_prefix_expression, parse_primary_expression, parse_postfix_chain, parse_call_arguments, parse_array_literal, parse_object_literal, parse_struct_literal, expression_is_struct_target, collect_struct_type_name, parse_lambda_expression, parse_lambda_parameter, parse_lambda_parameter_list, binary_precedence, unary_precedence, normalize_expression
from compiler.build.statements import parse_block, parse_block_statement, parse_for_statement, parse_loop_statement, parse_break_statement, parse_continue_statement, parse_if_statement, parse_match_statement, parse_match_cases, parse_match_case, split_match_case_tokens, parse_prompt_statement, parse_with_statement, parse_return_statement, parse_throw_statement, parse_try_statement, parse_assert_statement, parse_expression_statement, parse_unknown_statement
from compiler.build.declarations import consume_type_separator, parse_decorators, parse_decorator_argument, parse_effect_list, parse_type_parameter_clause, parse_implements_clause, parse_parameter_list, parse_single_parameter, parse_import, parse_export, parse_specifier_list, build_import_specifiers, build_export_specifiers, parse_variable, parse_function, parse_extern_function, parse_struct, parse_struct_field, parse_struct_method, parse_enum, parse_enum_variant, parse_enum_variant_field, parse_interface, parse_interface_member, parse_type_alias, parse_model, parse_model_property, parse_pipeline, parse_tool, parse_test, parse_unknown

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

__all__ = ["Parser", "StatementParseResult", "BlockStatementParseResult", "BlockParseResult", "ParameterParseResult", "ParameterListParseResult", "StructFieldParseResult", "ModelPropertyParseResult", "MethodParseResult", "InterfaceMemberParseResult", "EnumVariantParseResult", "TypeParameterParseResult", "ImplementsParseResult", "DecoratorParseResult", "EffectParseResult", "TypeSeparatorParseResult", "SpecifierListParseResult", "NamedSpecifier", "CaptureResult", "ParenthesizedParseResult", "PatternCaptureResult", "MatchCasesParseResult", "MatchCaseParseResult", "MatchCaseTokenSplit", "ExpressionTokens", "ExpressionParseResult", "ExpressionTypeSeparatorParseResult", "ExpressionCollectResult", "ExpressionBlockParseResult", "LambdaParameterParseResult", "LambdaParameterListParseResult", "CallArgumentsParseResult", "ArrayLiteralParseResult", "ObjectLiteralParseResult", "StructTypeNameResult", "trim_text", "is_trim_whitespace", "strip_surrounding_quotes", "strip_loose_quotes", "decode_string_literal_escapes", "normalize_test_name", "looks_like_number", "is_decimal_digit", "string_array_contains", "append_string", "parser_peek_raw", "parser_advance_raw", "skip_trivia", "is_end_of_file", "identifier_matches", "symbol_matches", "identifier_text", "string_literal_value", "consume_keyword", "consume_symbol", "advance_to_symbol", "is_trivia_token", "is_whitespace_lexeme", "token_slice", "trim_token_edges", "trim_block_tokens", "filter_trivia", "tokens_to_text", "source_span_from_tokens", "collect_until", "collect_parenthesized", "collect_pattern_until_arrow", "split_tokens_by_comma", "split_token_slices_by_comma", "find_top_level_symbol", "find_top_level_identifier", "find_top_level_colon", "skip_struct_member", "skip_enum_variant_entry", "skip_trailing_comma", "append_token", "append_token_array", "expression_tokens_is_at_end", "expression_tokens_peek", "expression_tokens_advance", "expression_parse_failure", "expression_tokens_consume_type_separator", "expression_tokens_collect_until", "collect_expression_block", "expression_from_tokens", "expression_from_single_token", "parse_expression_bp", "parse_prefix_expression", "parse_primary_expression", "parse_postfix_chain", "parse_call_arguments", "parse_array_literal", "parse_object_literal", "parse_struct_literal", "expression_is_struct_target", "collect_struct_type_name", "parse_lambda_expression", "parse_lambda_parameter", "parse_lambda_parameter_list", "binary_precedence", "unary_precedence", "normalize_expression", "parse_block", "parse_block_statement", "parse_for_statement", "parse_loop_statement", "parse_break_statement", "parse_continue_statement", "parse_if_statement", "parse_match_statement", "parse_match_cases", "parse_match_case", "split_match_case_tokens", "parse_prompt_statement", "parse_with_statement", "parse_return_statement", "parse_throw_statement", "parse_try_statement", "parse_assert_statement", "parse_expression_statement", "parse_unknown_statement", "consume_type_separator", "parse_decorators", "parse_decorator_argument", "parse_effect_list", "parse_type_parameter_clause", "parse_implements_clause", "parse_parameter_list", "parse_single_parameter", "parse_import", "parse_export", "parse_specifier_list", "build_import_specifiers", "build_export_specifiers", "parse_variable", "parse_function", "parse_extern_function", "parse_struct", "parse_struct_field", "parse_struct_method", "parse_enum", "parse_enum_variant", "parse_enum_variant_field", "parse_interface", "parse_interface_member", "parse_type_alias", "parse_model", "parse_model_property", "parse_pipeline", "parse_tool", "parse_test", "parse_unknown"]
