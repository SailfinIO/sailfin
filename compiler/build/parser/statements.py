import asyncio
from runtime import runtime_support as runtime

from ..token import Token
from ..ast import Block, Decorator, Expression, Statement, MatchCase, ElseBranch, ForClause, WithClause, SourceSpan
from ..string_utils import substring, char_code, char_at, strings_equal
from compiler.build.parser.types import Parser, StatementParseResult, BlockStatementParseResult, BlockParseResult, DecoratorParseResult, MatchCasesParseResult, MatchCaseParseResult, MatchCaseTokenSplit
from compiler.build.parser.utils import trim_text
from compiler.build.parser.token_utils import parser_peek_raw, parser_advance_raw, skip_trivia, identifier_matches, symbol_matches, identifier_text, string_literal_value, consume_keyword, consume_symbol, collect_until, collect_pattern_until_arrow, token_slice, trim_token_edges, tokens_to_text, source_span_from_tokens, append_token, find_top_level_identifier, split_token_slices_by_comma
from compiler.build.parser.expressions import expression_from_tokens

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

def parse_decorators_stub(parser):
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
        after = parser_peek_raw(current)
        if symbol_matches(after, "("):
            depth = 1
            current = parser_advance_raw(current)
            while True:
                tok = parser_peek_raw(current)
                if tok.kind.variant == "EndOfFile":
                    break
                if tok.kind.variant == "Symbol":
                    if strings_equal(tok.lexeme, "("):
                        depth += 1
                    else:
                        if strings_equal(tok.lexeme, ")"):
                            depth -= 1
                            if depth == 0:
                                current = parser_advance_raw(current)
                                break
                current = parser_advance_raw(current)
        decorators = append_decorator(decorators, Decorator(name=name, arguments=[]))
    return DecoratorParseResult(parser=current, decorators=decorators)

def parse_block(initial_parser):
    parser = initial_parser
    parser = skip_trivia(parser)
    token = parser_peek_raw(parser)
    if not symbol_matches(token, "{"):
        return BlockParseResult(parser=parser, block=Block(tokens=[], text="", statements=[]))
    start_index = parser.index
    current = parser_advance_raw(parser)
    block_end_index = start_index
    statements = []
    while True:
        current = skip_trivia(current)
        tok = parser_peek_raw(current)
        if symbol_matches(tok, "}"):
            block_end_index = current.index + 1
            current = parser_advance_raw(current)
            break
        if tok.kind.variant == "EndOfFile":
            break
        block_result = parse_block_statement(current)
        if block_result.success:
            current = block_result.parser
            if block_result.statement != None:
                statements = append_statement(statements, block_result.statement)
            continue
        before_index = current.index
        unknown_result = parse_unknown_statement(current)
        current = unknown_result.parser
        if unknown_result.statement.variant == "Unknown":
            statements = append_statement(statements, unknown_result.statement)
        if current.index <= before_index:
            current = parser_advance_raw(current)
    end_index = current.index
    if block_end_index > start_index:
        end_index = block_end_index
    block_tokens = token_slice(parser.tokens, start_index, end_index)
    block_tokens = trim_block_tokens_local(block_tokens)
    text = tokens_to_text(block_tokens)
    block = Block(tokens=block_tokens, text=text, statements=statements)
    return BlockParseResult(parser=skip_trivia(current), block=block)

def trim_block_tokens_local(tokens):
    depth = 0
    index = 0
    end = len(tokens)
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.lexeme
            if strings_equal(sym, "{"):
                depth += 1
            else:
                if strings_equal(sym, "}"):
                    if depth > 0:
                        depth -= 1
                    if depth == 0:
                        end = index + 1
                        break
        index += 1
    return token_slice(tokens, 0, end)

def parse_block_statement(parser):
    original = parser
    decorator_result = parse_decorators_stub(parser)
    current = decorator_result.parser
    decorators = decorator_result.decorators
    after_decorators = skip_trivia(current)
    token = parser_peek_raw(after_decorators)
    if symbol_matches(token, "{"):
        if len(decorators) > 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        body_result = parse_block(after_decorators)
        return BlockStatementParseResult(parser=body_result.parser, statement=runtime.enum_instantiate(Statement, 'BlockStatement', [runtime.enum_field('body', body_result.block)]), success=True)
    if identifier_matches(token, "for"):
        return parse_for_statement(after_decorators, decorators)
    if identifier_matches(token, "loop"):
        return parse_loop_statement(after_decorators, decorators)
    if identifier_matches(token, "break"):
        if len(decorators) > 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        return parse_break_statement(after_decorators)
    if identifier_matches(token, "continue"):
        if len(decorators) > 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        return parse_continue_statement(after_decorators)
    if identifier_matches(token, "if"):
        return parse_if_statement(after_decorators, decorators)
    if identifier_matches(token, "match"):
        return parse_match_statement(after_decorators, decorators)
    if identifier_matches(token, "prompt"):
        return parse_prompt_statement(after_decorators, decorators)
    if identifier_matches(token, "with"):
        return parse_with_statement(after_decorators, decorators)
    if identifier_matches(token, "unsafe"):
        if len(decorators) > 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        unsafe_current = consume_keyword(after_decorators, "unsafe")
        unsafe_current = skip_trivia(unsafe_current)
        body_result = parse_block(unsafe_current)
        return BlockStatementParseResult(parser=body_result.parser, statement=runtime.enum_instantiate(Statement, 'BlockStatement', [runtime.enum_field('body', body_result.block)]), success=True)
    if identifier_matches(token, "return"):
        if len(decorators) > 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        return parse_return_statement(after_decorators)
    if identifier_matches(token, "throw"):
        if len(decorators) > 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        return parse_throw_statement(after_decorators)
    if identifier_matches(token, "try"):
        if len(decorators) > 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        return parse_try_statement(after_decorators)
    if identifier_matches(token, "assert"):
        if len(decorators) > 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        return parse_assert_statement(after_decorators)
    expression_result = parse_expression_statement(after_decorators, decorators)
    if expression_result.success:
        return expression_result
    return BlockStatementParseResult(parser=original, statement=None, success=False)

def parse_for_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "for"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "for")
    clause_capture = collect_until(skip_trivia(current), ["{"])
    current = clause_capture.parser
    clause_tokens = trim_token_edges(clause_capture.tokens)
    if len(clause_tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    in_index = find_top_level_identifier(clause_tokens, "in")
    if in_index == -1:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    target_tokens = trim_token_edges(token_slice(clause_tokens, 0, in_index))
    iterable_tokens = trim_token_edges(token_slice(clause_tokens, in_index + 1, len(clause_tokens)))
    if len(target_tokens) == 0  or  len(iterable_tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    target_expression = expression_from_tokens(target_tokens)
    iterable_expression = expression_from_tokens(iterable_tokens)
    clause = ForClause(target=target_expression, iterable=iterable_expression, tokens=clause_tokens)
    body_result = parse_block(current)
    if len(body_result.block.tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = body_result.parser
    body = body_result.block
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if symbol_matches(terminator, ";"):
        current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'ForStatement', [runtime.enum_field('clause', clause), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)

def parse_loop_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "loop"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "loop")
    body_result = parse_block(current)
    if len(body_result.block.tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = body_result.parser
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if symbol_matches(terminator, ";"):
        current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'LoopStatement', [runtime.enum_field('body', body_result.block), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)

def parse_break_statement(parser):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "break"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "break")
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if symbol_matches(terminator, ";"):
        current = parser_advance_raw(current)
    return BlockStatementParseResult(parser=current, statement=Statement.BreakStatement(), success=True)

def parse_continue_statement(parser):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "continue"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "continue")
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if symbol_matches(terminator, ";"):
        current = parser_advance_raw(current)
    return BlockStatementParseResult(parser=current, statement=Statement.ContinueStatement(), success=True)

def parse_if_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "if"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "if")
    condition_capture = collect_until(skip_trivia(current), ["{"])
    current = condition_capture.parser
    condition_tokens = trim_token_edges(condition_capture.tokens)
    if len(condition_tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    condition_expression = expression_from_tokens(condition_tokens)
    then_result = parse_block(current)
    if len(then_result.block.tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = then_result.parser
    then_block = then_result.block
    current = skip_trivia(current)
    else_branch = None
    if identifier_matches(parser_peek_raw(current), "else"):
        current = consume_keyword(current, "else")
        current = skip_trivia(current)
        next_token = parser_peek_raw(current)
        if identifier_matches(next_token, "if"):
            nested_result = parse_if_statement(current, [])
            if not nested_result.success:
                return BlockStatementParseResult(parser=original, statement=None, success=False)
            if nested_result.statement == None:
                return BlockStatementParseResult(parser=original, statement=None, success=False)
            current = nested_result.parser
            else_branch = ElseBranch(statement=nested_result.statement, body=None)
        else:
            else_result = parse_block(current)
            if len(else_result.block.tokens) == 0:
                return BlockStatementParseResult(parser=original, statement=None, success=False)
            current = else_result.parser
            else_branch = ElseBranch(statement=None, body=else_result.block)
        current = skip_trivia(current)
        terminator = parser_peek_raw(current)
        if symbol_matches(terminator, ";"):
            current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'IfStatement', [runtime.enum_field('condition', condition_expression), runtime.enum_field('then_block', then_block), runtime.enum_field('else_branch', else_branch), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)

def parse_match_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "match"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "match")
    value_capture = collect_until(skip_trivia(current), ["{"])
    current = value_capture.parser
    value_tokens = trim_token_edges(value_capture.tokens)
    if len(value_tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    match_expression = expression_from_tokens(value_tokens)
    body_result = parse_match_cases(current)
    if not body_result.success:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = body_result.parser
    current = skip_trivia(current)
    if current.index < len(current.tokens):
        terminator = parser_peek_raw(current)
        if symbol_matches(terminator, ";"):
            current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'MatchStatement', [runtime.enum_field('expression', match_expression), runtime.enum_field('cases', body_result.cases), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)

def parse_match_cases(parser):
    current = skip_trivia(parser)
    current = advance_to_symbol_local(current, "{")
    peek = parser_peek_raw(current)
    if not symbol_matches(peek, "{"):
        return MatchCasesParseResult(parser=parser, cases=[], success=False)
    current = parser_advance_raw(current)
    cases = []
    while True:
        current = skip_trivia(current)
        token = parser_peek_raw(current)
        if symbol_matches(token, "}"):
            current = parser_advance_raw(current)
            break
        if token.kind.variant == "EndOfFile":
            return MatchCasesParseResult(parser=parser, cases=[], success=False)
        case_result = parse_match_case(current)
        if not case_result.success  or  case_result.case == None:
            return MatchCasesParseResult(parser=parser, cases=[], success=False)
        current = case_result.parser
        cases = append_match_case(cases, case_result.case)
        current = skip_trivia(current)
        separator = parser_peek_raw(current)
        if symbol_matches(separator, ","):
            current = parser_advance_raw(current)
    return MatchCasesParseResult(parser=current, cases=cases, success=True)

def parse_match_case(parser):
    original = parser
    current = skip_trivia(parser)
    if identifier_matches(parser_peek_raw(current), "case"):
        current = consume_keyword(current, "case")
        current = skip_trivia(current)
    pattern_capture = collect_pattern_until_arrow(current)
    if not pattern_capture.success:
        return MatchCaseParseResult(parser=original, case=None, success=False)
    current = pattern_capture.parser
    split_tokens = split_match_case_tokens(pattern_capture.tokens)
    if len(split_tokens.pattern_tokens) == 0:
        return MatchCaseParseResult(parser=original, case=None, success=False)
    pattern_expression = expression_from_tokens(split_tokens.pattern_tokens)
    guard_expression = None
    if split_tokens.has_guard:
        if len(split_tokens.guard_tokens) == 0:
            return MatchCaseParseResult(parser=original, case=None, success=False)
        guard_expression = expression_from_tokens(split_tokens.guard_tokens)
    current = skip_trivia(current)
    next = parser_peek_raw(current)
    body = None
    if symbol_matches(next, "{"):
        body_result = parse_block(current)
        if len(body_result.block.tokens) == 0:
            return MatchCaseParseResult(parser=original, case=None, success=False)
        current = body_result.parser
        body = body_result.block
    else:
        if identifier_matches(next, "return"):
            block_tokens = []
            block_tokens = append_token(block_tokens, next)
            current = parser_advance_raw(current)
            capture = collect_until(current, [";", ",", "}"])
            index = 0
            while True:
                if index >= len(capture.tokens):
                    break
                block_tokens = append_token(block_tokens, capture.tokens[index])
                index += 1
            trimmed_expression_tokens = trim_token_edges(capture.tokens)
            return_expression = None
            if len(trimmed_expression_tokens) > 0:
                return_expression = expression_from_tokens(trimmed_expression_tokens)
            else:
                if len(capture.tokens) > 0:
                    return_expression = expression_from_tokens(capture.tokens)
            current = skip_trivia(capture.parser)
            terminator = parser_peek_raw(current)
            if symbol_matches(terminator, ";"):
                block_tokens = append_token(block_tokens, terminator)
                current = parser_advance_raw(current)
            block_tokens = trim_token_edges(block_tokens)
            statement_span = source_span_from_tokens(block_tokens)
            statements = []
            statements = append_statement(statements, runtime.enum_instantiate(Statement, 'ReturnStatement', [runtime.enum_field('expression', return_expression), runtime.enum_field('span', statement_span)]))
            text = trim_text(tokens_to_text(block_tokens))
            body = Block(tokens=block_tokens, text=text, statements=statements)
        else:
            capture = collect_until(current, [";", ",", "}"])
            trimmed_expression_tokens = trim_token_edges(capture.tokens)
            if len(trimmed_expression_tokens) == 0:
                return MatchCaseParseResult(parser=original, case=None, success=False)
            expression = expression_from_tokens(trimmed_expression_tokens)
            block_tokens = []
            index = 0
            while True:
                if index >= len(capture.tokens):
                    break
                block_tokens = append_token(block_tokens, capture.tokens[index])
                index += 1
            current = skip_trivia(capture.parser)
            terminator = parser_peek_raw(current)
            if symbol_matches(terminator, ";"):
                block_tokens = append_token(block_tokens, terminator)
                current = parser_advance_raw(current)
            block_tokens = trim_token_edges(block_tokens)
            statement_span = source_span_from_tokens(block_tokens)
            statements = []
            statements = append_statement(statements, runtime.enum_instantiate(Statement, 'ExpressionStatement', [runtime.enum_field('expression', expression), runtime.enum_field('span', statement_span)]))
            text = trim_text(tokens_to_text(block_tokens))
            body = Block(tokens=block_tokens, text=text, statements=statements)
    if body == None:
        return MatchCaseParseResult(parser=original, case=None, success=False)
    case = MatchCase(pattern=pattern_expression, guard=guard_expression, body=body)
    return MatchCaseParseResult(parser=current, case=case, success=True)

def split_match_case_tokens(tokens):
    trimmed = trim_token_edges(tokens)
    if len(trimmed) == 0:
        return MatchCaseTokenSplit(pattern_tokens=[], guard_tokens=[], has_guard=False)
    guard_index = find_top_level_identifier(trimmed, "if")
    if guard_index == -1:
        return MatchCaseTokenSplit(pattern_tokens=trimmed, guard_tokens=[], has_guard=False)
    pattern_tokens = trim_token_edges(token_slice(trimmed, 0, guard_index))
    guard_tokens = trim_token_edges(token_slice(trimmed, guard_index + 1, len(trimmed)))
    return MatchCaseTokenSplit(pattern_tokens=pattern_tokens, guard_tokens=guard_tokens, has_guard=True)

def parse_prompt_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    prompt_token = parser_peek_raw(current)
    if not identifier_matches(prompt_token, "prompt"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "prompt")
    current = skip_trivia(current)
    channel_token = parser_peek_raw(current)
    channel = ""
    if channel_token.kind.variant == "Identifier":
        channel = identifier_text(channel_token)
        current = parser_advance_raw(current)
    else:
        if channel_token.kind.variant == "StringLiteral":
            channel = string_literal_value(channel_token)
            current = parser_advance_raw(current)
        else:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
    block_result = parse_block(current)
    if len(block_result.block.tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = block_result.parser
    body = block_result.block
    current = skip_trivia(current)
    if symbol_matches(parser_peek_raw(current), ";"):
        current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'PromptStatement', [runtime.enum_field('channel', channel), runtime.enum_field('keyword_token', prompt_token), runtime.enum_field('channel_token', channel_token), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)

def parse_with_statement(parser, decorators):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "with"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "with")
    clauses_capture = collect_until(skip_trivia(current), ["{"])
    current = clauses_capture.parser
    clause_slices = split_token_slices_by_comma(clauses_capture.tokens)
    clauses = []
    index = 0
    while True:
        if index >= len(clause_slices):
            break
        slice_tokens = trim_token_edges(clause_slices[index])
        if len(slice_tokens) > 0:
            expression = expression_from_tokens(slice_tokens)
            clauses = append_with_clause(clauses, WithClause(expression=expression))
        index += 1
    block_result = parse_block(current)
    if len(block_result.block.tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = block_result.parser
    body = block_result.block
    current = skip_trivia(current)
    if symbol_matches(parser_peek_raw(current), ";"):
        current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'WithStatement', [runtime.enum_field('clauses', clauses), runtime.enum_field('body', body), runtime.enum_field('decorators', decorators)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)

def parse_return_statement(parser):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "return"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    statement_tokens = []
    statement_tokens = append_token(statement_tokens, parser_peek_raw(current))
    current = consume_keyword(current, "return")
    capture = collect_until(skip_trivia(current), [";", "}"])
    current = capture.parser
    trimmed = trim_token_edges(capture.tokens)
    expression = None
    if len(trimmed) > 0:
        expression = expression_from_tokens(trimmed)
    else:
        if len(capture.tokens) > 0:
            expression = expression_from_tokens(capture.tokens)
    index = 0
    while True:
        if index >= len(capture.tokens):
            break
        statement_tokens = append_token(statement_tokens, capture.tokens[index])
        index += 1
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if symbol_matches(terminator, ";"):
        statement_tokens = append_token(statement_tokens, terminator)
        current = parser_advance_raw(current)
    span = source_span_from_tokens(statement_tokens)
    statement = runtime.enum_instantiate(Statement, 'ReturnStatement', [runtime.enum_field('expression', expression), runtime.enum_field('span', span)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)

def parse_throw_statement(parser):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "throw"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    statement_tokens = []
    statement_tokens = append_token(statement_tokens, parser_peek_raw(current))
    current = consume_keyword(current, "throw")
    capture = collect_until(skip_trivia(current), [";", "}"])
    current = capture.parser
    trimmed = trim_token_edges(capture.tokens)
    if len(trimmed) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    index = 0
    while True:
        if index >= len(capture.tokens):
            break
        statement_tokens = append_token(statement_tokens, capture.tokens[index])
        index += 1
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if symbol_matches(terminator, ";"):
        statement_tokens = append_token(statement_tokens, terminator)
        current = parser_advance_raw(current)
    span = source_span_from_tokens(statement_tokens)
    expression = expression_from_tokens(trimmed)
    statement = runtime.enum_instantiate(Statement, 'ThrowStatement', [runtime.enum_field('expression', expression), runtime.enum_field('span', span)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)

def parse_try_statement(parser):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "try"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = consume_keyword(current, "try")
    try_result = parse_block(current)
    if len(try_result.block.tokens) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    current = try_result.parser
    catch_name = None
    catch_name_token = None
    catch_block = None
    current = skip_trivia(current)
    if identifier_matches(parser_peek_raw(current), "catch"):
        current = consume_keyword(current, "catch")
        current = skip_trivia(current)
        if symbol_matches(parser_peek_raw(current), "("):
            current = parser_advance_raw(current)
            current = skip_trivia(current)
            name_token = parser_peek_raw(current)
            if name_token.kind.variant != "Identifier":
                return BlockStatementParseResult(parser=original, statement=None, success=False)
            catch_name = name_token.lexeme
            catch_name_token = name_token
            current = parser_advance_raw(current)
            current = skip_trivia(current)
            if not symbol_matches(parser_peek_raw(current), ")"):
                return BlockStatementParseResult(parser=original, statement=None, success=False)
            current = parser_advance_raw(current)
        catch_result = parse_block(current)
        if len(catch_result.block.tokens) == 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        catch_block = catch_result.block
        current = catch_result.parser
    finally_block = None
    current = skip_trivia(current)
    if identifier_matches(parser_peek_raw(current), "finally"):
        current = consume_keyword(current, "finally")
        finally_result = parse_block(current)
        if len(finally_result.block.tokens) == 0:
            return BlockStatementParseResult(parser=original, statement=None, success=False)
        finally_block = finally_result.block
        current = finally_result.parser
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if symbol_matches(terminator, ";"):
        current = parser_advance_raw(current)
    statement = runtime.enum_instantiate(Statement, 'TryStatement', [runtime.enum_field('try_block', try_result.block), runtime.enum_field('catch_name', catch_name), runtime.enum_field('catch_name_token', catch_name_token), runtime.enum_field('catch_block', catch_block), runtime.enum_field('finally_block', finally_block)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)

def parse_assert_statement(parser):
    original = parser
    current = skip_trivia(parser)
    if not identifier_matches(parser_peek_raw(current), "assert"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    statement_tokens = []
    statement_tokens = append_token(statement_tokens, parser_peek_raw(current))
    current = consume_keyword(current, "assert")
    capture = collect_until(skip_trivia(current), [";"])
    current = capture.parser
    trimmed = trim_token_edges(capture.tokens)
    if len(trimmed) == 0:
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    index = 0
    while True:
        if index >= len(capture.tokens):
            break
        statement_tokens = append_token(statement_tokens, capture.tokens[index])
        index += 1
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if not symbol_matches(terminator, ";"):
        return BlockStatementParseResult(parser=original, statement=None, success=False)
    statement_tokens = append_token(statement_tokens, terminator)
    current = parser_advance_raw(current)
    condition = expression_from_tokens(trimmed)
    fail_call = runtime.enum_instantiate(Expression, 'Call', [runtime.enum_field('callee', runtime.enum_instantiate(Expression, 'Identifier', [runtime.enum_field('name', "runtime_raise_value_error_fn")])), runtime.enum_field('arguments', [runtime.enum_instantiate(Expression, 'StringLiteral', [runtime.enum_field('value', "assertion failed")])])])
    fail_statement = runtime.enum_instantiate(Statement, 'ExpressionStatement', [runtime.enum_field('expression', fail_call), runtime.enum_field('span', None)])
    then_block = Block(tokens=[], text="", statements=[])
    else_block = Block(tokens=[], text="", statements=[fail_statement])
    else_branch = ElseBranch(statement=None, body=else_block)
    statement = runtime.enum_instantiate(Statement, 'IfStatement', [runtime.enum_field('condition', condition), runtime.enum_field('then_block', then_block), runtime.enum_field('else_branch', else_branch), runtime.enum_field('decorators', [])])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)

def parse_expression_statement(parser, decorators):
    if len(decorators) > 0:
        return BlockStatementParseResult(parser=parser, statement=None, success=False)
    current = skip_trivia(parser)
    start = parser_peek_raw(current)
    if start.kind.variant == "EndOfFile":
        return BlockStatementParseResult(parser=parser, statement=None, success=False)
    if start.kind.variant == "Symbol":
        sym = start.lexeme
        if strings_equal(sym, "}")  or  strings_equal(sym, "{"):
            return BlockStatementParseResult(parser=parser, statement=None, success=False)
    capture = collect_until(current, [";", "}"])
    if len(capture.tokens) == 0:
        return BlockStatementParseResult(parser=parser, statement=None, success=False)
    statement_tokens = []
    token_index = 0
    while True:
        if token_index >= len(capture.tokens):
            break
        statement_tokens = append_token(statement_tokens, capture.tokens[token_index])
        token_index += 1
    trimmed = trim_token_edges(capture.tokens)
    if len(trimmed) == 0:
        return BlockStatementParseResult(parser=parser, statement=None, success=False)
    current = capture.parser
    current = skip_trivia(current)
    terminator = parser_peek_raw(current)
    if symbol_matches(terminator, ";"):
        statement_tokens = append_token(statement_tokens, terminator)
        current = parser_advance_raw(current)
    else:
        if not symbol_matches(terminator, "}"):
            return BlockStatementParseResult(parser=parser, statement=None, success=False)
    expression = expression_from_tokens(trimmed)
    span = source_span_from_tokens(statement_tokens)
    statement = runtime.enum_instantiate(Statement, 'ExpressionStatement', [runtime.enum_field('expression', expression), runtime.enum_field('span', span)])
    return BlockStatementParseResult(parser=current, statement=statement, success=True)

def parse_unknown_statement(initial_parser):
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
        if is_end_of_file_local(current, tok):
            current = parser_advance_raw(current)
            break
        current = parser_advance_raw(current)
    text = tokens_to_text(tokens)
    if truncated:
        text = text + " /* parse_unknown truncated */"
    block = runtime.enum_instantiate(Statement, 'Unknown', [runtime.enum_field('tokens', tokens), runtime.enum_field('text', text)])
    parser = skip_trivia(current)
    return StatementParseResult(parser=parser, statement=block)

def is_end_of_file_local(parser, token):
    if parser.index + 1 >= len(parser.tokens):
        return len(token.lexeme) == 0
    return False

def advance_to_symbol_local(parser, symbol):
    current = parser
    while True:
        current = skip_trivia(current)
        token = parser_peek_raw(current)
        if symbol_matches(token, symbol):
            return current
        if token.kind.variant == "EndOfFile":
            return current
        next = parser_advance_raw(current)
        if next.index == current.index:
            return current
        current = next
    return current

def append_statement(statements, statement):
    statements.append(statement)
    return statements

def append_match_case(cases, case):
    cases.append(case)
    return cases

def append_with_clause(clauses, clause):
    clauses.append(clause)
    return clauses

def append_decorator(decorators, decorator):
    decorators.append(decorator)
    return decorators
