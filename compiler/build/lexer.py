import asyncio
from runtime import runtime_support as runtime

from compiler.build.token import Token, TokenKind, eof_token
from compiler.build.string_utils import char_code

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

class LexerState:
    def __init__(self, source, source_len, index, line, column):
        self.source = source
        self.source_len = source_len
        self.index = index
        self.line = line
        self.column = column

    def __repr__(self):
        return runtime.struct_repr('LexerState', [runtime.struct_field('source', self.source), runtime.struct_field('source_len', self.source_len), runtime.struct_field('index', self.index), runtime.struct_field('line', self.line), runtime.struct_field('column', self.column)])

def lex(source):
    length = len(source)
    state = LexerState(source=source, source_len=length, index=0, line=1, column=1)
    tokens = []
    while True:
        if state.index >= state.source_len:
            break
        ch = state.source[state.index]
        if is_whitespace(ch):
            start_index = state.index
            start_line = state.line
            start_column = state.column
            while True:
                if state.index >= state.source_len:
                    break
                if not is_whitespace(state.source[state.index]):
                    break
                if state.source[state.index] == "\n":
                    state.index += 1
                    state.line += 1
                    state.column = 1
                else:
                    state.index += 1
                    state.column += 1
            lexeme = slice(state.source, start_index, state.index)
            tokens = append(tokens, Token(kind=TokenKind.Whitespace(), lexeme=lexeme, line=start_line, column=start_column))
            continue
        if ch == "/":
            has_next = state.index + 1 < state.source_len
            if has_next:
                next = state.source[state.index + 1]
                if next == "/":
                    start_index = state.index
                    start_line = state.line
                    start_column = state.column
                    state.index += 2
                    state.column += 2
                    comment_end = state.source_len
                    scan_index = state.index
                    while True:
                        if scan_index >= state.source_len:
                            break
                        scan_character = state.source[scan_index]
                        if scan_character == "\n"  or  scan_character == "\r":
                            comment_end = scan_index
                            break
                        scan_index += 1
                    lexeme = slice(state.source, start_index, comment_end)
                    consumed_columns = comment_end - state.index
                    state.index = comment_end
                    state.column += consumed_columns
                    tokens = append(tokens, Token(kind=TokenKind.Comment(), lexeme=lexeme, line=start_line, column=start_column))
                    continue
                if next == "*":
                    start_index = state.index
                    start_line = state.line
                    start_column = state.column
                    state.index += 2
                    state.column += 2
                    while True:
                        if state.index >= state.source_len:
                            break
                        if state.source[state.index] == "*"  and  state.index + 1 < state.source_len  and  state.source[state.index + 1] == "/":
                            state.index += 2
                            state.column += 2
                            break
                        if state.source[state.index] == "\n":
                            state.index += 1
                            state.line += 1
                            state.column = 1
                        else:
                            state.index += 1
                            state.column += 1
                    lexeme = slice(state.source, start_index, state.index)
                    tokens = append(tokens, Token(kind=TokenKind.Comment(), lexeme=lexeme, line=start_line, column=start_column))
                    continue
        if is_double_quote(ch):
            start_index = state.index
            start_line = state.line
            start_column = state.column
            state.index += 1
            state.column += 1
            escaped = False
            while True:
                if state.index >= state.source_len:
                    break
                current = state.source[state.index]
                if not escaped  and  is_double_quote(current):
                    state.index += 1
                    state.column += 1
                    break
                if not escaped  and  is_backslash(current):
                    escaped = True
                    state.index += 1
                    state.column += 1
                    continue
                if escaped:
                    escaped = False
                if current == "\n":
                    state.index += 1
                    state.line += 1
                    state.column = 1
                else:
                    state.index += 1
                    state.column += 1
            lexeme = slice(state.source, start_index, state.index)
            tokens = append(tokens, Token(kind=TokenKind.StringLiteral(), lexeme=lexeme, line=start_line, column=start_column))
            continue
        if is_digit(ch):
            start_index = state.index
            start_line = state.line
            start_column = state.column
            state.index += 1
            state.column += 1
            while True:
                if state.index >= state.source_len:
                    break
                if not is_digit(state.source[state.index]):
                    break
                state.index += 1
                state.column += 1
            if state.index < state.source_len  and  state.source[state.index] == ".":
                next_is_digit = state.index + 1 < state.source_len  and  is_digit(state.source[state.index + 1])
                if next_is_digit:
                    state.index += 1
                    state.column += 1
                    while True:
                        if state.index >= state.source_len:
                            break
                        if not is_digit(state.source[state.index]):
                            break
                        state.index += 1
                        state.column += 1
            lexeme = slice(state.source, start_index, state.index)
            tokens = append(tokens, Token(kind=TokenKind.NumberLiteral(), lexeme=lexeme, line=start_line, column=start_column))
            continue
        if is_identifier_start(ch):
            start = state.index
            start_line = state.line
            start_column = state.column
            state.index += 1
            state.column += 1
            while True:
                if state.index >= state.source_len:
                    break
                if not is_identifier_part(state.source[state.index]):
                    break
                state.index += 1
                state.column += 1
            value = slice(state.source, start, state.index)
            if value == "true"  or  value == "false":
                tokens = append(tokens, Token(kind=TokenKind.BooleanLiteral(), lexeme=value, line=start_line, column=start_column))
            else:
                tokens = append(tokens, Token(kind=TokenKind.Identifier(), lexeme=value, line=start_line, column=start_column))
            continue
        start_line = state.line
        start_column = state.column
        lexeme = slice(state.source, state.index, state.index + 1)
        if state.index + 1 < state.source_len:
            pair = slice(state.source, state.index, state.index + 2)
            if pair == "<="  or  pair == ">=":
                lexeme = pair
                state.index += 2
                state.column += 2
                tokens = append(tokens, Token(kind=TokenKind.Symbol(), lexeme=lexeme, line=start_line, column=start_column))
                continue
            if is_two_char_symbol(pair):
                lexeme = pair
                state.index += 2
                state.column += 2
                tokens = append(tokens, Token(kind=TokenKind.Symbol(), lexeme=lexeme, line=start_line, column=start_column))
                continue
        state.index += 1
        if ch == "\n":
            state.line += 1
            state.column = 1
        else:
            state.column += 1
        tokens = append(tokens, Token(kind=TokenKind.Symbol(), lexeme=lexeme, line=start_line, column=start_column))
    tokens = append(tokens, eof_token(state.line, state.column))
    return tokens

def is_whitespace(ch):
    return ch == " "  or  ch == "\t"  or  ch == "\n"  or  ch == "\r"

def is_identifier_start(ch):
    return is_letter(ch)  or  ch == "_"

def is_identifier_part(ch):
    return is_identifier_start(ch)  or  is_digit(ch)

def is_letter(ch):
    c = char_code(ch)
    return c >= 65  and  c <= 90  or  c >= 97  and  c <= 122

def is_digit(ch):
    c = char_code(ch)
    return c >= 48  and  c <= 57

def is_double_quote(ch):
    return ch == "\""

def is_backslash(ch):
    return ch == "\\"

def slice(text, start, end):
    return substring_unchecked(text, start, end)

def append(tokens, token):
    return (tokens) + ([token])

def is_two_char_symbol(value):
    if value == "->":
        return True
    if value == "=>":
        return True
    if value == "==":
        return True
    if value == "!=":
        return True
    if value == "<=":
        return True
    if value == ">=":
        return True
    if value == "&&":
        return True
    if value == "||":
        return True
    if value == "..":
        return True
    return False
