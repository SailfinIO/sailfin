# bootstrap/ast_nodes.py

class ASTNode:
    pass


class Expression(ASTNode):
    pass


class Program(ASTNode):
    def __init__(self, statements):
        self.statements = statements


class PrintStatement(ASTNode):
    def __init__(self, expression):
        self.expression = expression


class VariableDeclaration(ASTNode):
    def __init__(self, name, var_type, value, mutable=False):
        self.name = name
        self.var_type = var_type  # Can be None if type is not specified
        self.value = value
        self.mutable = mutable


class ConstantDeclaration(ASTNode):
    def __init__(self, name, var_type, value):
        self.name = name
        self.var_type = var_type
        self.value = value


class FunctionDeclaration(ASTNode):
    def __init__(self, name, params, return_type, body, decorators=None):
        self.name = name
        self.params = params  # List of tuples: (param_name, param_type)
        self.return_type = return_type
        self.body = body  # List of statements
        self.decorators = decorators if decorators else []  # List of decorator names


class BinOp(Expression):
    def __init__(self, operator, left, right):
        self.operator = operator
        self.left = left
        self.right = right


class Number(Expression):
    def __init__(self, value):
        self.value = value


class String(Expression):
    def __init__(self, value):
        self.value = value


class Identifier(Expression):
    def __init__(self, name):
        self.name = name


class IfStatement(ASTNode):
    def __init__(self, condition, then_branch, else_branch=None):
        self.condition = condition
        self.then_branch = then_branch  # List of statements
        self.else_branch = else_branch  # List of statements or None


class ReturnStatement(ASTNode):
    def __init__(self, expression=None):
        self.expression = expression


class StructDeclaration(ASTNode):
    def __init__(self, name, members):
        self.name = name
        self.members = members  # List of FieldDeclaration


class FieldDeclaration(ASTNode):
    def __init__(self, name, field_type, mutable=False):
        self.name = name
        self.field_type = field_type
        self.mutable = mutable


class FunctionCall(Expression):
    def __init__(self, func_name, arguments):
        self.func_name = func_name
        self.arguments = arguments  # List of expressions


class MemberAccess(Expression):
    def __init__(self, object_, member):
        self.object = object_
        self.member = member


class Assignment(ASTNode):
    def __init__(self, target, value):
        self.target = target  # Identifier or MemberAccess
        self.value = value


class MethodDeclaration(ASTNode):
    def __init__(self, name, params, return_type, body, decorators=None):
        self.name = name
        self.params = params  # List of tuples: (param_name, param_type)
        self.return_type = return_type
        self.body = body  # List of statements
        self.decorators = decorators if decorators else []


class EnumDeclaration(ASTNode):
    def __init__(self, name, variants):
        self.name = name
        self.variants = variants  # List of EnumVariant


class EnumVariant(ASTNode):
    def __init__(self, name, fields=None):
        self.name = name
        self.fields = fields if fields else []  # List of FieldDeclaration


class ExpressionStatement(ASTNode):
    def __init__(self, expression):
        self.expression = expression


class LambdaExpression(Expression):
    def __init__(self, params, body):
        self.params = params
        self.body = body


class ImportStatement(ASTNode):
    def __init__(self, items, source):
        self.items = items  # List of identifiers
        self.source = source  # String literal


class TypeAliasDeclaration(ASTNode):
    def __init__(self, name, aliased_type):
        self.name = name
        self.aliased_type = aliased_type


class MatchStatement(ASTNode):
    def __init__(self, condition, arms):
        self.condition = condition
        self.arms = arms


class MatchArm(ASTNode):
    def __init__(self, pattern, body):
        self.pattern = pattern
        self.body = body


class NumberPattern(ASTNode):
    def __init__(self, value):
        self.value = value


class WildcardPattern(ASTNode):
    pass


class ArrayLiteral(Expression):
    def __init__(self, elements):
        self.elements = elements  # List of expressions
