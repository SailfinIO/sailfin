from ast_nodes import *
from errors import ValidationError


class ASTValidator:
    @staticmethod
    def validate(node: ASTNode):
        if isinstance(node, Program):
            for stmt in node.statements:
                ASTValidator.validate(stmt)
        elif isinstance(node, list):
            for sub_node in node:
                ASTValidator.validate(sub_node)
        elif isinstance(node, FunctionDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid function name: {node.name}")
            for param in node.params:
                # Expecting parameters as a tuple: (param_name, param_type, default)
                param_name, param_type, _ = param
                if not param_name.isidentifier():
                    raise ValidationError(
                        f"Invalid parameter name: {param_name}")
                if param_type and not param_type.isidentifier():
                    raise ValidationError(
                        f"Invalid parameter type: {param_type}")
            for stmt in node.body:
                ASTValidator.validate(stmt)
        elif isinstance(node, PrintStatement):
            ASTValidator.validate(node.expression)
        elif isinstance(node, Assignment):
            ASTValidator.validate(node.target)
            ASTValidator.validate(node.value)
        elif isinstance(node, VariableDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid variable name: {node.name}")
            ASTValidator.validate(node.value)
        elif isinstance(node, ConstantDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid constant name: {node.name}")
            ASTValidator.validate(node.value)
        elif isinstance(node, EnumDeclaration):
            for variant in node.variants:
                ASTValidator.validate(variant)
        elif isinstance(node, EnumVariant):
            for field in node.fields:
                ASTValidator.validate(field)
        elif isinstance(node, IfStatement):
            ASTValidator.validate(node.condition)
            for stmt in node.then_branch:
                ASTValidator.validate(stmt)
            if node.else_branch:
                for stmt in node.else_branch:
                    ASTValidator.validate(stmt)
        elif isinstance(node, ExpressionStatement):
            ASTValidator.validate(node.expression)
        elif isinstance(node, FunctionCall):
            ASTValidator.validate(node.func_name)
            for arg in node.arguments:
                ASTValidator.validate(arg)
        elif isinstance(node, MemberAccess):
            ASTValidator.validate(node.object_)
        elif isinstance(node, BinOp):
            ASTValidator.validate(node.left)
            ASTValidator.validate(node.right)
        elif isinstance(node, UnaryOp):
            ASTValidator.validate(node.operand)
        elif isinstance(node, Identifier):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid identifier: {node.name}")
        elif isinstance(node, String):
            pass  # Strings are always valid
        elif isinstance(node, Number):
            pass  # Numbers are always valid
        elif isinstance(node, ArrayLiteral):
            for element in node.elements:
                ASTValidator.validate(element)
        elif isinstance(node, WhileLoop):
            ASTValidator.validate(node.condition)
            for stmt in node.body:
                ASTValidator.validate(stmt)
        elif isinstance(node, ForLoop):
            if not node.variable.isidentifier():
                raise ValidationError(
                    f"Invalid loop variable name: {node.variable}")
            ASTValidator.validate(node.iterable)
            for stmt in node.body:
                ASTValidator.validate(stmt)
        elif isinstance(node, LambdaExpression):
            # Validate each parameter: expect a tuple (name, type)
            for param in node.params:
                param_name, param_type = param
                if not param_name.isidentifier():
                    raise ValidationError(
                        f"Invalid lambda parameter name: {param_name}")
                if param_type and not param_type.isidentifier():
                    raise ValidationError(
                        f"Invalid lambda parameter type: {param_type}")
            # Optionally, validate the return type if provided
            if node.return_type and not node.return_type.isidentifier():
                raise ValidationError(
                    f"Invalid lambda return type: {node.return_type}")
            # Validate the lambda body (list of statements)
            for stmt in node.body:
                ASTValidator.validate(stmt)
        elif isinstance(node, ReturnStatement):
            # Validate the return expression if it exists
            if node.expression is not None:
                ASTValidator.validate(node.expression)
        else:
            raise ValidationError(f"Unknown AST node: {type(node).__name__}")
