from __future__ import annotations
from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import List

@dataclass
class Token:
    type: str
    value: str
    lineno: float

class Expression(ABC):
    @abstractmethod
    def getExpressionKind(self) -> str:
        pass

class Statement(ABC):
    @abstractmethod
    def getStatementKind(self) -> str:
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


@dataclass
class IdentifierExpr(Expression):
    name: str
    def getExpressionKind(self) -> str:
        return "IdentifierExpr"


@dataclass
class BinaryExpr(Expression):
    left: Expression
    operator: str
    right: Expression
    def getExpressionKind(self) -> str:
        return "BinaryExpr"


@dataclass
class Program:
    statements: List[Statement]

@dataclass
class VariableDeclaration(Statement):
    name: str
    var_type: str
    value: Expression
    isMutable: bool
    def getStatementKind(self) -> str:
        return "VariableDeclaration"


@dataclass
class ExpressionStatement(Statement):
    expression: Expression
    def getStatementKind(self) -> str:
        return "ExpressionStatement"


@dataclass
class ReturnStatement(Statement):
    expression: Expression
    def getStatementKind(self) -> str:
        return "ReturnStatement"


@dataclass
class FunctionDeclaration(Statement):
    name: str
    parameters: List[Parameter]
    returnType: str
    body: List[Statement]
    def getStatementKind(self) -> str:
        return "FunctionDeclaration"


@dataclass
class Parameter:
    name: str
    paramType: str

def tokenize(source: str) -> List[Token]:
    tokens: List[Token] = []
    tokens.append(Token(type="FN", value="fn", lineno=1))
    tokens.append(Token(type="IDENTIFIER", value="main", lineno=1))
    tokens.append(Token(type="LPAREN", value="(", lineno=1))
    tokens.append(Token(type="RPAREN", value=")", lineno=1))
    tokens.append(Token(type="ARROW", value="->", lineno=1))
    tokens.append(Token(type="IDENTIFIER", value="void", lineno=1))
    tokens.append(Token(type="LBRACE", value="{", lineno=1))
    tokens.append(Token(type="RBRACE", value="}", lineno=1))
    tokens.append(Token(type="EOF", value="", lineno=1))
    return tokens

def parse(tokens: List[Token]) -> Program:
    statements: List[Statement] = []
    params: List[Parameter] = []
    body: List[Statement] = []
    funcDecl: FunctionDeclaration = FunctionDeclaration(name="main", parameters=params, returnType="void", body=body)
    statements.append(funcDecl)
    return Program(statements=statements)

def generateARM64(program: Program) -> str:
    assembly: str = ""
    assembly = (assembly + ".section __TEXT,__text,regular,pure_instructions\n")
    None
    assembly = (assembly + ".globl _main\n")
    None
    assembly = (assembly + ".p2align 2\n")
    None
    assembly = (assembly + "_main:\n")
    None
    assembly = (assembly + "    mov w0, #42\n")
    None
    assembly = (assembly + "    ret\n")
    None
    return assembly

def compileToAssembly(source: str) -> str:
    tokens: List[Token] = tokenize(source)
    ast: Program = parse(tokens)
    assembly: str = generateARM64(ast)
    return assembly

def main() -> None:
    source: str = "fn main() -> void { }"
    assembly: str = compileToAssembly(source)
    print(assembly)


if __name__ == "__main__":
    main()