# bootstrap/ast_nodes.py

from dataclasses import dataclass, field
from typing import List, Optional, Dict, Tuple, Union


@dataclass
class ASTNode:
    pass


@dataclass
class Expression(ASTNode):
    pass


@dataclass
class UnaryOp(Expression):
    operator: str
    operand: Expression


@dataclass
class BinOp(Expression):
    operator: str
    left: Expression
    right: Expression


@dataclass
class Number(Expression):
    value: Union[int, float]


@dataclass
class String(Expression):
    value: str


@dataclass
class Identifier(Expression):
    name: str


@dataclass
class UnionType(Expression):
    left: Expression
    right: Expression


@dataclass
class IntersectionType(Expression):
    left: Expression
    right: Expression


@dataclass
class TypeCheck(Expression):
    expr: Expression
    type_name: str


@dataclass
class FunctionCall(Expression):
    func_name: Union[Identifier, 'MemberAccess']
    arguments: List[Expression]


@dataclass
class MemberAccess(Expression):
    object_: Expression
    member: str


@dataclass
class Program(ASTNode):
    statements: List[ASTNode]


@dataclass
class PrintStatement(ASTNode):
    expression: Expression


@dataclass
class AssertStatement(ASTNode):
    condition: Expression


@dataclass
class VariableDeclaration(ASTNode):
    name: str
    var_type: Optional[ASTNode]
    value: Expression
    mutable: bool = False


@dataclass
class ConstantDeclaration(ASTNode):
    name: str
    var_type: ASTNode
    value: Expression


@dataclass
class FunctionDeclaration(ASTNode):
    name: str
    # Now each parameter name is an Identifier
    params: List[Tuple[Identifier, Optional[ASTNode]]]
    return_type: Optional[ASTNode]
    body: List[ASTNode]
    type_params: List[str] = field(default_factory=list)
    decorators: List[str] = field(default_factory=list)
    is_async: bool = False


@dataclass
class IfStatement(ASTNode):
    condition: Expression
    then_branch: List[ASTNode]
    else_branch: Optional[List[ASTNode]] = None


@dataclass
class ReturnStatement(ASTNode):
    expression: Optional[Expression] = None


@dataclass
class StructDeclaration(ASTNode):
    name: str
    members: List[Union['FieldDeclaration', 'MethodDeclaration']]
    type_params: List[str] = field(default_factory=list)
    interfaces: List[str] = field(default_factory=list)


@dataclass
class StructInstantiation(Expression):
    struct_name: str
    field_inits: List[Tuple[str, Expression]]


@dataclass
class EnumVariantConstruction(Expression):
    enum_name: Expression  # Usually an Identifier, but could be a MemberAccess
    variant_name: str
    field_inits: List[Tuple[str, Expression]]


@dataclass
class FieldDeclaration(ASTNode):
    name: str
    field_type: ASTNode
    mutable: bool = False


@dataclass
@dataclass
class MethodDeclaration(ASTNode):
    name: str
    # Now each parameter name is an Identifier
    params: List[Tuple[Identifier, Optional[ASTNode]]]
    return_type: Optional[ASTNode]
    body: List[ASTNode]
    type_params: List[str] = field(default_factory=list)
    decorators: List[str] = field(default_factory=list)
    is_async: bool = False


@dataclass
class InterfaceDeclaration(ASTNode):
    name: str
    members: List[Union['InterfaceMethod', 'InterfaceProperty']]
    type_params: List[str] = field(default_factory=list)


@dataclass
class InterfaceMethod(ASTNode):
    name: str
    # List of (param_name, param_type)
    params: List[Tuple[str, Optional[ASTNode]]]
    return_type: Optional[ASTNode]


@dataclass
class InterfaceProperty(ASTNode):
    name: str
    property_type: Optional[ASTNode]


@dataclass
class EnumDeclaration(ASTNode):
    name: str
    variants: List['EnumVariant']


@dataclass
class EnumVariant(ASTNode):
    name: str
    value: Optional[str] = None      # Added to hold assigned string values
    fields: List[FieldDeclaration] = field(default_factory=list)


@dataclass
class MatchStatement(ASTNode):
    condition: Expression
    arms: List['MatchArm']


@dataclass
class MatchArm(ASTNode):
    pattern: 'Pattern'
    guard: Optional[Expression] = None
    body: List[ASTNode] = field(default_factory=list)


@dataclass
class Pattern(ASTNode):
    pass


@dataclass
class NumberPattern(Pattern):
    value: Union[int, float]


@dataclass
class WildcardPattern(Pattern):
    pass


@dataclass
class TaggedPattern(Pattern):
    type_name: str
    variant: str
    fields: List[str] = field(default_factory=list)


@dataclass
class Assignment(ASTNode):
    target: Union[Identifier, MemberAccess]
    value: Expression


@dataclass
class ExpressionStatement(ASTNode):
    expression: Expression


@dataclass
class ImportStatement(ASTNode):
    items: List[str]
    source: str


@dataclass
class ImportModuleStatement(ASTNode):
    source: str
    alias: str


@dataclass
class TypeAliasDeclaration(ASTNode):
    name: str
    aliased_type: ASTNode


@dataclass
class LambdaExpression(Expression):
    params: List[Tuple[str, ASTNode]]  # Each is (name, type)
    return_type: Optional[ASTNode]
    body: List[ASTNode]


@dataclass
class Await(Expression):
    expression: Expression


@dataclass
class AsyncBlock(Expression):
    body: List[ASTNode]


@dataclass
class Routine(Expression):
    name: Optional[str]  # Optional name for the routine
    body: List[ASTNode]


@dataclass
class TryFinally(ASTNode):
    try_block: List[ASTNode]
    finally_block: List[ASTNode]


@dataclass
class TryCatchFinally(ASTNode):
    try_block: List[ASTNode]
    # List of (error_type, error_var, block)
    catch_blocks: List[Tuple[str, str, List[ASTNode]]]
    finally_block: Optional[List[ASTNode]] = None


@dataclass
class ThrowStatement(ASTNode):
    expression: Expression


@dataclass
class ArrayLiteral(Expression):
    elements: List[Expression]


@dataclass
class ParallelExpression(Expression):
    tasks: List[Expression]


@dataclass
class DictionaryLiteral(Expression):
    pairs: List[Tuple[Expression, Expression]]  # List of (key, value) pairs


@dataclass
class WhileLoop(ASTNode):
    condition: Expression
    body: List[ASTNode]


@dataclass
class ForLoop(ASTNode):
    variable: str
    iterable: Expression
    body: List[ASTNode]


@dataclass
class RangeExpression(Expression):
    start: Expression
    end: Expression


@dataclass
class TestDeclaration(ASTNode):
    description: str
    body: List[ASTNode]


@dataclass
class ArrayIndexing(Expression):
    object_: Expression
    index: Expression


@dataclass
class FunctionExpression(Expression):
    params: List[Tuple[Identifier, Optional[ASTNode]]]
    return_type: Optional[ASTNode]
    body: List[ASTNode]


# First-class array and optional AST types


@dataclass
class ArrayType(ASTNode):
    element_type: ASTNode


@dataclass
class OptionalType(ASTNode):
    base: ASTNode


@dataclass
class TypeApplication(Expression):
    base: Expression
    type_args: List[ASTNode]
    arguments: List[Expression]


# Removed duplicate Identifier definition to avoid conflicts
