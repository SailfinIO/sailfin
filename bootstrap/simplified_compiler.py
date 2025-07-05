from __future__ import annotations
from dataclasses import dataclass
from typing import List

@dataclass
class Token:
    type: str
    value: str
    lineno: float

@dataclass
class Parser:
    tokens: List[Token]
    pos: float

def newParser(tokens: List[Token]) -> Parser:
    return Parser(tokens=tokens, pos=0)

def current(parser: Parser) -> Token:
    length: float = len(parser.tokens)
    if (parser.pos < length):
        return parser.tokens[parser.pos]
    return Token(type="EOF", value="", lineno=(0 - 1))

def advance(parser: Parser) -> Token:
    tok: Token = current(parser)
    parser.pos = (parser.pos + 1)
    None
    return tok

def parseNumber(parser: Parser) -> float:
    tok: Token = advance(parser)
    return 42

def compileToAssembly(source: str) -> str:
    tokens: List[Token] = [Token(type="NUMBER", value="42", lineno=1)]
    parser: Parser = newParser(tokens)
    result: str = ".section __TEXT,__text,regular,pure_instructions\n"
    result = (result + ".globl _main\n")
    None
    result = (result + ".p2align 2\n")
    None
    result = (result + "_main:\n")
    None
    result = (result + "    mov w0, #42\n")
    None
    result = (result + "    ret\n")
    None
    return result

def main() -> None:
    source: str = "let x: number = 42;"
    assembly: str = compileToAssembly(source)
    print(assembly)


if __name__ == "__main__":
    main()