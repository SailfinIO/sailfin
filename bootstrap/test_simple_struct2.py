from __future__ import annotations
from dataclasses import dataclass

@dataclass
class Token:
    value: str

token: Token = Token(value="test")