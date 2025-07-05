from __future__ import annotations
from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import List

@dataclass
class Token:
    type: str
    value: str
    lineno: float

class Statement(ABC):
    @abstractmethod
    def getStatementKind(self) -> str:
        pass

class Expression(ABC):
    @abstractmethod
    def getExpressionKind(self) -> str:
        pass

@dataclass
class Parser:
    tokens: List[Token]
    pos: float

def newParser(tokens: List[Token]) -> Parser:
    return Parser(tokens=tokens, pos=0)

def current(parser: Parser) -> Token:
    pos: float = parser.pos
    length: float = len(parser.tokens)
    if (pos < length):
        return parser.tokens[pos]
    return Token(type="EOF", value="", lineno=(0 - 1))
