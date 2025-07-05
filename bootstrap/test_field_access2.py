from __future__ import annotations
from dataclasses import dataclass
from typing import List

@dataclass
class Token:
    value: str

tokens: List[Token] = [Token(value="test")]
result: str = tokens[0].value