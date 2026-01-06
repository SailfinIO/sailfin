import asyncio
from runtime import runtime_support as runtime

from ..token import Token, TokenKind
from ..ast import Block, Expression, ObjectField, Parameter, TypeAnnotation
from ..string_utils import substring, char_code, char_at, strings_equal
from compiler.build.parser.types import Parser, ExpressionTokens, ExpressionParseResult, ExpressionTypeSeparatorParseResult, ExpressionCollectResult, ExpressionBlockParseResult, LambdaParameterParseResult, LambdaParameterListParseResult, CallArgumentsParseResult, ArrayLiteralParseResult, ObjectLiteralParseResult, StructTypeNameResult, BlockParseResult
from compiler.build.parser.utils import trim_text, string_array_contains
from compiler.build.parser.token_utils import identifier_matches, symbol_matches, identifier_text, string_literal_value, token_slice, trim_token_edges, filter_trivia, tokens_to_text, source_span_from_tokens, append_token, parser_peek_raw, parser_advance_raw, skip_trivia

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

def expression_tokens_is_at_end(state):
    return state.index >= len(state.tokens)

def expression_tokens_peek(state):
    return state.tokens[state.index]

def expression_tokens_advance(state):
    if state.index >= len(state.tokens):
        return state
    return ExpressionTokens(tokens=state.tokens, index=state.index + 1)

def expression_parse_failure(state):
    return ExpressionParseResult(state=state, expression=runtime.enum_instantiate(Expression, 'Raw', [runtime.enum_field('text', "")]), success=False)

def expression_tokens_consume_type_separator(state, accept_colon, accept_arrow):
    if expression_tokens_is_at_end(state):
        return ExpressionTypeSeparatorParseResult(state=state, used_separator="", found=False)
    token = expression_tokens_peek(state)
    if token.kind.variant != "Symbol":
        return ExpressionTypeSeparatorParseResult(state=state, used_separator="", found=False)
    if accept_colon  and  symbol_matches(token, ":"):
        return ExpressionTypeSeparatorParseResult(state=expression_tokens_advance(state), used_separator=":", found=True)
    if accept_arrow:
        if symbol_matches(token, "->"):
            return ExpressionTypeSeparatorParseResult(state=expression_tokens_advance(state), used_separator="->", found=True)
        if symbol_matches(token, "-"):
            next_state = expression_tokens_advance(state)
            if not expression_tokens_is_at_end(next_state):
                maybe_gt = expression_tokens_peek(next_state)
                if maybe_gt.kind.variant == "Symbol"  and  symbol_matches(maybe_gt, ">"):
                    next_state = expression_tokens_advance(next_state)
            return ExpressionTypeSeparatorParseResult(state=next_state, used_separator="->", found=True)
    return ExpressionTypeSeparatorParseResult(state=state, used_separator="", found=False)

def expression_tokens_collect_until(state, terminators):
    current = state
    collected = []
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    while True:
        if expression_tokens_is_at_end(current):
            return ExpressionCollectResult(state=current, tokens=collected, success=False)
        token = expression_tokens_peek(current)
        at_top = angle == 0  and  paren == 0  and  brace == 0  and  bracket == 0
        if at_top  and  token.kind.variant == "Symbol"  and  string_array_contains(terminators, token.lexeme):
            break
        if token.kind.variant == "Symbol":
            sym = token.lexeme
            if strings_equal(sym, "<"):
                angle += 1
            else:
                if strings_equal(sym, ">"):
                    if angle > 0:
                        angle -= 1
                else:
                    if strings_equal(sym, "("):
                        paren += 1
                    else:
                        if strings_equal(sym, ")"):
                            if paren > 0:
                                paren -= 1
                        else:
                            if strings_equal(sym, "{"):
                                brace += 1
                            else:
                                if strings_equal(sym, "}"):
                                    if brace > 0:
                                        brace -= 1
                                else:
                                    if strings_equal(sym, "["):
                                        bracket += 1
                                    else:
                                        if strings_equal(sym, "]"):
                                            if bracket > 0:
                                                bracket -= 1
        collected = append_token(collected, token)
        current = expression_tokens_advance(current)
    return ExpressionCollectResult(state=current, tokens=collected, success=True)

def collect_expression_block(state):
    current = state
    if expression_tokens_is_at_end(current):
        return ExpressionBlockParseResult(state=current, tokens=[], success=False)
    first = expression_tokens_peek(current)
    if not symbol_matches(first, "{"):
        return ExpressionBlockParseResult(state=current, tokens=[], success=False)
    tokens = []
    depth = 0
    while True:
        if expression_tokens_is_at_end(current):
            return ExpressionBlockParseResult(state=current, tokens=tokens, success=False)
        token = expression_tokens_peek(current)
        tokens = append_token(tokens, token)
        if token.kind.variant == "Symbol":
            sym = token.lexeme
            if strings_equal(sym, "{"):
                depth += 1
            else:
                if strings_equal(sym, "}"):
                    depth -= 1
                    if depth == 0:
                        current = expression_tokens_advance(current)
                        break
        current = expression_tokens_advance(current)
    return ExpressionBlockParseResult(state=current, tokens=tokens, success=True)

def expression_from_tokens(tokens):
    filtered = filter_trivia(tokens)
    if len(filtered) == 0:
        return runtime.enum_instantiate(Expression, 'Raw', [runtime.enum_field('text', "")])
    if len(filtered) == 1:
        single = expression_from_single_token(filtered[0])
        if single != None:
            return single
    state = ExpressionTokens(tokens=filtered, index=0)
    result = parse_expression_bp(state, 0)
    if not result.success:
        return runtime.enum_instantiate(Expression, 'Raw', [runtime.enum_field('text', trim_text(tokens_to_text(tokens)))])
    if result.state.index != len(result.state.tokens):
        return runtime.enum_instantiate(Expression, 'Raw', [runtime.enum_field('text', trim_text(tokens_to_text(tokens)))])
    return result.expression

def expression_from_single_token(token):
    if token.kind.variant == "NumberLiteral":
        return runtime.enum_instantiate(Expression, 'NumberLiteral', [runtime.enum_field('value', token.lexeme)])
    if token.kind.variant == "BooleanLiteral":
        return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', token.lexeme)])
    if token.kind.variant == "StringLiteral":
        return runtime.enum_instantiate(Expression, 'StringLiteral', [runtime.enum_field('value', string_literal_value(token))])
    if token.kind.variant == "Identifier":
        value = identifier_text(token)
        if strings_equal(value, "true"):
            return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', "true")])
        if strings_equal(value, "false"):
            return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', "false")])
        if strings_equal(value, "null"):
            return Expression.NullLiteral()
        return runtime.enum_instantiate(Expression, 'Identifier', [runtime.enum_field('name', value)])
    return None

def parse_expression_bp(state, min_precedence):
    prefix_result = parse_prefix_expression(state)
    if not prefix_result.success:
        return prefix_result
    current_state = prefix_result.state
    left_expression = prefix_result.expression
    while True:
        if expression_tokens_is_at_end(current_state):
            break
        token = expression_tokens_peek(current_state)
        if token.kind.variant != "Symbol":
            break
        op = token.lexeme
        precedence = binary_precedence(op)
        if precedence == -1:
            break
        if precedence < min_precedence:
            break
        current_state = expression_tokens_advance(current_state)
        rhs_result = parse_expression_bp(current_state, precedence + 1)
        if not rhs_result.success:
            return expression_parse_failure(state)
        current_state = rhs_result.state
        if op == "..":
            left_expression = runtime.enum_instantiate(Expression, 'Range', [runtime.enum_field('start', left_expression), runtime.enum_field('end', rhs_result.expression)])
        else:
            left_expression = runtime.enum_instantiate(Expression, 'Binary', [runtime.enum_field('operator', op), runtime.enum_field('left', left_expression), runtime.enum_field('right', rhs_result.expression)])
    return ExpressionParseResult(state=current_state, expression=left_expression, success=True)

def parse_prefix_expression(state):
    if expression_tokens_is_at_end(state):
        return expression_parse_failure(state)
    token = expression_tokens_peek(state)
    if token.kind.variant == "Symbol":
        sym = token.lexeme
        if strings_equal(sym, "-")  or  strings_equal(sym, "!"):
            advanced = expression_tokens_advance(state)
            operand_result = parse_expression_bp(advanced, unary_precedence())
            if not operand_result.success:
                return operand_result
            return ExpressionParseResult(state=operand_result.state, expression=runtime.enum_instantiate(Expression, 'Unary', [runtime.enum_field('operator', sym), runtime.enum_field('operand', operand_result.expression)]), success=True)
    if token.kind.variant == "Identifier"  and  identifier_matches(token, "fn"):
        lambda_result = parse_lambda_expression(state)
        if lambda_result.success:
            return lambda_result
    primary_result = parse_primary_expression(state)
    if not primary_result.success:
        return primary_result
    return parse_postfix_chain(primary_result.state, primary_result.expression)

def parse_primary_expression(state):
    if expression_tokens_is_at_end(state):
        return expression_parse_failure(state)
    token = expression_tokens_peek(state)
    if token.kind.variant == "NumberLiteral":
        return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'NumberLiteral', [runtime.enum_field('value', token.lexeme)]), success=True)
    if token.kind.variant == "BooleanLiteral":
        return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', token.lexeme)]), success=True)
    if token.kind.variant == "StringLiteral":
        return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'StringLiteral', [runtime.enum_field('value', string_literal_value(token))]), success=True)
    if token.kind.variant == "Identifier":
        name = identifier_text(token)
        if strings_equal(name, "true"):
            return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', "true")]), success=True)
        if strings_equal(name, "false"):
            return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', "false")]), success=True)
        if strings_equal(name, "null"):
            return ExpressionParseResult(state=expression_tokens_advance(state), expression=Expression.NullLiteral(), success=True)
        return ExpressionParseResult(state=expression_tokens_advance(state), expression=runtime.enum_instantiate(Expression, 'Identifier', [runtime.enum_field('name', name)]), success=True)
    if symbol_matches(token, "("):
        inner_state = expression_tokens_advance(state)
        inner_result = parse_expression_bp(inner_state, 0)
        if not inner_result.success:
            return inner_result
        after_inner = inner_result.state
        if expression_tokens_is_at_end(after_inner):
            return expression_parse_failure(state)
        closing = expression_tokens_peek(after_inner)
        if not symbol_matches(closing, ")"):
            return expression_parse_failure(state)
        return ExpressionParseResult(state=expression_tokens_advance(after_inner), expression=inner_result.expression, success=True)
    if symbol_matches(token, "["):
        array_result = parse_array_literal(expression_tokens_advance(state))
        if not array_result.success:
            return expression_parse_failure(state)
        return ExpressionParseResult(state=array_result.state, expression=runtime.enum_instantiate(Expression, 'Array', [runtime.enum_field('elements', array_result.elements)]), success=True)
    if symbol_matches(token, "{"):
        object_result = parse_object_literal(expression_tokens_advance(state))
        if not object_result.success:
            return expression_parse_failure(state)
        return ExpressionParseResult(state=object_result.state, expression=runtime.enum_instantiate(Expression, 'Object', [runtime.enum_field('fields', object_result.fields)]), success=True)
    return expression_parse_failure(state)

def parse_postfix_chain(state, expression):
    current_state = state
    current_expression = expression
    while True:
        if expression_tokens_is_at_end(current_state):
            break
        token = expression_tokens_peek(current_state)
        if token.kind.variant != "Symbol":
            break
        sym = token.lexeme
        if strings_equal(sym, "."):
            after_dot = expression_tokens_advance(current_state)
            if expression_tokens_is_at_end(after_dot):
                return expression_parse_failure(state)
            member_token = expression_tokens_peek(after_dot)
            if member_token.kind.variant != "Identifier":
                return expression_parse_failure(state)
            current_state = expression_tokens_advance(after_dot)
            current_expression = runtime.enum_instantiate(Expression, 'Member', [runtime.enum_field('object', current_expression), runtime.enum_field('member', identifier_text(member_token))])
            continue
        if strings_equal(sym, "("):
            call_result = parse_call_arguments(current_state)
            if not call_result.success:
                return expression_parse_failure(state)
            current_state = call_result.state
            current_expression = runtime.enum_instantiate(Expression, 'Call', [runtime.enum_field('callee', current_expression), runtime.enum_field('arguments', call_result.arguments)])
            continue
        if strings_equal(sym, "["):
            index_state = expression_tokens_advance(current_state)
            index_result = parse_expression_bp(index_state, 0)
            if not index_result.success:
                return expression_parse_failure(state)
            after_index = index_result.state
            if expression_tokens_is_at_end(after_index):
                return expression_parse_failure(state)
            closing = expression_tokens_peek(after_index)
            if not symbol_matches(closing, "]"):
                return expression_parse_failure(state)
            current_state = expression_tokens_advance(after_index)
            current_expression = runtime.enum_instantiate(Expression, 'Index', [runtime.enum_field('sequence', current_expression), runtime.enum_field('index', index_result.expression)])
            continue
        if strings_equal(sym, "{"):
            if not expression_is_struct_target(current_expression):
                break
            struct_result = parse_struct_literal(expression_tokens_advance(current_state), current_expression)
            if not struct_result.success:
                return expression_parse_failure(state)
            current_state = struct_result.state
            current_expression = struct_result.expression
            continue
        break
    return ExpressionParseResult(state=current_state, expression=current_expression, success=True)

def parse_call_arguments(state):
    current = expression_tokens_advance(state)
    arguments = []
    if expression_tokens_is_at_end(current):
        return CallArgumentsParseResult(state=state, arguments=[], success=False)
    closing_token = expression_tokens_peek(current)
    if closing_token.kind.variant == "Symbol"  and  symbol_matches(closing_token, ")"):
        current = expression_tokens_advance(current)
        return CallArgumentsParseResult(state=current, arguments=arguments, success=True)
    while True:
        argument_result = parse_expression_bp(current, 0)
        if not argument_result.success:
            return CallArgumentsParseResult(state=state, arguments=[], success=False)
        arguments = append_expression(arguments, argument_result.expression)
        current = argument_result.state
        if expression_tokens_is_at_end(current):
            return CallArgumentsParseResult(state=state, arguments=[], success=False)
        separator = expression_tokens_peek(current)
        if symbol_matches(separator, ","):
            current = expression_tokens_advance(current)
            continue
        if symbol_matches(separator, ")"):
            current = expression_tokens_advance(current)
            break
        return CallArgumentsParseResult(state=state, arguments=[], success=False)
    return CallArgumentsParseResult(state=current, arguments=arguments, success=True)

def parse_array_literal(state):
    current = state
    elements = []
    if expression_tokens_is_at_end(current):
        return ArrayLiteralParseResult(state=state, elements=[], success=False)
    closing_bracket = expression_tokens_peek(current)
    if closing_bracket.kind.variant == "Symbol"  and  symbol_matches(closing_bracket, "]"):
        current = expression_tokens_advance(current)
        return ArrayLiteralParseResult(state=current, elements=elements, success=True)
    while True:
        element_result = parse_expression_bp(current, 0)
        if not element_result.success:
            return ArrayLiteralParseResult(state=state, elements=[], success=False)
        elements = append_expression(elements, element_result.expression)
        current = element_result.state
        if expression_tokens_is_at_end(current):
            return ArrayLiteralParseResult(state=state, elements=[], success=False)
        separator = expression_tokens_peek(current)
        if symbol_matches(separator, ","):
            current = expression_tokens_advance(current)
            if expression_tokens_is_at_end(current):
                return ArrayLiteralParseResult(state=state, elements=[], success=False)
            maybe_end = expression_tokens_peek(current)
            if symbol_matches(maybe_end, "]"):
                current = expression_tokens_advance(current)
                break
            continue
        if symbol_matches(separator, "]"):
            current = expression_tokens_advance(current)
            break
        return ArrayLiteralParseResult(state=state, elements=[], success=False)
    return ArrayLiteralParseResult(state=current, elements=elements, success=True)

def parse_object_literal(state):
    current = state
    fields = []
    if expression_tokens_is_at_end(current):
        return ObjectLiteralParseResult(state=state, fields=[], success=False)
    closing_brace = expression_tokens_peek(current)
    if closing_brace.kind.variant == "Symbol"  and  symbol_matches(closing_brace, "}"):
        current = expression_tokens_advance(current)
        return ObjectLiteralParseResult(state=current, fields=fields, success=True)
    while True:
        if expression_tokens_is_at_end(current):
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        name_token = expression_tokens_peek(current)
        if name_token.kind.variant != "Identifier":
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        field_name = identifier_text(name_token)
        current = expression_tokens_advance(current)
        if expression_tokens_is_at_end(current):
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        colon = expression_tokens_peek(current)
        if not symbol_matches(colon, ":"):
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        current = expression_tokens_advance(current)
        value_result = parse_expression_bp(current, 0)
        if not value_result.success:
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        current = value_result.state
        fields = append_object_field(fields, ObjectField(name=field_name, value=value_result.expression))
        if expression_tokens_is_at_end(current):
            return ObjectLiteralParseResult(state=state, fields=[], success=False)
        separator = expression_tokens_peek(current)
        if symbol_matches(separator, ","):
            current = expression_tokens_advance(current)
            if expression_tokens_is_at_end(current):
                return ObjectLiteralParseResult(state=state, fields=[], success=False)
            maybe_end = expression_tokens_peek(current)
            if symbol_matches(maybe_end, "}"):
                current = expression_tokens_advance(current)
                break
            continue
        if symbol_matches(separator, "}"):
            current = expression_tokens_advance(current)
            break
        return ObjectLiteralParseResult(state=state, fields=[], success=False)
    return ObjectLiteralParseResult(state=current, fields=fields, success=True)

def parse_struct_literal(state, target):
    type_result = collect_struct_type_name(target)
    if not type_result.success:
        return expression_parse_failure(state)
    fields_result = parse_object_literal(state)
    if not fields_result.success:
        return expression_parse_failure(state)
    return ExpressionParseResult(state=fields_result.state, expression=runtime.enum_instantiate(Expression, 'Struct', [runtime.enum_field('type_name', type_result.parts), runtime.enum_field('fields', fields_result.fields)]), success=True)

def expression_is_struct_target(expression):
    if expression.variant == "Identifier":
        return True
    if expression.variant == "Member":
        return expression_is_struct_target(expression.object)
    return False

def collect_struct_type_name(expression):
    if expression.variant == "Identifier":
        return StructTypeNameResult(parts=[expression.name], success=True)
    if expression.variant == "Member":
        inner = collect_struct_type_name(expression.object)
        if not inner.success:
            return StructTypeNameResult(parts=[], success=False)
        return StructTypeNameResult(parts=append_string_local(inner.parts, expression.member), success=True)
    return StructTypeNameResult(parts=[], success=False)

def parse_lambda_expression(state):
    current = state
    if expression_tokens_is_at_end(current):
        return expression_parse_failure(state)
    token = expression_tokens_peek(current)
    if token.kind.variant != "Identifier"  or  not identifier_matches(token, "fn"):
        return expression_parse_failure(state)
    current = expression_tokens_advance(current)
    if expression_tokens_is_at_end(current):
        return expression_parse_failure(state)
    open_paren = expression_tokens_peek(current)
    if not symbol_matches(open_paren, "("):
        return expression_parse_failure(state)
    current = expression_tokens_advance(current)
    params_result = parse_lambda_parameter_list(current)
    if not params_result.success:
        return expression_parse_failure(state)
    current = params_result.state
    parameters = params_result.parameters
    return_type = None
    if not expression_tokens_is_at_end(current):
        sep_result = expression_tokens_consume_type_separator(current, True, True)
        if sep_result.found:
            current = sep_result.state
            capture = expression_tokens_collect_until(current, ["{"])
            if not capture.success:
                return expression_parse_failure(state)
            type_text = trim_text(tokens_to_text(capture.tokens))
            if len(type_text) > 0:
                return_type = TypeAnnotation(text=type_text)
            current = capture.state
    if expression_tokens_is_at_end(current):
        return expression_parse_failure(state)
    block_result = collect_expression_block(current)
    if not block_result.success:
        return expression_parse_failure(state)
    current = block_result.state
    block_tokens = block_result.tokens
    block_tokens = append_token(block_tokens, Token(kind=TokenKind.EndOfFile(), lexeme="", line=0, column=0))
    block_parser = Parser(tokens=block_tokens, index=0)
    parsed_block = parse_block_for_lambda(block_parser)
    body = parsed_block.block
    return ExpressionParseResult(state=current, expression=runtime.enum_instantiate(Expression, 'Lambda', [runtime.enum_field('parameters', parameters), runtime.enum_field('body', body), runtime.enum_field('return_type', return_type)]), success=True)

def parse_lambda_parameter(state):
    current = state
    if expression_tokens_is_at_end(current):
        return LambdaParameterParseResult(state=current, parameter=Parameter(name="", type_annotation=None, default_value=None, mutable=False, span=None), success=False)
    start_index = current.index
    is_mutable = False
    token = expression_tokens_peek(current)
    if token.kind.variant == "Identifier"  and  identifier_matches(token, "mut"):
        is_mutable = True
        current = expression_tokens_advance(current)
        if expression_tokens_is_at_end(current):
            return LambdaParameterParseResult(state=current, parameter=Parameter(name="", type_annotation=None, default_value=None, mutable=False, span=None), success=False)
    name_token = expression_tokens_peek(current)
    if name_token.kind.variant != "Identifier":
        return LambdaParameterParseResult(state=current, parameter=Parameter(name="", type_annotation=None, default_value=None, mutable=False, span=None), success=False)
    name = identifier_text(name_token)
    current = expression_tokens_advance(current)
    type_annotation = None
    if not expression_tokens_is_at_end(current):
        sep_result = expression_tokens_consume_type_separator(current, True, True)
        if sep_result.found:
            current = sep_result.state
            capture = expression_tokens_collect_until(current, ["=", ",", ")"])
            if not capture.success:
                return LambdaParameterParseResult(state=current, parameter=Parameter(name=name, type_annotation=None, default_value=None, mutable=is_mutable, span=None), success=False)
            type_text = trim_text(tokens_to_text(capture.tokens))
            if len(type_text) > 0:
                type_annotation = TypeAnnotation(text=type_text)
            current = capture.state
    default_value = None
    if not expression_tokens_is_at_end(current):
        assign = expression_tokens_peek(current)
        if symbol_matches(assign, "="):
            current = expression_tokens_advance(current)
            capture = expression_tokens_collect_until(current, [",", ")"])
            if not capture.success:
                return LambdaParameterParseResult(state=current, parameter=Parameter(name=name, type_annotation=type_annotation, default_value=None, mutable=is_mutable, span=None), success=False)
            default_value = expression_from_tokens(capture.tokens)
            current = capture.state
    parameter_tokens = token_slice(state.tokens, start_index, current.index)
    span = source_span_from_tokens(parameter_tokens)
    parameter = Parameter(name=name, type_annotation=type_annotation, default_value=default_value, mutable=is_mutable, span=span)
    return LambdaParameterParseResult(state=current, parameter=parameter, success=True)

def parse_lambda_parameter_list(state):
    current = state
    parameters = []
    if expression_tokens_is_at_end(current):
        return LambdaParameterListParseResult(state=current, parameters=parameters, success=False)
    closing = expression_tokens_peek(current)
    if symbol_matches(closing, ")"):
        current = expression_tokens_advance(current)
        return LambdaParameterListParseResult(state=current, parameters=parameters, success=True)
    while True:
        param_result = parse_lambda_parameter(current)
        if not param_result.success:
            return LambdaParameterListParseResult(state=current, parameters=parameters, success=False)
        parameters = append_parameter(parameters, param_result.parameter)
        current = param_result.state
        if expression_tokens_is_at_end(current):
            return LambdaParameterListParseResult(state=current, parameters=parameters, success=False)
        separator = expression_tokens_peek(current)
        if separator.kind.variant == "Symbol":
            if symbol_matches(separator, ","):
                current = expression_tokens_advance(current)
                continue
            if symbol_matches(separator, ")"):
                current = expression_tokens_advance(current)
                break
        return LambdaParameterListParseResult(state=current, parameters=parameters, success=False)
    return LambdaParameterListParseResult(state=current, parameters=parameters, success=True)

def binary_precedence(op):
    if op == "..":
        return 0
    if op == "||":
        return 1
    if op == "&&":
        return 2
    if op == "=="  or  op == "!=":
        return 3
    if op == "<"  or  op == "<="  or  op == ">"  or  op == ">=":
        return 4
    if op == "+"  or  op == "-":
        return 5
    if op == "*"  or  op == "/"  or  op == "%":
        return 6
    return -1

def unary_precedence():
    return 7

def normalize_expression(tokens, expr):
    if expr.variant == "Raw":
        filtered = filter_trivia(tokens)
        if len(filtered) == 1:
            token = filtered[0]
            if token.kind.variant == "StringLiteral":
                return runtime.enum_instantiate(Expression, 'StringLiteral', [runtime.enum_field('value', string_literal_value(token))])
            if token.kind.variant == "BooleanLiteral":
                return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', token.lexeme)])
            if token.kind.variant == "NumberLiteral":
                return runtime.enum_instantiate(Expression, 'NumberLiteral', [runtime.enum_field('value', token.lexeme)])
        raw_text = trim_text(expr.text)
        if len(raw_text) >= 2  and  char_at(raw_text, 0) == "\""  and  char_at(raw_text, len(raw_text) - 1) == "\"":
            literal = strip_surrounding_quotes_expr(raw_text)
            return runtime.enum_instantiate(Expression, 'StringLiteral', [runtime.enum_field('value', literal)])
        if raw_text == "true":
            return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', "true")])
        if raw_text == "false":
            return runtime.enum_instantiate(Expression, 'BooleanLiteral', [runtime.enum_field('value', "false")])
        if looks_like_number_expr(raw_text):
            return runtime.enum_instantiate(Expression, 'NumberLiteral', [runtime.enum_field('value', raw_text)])
    return expr

def strip_surrounding_quotes_expr(text):
    if len(text) < 2:
        return text
    first = char_code(char_at(text, 0))
    last = char_code(char_at(text, len(text) - 1))
    if first == 34  and  last == 34:
        return substring(text, 1, len(text) - 1)
    return text

def looks_like_number_expr(text):
    if len(text) == 0:
        return False
    has_decimal = False
    index = 0
    if char_at(text, 0) == "-":
        if len(text) == 1:
            return False
        index = 1
    while True:
        if index >= len(text):
            break
        ch = char_at(text, index)
        if ch == ".":
            if has_decimal:
                return False
            has_decimal = True
            index += 1
            continue
        if not is_decimal_digit_expr(ch):
            return False
        index += 1
    return True

def is_decimal_digit_expr(ch):
    return ch == "0"  or  ch == "1"  or  ch == "2"  or  ch == "3"  or  ch == "4"  or  ch == "5"  or  ch == "6"  or  ch == "7"  or  ch == "8"  or  ch == "9"

def append_expression(expressions, expression):
    expressions.append(expression)
    return expressions

def append_object_field(fields, field):
    fields.append(field)
    return fields

def append_parameter(parameters, parameter):
    return (parameters) + ([parameter])

def append_string_local(values, value):
    return (values) + ([value])

def parse_block_for_lambda(parser):
    current = parser
    current = skip_trivia(current)
    token = parser_peek_raw(current)
    if not symbol_matches(token, "{"):
        return BlockParseResult(parser=current, block=Block(tokens=[], text="", statements=[]))
    start_index = current.index
    block_end_index = start_index
    current = parser_advance_raw(current)
    depth = 1
    while True:
        current = skip_trivia(current)
        tok = parser_peek_raw(current)
        if symbol_matches(tok, "}"):
            depth -= 1
            if depth == 0:
                block_end_index = current.index + 1
                current = parser_advance_raw(current)
                break
        if symbol_matches(tok, "{"):
            depth += 1
        if tok.kind.variant == "EndOfFile":
            break
        current = parser_advance_raw(current)
    end_index = current.index
    if block_end_index > start_index:
        end_index = block_end_index
    block_tokens = token_slice(parser.tokens, start_index, end_index)
    text = tokens_to_text(block_tokens)
    block = Block(tokens=block_tokens, text=text, statements=[])
    return BlockParseResult(parser=skip_trivia(current), block=block)
