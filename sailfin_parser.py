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
class ArrayExpr(Expression):
    elements: List[Expression]
    def getExpressionKind(self) -> str:
        return "ArrayExpr"


@dataclass
class IndexExpr(Expression):
    array: Expression
    index: Expression
    def getExpressionKind(self) -> str:
        return "IndexExpr"


@dataclass
class CallExpr(Expression):
    callee: Expression
    arguments: List[Expression]
    def getExpressionKind(self) -> str:
        return "CallExpr"


@dataclass
class NilExpr(Expression):
    def getExpressionKind(self) -> str:
        return "NilExpr"


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
class AssignmentStatement(Statement):
    target: str
    value: Expression
    def getStatementKind(self) -> str:
        return "AssignmentStatement"


@dataclass
class IfStatement(Statement):
    condition: Expression
    thenBody: List[Statement]
    elseBody: List[Statement]
    def getStatementKind(self) -> str:
        return "IfStatement"


@dataclass
class WhileStatement(Statement):
    condition: Expression
    body: List[Statement]
    def getStatementKind(self) -> str:
        return "WhileStatement"


@dataclass
class ForStatement(Statement):
    init: Statement
    condition: Expression
    update: Statement
    body: List[Statement]
    def getStatementKind(self) -> str:
        return "ForStatement"


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

@dataclass
class StructDeclaration(Statement):
    name: str
    fields: List[FieldDeclaration]
    def getStatementKind(self) -> str:
        return "StructDeclaration"


@dataclass
class FieldDeclaration:
    name: str
    fieldType: str

@dataclass
class ImportStatement(Statement):
    modulePath: str
    alias: str
    def getStatementKind(self) -> str:
        return "ImportStatement"


@dataclass
class ExportStatement(Statement):
    declaration: Statement
    def getStatementKind(self) -> str:
        return "ExportStatement"


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

def advance(parser: Parser) -> Token:
    tok = current(parser)
    parser.pos = (parser.pos + 1)
    None
    return tok

def expect(parser: Parser, expectedType: str) -> Token:
    tok = current(parser)
    if (tok.type == expectedType):
        return advance(parser)
    else:
        raise RuntimeError(((((("Expected " + expectedType) + " but found ") + tok.type) + " at line ") + str(tok.lineno)))

def peek(parser: Parser) -> Token:
    nextPos: float = (parser.pos + 1)
    tokensLength: float = len(parser.tokens)
    if (nextPos >= tokensLength):
        eofToken: Token = Token(type="EOF", value="", lineno=0)
        return eofToken
    nextToken: Token = parser.tokens[nextPos]
    return nextToken

def parseExpression(parser: Parser) -> Expression:
    return parseBinaryExpression(parser, 0)

def parseBinaryExpression(parser: Parser, minPrecedence: float) -> Expression:
    left: Expression = parsePrimaryExpression(parser)
    while True:
        tok: Token = current(parser)
        precedence: float = getOperatorPrecedence(tok.type)
        if (precedence < minPrecedence):
            break
        advance(parser)
        operator: str = tok.value
        right: Expression = parseBinaryExpression(parser, (precedence + 1))
        left = BinaryExpr(left=left, operator=operator, right=right)
        None
    return left

def parsePrimaryExpression(parser: Parser) -> Expression:
    tok = current(parser)
    if (tok.type == "NUMBER"):
        advance(parser)
        return NumberExpr(value=tok.value.toNumber())
    else:
        if (tok.type == "STRING"):
            advance(parser)
            return StringExpr(value=tok.value)
        else:
            if (tok.type == "LBRACKET"):
                advance(parser)
                elements: List[Expression] = []
                if (current(parser).type != "RBRACKET"):
                    elements.append(parseExpression(parser))
                    while (current(parser).type == "COMMA"):
                        advance(parser)
                        elements.append(parseExpression(parser))
                expect(parser, "RBRACKET")
                return ArrayExpr(elements=elements)
            else:
                if (tok.type == "IDENTIFIER"):
                    advance(parser)
                    name: str = tok.value
                    expr: Expression = IdentifierExpr(name=name)
                    while True:
                        if (current(parser).type == "LPAREN"):
                            advance(parser)
                            args: List[Expression] = []
                            if (current(parser).type != "RPAREN"):
                                args.append(parseExpression(parser))
                                while (current(parser).type == "COMMA"):
                                    advance(parser)
                                    args.append(parseExpression(parser))
                            expect(parser, "RPAREN")
                            expr = CallExpr(callee=expr, arguments=args)
                            None
                        else:
                            if (current(parser).type == "LBRACKET"):
                                advance(parser)
                                index: Expression = parseExpression(parser)
                                expect(parser, "RBRACKET")
                                expr = IndexExpr(array=expr, index=index)
                                None
                            else:
                                break
                    return expr
                else:
                    if (tok.type == "LPAREN"):
                        advance(parser)
                        expr: Expression = parseExpression(parser)
                        expect(parser, "RPAREN")
                        return expr
                    else:
                        raise RuntimeError(("Unexpected token in expression: " + tok.type))

def getOperatorPrecedence(tokenType: str) -> float:
    if ((tokenType == "MULTIPLY") or (tokenType == "DIVIDE")):
        return 20
    else:
        if ((tokenType == "PLUS") or (tokenType == "MINUS")):
            return 10
        else:
            if ((((((tokenType == "EQ") or (tokenType == "NEQ")) or (tokenType == "LT")) or (tokenType == "GT")) or (tokenType == "LEQ")) or (tokenType == "GEQ")):
                return 5
            else:
                return 0

def parseStatement(parser: Parser) -> Statement:
    tok = current(parser)
    if ((tok.type == "LET") or (tok.type == "MUT")):
        isMutable: bool = (tok.type == "MUT")
        advance(parser)
        identTok = expect(parser, "IDENTIFIER")
        varType: str = ""
        if (current(parser).type == "COLON"):
            advance(parser)
            typeTok = expect(parser, "IDENTIFIER")
            varType = typeTok.value
            None
        expect(parser, "ASSIGN")
        expr = parseExpression(parser)
        expect(parser, "SEMICOLON")
        return VariableDeclaration(name=identTok.value, var_type=varType, value=expr, isMutable=isMutable)
    else:
        if (tok.type == "IDENTIFIER"):
            nextTok: Token = peek(parser)
            if (nextTok.type == "ASSIGN"):
                identTok: Token = advance(parser)
                expect(parser, "ASSIGN")
                expr: Expression = parseExpression(parser)
                expect(parser, "SEMICOLON")
                return AssignmentStatement(target=identTok.value, value=expr)
            else:
                expr = parseExpression(parser)
                expect(parser, "SEMICOLON")
                return ExpressionStatement(expression=expr)
        else:
            if (tok.type == "STRUCT"):
                advance(parser)
                nameTok: Token = expect(parser, "IDENTIFIER")
                expect(parser, "LBRACE")
                fields: List[FieldDeclaration] = []
                while (current(parser).type != "RBRACE"):
                    fieldName: Token = expect(parser, "IDENTIFIER")
                    expect(parser, "COLON")
                    fieldType: Token = expect(parser, "IDENTIFIER")
                    expect(parser, "SEMICOLON")
                    fields.append(FieldDeclaration(name=fieldName.value, fieldType=fieldType.value))
                expect(parser, "RBRACE")
                return StructDeclaration(name=nameTok.value, fields=fields)
            else:
                if (tok.type == "FN"):
                    advance(parser)
                    nameTok: Token = expect(parser, "IDENTIFIER")
                    expect(parser, "LPAREN")
                    params: List[Parameter] = []
                    if (current(parser).type != "RPAREN"):
                        params.append(parseParameter(parser))
                        while (current(parser).type == "COMMA"):
                            advance(parser)
                            params.append(parseParameter(parser))
                    expect(parser, "RPAREN")
                    returnType: str = ""
                    if (current(parser).type == "ARROW"):
                        advance(parser)
                        typeTok: Token = expect(parser, "IDENTIFIER")
                        returnType = typeTok.value
                        None
                    expect(parser, "LBRACE")
                    body: List[Statement] = []
                    while (current(parser).type != "RBRACE"):
                        body.append(parseStatement(parser))
                    expect(parser, "RBRACE")
                    return FunctionDeclaration(name=nameTok.value, parameters=params, returnType=returnType, body=body)
                else:
                    if (tok.type == "IF"):
                        advance(parser)
                        condition: Expression = parseExpression(parser)
                        expect(parser, "LBRACE")
                        thenBody: List[Statement] = []
                        while (current(parser).type != "RBRACE"):
                            thenBody.append(parseStatement(parser))
                        expect(parser, "RBRACE")
                        elseBody: List[Statement] = []
                        if (current(parser).type == "ELSE"):
                            advance(parser)
                            expect(parser, "LBRACE")
                            while (current(parser).type != "RBRACE"):
                                elseBody.append(parseStatement(parser))
                            expect(parser, "RBRACE")
                        return IfStatement(condition=condition, thenBody=thenBody, elseBody=elseBody)
                    else:
                        if (tok.type == "WHILE"):
                            advance(parser)
                            condition: Expression = parseExpression(parser)
                            expect(parser, "LBRACE")
                            body: List[Statement] = []
                            while (current(parser).type != "RBRACE"):
                                body.append(parseStatement(parser))
                            expect(parser, "RBRACE")
                            return WhileStatement(condition=condition, body=body)
                        else:
                            if (tok.type == "FOR"):
                                advance(parser)
                                expect(parser, "LPAREN")
                                init: Statement = parseStatement(parser)
                                condition: Expression = parseExpression(parser)
                                expect(parser, "SEMICOLON")
                                update: Statement = parseStatement(parser)
                                expect(parser, "RPAREN")
                                expect(parser, "LBRACE")
                                body: List[Statement] = []
                                while (current(parser).type != "RBRACE"):
                                    body.append(parseStatement(parser))
                                expect(parser, "RBRACE")
                                return ForStatement(init=init, condition=condition, update=update, body=body)
                            else:
                                if (tok.type == "RETURN"):
                                    advance(parser)
                                    expr: Expression = NilExpr()
                                    if (current(parser).type != "SEMICOLON"):
                                        expr = parseExpression(parser)
                                        None
                                    expect(parser, "SEMICOLON")
                                    return ReturnStatement(expression=expr)
                                else:
                                    if (tok.type == "IMPORT"):
                                        advance(parser)
                                        modulePathTok: Token = expect(parser, "STRING")
                                        modulePath: str = modulePathTok.value
                                        alias: str = ""
                                        if ((current(parser).type == "IDENTIFIER") and (current(parser).value == "as")):
                                            advance(parser)
                                            aliasTok: Token = expect(parser, "IDENTIFIER")
                                            alias = aliasTok.value
                                            None
                                        expect(parser, "SEMICOLON")
                                        return ImportStatement(modulePath=modulePath, alias=alias)
                                    else:
                                        if (tok.type == "EXPORT"):
                                            advance(parser)
                                            declaration: Statement = parseStatement(parser)
                                            return ExportStatement(declaration=declaration)
                                        else:
                                            expr = parseExpression(parser)
                                            expect(parser, "SEMICOLON")
                                            return ExpressionStatement(expression=expr)

def parseParameter(parser: Parser) -> Parameter:
    nameTok: Token = expect(parser, "IDENTIFIER")
    expect(parser, "COLON")
    typeTok: Token = expect(parser, "IDENTIFIER")
    return Parameter(name=nameTok.value, paramType=typeTok.value)

def parseProgram(parser: Parser) -> Program:
    stmts: List[Statement] = []
    while (current(parser).type != "EOF"):
        stmt = parseStatement(parser)
        stmts.append(stmt)
    return Program(statements=stmts)
