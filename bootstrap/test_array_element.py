from __future__ import annotations
from dataclasses import dataclass
from typing import List

@dataclass
class Token:
    value: str

@dataclass
class Parser:
    tokens: List[Token]
    pos: float

def getCurrentToken(parser: Parser) -> Token:
    return parser.tokens[parser.pos]
