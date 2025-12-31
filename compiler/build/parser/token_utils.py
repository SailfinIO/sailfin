import asyncio
from runtime import runtime_support as runtime

from compiler.build.token import Token
from compiler.build.ast import SourceSpan
from compiler.build.string_utils import substring, char_code, char_at, strings_equal
from compiler.build.parser.types import Parser, CaptureResult, ParenthesizedParseResult, PatternCaptureResult
from compiler.build.parser.utils import string_array_contains, trim_text

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

def parser_peek_raw(parser):
    if parser.index >= len(parser.tokens):
        return parser.tokens[len(parser.tokens) - 1]
    return parser.tokens[parser.index]

def parser_advance_raw(parser):
    if parser.index + 1 > len(parser.tokens):
        return parser
    return Parser(tokens=parser.tokens, index=parser.index + 1)

def skip_trivia(parser):
    current = parser
    while True:
        if current.index >= len(current.tokens):
            break
        token = current.tokens[current.index]
        if is_trivia_token(token):
            current = parser_advance_raw(current)
            continue
        break
    return current

def is_end_of_file(parser, token):
    if parser.index + 1 >= len(parser.tokens):
        return len(token.lexeme) == 0
    return False

def identifier_matches(token, expected):
    lexeme = token.lexeme
    return len(lexeme) > 0  and  strings_equal(lexeme, expected)

def symbol_matches(token, expected):
    lexeme = token.lexeme
    return len(lexeme) > 0  and  strings_equal(lexeme, expected)

def identifier_text(token):
    return token.lexeme

def string_literal_value(token):
    lexeme = token.lexeme
    stripped = strip_surrounding_quotes_local(lexeme)
    return decode_string_literal_escapes_local(stripped)

def strip_surrounding_quotes_local(text):
    if len(text) < 2:
        return text
    first = char_code(char_at(text, 0))
    last = char_code(char_at(text, len(text) - 1))
    if first == 34  and  last == 34:
        return substring(text, 1, len(text) - 1)
    return text

def decode_string_literal_escapes_local(text):
    if len(text) == 0:
        return ""
    decoded = ""
    index = 0
    while True:
        if index >= len(text):
            break
        ch = char_at(text, index)
        if ch == "\\":
            next_index = index + 1
            if next_index >= len(text):
                decoded = decoded + ch
                index += 1
                continue
            escaped = char_at(text, next_index)
            if escaped == "n":
                decoded = decoded + "\n"
            else:
                if escaped == "t":
                    decoded = decoded + "\t"
                else:
                    if escaped == "r":
                        decoded = decoded + "\r"
                    else:
                        if escaped == "\"":
                            decoded = decoded + "\""
                        else:
                            if escaped == "\\":
                                decoded = decoded + "\\"
                            else:
                                decoded = decoded + escaped
            index += 2
            continue
        decoded = decoded + ch
        index += 1
    return decoded

def consume_keyword(initial_parser, keyword):
    parser = initial_parser
    parser = skip_trivia(parser)
    token = parser_peek_raw(parser)
    if identifier_matches(token, keyword):
        return parser_advance_raw(parser)
    return parser

def consume_symbol(initial_parser, symbol):
    parser = initial_parser
    parser = skip_trivia(parser)
    token = parser_peek_raw(parser)
    if symbol_matches(token, symbol):
        return parser_advance_raw(parser)
    return parser

def advance_to_symbol(parser, symbol):
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

def is_trivia_token(token):
    if token.kind.variant == "Whitespace"  or  token.kind.variant == "Comment":
        return True
    text = token.lexeme
    if len(text) == 0:
        return False
    if is_whitespace_lexeme(text):
        return True
    if len(text) >= 2:
        prefix = substring(text, 0, 2)
        if strings_equal(prefix, "//")  or  strings_equal(prefix, "/*"):
            return True
    return False

def is_whitespace_lexeme(text):
    if len(text) == 0:
        return False
    index = 0
    while True:
        if index >= len(text):
            break
        ch = char_at(text, index)
        if not is_trim_whitespace_local(ch):
            return False
        index += 1
    return True

def is_trim_whitespace_local(ch):
    code = char_code(ch)
    return code == 32  or  code == 10  or  code == 9  or  code == 13

def token_slice(tokens, start, end):
    result = []
    index = start
    while True:
        if index >= end:
            break
        result = append_token(result, tokens[index])
        index += 1
    return result

def trim_token_edges(tokens):
    start = 0
    end = len(tokens)
    while True:
        if start >= end:
            break
        token = tokens[start]
        if is_trivia_token(token):
            start += 1
            continue
        break
    while True:
        if end <= start:
            break
        token = tokens[end - 1]
        if is_trivia_token(token):
            end -= 1
            continue
        break
    return token_slice(tokens, start, end)

def trim_block_tokens(tokens):
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

def filter_trivia(tokens):
    index = 0
    filtered = []
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant != "Whitespace"  and  token.kind.variant != "Comment"  and  token.kind.variant != "EndOfFile":
            filtered = append_token(filtered, token)
        index += 1
    return filtered

def tokens_to_text(tokens):
    text = ""
    index = 0
    limit = 8192
    max_tokens = 512
    truncated = False
    while True:
        if index >= len(tokens):
            break
        if index >= max_tokens:
            truncated = True
            break
        text = text + tokens[index].lexeme
        index += 1
        if len(text) > limit:
            text = substring(text, 0, limit)
            truncated = True
            break
    if truncated  and  len(text) > limit:
        text = substring(text, 0, limit)
    if truncated:
        text = text + "... (truncated)"
    return text

def source_span_from_tokens(tokens):
    trimmed = trim_token_edges(tokens)
    if len(trimmed) == 0:
        return None
    start = trimmed[0]
    last = trimmed[len(trimmed) - 1]
    end_line = last.line
    end_column = last.column
    lexeme = last.lexeme
    index = 0
    while True:
        if index >= len(lexeme):
            break
        ch = char_at(lexeme, index)
        if ch == "\n":
            end_line += 1
            end_column = 1
        else:
            end_column += 1
        index += 1
    return SourceSpan(start_line=start.line, start_column=start.column, end_line=end_line, end_column=end_column)

def collect_until(parser, terminators):
    current = parser
    captured = []
    paren_depth = 0
    brace_depth = 0
    bracket_depth = 0
    while True:
        token = parser_peek_raw(current)
        if token.kind.variant == "EndOfFile":
            break
        is_balanced = paren_depth == 0  and  brace_depth == 0  and  bracket_depth == 0
        is_symbol = token.kind.variant == "Symbol"
        should_stop = False
        if is_balanced  and  is_symbol:
            should_stop = string_array_contains(terminators, token.lexeme)
        if should_stop:
            break
        captured = append_token(captured, token)
        if token.kind.variant == "Symbol":
            sym = token.lexeme
            if strings_equal(sym, "("):
                paren_depth += 1
            else:
                if strings_equal(sym, ")")  and  paren_depth > 0:
                    paren_depth -= 1
                else:
                    if strings_equal(sym, "{"):
                        brace_depth += 1
                    else:
                        if strings_equal(sym, "}")  and  brace_depth > 0:
                            brace_depth -= 1
                        else:
                            if strings_equal(sym, "["):
                                bracket_depth += 1
                            else:
                                if strings_equal(sym, "]")  and  bracket_depth > 0:
                                    bracket_depth -= 1
        advanced = parser_advance_raw(current)
        if advanced.index == current.index:
            break
        current = advanced
    return CaptureResult(parser=current, tokens=captured)

def collect_parenthesized(parser):
    current = skip_trivia(parser)
    start = parser_peek_raw(current)
    if not symbol_matches(start, "("):
        return ParenthesizedParseResult(parser=parser, tokens=[], success=False)
    current = parser_advance_raw(current)
    tokens = []
    depth = 1
    while True:
        token = parser_peek_raw(current)
        if token.kind.variant == "EndOfFile":
            return ParenthesizedParseResult(parser=parser, tokens=[], success=False)
        if token.kind.variant == "Symbol":
            sym = token.lexeme
            if strings_equal(sym, "("):
                depth += 1
            else:
                if strings_equal(sym, ")"):
                    depth -= 1
                    if depth == 0:
                        current = parser_advance_raw(current)
                        break
        tokens = append_token(tokens, token)
        current = parser_advance_raw(current)
    return ParenthesizedParseResult(parser=current, tokens=tokens, success=True)

def collect_pattern_until_arrow(parser):
    current = skip_trivia(parser)
    tokens = []
    while True:
        token = parser_peek_raw(current)
        if token.kind.variant == "EndOfFile":
            return PatternCaptureResult(parser=parser, tokens=[], success=False)
        if token.kind.variant == "Symbol":
            sym = token.lexeme
            if strings_equal(sym, "=>")  or  strings_equal(sym, "->"):
                current = parser_advance_raw(current)
                break
        tokens = append_token(tokens, token)
        advanced = parser_advance_raw(current)
        if advanced.index == current.index:
            return PatternCaptureResult(parser=parser, tokens=[], success=False)
        current = advanced
    return PatternCaptureResult(parser=current, tokens=tokens, success=True)

def split_tokens_by_comma(tokens):
    parts = []
    segment = ""
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.lexeme
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
            if strings_equal(sym, ",")  and  angle == 0  and  paren == 0  and  brace == 0  and  bracket == 0:
                text = trim_text(segment)
                if len(text) > 0:
                    parts = append_string_local(parts, text)
                segment = ""
                index += 1
                continue
        segment = segment + token.lexeme
        index += 1
    tail = trim_text(segment)
    if len(tail) > 0:
        parts = append_string_local(parts, tail)
    return parts

def split_token_slices_by_comma(tokens):
    parts = []
    segment = []
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.lexeme
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
            if strings_equal(sym, ",")  and  angle == 0  and  paren == 0  and  brace == 0  and  bracket == 0:
                parts = append_token_array(parts, segment)
                segment = []
                index += 1
                continue
        segment = append_token(segment, token)
        index += 1
    if len(segment) > 0:
        parts = append_token_array(parts, segment)
    return parts

def find_top_level_symbol(tokens, symbol):
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.lexeme
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
            if strings_equal(sym, symbol)  and  angle == 0  and  paren == 0  and  brace == 0  and  bracket == 0:
                return index
        index += 1
    return -1

def find_top_level_identifier(tokens, keyword):
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.lexeme
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
        if token.kind.variant == "Identifier":
            if identifier_matches(token, keyword):
                if angle == 0  and  paren == 0  and  brace == 0  and  bracket == 0:
                    return index
        index += 1
    return -1

def find_top_level_colon(tokens):
    angle = 0
    paren = 0
    brace = 0
    bracket = 0
    index = 0
    while True:
        if index >= len(tokens):
            break
        token = tokens[index]
        if token.kind.variant == "Symbol":
            sym = token.lexeme
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
                                        else:
                                            if strings_equal(sym, ":"):
                                                at_top = angle == 0  and  paren == 0  and  brace == 0  and  bracket == 0
                                                if at_top:
                                                    return index
        index += 1
    return -1

def skip_struct_member(parser):
    current = parser
    while True:
        next = parser_advance_raw(current)
        if next.index == current.index:
            return current
        current = next
        token = parser_peek_raw(current)
        if token.kind.variant == "EndOfFile":
            return current
        if token.kind.variant == "Symbol":
            sym = token.lexeme
            if strings_equal(sym, ";"):
                current = parser_advance_raw(current)
                return current
            if strings_equal(sym, "}"):
                return current
    return current

def skip_enum_variant_entry(parser):
    current = parser
    while True:
        next = parser_advance_raw(current)
        if next.index == current.index:
            return current
        current = next
        token = parser_peek_raw(current)
        if token.kind.variant == "EndOfFile":
            return current
        if token.kind.variant == "Symbol":
            sym = token.lexeme
            if strings_equal(sym, ","):
                current = parser_advance_raw(current)
                return current
            if strings_equal(sym, "}"):
                return current
    return current

def skip_trailing_comma(parser):
    current = skip_trivia(parser)
    token = parser_peek_raw(current)
    if symbol_matches(token, ","):
        current = parser_advance_raw(current)
    return current

def append_token(tokens, token):
    return (tokens) + ([token])

def append_token_array(collection, tokens):
    return (collection) + ([tokens])

def append_string_local(values, value):
    return (values) + ([value])
