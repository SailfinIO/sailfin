from __future__ import annotations
from dataclasses import dataclass

@dataclass
class MyStruct:
    field: float

def testAccess(s: MyStruct) -> float:
    return s.field
