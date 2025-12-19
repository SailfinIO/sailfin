import asyncio
from runtime import runtime_support as runtime

from compiler.build.token import Token, TokenKind, eof_token
from compiler.build.string_utils import substring, char_code, char_at

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
globals()['t' + 'rue'] = True
globals()['f' + 'alse'] = False

class LexerState:
    def __init__(self, source, index, line, column):
        self.source = source
        self.index = index
        self.line = line
        self.column = column

    def __repr__(self):
        return runtime.struct_repr('LexerState', [runtime.struct_field('source', self.source), runtime.struct_field('index', self.index), runtime.struct_field('line', self.line), runtime.struct_field('column', self.column)])

def lex(source):
    state = LexerState(source=source, index=0, line=1, column=1)
    tokens = []
    while True:
        if state.index >= len(state.source):
            break
        ch = char_at(state.source, state.index)
        if is_whitespace(ch):
            start_index = state.index
            start_line = state.line
            start_column = state.column
            while True:
                if state.index >= len(state.source):
                    break
                if not is_whitespace(char_at(state.source, state.index)):
                    break
                if char_at(state.source, state.index) == "\n":
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
            next = peek_next_char(state)
            if next == "/":
                start_index = state.index
                start_line = state.line
                start_column = state.column
                state.index += 2
                state.column += 2
                comment_end = len(state.source)
                scan_index = state.index
                while True:
                    if scan_index >= len(state.source):
                        break
                    scan_character = char_at(state.source, scan_index)
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
                    if state.index >= len(state.source):
                        break
                    if char_at(state.source, state.index) == "*"  and  peek_next_char(state) == "/":
                        state.index += 2
                        state.column += 2
                        break
                    if char_at(state.source, state.index) == "\n":
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
            literal = ""
            escaped = False
            while True:
                if state.index >= len(state.source):
                    break
                current = char_at(state.source, state.index)
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
                    literal = literal + interpret_escape(current)
                    escaped = False
                else:
                    literal = literal + current
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
                if state.index >= len(state.source):
                    break
                if not is_digit(char_at(state.source, state.index)):
                    break
                state.index += 1
                state.column += 1
            if state.index < len(state.source)  and  char_at(state.source, state.index) == ".":
                next_is_digit = state.index + 1 < len(state.source)  and  is_digit(char_at(state.source, state.index + 1))
                if next_is_digit:
                    state.index += 1
                    state.column += 1
                    while True:
                        if state.index >= len(state.source):
                            break
                        if not is_digit(char_at(state.source, state.index)):
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
                if state.index >= len(state.source):
                    break
                if not is_identifier_part(char_at(state.source, state.index)):
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
        lexeme = ch
        next_symbol = peek_next_char(state)
        if next_symbol != "":
            pair = ch + next_symbol
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
    code = char_code(ch)
    return code >= char_code("a")  and  code <= char_code("z")  or  code >= char_code("A")  and  code <= char_code("Z")

def is_digit(ch):
    code = char_code(ch)
    return code >= char_code("0")  and  code <= char_code("9")

def is_double_quote(ch):
    return char_code(ch) == 34

def is_backslash(ch):
    return char_code(ch) == 92

def slice(text, start, end):
    return substring(text, start, end)

def append(tokens, token):
    return (tokens) + ([token])

def peek_next_char(state):
    next_index = state.index + 1
    if next_index >= len(state.source):
        return ""
    return char_at(state.source, next_index)

def interpret_escape(ch):
    if ch == "n":
        return "\n"
    if ch == "t":
        return "\t"
    if ch == "r":
        return "\r"
    if is_double_quote(ch):
        return "\""
    if is_backslash(ch):
        return "\\"
    return ch

def is_two_char_symbol(value):
    return value == "->"  or  value == "=>"  or  value == "=="  or  value == "!="  or  value == "<="  or  value == ">="  or  value == "&&"  or  value == "||"  or  value == ".."
