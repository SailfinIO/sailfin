import asyncio
from runtime import runtime_support as runtime

from compiler.build.token import Token
from compiler.build.ast import Block, Decorator, DecoratorArgument, Expression, FieldDeclaration, FunctionSignature, EnumVariant, MethodDeclaration, ModelProperty, Parameter, Statement, ImportSpecifier, ExportSpecifier, TypeParameter, TypeAnnotation
from compiler.build.decorator_semantics import evaluate_decorators, infer_effects
from compiler.build.string_utils import substring, char_code, char_at, strings_equal
from compiler.build.parser.types import Parser, StatementParseResult, ParameterParseResult, ParameterListParseResult, StructFieldParseResult, ModelPropertyParseResult, MethodParseResult, InterfaceMemberParseResult, EnumVariantParseResult, TypeParameterParseResult, ImplementsParseResult, DecoratorParseResult, EffectParseResult, TypeSeparatorParseResult, SpecifierListParseResult, NamedSpecifier, BlockParseResult
from compiler.build.parser.utils import trim_text, strip_surrounding_quotes, strip_loose_quotes, looks_like_number, normalize_test_name
from compiler.build.parser.token_utils import parser_peek_raw, parser_advance_raw, skip_trivia, identifier_matches, symbol_matches, identifier_text, string_literal_value, consume_keyword, consume_symbol, advance_to_symbol, collect_until, collect_parenthesized, token_slice, trim_token_edges, filter_trivia, tokens_to_text, source_span_from_tokens, append_token, find_top_level_symbol, find_top_level_colon, split_tokens_by_comma, split_token_slices_by_comma, skip_struct_member, skip_enum_variant_entry, skip_trailing_comma, is_end_of_file
from compiler.build.parser.expressions import expression_from_tokens, normalize_expression
from compiler.build.parser.statements import parse_block

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

def consume_type_separator(parser):
    token = parser_peek_raw(parser)
    if symbol_matches(token, ":")  or  symbol_matches(token, "->"):
        return TypeSeparatorParseResult(parser=parser_advance_raw(parser), found=True)
    if symbol_matches(token, "-"):
        current = parser_advance_raw(parser)
        maybe_gt = parser_peek_raw(current)
        if symbol_matches(maybe_gt, ">"):
            current = parser_advance_raw(current)
        return TypeSeparatorParseResult(parser=current, found=True)
    return TypeSeparatorParseResult(parser=parser, found=False)

def parse_decorators(parser):
    current = parser
    decorators = []
    while True:
        current = skip_trivia(current)
        token = parser_peek_raw(current)
        if not symbol_matches(token, "@"):
            break
        decorator_start = current
        current = parser_advance_raw(current)
        current = skip_trivia(current)
        name_token = parser_peek_raw(current)
        if name_token.kind.variant != "Identifier":
            current = decorator_start
            break
        name = identifier_text(name_token)
        current = parser_advance_raw(current)
        current = skip_trivia(current)
        decorator_arguments = []
        after = parser_peek_raw(current)
        if symbol_matches(after, "("):
            paren_result = collect_parenthesized(current)
            if paren_result.success:
                segment_tokens = []
                angle = 0
                paren = 0
                brace = 0
                bracket = 0
                index = 0
                while True:
                    if index >= len(paren_result.tokens):
                        break
                    tok = paren_result.tokens[index]
                    if tok.kind.variant == "Symbol":
                        sym = tok.lexeme
                        if strings_equal(sym, "<"):
                            angle += 1
                        else:
                            if strings_equal(sym, ">")  and  angle > 0:
                                angle -= 1
                            else:
                                if strings_equal(sym, "("):
                                    paren += 1
                                else:
                                    if strings_equal(sym, ")")  and  paren > 0:
                                        paren -= 1
                                    else:
                                        if strings_equal(sym, "{"):
                                            brace += 1
                                        else:
                                            if strings_equal(sym, "}")  and  brace > 0:
                                                brace -= 1
                                            else:
                                                if strings_equal(sym, "["):
                                                    bracket += 1
                                                else:
                                                    if strings_equal(sym, "]")  and  bracket > 0:
                                                        bracket -= 1
                        at_top_level = angle == 0  and  paren == 0  and  brace == 0  and  bracket == 0
                        if strings_equal(sym, ",")  and  at_top_level:
                            trimmed_tokens = trim_token_edges(segment_tokens)
                            argument = parse_decorator_argument(trimmed_tokens)
                            if argument != None:
                                decorator_arguments = append_decorator_argument(decorator_arguments, argument)
                            segment_tokens = []
                            index += 1
                            continue
                    segment_tokens = append_token(segment_tokens, tok)
                    index += 1
                final_tokens = trim_token_edges(segment_tokens)
                trailing_argument = parse_decorator_argument(final_tokens)
                if trailing_argument != None:
                    decorator_arguments = append_decorator_argument(decorator_arguments, trailing_argument)
                current = paren_result.parser
            else:
                current = decorator_start
                break
        decorators = append_decorator(decorators, Decorator(name=name, arguments=decorator_arguments))
    return DecoratorParseResult(parser=current, decorators=decorators)

def parse_decorator_argument(tokens):
    if len(tokens) == 0:
        return None
    colon_index = find_top_level_colon(tokens)
    if colon_index == -1:
        trimmed_tokens = trim_token_edges(tokens)
        if len(trimmed_tokens) == 0:
            return None
        expr = normalize_expression(trimmed_tokens, expression_from_tokens(trimmed_tokens))
        return DecoratorArgument(name=None, expression=expr)
    name_tokens = trim_token_edges(token_slice(tokens, 0, colon_index))
    value_tokens = trim_token_edges(token_slice(tokens, colon_index + 1, len(tokens)))
    if len(value_tokens) == 0:
        return None
    name_text = trim_text(tokens_to_text(name_tokens))
    if len(name_text) == 0:
        return None
    expr = normalize_expression(value_tokens, expression_from_tokens(value_tokens))
    if expr.variant == "Raw":
        raw_text = trim_text(tokens_to_text(value_tokens))
        if len(raw_text) >= 2  and  char_at(raw_text, 0) == "\""  and  char_at(raw_text, len(raw_text) - 1) == "\"":
            literal = strip_surrounding_quotes(raw_text)
            expr = runtime.enum_instantiate(Expression, 'StringLiteral', [runtime.enum_field('value', literal)])
        else:
            if raw_text == "true":
                expr = runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', "true")])
            else:
                if raw_text == "false":
                    expr = runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', "false")])
                else:
                    if looks_like_number(raw_text):
                        expr = runtime.enum_instantiate(Expression, 'NumberLiteral', [runtime.enum_field('value', raw_text)])
    return DecoratorArgument(name=name_text, expression=expr)

def parse_effect_list(initial_parser):
    parser = initial_parser
    parser = skip_trivia(parser)
    token = parser_peek_raw(parser)
    if not symbol_matches(token, "!"):
        return EffectParseResult(parser=parser, effects=[])
    parser = parser_advance_raw(parser)
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, "[")
    effects = []
    parser = skip_trivia(parser)
    while True:
        current = parser_peek_raw(parser)
        if symbol_matches(current, "]"):
            parser = parser_advance_raw(parser)
            break
        if current.kind.variant == "Identifier":
            effect = identifier_text(current)
            effects = append_string(effects, effect)
            parser = parser_advance_raw(parser)
            parser = skip_trivia(parser)
            separator = parser_peek_raw(parser)
            if symbol_matches(separator, ","):
                parser = parser_advance_raw(parser)
                parser = skip_trivia(parser)
                continue
            continue
        parser = parser_advance_raw(parser)
        parser = skip_trivia(parser)
    return EffectParseResult(parser=parser, effects=effects)

def parse_type_parameter_clause(parser):
    current = skip_trivia(parser)
    token = parser_peek_raw(current)
    if not symbol_matches(token, "<"):
        return TypeParameterParseResult(parser=parser, parameters=[])
    current = parser_advance_raw(current)
    collected = []
    depth = 1
    while True:
        tok = parser_peek_raw(current)
        if tok.kind.variant == "EndOfFile":
            break
        if tok.kind.variant == "Symbol":
            sym = tok.lexeme
            if strings_equal(sym, "<"):
                depth += 1
            else:
                if strings_equal(sym, ">"):
                    depth -= 1
                    if depth == 0:
                        current = parser_advance_raw(current)
                        break
        collected = append_token(collected, tok)
        current = parser_advance_raw(current)
    slices = split_token_slices_by_comma(collected)
    parameters = []
    index = 0
    while True:
        if index >= len(slices):
            break
        slice_tokens = trim_token_edges(slices[index])
        if len(slice_tokens) > 0:
            colon_index = find_top_level_symbol(slice_tokens, ":")
            name_tokens = slice_tokens
            bound_tokens = []
            if colon_index != -1:
                name_tokens = token_slice(slice_tokens, 0, colon_index)
                bound_tokens = token_slice(slice_tokens, colon_index + 1, len(slice_tokens))
            name_text = trim_text(tokens_to_text(name_tokens))
            if len(name_text) > 0:
                bound = None
                bound_text = trim_text(tokens_to_text(bound_tokens))
                if len(bound_tokens) > 0  and  len(bound_text) > 0:
                    bound = TypeAnnotation(text=bound_text)
                name_span = source_span_from_tokens(name_tokens)
                parameter = TypeParameter(name=name_text, bound=bound, span=name_span)
                parameters = (parameters) + ([parameter])
        index += 1
    return TypeParameterParseResult(parser=current, parameters=parameters)

def parse_implements_clause(parser):
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "implements"):
        return ImplementsParseResult(parser=parser, types=[], found=False)
    current = consume_keyword(current, "implements")
    current = skip_trivia(current)
    capture = collect_until(current, ["{"])
    current = capture.parser
    implements_types = []
    entries = split_tokens_by_comma(capture.tokens)
    index = 0
    while True:
        if index >= len(entries):
            break
        text = trim_text(entries[index])
        if len(text) > 0:
            implements_types = append_type_annotation(implements_types, TypeAnnotation(text=text))
        index += 1
    return ImplementsParseResult(parser=current, types=implements_types, found=True)

def parse_parameter_list(initial_parser):
    parser = initial_parser
    parser = skip_trivia(parser)
    parameters = []
    token = parser_peek_raw(parser)
    if symbol_matches(token, ")"):
        parser = parser_advance_raw(parser)
        return ParameterListParseResult(parser=parser, parameters=parameters)
    while True:
        param_result = parse_single_parameter(parser)
        parser = param_result.parser
        parameters = append_parameter(parameters, param_result.parameter)
        parser = skip_trivia(parser)
        separator = parser_peek_raw(parser)
        if symbol_matches(separator, ","):
            parser = parser_advance_raw(parser)
            parser = skip_trivia(parser)
            continue
        if symbol_matches(separator, ")"):
            parser = parser_advance_raw(parser)
            break
        if separator.kind.variant == "EndOfFile":
            break
    return ParameterListParseResult(parser=parser, parameters=parameters)

def parse_single_parameter(initial_parser):
    parser = initial_parser
    parser = skip_trivia(parser)
    tokens_ref = parser.tokens
    start_index = parser.index
    is_mutable = False
    token = parser_peek_raw(parser)
    if identifier_matches(token, "mut"):
        parser = parser_advance_raw(parser)
        is_mutable = True
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    parser = parser_advance_raw(parser)
    type_annotation = None
    parser = skip_trivia(parser)
    separator_result = consume_type_separator(parser)
    if separator_result.found:
        parser = separator_result.parser
        capture = collect_until(skip_trivia(parser), ["=", ",", ")"])
        parser = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            type_annotation = TypeAnnotation(text=text)
    default_value = None
    parser = skip_trivia(parser)
    assign = parser_peek_raw(parser)
    if symbol_matches(assign, "="):
        parser = parser_advance_raw(parser)
        capture = collect_until(skip_trivia(parser), [",", ")"])
        parser = capture.parser
        default_value = expression_from_tokens(capture.tokens)
    end_index = parser.index
    parameter_tokens = token_slice(tokens_ref, start_index, end_index)
    span = source_span_from_tokens(parameter_tokens)
    parameter = Parameter(name=name, type_annotation=type_annotation, default_value=default_value, mutable=is_mutable, span=span)
    return ParameterParseResult(parser=parser, parameter=parameter)

def parse_import(initial_parser):
    parser = initial_parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "import")
    specifier_result = parse_specifier_list(parser)
    parser = specifier_result.parser
    import_specifiers = build_import_specifiers(specifier_result.specifiers)
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "from")
    parser = skip_trivia(parser)
    source = ""
    token = parser_peek_raw(parser)
    text = token.lexeme
    if len(text) > 0  and  strings_equal(char_at(text, 0), "\""):
        source = string_literal_value(token)
        parser = parser_advance_raw(parser)
    else:
        capture = collect_until(parser, [";"])
        parser = capture.parser
        source = trim_text(tokens_to_text(capture.tokens))
        source = strip_surrounding_quotes(strip_loose_quotes(source))
    parser = skip_trivia(parser)
    import_terminator = parser_peek_raw(parser)
    if symbol_matches(import_terminator, ";"):
        parser = parser_advance_raw(parser)
    statement = runtime.enum_instantiate(Statement, 'ImportDeclaration', [runtime.enum_field('import_specifiers', import_specifiers), runtime.enum_field('source', source)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_export(initial_parser):
    parser = initial_parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "export")
    specifier_result = parse_specifier_list(parser)
    parser = specifier_result.parser
    export_specifiers = build_export_specifiers(specifier_result.specifiers)
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "from")
    parser = skip_trivia(parser)
    source = ""
    token = parser_peek_raw(parser)
    text = token.lexeme
    if len(text) > 0  and  strings_equal(char_at(text, 0), "\""):
        source = string_literal_value(token)
        parser = parser_advance_raw(parser)
    else:
        capture = collect_until(parser, [";"])
        parser = capture.parser
        source = trim_text(tokens_to_text(capture.tokens))
        source = strip_surrounding_quotes(strip_loose_quotes(source))
    parser = skip_trivia(parser)
    export_terminator = parser_peek_raw(parser)
    if symbol_matches(export_terminator, ";"):
        parser = parser_advance_raw(parser)
    statement = runtime.enum_instantiate(Statement, 'ExportDeclaration', [runtime.enum_field('export_specifiers', export_specifiers), runtime.enum_field('source', source)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_specifier_list(initial_parser):
    parser = initial_parser
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, "{")
    specifiers = []
    parser = skip_trivia(parser)
    while True:
        current = parser_peek_raw(parser)
        if symbol_matches(current, "}"):
            parser = parser_advance_raw(parser)
            break
        if current.kind.variant != "Identifier":
            break
        name = identifier_text(current)
        parser = parser_advance_raw(parser)
        parser = skip_trivia(parser)
        alias = None
        potential_alias = parser_peek_raw(parser)
        if identifier_matches(potential_alias, "as"):
            parser = consume_keyword(parser, "as")
            parser = skip_trivia(parser)
            alias_token = parser_peek_raw(parser)
            if alias_token.kind.variant == "Identifier":
                alias = identifier_text(alias_token)
                parser = parser_advance_raw(parser)
                parser = skip_trivia(parser)
        specifiers = (specifiers) + ([NamedSpecifier(name=name, alias=alias)])
        separator = parser_peek_raw(parser)
        if symbol_matches(separator, ","):
            parser = parser_advance_raw(parser)
            parser = skip_trivia(parser)
            continue
    parser = skip_trivia(parser)
    if symbol_matches(parser_peek_raw(parser), "}"):
        parser = parser_advance_raw(parser)
    return SpecifierListParseResult(parser=parser, specifiers=specifiers)

def build_import_specifiers(values):
    result = []
    index = 0
    while True:
        if index >= len(values):
            break
        entry = values[index]
        result = (result) + ([ImportSpecifier(name=entry.name, alias=entry.alias)])
        index += 1
    return result

def build_export_specifiers(values):
    result = []
    index = 0
    while True:
        if index >= len(values):
            break
        entry = values[index]
        result = (result) + ([ExportSpecifier(name=entry.name, alias=entry.alias)])
        index += 1
    return result

def parse_variable(initial_parser):
    parser = initial_parser
    parser = skip_trivia(parser)
    statement_tokens = []
    let_token = parser_peek_raw(parser)
    statement_tokens = append_token(statement_tokens, let_token)
    parser = consume_keyword(parser, "let")
    mutable_flag = False
    parser = skip_trivia(parser)
    mut_token = parser_peek_raw(parser)
    if identifier_matches(mut_token, "mut"):
        statement_tokens = append_token(statement_tokens, mut_token)
        parser = consume_keyword(parser, "mut")
        mutable_flag = True
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    statement_tokens = append_token(statement_tokens, name_token)
    name = identifier_text(name_token)
    parser = parser_advance_raw(parser)
    type_annotation = None
    parser = skip_trivia(parser)
    separator_token = parser_peek_raw(parser)
    separator_result = consume_type_separator(parser)
    if separator_result.found:
        statement_tokens = append_token(statement_tokens, separator_token)
        parser = separator_result.parser
        capture = collect_until(skip_trivia(parser), ["=", ";"])
        index = 0
        while True:
            if index >= len(capture.tokens):
                break
            statement_tokens = append_token(statement_tokens, capture.tokens[index])
            index += 1
        parser = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            type_annotation = TypeAnnotation(text=text)
    initializer = None
    initializer_span = None
    parser = skip_trivia(parser)
    assign = parser_peek_raw(parser)
    if symbol_matches(assign, "="):
        statement_tokens = append_token(statement_tokens, assign)
        parser = parser_advance_raw(parser)
        capture = collect_until(skip_trivia(parser), [";"])
        index = 0
        while True:
            if index >= len(capture.tokens):
                break
            statement_tokens = append_token(statement_tokens, capture.tokens[index])
            index += 1
        parser = capture.parser
        if len(capture.tokens) > 0:
            initializer_span = source_span_from_tokens(capture.tokens)
            initializer = expression_from_tokens(capture.tokens)
    parser = skip_trivia(parser)
    terminator = parser_peek_raw(parser)
    if symbol_matches(terminator, ";"):
        statement_tokens = append_token(statement_tokens, terminator)
        parser = parser_advance_raw(parser)
    span = source_span_from_tokens(statement_tokens)
    statement = runtime.enum_instantiate(Statement, 'VariableDeclaration', [runtime.enum_field('name', name), runtime.enum_field('mutable', mutable_flag), runtime.enum_field('type_annotation', type_annotation), runtime.enum_field('initializer', initializer), runtime.enum_field('span', span), runtime.enum_field('initializer_span', initializer_span)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_function(initial_parser, starts_with_async, decorators):
    parser = initial_parser
    parser = skip_trivia(parser)
    is_async = False
    if starts_with_async:
        parser = consume_keyword(parser, "async")
        is_async = True
    else:
        look = parser_peek_raw(parser)
        if identifier_matches(look, "async"):
            lookahead = skip_trivia(parser_advance_raw(parser))
            next = parser_peek_raw(lookahead)
            if identifier_matches(next, "fn"):
                parser = consume_keyword(parser, "async")
                parser = skip_trivia(parser)
                is_async = True
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "fn")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, "(")
    parameter_result = parse_parameter_list(parser)
    parser = parameter_result.parser
    parameters = parameter_result.parameters
    parser = skip_trivia(parser)
    return_type = None
    sep_result = consume_type_separator(parser)
    if sep_result.found:
        parser = sep_result.parser
        capture = collect_until(skip_trivia(parser), ["!", "{"])
        parser = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            return_type = TypeAnnotation(text=text)
    effect_result = parse_effect_list(parser)
    parser = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    if return_type == None:
        parser = skip_trivia(parser)
        late_sep = consume_type_separator(parser)
        if late_sep.found:
            parser = late_sep.parser
            capture = collect_until(skip_trivia(parser), ["{"])
            parser = capture.parser
            text = trim_text(tokens_to_text(capture.tokens))
            if len(text) > 0:
                return_type = TypeAnnotation(text=text)
    block_result = parse_block(parser)
    parser = block_result.parser
    body = block_result.block
    signature = FunctionSignature(name=name, is_async=is_async, parameters=parameters, return_type=return_type, effects=inferred_effects, type_parameters=type_parameters, name_span=name_span)
    statement = runtime.enum_instantiate(Statement, 'FunctionDeclaration', [runtime.enum_field('signature', signature), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_extern_function(initial_parser, starts_with_unsafe, decorators):
    parser = initial_parser
    parser = skip_trivia(parser)
    is_unsafe = False
    if starts_with_unsafe:
        parser = consume_keyword(parser, "unsafe")
        is_unsafe = True
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "extern")
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "fn")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, "(")
    parameter_result = parse_parameter_list(parser)
    parser = parameter_result.parser
    parameters = parameter_result.parameters
    parser = skip_trivia(parser)
    return_type = None
    sep_result = consume_type_separator(parser)
    if sep_result.found:
        parser = sep_result.parser
        capture = collect_until(skip_trivia(parser), ["!", ";"])
        parser = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            return_type = TypeAnnotation(text=text)
    effect_result = parse_effect_list(parser)
    parser = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    if return_type == None:
        parser = skip_trivia(parser)
        late_sep = consume_type_separator(parser)
        if late_sep.found:
            parser = late_sep.parser
            capture = collect_until(skip_trivia(parser), [";"])
            parser = capture.parser
            text = trim_text(tokens_to_text(capture.tokens))
            if len(text) > 0:
                return_type = TypeAnnotation(text=text)
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, ";")
    signature = FunctionSignature(name=name, is_async=False, parameters=parameters, return_type=return_type, effects=inferred_effects, type_parameters=type_parameters, name_span=name_span)
    statement = runtime.enum_instantiate(Statement, 'ExternFunctionDeclaration', [runtime.enum_field('signature', signature), runtime.enum_field('unsafe', is_unsafe), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_struct(initial_parser, decorators):
    parser = initial_parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "struct")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    implements_result = parse_implements_clause(parser)
    parser = implements_result.parser
    implements_types = implements_result.types
    parser = skip_trivia(parser)
    parser = advance_to_symbol(parser, "{")
    parser = consume_symbol(parser, "{")
    fields = []
    methods = []
    while True:
        parser = skip_trivia(parser)
        member_start = parser
        decorator_result = parse_decorators(parser)
        parser = decorator_result.parser
        member_decorators = decorator_result.decorators
        parser = skip_trivia(parser)
        token = parser_peek_raw(parser)
        if symbol_matches(token, "}"):
            parser = parser_advance_raw(parser)
            break
        if token.kind.variant == "EndOfFile":
            break
        field_result = parse_struct_field(parser)
        if field_result.success  and  len(member_decorators) == 0:
            if field_result.field != None:
                fields = append_field(fields, field_result.field)
            parser = field_result.parser
            continue
        method_result = parse_struct_method(parser, member_decorators)
        if method_result.success:
            if method_result.method != None:
                methods = append_method(methods, method_result.method)
            parser = method_result.parser
            continue
        parser = skip_struct_member(member_start)
    statement = runtime.enum_instantiate(Statement, 'StructDeclaration', [runtime.enum_field('name', name), runtime.enum_field('name_span', name_span), runtime.enum_field('type_parameters', type_parameters), runtime.enum_field('implements_types', implements_types), runtime.enum_field('fields', fields), runtime.enum_field('methods', methods), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_struct_field(parser):
    current = skip_trivia(parser)
    is_mutable = False
    token = parser_peek_raw(current)
    token_to_use = token
    if identifier_matches(token_to_use, "mut"):
        current = parser_advance_raw(current)
        is_mutable = True
        current = skip_trivia(current)
        token_to_use = parser_peek_raw(current)
    if token_to_use.kind.variant != "Identifier":
        return StructFieldParseResult(parser=parser, field=None, success=False)
    name = identifier_text(token_to_use)
    name_span = source_span_from_tokens([token_to_use])
    current = parser_advance_raw(current)
    current = skip_trivia(current)
    separator_result = consume_type_separator(current)
    current = separator_result.parser
    if not separator_result.found:
        return StructFieldParseResult(parser=parser, field=None, success=False)
    capture = collect_until(skip_trivia(current), [";", ",", "}"])
    current = capture.parser
    type_text = trim_text(tokens_to_text(capture.tokens))
    if len(type_text) == 0:
        return StructFieldParseResult(parser=parser, field=None, success=False)
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if not symbol_matches(terminator, ";"):
        return StructFieldParseResult(parser=parser, field=None, success=False)
    current = parser_advance_raw(current)
    field = FieldDeclaration(name=name, type_annotation=TypeAnnotation(text=type_text), mutable=is_mutable, name_span=name_span)
    return StructFieldParseResult(parser=current, field=field, success=True)

def parse_struct_method(parser, decorators):
    current = skip_trivia(parser)
    is_async = False
    peek = parser_peek_raw(current)
    if identifier_matches(peek, "async"):
        lookahead = skip_trivia(parser_advance_raw(current))
        if identifier_matches(parser_peek_raw(lookahead), "fn"):
            current = consume_keyword(current, "async")
            is_async = True
    current = skip_trivia(current)
    if not identifier_matches(parser_peek_raw(current), "fn"):
        return MethodParseResult(parser=parser, method=None, success=False)
    current = consume_keyword(current, "fn")
    current = skip_trivia(current)
    name_token = parser_peek_raw(current)
    if name_token.kind.variant != "Identifier":
        return MethodParseResult(parser=parser, method=None, success=False)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    current = parser_advance_raw(current)
    type_param_result = parse_type_parameter_clause(current)
    current = type_param_result.parser
    type_parameters = type_param_result.parameters
    current = skip_trivia(current)
    current = consume_symbol(current, "(")
    parameter_result = parse_parameter_list(current)
    current = parameter_result.parser
    parameters = parameter_result.parameters
    current = skip_trivia(current)
    return_type = None
    sep_result = consume_type_separator(current)
    if sep_result.found:
        current = sep_result.parser
        capture = collect_until(skip_trivia(current), ["!", "{"])
        current = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            return_type = TypeAnnotation(text=text)
    effect_result = parse_effect_list(current)
    current = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    block_result = parse_block(current)
    current = block_result.parser
    body = block_result.block
    signature = FunctionSignature(name=name, is_async=is_async, parameters=parameters, return_type=return_type, effects=inferred_effects, type_parameters=type_parameters, name_span=name_span)
    method = MethodDeclaration(signature=signature, body=body, decorators=decorators)
    return MethodParseResult(parser=current, method=method, success=True)

def parse_enum(initial_parser, decorators):
    parser = initial_parser
    original = parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "enum")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    if name_token.kind.variant != "Identifier":
        return parse_unknown(original)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    parser = skip_trivia(parser)
    parser = advance_to_symbol(parser, "{")
    parser = consume_symbol(parser, "{")
    variants = []
    while True:
        parser = skip_trivia(parser)
        token = parser_peek_raw(parser)
        if symbol_matches(token, "}"):
            parser = parser_advance_raw(parser)
            break
        if token.kind.variant == "EndOfFile":
            break
        variant_result = parse_enum_variant(parser)
        if variant_result.success:
            parser = variant_result.parser
            if variant_result.variant != None:
                variants = append_enum_variant(variants, variant_result.variant)
            parser = skip_trailing_comma(parser)
            continue
        parser = skip_struct_member(parser)
    statement = runtime.enum_instantiate(Statement, 'EnumDeclaration', [runtime.enum_field('name', name), runtime.enum_field('name_span', name_span), runtime.enum_field('type_parameters', type_parameters), runtime.enum_field('variants', variants), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_enum_variant(parser):
    original = parser
    current = skip_trivia(parser)
    name_token = parser_peek_raw(current)
    if name_token.kind.variant != "Identifier":
        return EnumVariantParseResult(parser=original, variant=None, success=False)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    current = parser_advance_raw(current)
    fields = []
    current = skip_trivia(current)
    next = parser_peek_raw(current)
    if symbol_matches(next, "{"):
        current = parser_advance_raw(current)
        while True:
            current = skip_trivia(current)
            token = parser_peek_raw(current)
            if symbol_matches(token, "}"):
                current = parser_advance_raw(current)
                break
            if token.kind.variant == "EndOfFile":
                break
            field_result = parse_enum_variant_field(current)
            if field_result.success:
                current = field_result.parser
                if field_result.field != None:
                    fields = append_field(fields, field_result.field)
                continue
            current = skip_enum_variant_entry(current)
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if symbol_matches(terminator, ";"):
        current = parser_advance_raw(current)
        current = skip_trivia(current)
        terminator = parser_peek_raw(current)
    variant = EnumVariant(name=name, fields=fields, name_span=name_span)
    return EnumVariantParseResult(parser=current, variant=variant, success=True)

def parse_enum_variant_field(parser):
    current = skip_trivia(parser)
    is_mutable = False
    token = parser_peek_raw(current)
    token_to_use = token
    if identifier_matches(token_to_use, "mut"):
        current = parser_advance_raw(current)
        is_mutable = True
        current = skip_trivia(current)
        token_to_use = parser_peek_raw(current)
    if token_to_use.kind.variant != "Identifier":
        return StructFieldParseResult(parser=parser, field=None, success=False)
    name = identifier_text(token_to_use)
    name_span = source_span_from_tokens([token_to_use])
    current = parser_advance_raw(current)
    current = skip_trivia(current)
    sep_result = consume_type_separator(current)
    if not sep_result.found:
        return StructFieldParseResult(parser=parser, field=None, success=False)
    current = sep_result.parser
    capture = collect_until(skip_trivia(current), [",", "}", ";"])
    current = capture.parser
    type_text = trim_text(tokens_to_text(capture.tokens))
    while True:
        if len(type_text) == 0:
            break
        last = char_at(type_text, len(type_text) - 1)
        if last != ";":
            break
        trimmed = substring(type_text, 0, len(type_text) - 1)
        type_text = trim_text(trimmed)
    if len(type_text) == 0:
        return StructFieldParseResult(parser=parser, field=None, success=False)
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if symbol_matches(terminator, ","):
        current = parser_advance_raw(current)
    else:
        if symbol_matches(terminator, ";"):
            current = parser_advance_raw(current)
            current = skip_trivia(current)
            maybe_comma = parser_peek_raw(current)
            if symbol_matches(maybe_comma, ","):
                current = parser_advance_raw(current)
    field = FieldDeclaration(name=name, type_annotation=TypeAnnotation(text=type_text), mutable=is_mutable, name_span=name_span)
    return StructFieldParseResult(parser=current, field=field, success=True)

def parse_interface(initial_parser, decorators):
    parser = initial_parser
    original = parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "interface")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    if name_token.kind.variant != "Identifier":
        return parse_unknown(original)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    parser = skip_trivia(parser)
    parser = advance_to_symbol(parser, "{")
    parser = consume_symbol(parser, "{")
    members = []
    while True:
        parser = skip_trivia(parser)
        token = parser_peek_raw(parser)
        if symbol_matches(token, "}"):
            parser = parser_advance_raw(parser)
            break
        if token.kind.variant == "EndOfFile":
            break
        member_start = parser
        decorator_result = parse_decorators(parser)
        parser = decorator_result.parser
        member_decorators = decorator_result.decorators
        parser = skip_trivia(parser)
        member_result = parse_interface_member(parser, member_decorators)
        if member_result.success:
            parser = member_result.parser
            if member_result.signature != None:
                members = append_signature(members, member_result.signature)
            continue
        parser = skip_struct_member(member_start)
    statement = runtime.enum_instantiate(Statement, 'InterfaceDeclaration', [runtime.enum_field('name', name), runtime.enum_field('name_span', name_span), runtime.enum_field('type_parameters', type_parameters), runtime.enum_field('members', members), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_interface_member(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    is_async = False
    peek = parser_peek_raw(current)
    if identifier_matches(peek, "async"):
        lookahead = skip_trivia(parser_advance_raw(current))
        if identifier_matches(parser_peek_raw(lookahead), "fn"):
            current = consume_keyword(current, "async")
            is_async = True
    current = skip_trivia(current)
    if not identifier_matches(parser_peek_raw(current), "fn"):
        return InterfaceMemberParseResult(parser=original, signature=None, success=False)
    current = consume_keyword(current, "fn")
    current = skip_trivia(current)
    name_token = parser_peek_raw(current)
    if name_token.kind.variant != "Identifier":
        return InterfaceMemberParseResult(parser=original, signature=None, success=False)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    current = parser_advance_raw(current)
    type_param_result = parse_type_parameter_clause(current)
    current = type_param_result.parser
    type_parameters = type_param_result.parameters
    current = skip_trivia(current)
    current = consume_symbol(current, "(")
    parameter_result = parse_parameter_list(current)
    current = parameter_result.parser
    parameters = parameter_result.parameters
    current = skip_trivia(current)
    return_type = None
    separator_result = consume_type_separator(current)
    if separator_result.found:
        current = separator_result.parser
        capture = collect_until(skip_trivia(current), ["!", ";", "{"])
        current = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            return_type = TypeAnnotation(text=text)
    effect_result = parse_effect_list(current)
    current = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    current = skip_trivia(current)
    if current.index < len(current.tokens):
        terminator = parser_peek_raw(current)
        if symbol_matches(terminator, ";"):
            current = parser_advance_raw(current)
    signature = FunctionSignature(name=name, is_async=is_async, parameters=parameters, return_type=return_type, effects=inferred_effects, type_parameters=type_parameters, name_span=name_span)
    return InterfaceMemberParseResult(parser=current, signature=signature, success=True)

def parse_type_alias(initial_parser, decorators):
    parser = initial_parser
    original = parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "type")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    if name_token.kind.variant != "Identifier":
        return parse_unknown(original)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    parser = skip_trivia(parser)
    equals = parser_peek_raw(parser)
    if not symbol_matches(equals, "="):
        return parse_unknown(original)
    parser = parser_advance_raw(parser)
    capture = collect_until(skip_trivia(parser), [";"])
    parser = capture.parser
    aliased_text = trim_text(tokens_to_text(capture.tokens))
    if len(aliased_text) == 0:
        return parse_unknown(original)
    aliased_type = TypeAnnotation(text=aliased_text)
    parser = skip_trivia(parser)
    alias_terminator = parser_peek_raw(parser)
    if symbol_matches(alias_terminator, ";"):
        parser = parser_advance_raw(parser)
    statement = runtime.enum_instantiate(Statement, 'TypeAliasDeclaration', [runtime.enum_field('name', name), runtime.enum_field('name_span', name_span), runtime.enum_field('type_parameters', type_parameters), runtime.enum_field('aliased_type', aliased_type), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_model(initial_parser, decorators):
    parser = initial_parser
    original = parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "model")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    parser = skip_trivia(parser)
    parser = advance_to_symbol(parser, ":")
    parser = consume_symbol(parser, ":")
    type_capture = collect_until(skip_trivia(parser), ["!", "{"])
    parser = type_capture.parser
    type_text = trim_text(tokens_to_text(type_capture.tokens))
    if len(type_text) == 0:
        return parse_unknown(original)
    model_type = TypeAnnotation(text=type_text)
    effect_result = parse_effect_list(parser)
    parser = effect_result.parser
    effects = effect_result.effects
    parser = skip_trivia(parser)
    parser = advance_to_symbol(parser, "{")
    parser = consume_symbol(parser, "{")
    properties = []
    while True:
        parser = skip_trivia(parser)
        token = parser_peek_raw(parser)
        if symbol_matches(token, "}"):
            parser = parser_advance_raw(parser)
            break
        if token.kind.variant == "EndOfFile":
            break
        entry_start = parser
        property_result = parse_model_property(parser)
        if property_result.success  and  property_result.property != None:
            parser = property_result.parser
            properties = append_model_property(properties, property_result.property)
            continue
        parser = skip_struct_member(entry_start)
        parser = skip_trivia(parser)
        maybe_close = parser_peek_raw(parser)
        if symbol_matches(maybe_close, "}"):
            parser = parser_advance_raw(parser)
            break
        if maybe_close.kind.variant == "EndOfFile":
            break
    statement = runtime.enum_instantiate(Statement, 'ModelDeclaration', [runtime.enum_field('name', name), runtime.enum_field('name_span', name_span), runtime.enum_field('model_type', model_type), runtime.enum_field('properties', properties), runtime.enum_field('effects', effects), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_model_property(parser):
    current = skip_trivia(parser)
    name_token = parser_peek_raw(current)
    if name_token.kind.variant != "Identifier":
        return ModelPropertyParseResult(parser=parser, property=None, success=False)
    name = identifier_text(name_token)
    current = parser_advance_raw(current)
    current = skip_trivia(current)
    equals = parser_peek_raw(current)
    if not symbol_matches(equals, "="):
        return ModelPropertyParseResult(parser=parser, property=None, success=False)
    current = parser_advance_raw(current)
    capture = collect_until(skip_trivia(current), [";"])
    current = capture.parser
    value_expression = expression_from_tokens(capture.tokens)
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if not symbol_matches(terminator, ";"):
        return ModelPropertyParseResult(parser=parser, property=None, success=False)
    current = parser_advance_raw(current)
    property = ModelProperty(name=name, value=value_expression, span=source_span_from_tokens([name_token]))
    return ModelPropertyParseResult(parser=current, property=property, success=True)

def parse_pipeline(initial_parser, decorators):
    parser = initial_parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "pipeline")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    type_param_result = parse_type_parameter_clause(parser)
    parser = type_param_result.parser
    type_parameters = type_param_result.parameters
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, "(")
    parameter_result = parse_parameter_list(parser)
    parser = parameter_result.parser
    parameters = parameter_result.parameters
    parser = skip_trivia(parser)
    return_type = None
    sep_result = consume_type_separator(parser)
    if sep_result.found:
        parser = sep_result.parser
        capture = collect_until(skip_trivia(parser), ["!", "{"])
        parser = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            return_type = TypeAnnotation(text=text)
    effect_result = parse_effect_list(parser)
    parser = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    if return_type == None:
        parser = skip_trivia(parser)
        late_sep = consume_type_separator(parser)
        if late_sep.found:
            parser = late_sep.parser
            capture = collect_until(skip_trivia(parser), ["{"])
            parser = capture.parser
            text = trim_text(tokens_to_text(capture.tokens))
            if len(text) > 0:
                return_type = TypeAnnotation(text=text)
    block_result = parse_block(parser)
    parser = block_result.parser
    body = block_result.block
    signature = FunctionSignature(name=name, is_async=False, parameters=parameters, return_type=return_type, effects=inferred_effects, type_parameters=[], name_span=name_span)
    statement = runtime.enum_instantiate(Statement, 'PipelineDeclaration', [runtime.enum_field('signature', signature), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_tool(initial_parser, decorators):
    parser = initial_parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "tool")
    parser = skip_trivia(parser)
    name_token = parser_peek_raw(parser)
    name = identifier_text(name_token)
    name_span = source_span_from_tokens([name_token])
    parser = parser_advance_raw(parser)
    parser = skip_trivia(parser)
    parser = consume_symbol(parser, "(")
    parameter_result = parse_parameter_list(parser)
    parser = parameter_result.parser
    parameters = parameter_result.parameters
    parser = skip_trivia(parser)
    return_type = None
    sep_result = consume_type_separator(parser)
    if sep_result.found:
        parser = sep_result.parser
        capture = collect_until(skip_trivia(parser), ["!", "{"])
        parser = capture.parser
        text = trim_text(tokens_to_text(capture.tokens))
        if len(text) > 0:
            return_type = TypeAnnotation(text=text)
    effect_result = parse_effect_list(parser)
    parser = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    if return_type == None:
        parser = skip_trivia(parser)
        late_sep = consume_type_separator(parser)
        if late_sep.found:
            parser = late_sep.parser
            capture = collect_until(skip_trivia(parser), ["{"])
            parser = capture.parser
            text = trim_text(tokens_to_text(capture.tokens))
            if len(text) > 0:
                return_type = TypeAnnotation(text=text)
    block_result = parse_block(parser)
    parser = block_result.parser
    body = block_result.block
    signature = FunctionSignature(name=name, is_async=False, parameters=parameters, return_type=return_type, effects=inferred_effects, type_parameters=[], name_span=name_span)
    statement = runtime.enum_instantiate(Statement, 'ToolDeclaration', [runtime.enum_field('signature', signature), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_test(initial_parser, decorators):
    parser = initial_parser
    original = parser
    parser = skip_trivia(parser)
    parser = consume_keyword(parser, "test")
    name_capture = collect_until(skip_trivia(parser), ["!", "{"])
    parser = name_capture.parser
    name_text = trim_text(tokens_to_text(name_capture.tokens))
    if len(name_text) == 0:
        return parse_unknown(original)
    name_span = source_span_from_tokens(name_capture.tokens)
    name = normalize_test_name(name_text)
    effect_result = parse_effect_list(parser)
    parser = effect_result.parser
    parsed_effects = effect_result.effects
    decorator_info = evaluate_decorators(decorators)
    inferred_effects = infer_effects(parsed_effects, decorator_info)
    block_result = parse_block(parser)
    parser = block_result.parser
    body = block_result.block
    statement = runtime.enum_instantiate(Statement, 'TestDeclaration', [runtime.enum_field('name', name), runtime.enum_field('name_span', name_span), runtime.enum_field('body', body), runtime.enum_field('effects', inferred_effects), runtime.enum_field('decorators', decorators)])
    return StatementParseResult(parser=parser, statement=statement)

def parse_unknown(initial_parser):
    parser = initial_parser
    parser = skip_trivia(parser)
    tokens = []
    current = parser
    depth = 0
    iteration_limit = 16384
    iteration_count = 0
    truncated = False
    while True:
        if iteration_count >= iteration_limit:
            truncated = True
            current = parser_advance_raw(current)
            break
        iteration_count += 1
        tok = parser_peek_raw(current)
        tokens = append_token(tokens, tok)
        if symbol_matches(tok, "{"):
            depth += 1
        else:
            if symbol_matches(tok, "}"):
                if depth > 0:
                    depth -= 1
                if depth == 0:
                    current = parser_advance_raw(current)
                    break
            else:
                if depth == 0  and  symbol_matches(tok, ";"):
                    current = parser_advance_raw(current)
                    break
        if is_end_of_file(current, tok):
            current = parser_advance_raw(current)
            break
        current = parser_advance_raw(current)
    text = tokens_to_text(tokens)
    if truncated:
        text = text + " /* parse_unknown truncated */"
    block = runtime.enum_instantiate(Statement, 'Unknown', [runtime.enum_field('tokens', tokens), runtime.enum_field('text', text)])
    parser = skip_trivia(current)
    return StatementParseResult(parser=parser, statement=block)

def append_string(values, value):
    return (values) + ([value])

def append_parameter(parameters, parameter):
    return (parameters) + ([parameter])

def append_field(fields, field):
    return (fields) + ([field])

def append_method(methods, method):
    return (methods) + ([method])

def append_signature(signatures, signature):
    return (signatures) + ([signature])

def append_enum_variant(variants, variant):
    return (variants) + ([variant])

def append_type_annotation(types, item):
    return (types) + ([item])

def append_model_property(properties, property):
    return (properties) + ([property])

def append_decorator(decorators, decorator):
    return (decorators) + ([decorator])

def append_decorator_argument(arguments, argument):
    return (arguments) + ([argument])
