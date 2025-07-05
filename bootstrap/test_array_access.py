from __future__ import annotations
from dataclasses import dataclass
from typing import List

@dataclass
class Container:
    items: List[float]

def getItem(c: Container, index: float) -> float:
    return c.items[index]
