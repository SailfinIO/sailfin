import asyncio
import importlib
from bootstrap import runtime_support as runtime

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

__module_1 = importlib.import_module('compiler.build.token')
Token = getattr(__module_1, 'Token')
TokenKind = getattr(__module_1, 'TokenKind')
eof_token = getattr(__module_1, 'eof_token')
class LexerState:
    def __init__(self, source, index, line, column):
        self.source = source
        self.index = index
        self.line = line
        self.column = column

def lex(source):
    state = LexerState(source=source, index=0, line=1, column=1)
    tokens = []
    while True:
        if (state.index >= len(state.source)):
            break
        ch = state.source[state.index]
        if is_whitespace(ch):
            start_index = state.index
            start_line = state.line
            start_column = state.column
            while True:
                if (state.index >= len(state.source)):
                    break
                if (not is_whitespace(state.source[state.index])):
                    break
                if (state.source[state.index] == '\n'):
                    state.index += 1
                    state.line += 1
                    state.column = 1
                else:
                    state.index += 1
                    state.column += 1
            lexeme = slice(state.source, start_index, state.index)
            tokens = append(tokens, Token(kind=TokenKind.Whitespace(), lexeme=lexeme, line=start_line, column=start_column))
            continue
        if (ch == '/'):
            next = peek_next_char(state)
            if (next == '/'):
                start_index = state.index
                start_line = state.line
                start_column = state.column
                state.index += 2
                state.column += 2
                newline_index = runtime.find_char(state.source, '\n', state.index)
                carriage_index = runtime.find_char(state.source, '\r', state.index)
                comment_end = len(state.source)
                if (newline_index != (-1)):
                    comment_end = newline_index
                if ((carriage_index != (-1)) and (carriage_index < comment_end)):
                    comment_end = carriage_index
                lexeme = slice(state.source, start_index, comment_end)
                consumed_columns = (comment_end - state.index)
                state.index = comment_end
                state.column += consumed_columns
                tokens = append(tokens, Token(kind=TokenKind.Comment(), lexeme=lexeme, line=start_line, column=start_column))
                continue
            if (next == '*'):
                start_index = state.index
                start_line = state.line
                start_column = state.column
                state.index += 2
                state.column += 2
                while True:
                    if (state.index >= len(state.source)):
                        break
                    if ((state.source[state.index] == '*') and (peek_next_char(state) == '/')):
                        state.index += 2
                        state.column += 2
                        break
                    if (state.source[state.index] == '\n'):
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
            literal = ''
            escaped = False
            while True:
                if (state.index >= len(state.source)):
                    break
                current = state.source[state.index]
                if ((not escaped) and is_double_quote(current)):
                    state.index += 1
                    state.column += 1
                    break
                if ((not escaped) and is_backslash(current)):
                    escaped = True
                    state.index += 1
                    state.column += 1
                    continue
                if escaped:
                    literal = (literal + interpret_escape(current))
                    escaped = False
                else:
                    literal = (literal + current)
                if (current == '\n'):
                    state.index += 1
                    state.line += 1
                    state.column = 1
                else:
                    state.index += 1
                    state.column += 1
            lexeme = slice(state.source, start_index, state.index)
            tokens = append(tokens, Token(kind=TokenKind.StringLiteral(value=literal), lexeme=lexeme, line=start_line, column=start_column))
            continue
        if is_digit(ch):
            start_index = state.index
            start_line = state.line
            start_column = state.column
            state.index += 1
            state.column += 1
            while True:
                if (state.index >= len(state.source)):
                    break
                if (not is_digit(state.source[state.index])):
                    break
                state.index += 1
                state.column += 1
            if ((state.index < len(state.source)) and (state.source[state.index] == '.')):
                next_is_digit = (((state.index + 1) < len(state.source)) and is_digit(state.source[(state.index + 1)]))
                if next_is_digit:
                    state.index += 1
                    state.column += 1
                    while True:
                        if (state.index >= len(state.source)):
                            break
                        if (not is_digit(state.source[state.index])):
                            break
                        state.index += 1
                        state.column += 1
            lexeme = slice(state.source, start_index, state.index)
            tokens = append(tokens, Token(kind=TokenKind.NumberLiteral(value=lexeme), lexeme=lexeme, line=start_line, column=start_column))
            continue
        if is_identifier_start(ch):
            start = state.index
            start_line = state.line
            start_column = state.column
            state.index += 1
            state.column += 1
            while True:
                if (state.index >= len(state.source)):
                    break
                if (not is_identifier_part(state.source[state.index])):
                    break
                state.index += 1
                state.column += 1
            value = slice(state.source, start, state.index)
            if ((value == 'true') or (value == 'false')):
                bool_value = (value == 'true')
                tokens = append(tokens, Token(kind=TokenKind.BooleanLiteral(value=bool_value), lexeme=value, line=start_line, column=start_column))
            else:
                tokens = append(tokens, Token(kind=TokenKind.Identifier(value=value), lexeme=value, line=start_line, column=start_column))
            continue
        start_line = state.line
        start_column = state.column
        lexeme = ch
        next_symbol = peek_next_char(state)
        if (next_symbol != ''):
            pair = (ch + next_symbol)
            if is_two_char_symbol(pair):
                lexeme = pair
                state.index += 2
                state.column += 2
                tokens = append(tokens, Token(kind=TokenKind.Symbol(value=lexeme), lexeme=lexeme, line=start_line, column=start_column))
                continue
        state.index += 1
        if (ch == '\n'):
            state.line += 1
            state.column = 1
        else:
            state.column += 1
        tokens = append(tokens, Token(kind=TokenKind.Symbol(value=lexeme), lexeme=lexeme, line=start_line, column=start_column))
    tokens = append(tokens, eof_token(state.line, state.column))
    return tokens

def is_whitespace(ch):
    return ((((ch == ' ') or (ch == '\t')) or (ch == '\n')) or (ch == '\r'))

def is_identifier_start(ch):
    return (is_letter(ch) or (ch == '_'))

def is_identifier_part(ch):
    return (is_identifier_start(ch) or is_digit(ch))

def is_letter(ch):
    code = char_code(ch)
    return (((code >= char_code('a')) and (code <= char_code('z'))) or ((code >= char_code('A')) and (code <= char_code('Z'))))

def is_digit(ch):
    code = char_code(ch)
    return ((code >= char_code('0')) and (code <= char_code('9')))

def char_code(ch):
    return runtime.char_code(ch)

def is_double_quote(ch):
    return (char_code(ch) == 34)

def is_backslash(ch):
    return (char_code(ch) == 92)

def slice(text, start, end):
    return runtime.substring(text, start, end)

def append(tokens, token):
    return list(tokens) + list([token])

def peek_next_char(state):
    next_index = (state.index + 1)
    if (next_index >= len(state.source)):
        return ''
    return state.source[next_index]

def interpret_escape(ch):
    if (ch == 'n'):
        return '\n'
    if (ch == 't'):
        return '\t'
    if (ch == 'r'):
        return '\r'
    if is_double_quote(ch):
        return '\"'
    if is_backslash(ch):
        return '\\'
    return ch

def is_two_char_symbol(value):
    return (((((((((value == '->') or (value == '=>')) or (value == '==')) or (value == '!=')) or (value == '<=')) or (value == '>=')) or (value == '&&')) or (value == '||')) or (value == '..'))
