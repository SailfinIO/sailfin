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

def current(parser: Parser) -> Token:
    pos: float = parser.pos
    length: float = len(parser.tokens)
    if (pos < length):
        return parser.tokens[pos]
    return Token(type="EOF", value="", lineno=(0 - 1))
