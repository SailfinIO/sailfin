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

TokenKind = runtime.EnumType('TokenKind')
TokenKind.Identifier = TokenKind.variant('Identifier', ['value'])
TokenKind.NumberLiteral = TokenKind.variant('NumberLiteral', ['value'])
TokenKind.StringLiteral = TokenKind.variant('StringLiteral', ['value'])
TokenKind.BooleanLiteral = TokenKind.variant('BooleanLiteral', ['value'])
TokenKind.Symbol = TokenKind.variant('Symbol', ['value'])
TokenKind.Whitespace = TokenKind.variant('Whitespace', [])
TokenKind.Comment = TokenKind.variant('Comment', [])
TokenKind.EndOfFile = TokenKind.variant('EndOfFile', [])

class Token:
    def __init__(self, kind, lexeme, line, column):
        self.kind = kind
        self.lexeme = lexeme
        self.line = line
        self.column = column

def eof_token(line, column):
    return Token(kind=TokenKind.EndOfFile(), lexeme="", line=line, column=column)
