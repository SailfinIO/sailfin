import asyncio
from runtime import runtime_support as runtime

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

TokenKind = runtime.enum_type('TokenKind')
TokenKind = runtime.enum_define_variant(TokenKind, 'Identifier', ['value'])
TokenKind = runtime.enum_define_variant(TokenKind, 'NumberLiteral', ['value'])
TokenKind = runtime.enum_define_variant(TokenKind, 'StringLiteral', ['value'])
TokenKind = runtime.enum_define_variant(TokenKind, 'BooleanLiteral', ['value'])
TokenKind = runtime.enum_define_variant(TokenKind, 'Symbol', ['value'])
TokenKind = runtime.enum_define_variant(TokenKind, 'Whitespace', [])
TokenKind = runtime.enum_define_variant(TokenKind, 'Comment', [])
TokenKind = runtime.enum_define_variant(TokenKind, 'EndOfFile', [])

class Token:
    def __init__(self, kind, lexeme, line, column):
        self.kind = kind
        self.lexeme = lexeme
        self.line = line
        self.column = column

    def __repr__(self):
        return runtime.struct_repr('Token', [runtime.struct_field('kind', self.kind), runtime.struct_field('lexeme', self.lexeme), runtime.struct_field('line', self.line), runtime.struct_field('column', self.column)])

def eof_token(line, column):
    return Token(kind=TokenKind.EndOfFile(), lexeme="", line=line, column=column)
