"""Abstract syntax tree definitions for the Sailfin bootstrap compiler."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import List, Optional, Sequence, Union


# ---------------------------------------------------------------------------
# Base hierarchy
# ---------------------------------------------------------------------------


class ASTNode:
    """Base class for all AST nodes."""


class Statement(ASTNode):
    """Marker base class for statements."""


class Expression(ASTNode):
    """Marker base class for expressions."""


class Pattern(ASTNode):
    """Marker base class for pattern nodes."""


class TypeAnnotation(ASTNode):
    """Marker base class for type annotations."""


# ---------------------------------------------------------------------------
# Utility structures
# ---------------------------------------------------------------------------


@dataclass
class QualifiedName(ASTNode):
    parts: List[str]

    def __str__(self) -> str:  # pragma: no cover - helper for debugging
        return ".".join(self.parts)


@dataclass
class Decorator(ASTNode):
    name: QualifiedName
    arguments: List[Expression] = field(default_factory=list)


@dataclass
class TypeParameter(ASTNode):
    name: str
    bound: Optional[TypeAnnotation] = None


# ---------------------------------------------------------------------------
# Type annotations
# ---------------------------------------------------------------------------


@dataclass
class SimpleType(TypeAnnotation):
    name: QualifiedName
    type_arguments: List[TypeAnnotation] = field(default_factory=list)


@dataclass
class ArrayType(TypeAnnotation):
    element_type: TypeAnnotation


@dataclass
class TupleType(TypeAnnotation):
    elements: List[TypeAnnotation]


@dataclass
class OptionalType(TypeAnnotation):
    base: TypeAnnotation


@dataclass
class UnionType(TypeAnnotation):
    options: List[TypeAnnotation]


@dataclass
class IntersectionType(TypeAnnotation):
    components: List[TypeAnnotation]


@dataclass
class FunctionType(TypeAnnotation):
    parameters: List[TypeAnnotation]
    return_type: TypeAnnotation


# ---------------------------------------------------------------------------
# Parameters and blocks
# ---------------------------------------------------------------------------


@dataclass
class Parameter(ASTNode):
    name: str
    type_annotation: Optional[TypeAnnotation] = None
    default: Optional[Expression] = None
    mutable: bool = False


@dataclass
class Block(ASTNode):
    statements: List[Statement] = field(default_factory=list)


# ---------------------------------------------------------------------------
# Top level declarations
# ---------------------------------------------------------------------------


@dataclass
class Program(ASTNode):
    statements: List[Statement] = field(default_factory=list)


@dataclass
class ImportDeclaration(Statement):
    items: List[str]
    source: str


@dataclass
class TypeAliasDeclaration(Statement):
    name: str
    type_parameters: List[TypeParameter]
    aliased_type: TypeAnnotation


@dataclass
class InterfaceDeclaration(Statement):
    name: str
    members: List['FunctionSignature']
    type_parameters: List[TypeParameter] = field(default_factory=list)


@dataclass
class FunctionSignature(ASTNode):
    name: str
    parameters: List[Parameter]
    return_type: Optional[TypeAnnotation]


@dataclass
class FunctionDeclaration(Statement):
    name: str
    parameters: List[Parameter]
    body: Block
    return_type: Optional[TypeAnnotation] = None
    decorators: List[Decorator] = field(default_factory=list)
    type_parameters: List[TypeParameter] = field(default_factory=list)
    is_async: bool = False


@dataclass
class FieldDeclaration(ASTNode):
    name: str
    type_annotation: TypeAnnotation
    mutable: bool = False


@dataclass
class MethodDeclaration(ASTNode):
    name: str
    parameters: List[Parameter]
    body: Block
    return_type: Optional[TypeAnnotation] = None
    decorators: List[Decorator] = field(default_factory=list)
    type_parameters: List[TypeParameter] = field(default_factory=list)
    is_async: bool = False


StructMember = Union[FieldDeclaration, MethodDeclaration]


@dataclass
class StructDeclaration(Statement):
    name: str
    members: List[StructMember]
    type_parameters: List[TypeParameter] = field(default_factory=list)
    implements: List[SimpleType] = field(default_factory=list)


@dataclass
class EnumVariant(ASTNode):
    name: str
    fields: List[FieldDeclaration] = field(default_factory=list)


@dataclass
class EnumDeclaration(Statement):
    name: str
    variants: List[EnumVariant]
    type_parameters: List[TypeParameter] = field(default_factory=list)


@dataclass
class TestDeclaration(Statement):
    name: str
    body: Block


# ---------------------------------------------------------------------------
# Statements
# ---------------------------------------------------------------------------


@dataclass
class VariableDeclaration(Statement):
    name: str
    initializer: Optional[Expression]
    type_annotation: Optional[TypeAnnotation] = None
    mutable: bool = False


@dataclass
class ConstantDeclaration(Statement):
    name: str
    initializer: Expression
    type_annotation: Optional[TypeAnnotation] = None


@dataclass
class ExpressionStatement(Statement):
    expression: Expression


@dataclass
class ReturnStatement(Statement):
    value: Optional[Expression] = None


@dataclass
class IfStatement(Statement):
    condition: Expression
    then_block: Block
    else_branch: Optional[Union['IfStatement', Block]] = None


@dataclass
class MatchCase(ASTNode):
    pattern: Pattern
    body: Union[Block, Expression]
    guard: Optional[Expression] = None


@dataclass
class MatchStatement(Statement):
    value: Expression
    cases: List[MatchCase]


@dataclass
class ForStatement(Statement):
    pattern: Pattern
    iterable: Expression
    body: Block


@dataclass
class WhileStatement(Statement):
    condition: Expression
    body: Block


@dataclass
class LoopStatement(Statement):
    body: Block


@dataclass
class BreakStatement(Statement):
    pass


@dataclass
class ContinueStatement(Statement):
    pass


@dataclass
class ThrowStatement(Statement):
    expression: Expression


@dataclass
class AssertStatement(Statement):
    expression: Expression


@dataclass
class CatchClause(ASTNode):
    identifier: Optional[str]
    pattern: Optional[Pattern]
    body: Block


@dataclass
class TryStatement(Statement):
    try_block: Block
    catch: Optional[CatchClause] = None
    finally_block: Optional[Block] = None


@dataclass
class RoutineDeclaration(Statement):
    body: Block
    name: Optional[str] = None


@dataclass
class Assignment(Statement, Expression):
    target: Expression
    value: Expression
    operator: str = '='


# ---------------------------------------------------------------------------
# Expressions
# ---------------------------------------------------------------------------


@dataclass
class Identifier(Expression):
    name: str
    type_arguments: List[TypeAnnotation] = field(default_factory=list)


@dataclass
class NumberLiteral(Expression):
    value: Union[int, float]


@dataclass
class StringLiteral(Expression):
    value: str


@dataclass
class BooleanLiteral(Expression):
    value: bool


@dataclass
class NullLiteral(Expression):
    pass


@dataclass
class ArrayLiteral(Expression):
    elements: List[Expression]


@dataclass
class ObjectField(ASTNode):
    name: str
    value: Expression


@dataclass
class ObjectLiteral(Expression):
    fields: List[ObjectField]


@dataclass
class StructLiteral(Expression):
    type_name: QualifiedName
    fields: List[ObjectField]


@dataclass
class MemberExpression(Expression):
    object: Expression
    member: str


@dataclass
class IndexExpression(Expression):
    sequence: Expression
    index: Expression


@dataclass
class CallExpression(Expression):
    callee: Expression
    arguments: List[Expression]


@dataclass
class LambdaExpression(Expression):
    parameters: List[Parameter]
    body: Block
    return_type: Optional[TypeAnnotation] = None


@dataclass
class AwaitExpression(Expression):
    expression: Expression


@dataclass
class AsyncBlockExpression(Expression):
    block: Block


@dataclass
class ParallelExpression(Expression):
    thunks: List[Expression]


@dataclass
class RangeExpression(Expression):
    start: Expression
    end: Expression


@dataclass
class UnaryExpression(Expression):
    operator: str
    operand: Expression


@dataclass
class BinaryExpression(Expression):
    operator: str
    left: Expression
    right: Expression


@dataclass
class TypeCheckExpression(Expression):
    value: Expression
    type_annotation: TypeAnnotation


@dataclass
class MatchExpression(Expression):
    value: Expression
    cases: List[MatchCase]


# ---------------------------------------------------------------------------
# Patterns
# ---------------------------------------------------------------------------


@dataclass
class WildcardPattern(Pattern):
    pass


@dataclass
class IdentifierPattern(Pattern):
    name: str


@dataclass
class LiteralPattern(Pattern):
    value: Expression


@dataclass
class PatternField(ASTNode):
    name: str
    pattern: Optional[Pattern] = None


@dataclass
class ConstructorPattern(Pattern):
    type_name: QualifiedName
    fields: List[PatternField] = field(default_factory=list)


__all__ = [
    # Base markers
    "ASTNode",
    "Statement",
    "Expression",
    "Pattern",
    "TypeAnnotation",
    # Utilities & types
    "QualifiedName",
    "Decorator",
    "TypeParameter",
    "SimpleType",
    "ArrayType",
    "TupleType",
    "OptionalType",
    "UnionType",
    "IntersectionType",
    "FunctionType",
    "Parameter",
    "Block",
    # Declarations
    "Program",
    "ImportDeclaration",
    "TypeAliasDeclaration",
    "InterfaceDeclaration",
    "FunctionSignature",
    "FunctionDeclaration",
    "FieldDeclaration",
    "MethodDeclaration",
    "StructDeclaration",
    "EnumVariant",
    "EnumDeclaration",
    "TestDeclaration",
    # Statements
    "VariableDeclaration",
    "ConstantDeclaration",
    "ExpressionStatement",
    "ReturnStatement",
    "IfStatement",
    "MatchCase",
    "MatchStatement",
    "ForStatement",
    "WhileStatement",
    "LoopStatement",
    "BreakStatement",
    "ContinueStatement",
    "ThrowStatement",
    "AssertStatement",
    "CatchClause",
    "TryStatement",
    "RoutineDeclaration",
    "Assignment",
    # Expressions
    "Identifier",
    "NumberLiteral",
    "StringLiteral",
    "BooleanLiteral",
    "NullLiteral",
    "ArrayLiteral",
    "ObjectField",
    "ObjectLiteral",
    "StructLiteral",
    "MemberExpression",
    "IndexExpression",
    "CallExpression",
    "LambdaExpression",
    "AwaitExpression",
    "AsyncBlockExpression",
    "ParallelExpression",
    "RangeExpression",
    "UnaryExpression",
    "BinaryExpression",
    "TypeCheckExpression",
    "MatchExpression",
    # Patterns
    "WildcardPattern",
    "IdentifierPattern",
    "LiteralPattern",
    "PatternField",
    "ConstructorPattern",
]

