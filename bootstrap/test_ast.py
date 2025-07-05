from __future__ import annotations
from abc import ABC, abstractmethod
from dataclasses import dataclass

class Statement(ABC):
    @abstractmethod
    def getStatementKind(self) -> str:
        pass

class Expression(ABC):
    @abstractmethod
    def getExpressionKind(self) -> str:
        pass

@dataclass
class NumberExpr(Expression):
    value: float
    def getExpressionKind(self) -> str:
        return "NumberExpr"


@dataclass
class StringExpr(Expression):
    value: str
    def getExpressionKind(self) -> str:
        return "StringExpr"

