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
        elif isinstance(node, MethodDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid method name: {node.name}")
            # Method parameters are defined as (param_name, param_type, default)
            for param in node.params:
                if len(param) == 3:
                    param_name, param_type, _ = param
                else:
                    param_name, param_type = param[0], param[1]
                if not param_name.isidentifier():
                    raise ValidationError(
                        f"Invalid method parameter name: {param_name}")
                if param_type and not param_type.isidentifier():
                    raise ValidationError(
                        f"Invalid method parameter type: {param_type}")
            for stmt in node.body:
                ASTValidator.validate(stmt)
        elif isinstance(node, StructDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid struct name: {node.name}")
            for member in node.members:
                ASTValidator.validate(member)
        elif isinstance(node, FieldDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid field name: {node.name}")
            if not node.field_type.isidentifier():
                raise ValidationError(f"Invalid field type: {node.field_type}")
        elif isinstance(node, InterfaceDeclaration):
            # New branch: validate interface declarations
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid interface name: {node.name}")
            for method in node.methods:
                ASTValidator.validate(method)
        elif isinstance(node, InterfaceMethod):
            # Validate interface methods
            if not node.name.isidentifier():
                raise ValidationError(
                    f"Invalid interface method name: {node.name}")
            for param in node.params:
                # Unpack assuming a three-element tuple (e.g., ('self', None, None)).
                if len(param) == 3:
                    param_name, param_type, _ = param
                else:
                    param_name, param_type = param[0], param[1]
                if not param_name.isidentifier():
                    raise ValidationError(
                        f"Invalid interface method parameter name: {param_name}")
                if param_type and not param_type.isidentifier():
                    raise ValidationError(
                        f"Invalid interface method parameter type: {param_type}")
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
        elif isinstance(node, ArrayIndexing):
            # New branch for array indexing expressions
            ASTValidator.validate(node.object_)
            ASTValidator.validate(node.index)
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
            for param in node.params:
                param_name, param_type = param
                if not param_name.isidentifier():
                    raise ValidationError(
                        f"Invalid lambda parameter name: {param_name}")
                if param_type and not param_type.isidentifier():
                    raise ValidationError(
                        f"Invalid lambda parameter type: {param_type}")
            if node.return_type and not node.return_type.isidentifier():
                raise ValidationError(
                    f"Invalid lambda return type: {node.return_type}")
            for stmt in node.body:
                ASTValidator.validate(stmt)
        elif isinstance(node, ReturnStatement):
            if node.expression is not None:
                ASTValidator.validate(node.expression)
        elif isinstance(node, StructInstantiation):
            if not node.struct_name.isidentifier():
                raise ValidationError(
                    f"Invalid struct instantiation name: {node.struct_name}")
            for field_name, expr in node.field_inits:
                if not field_name.isidentifier():
                    raise ValidationError(
                        f"Invalid field name in struct instantiation: {field_name}")
                ASTValidator.validate(expr)
        else:
            raise ValidationError(f"Unknown AST node: {type(node).__name__}")
