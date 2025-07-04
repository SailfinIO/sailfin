from ast_nodes import *
from errors import ValidationError
from parser import stringify_type
import re


class ASTValidator:
    def __init__(self):
        self.current_type_params = set()

    def is_valid_type(self, t) -> bool:
        # Convert AST node to string if needed
        if hasattr(t, '__class__') and not isinstance(t, str):
            t = stringify_type(t)

        # Check if t is a type parameter
        if t in self.current_type_params:
            return True

        # This regex allows one or more type segments (identifiers with optional array notation and optional '?' suffix)
        # separated by union (|) or intersection (&) operators.
        # Now supports: TypeName, TypeName[], TypeName?, TypeName[]?, A|B, A&B, etc.
        pattern = r'^(?:[A-Za-z_][A-Za-z0-9_]*(?:\[\])*\??)(?:[|&][A-Za-z_][A-Za-z0-9_]*(?:\[\])*\??)*$'
        return re.fullmatch(pattern, t) is not None

    def validate(self, node: ASTNode):
        if isinstance(node, Program):
            for stmt in node.statements:
                self.validate(stmt)
        elif isinstance(node, list):
            for sub_node in node:
                self.validate(sub_node)
        elif isinstance(node, FunctionDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid function name: {node.name}")
            for param in node.params:
                # Expecting parameters as a tuple: (param_name, param_type, default)
                param_name, param_type, _ = param
                if not param_name.name.isidentifier():
                    raise ValidationError(
                        f"Invalid parameter name: {param_name.name}")

                if param_type:
                    # Convert param_type to a string representation if needed.
                    param_type_str = param_type if isinstance(
                        param_type, str) else stringify_type(param_type)
                    if not self.is_valid_type(param_type_str):
                        raise ValidationError(
                            f"Invalid parameter type: {param_type_str}")
            for stmt in node.body:
                self.validate(stmt)

        elif isinstance(node, MethodDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid method name: {node.name}")
            for param in node.params:
                # Handle both 2-tuple and 3-tuple parameter formats.
                if len(param) == 3:
                    param_name, param_type, _ = param
                else:
                    param_name, param_type = param[0], param[1]
                if not param_name.name.isidentifier():
                    raise ValidationError(
                        f"Invalid method parameter name: {param_name.name}")

                if param_type:
                    param_type_str = param_type if isinstance(
                        param_type, str) else stringify_type(param_type)
                    if not self.is_valid_type(param_type_str):
                        raise ValidationError(
                            f"Invalid method parameter type: {param_type_str}")
            for stmt in node.body:
                self.validate(stmt)

        elif isinstance(node, StructDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid struct name: {node.name}")

            # Validate type parameters
            for type_param in node.type_params:
                if not type_param.isidentifier():
                    raise ValidationError(
                        f"Invalid type parameter: {type_param}")

            # Set current type parameters context
            prev_type_params = self.current_type_params.copy()
            self.current_type_params.update(node.type_params)

            for member in node.members:
                self.validate(member)

            # Restore previous type parameters context
            self.current_type_params = prev_type_params
        # In the validator for FieldDeclaration:
        elif isinstance(node, FieldDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid field name: {node.name}")
            if not self.is_valid_type(node.field_type):
                raise ValidationError(f"Invalid field type: {node.field_type}")
        elif isinstance(node, InterfaceDeclaration):
            # New branch: validate interface declarations
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid interface name: {node.name}")

            for member in node.members:
                self.validate(member)
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
                # Handle param_name as either string or Identifier object
                param_name_str = param_name.name if hasattr(
                    param_name, 'name') else param_name
                if not param_name_str.isidentifier():
                    raise ValidationError(
                        f"Invalid interface method parameter name: {param_name_str}")
                # Handle param_type as either string or Identifier object
                if param_type:
                    param_type_str = param_type.name if hasattr(
                        param_type, 'name') else param_type
                    if not param_type_str.isidentifier():
                        raise ValidationError(
                            f"Invalid interface method parameter type: {param_type_str}")
        elif isinstance(node, InterfaceProperty):
            # Validate interface properties
            if not node.name.isidentifier():
                raise ValidationError(
                    f"Invalid interface property name: {node.name}")
            if node.property_type:
                # Convert property_type to string representation if needed
                property_type_str = node.property_type if isinstance(
                    node.property_type, str) else stringify_type(node.property_type)
                if not self.is_valid_type(property_type_str):
                    raise ValidationError(
                        f"Invalid interface property type: {property_type_str}")
        elif isinstance(node, TypeCheck):
            # Validate type check expressions (e.g., value is string)
            self.validate(node.expr)
            if not self.is_valid_type(node.type_name):
                raise ValidationError(
                    f"Invalid type name in type check: {node.type_name}")
        elif isinstance(node, PrintStatement):
            self.validate(node.expression)
        elif isinstance(node, AssertStatement):
            self.validate(node.condition)
        elif isinstance(node, TestDeclaration):
            # Validate test description is a string, body statements are valid
            for stmt in node.body:
                self.validate(stmt)
        elif isinstance(node, Assignment):
            self.validate(node.target)
            self.validate(node.value)
        elif isinstance(node, VariableDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid variable name: {node.name}")
            self.validate(node.value)
        elif isinstance(node, ConstantDeclaration):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid constant name: {node.name}")
            self.validate(node.value)
        elif isinstance(node, EnumDeclaration):
            for variant in node.variants:
                self.validate(variant)
        elif isinstance(node, TypeAliasDeclaration):
            # Validate type alias declarations
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid type alias name: {node.name}")
            # Validate the aliased type by converting to string representation
            aliased_type_str = node.aliased_type if isinstance(
                node.aliased_type, str) else stringify_type(node.aliased_type)
            if not self.is_valid_type(aliased_type_str):
                raise ValidationError(
                    f"Invalid aliased type: {aliased_type_str}")
        elif isinstance(node, EnumVariant):
            for field in node.fields:
                self.validate(field)
        elif isinstance(node, IfStatement):
            self.validate(node.condition)
            for stmt in node.then_branch:
                self.validate(stmt)
            if node.else_branch:
                for stmt in node.else_branch:
                    self.validate(stmt)
        elif isinstance(node, ExpressionStatement):
            self.validate(node.expression)
        elif isinstance(node, FunctionCall):
            self.validate(node.func_name)
            for arg in node.arguments:
                self.validate(arg)
        elif isinstance(node, MemberAccess):
            self.validate(node.object_)
        elif isinstance(node, BinOp):
            self.validate(node.left)
            self.validate(node.right)
        elif isinstance(node, UnaryOp):
            self.validate(node.operand)
        elif isinstance(node, Identifier):
            if not node.name.isidentifier():
                raise ValidationError(f"Invalid identifier: {node.name}")
        elif isinstance(node, String):
            pass  # Strings are always valid
        elif isinstance(node, Number):
            pass  # Numbers are always valid
        elif isinstance(node, ArrayLiteral):
            for element in node.elements:
                self.validate(element)
        elif isinstance(node, DictionaryLiteral):
            for key, value in node.pairs:
                self.validate(key)
                self.validate(value)
        elif isinstance(node, ArrayIndexing):
            # New branch for array indexing expressions
            self.validate(node.object_)
            self.validate(node.index)
        elif isinstance(node, AsyncBlock):
            # Validate async block expressions
            for stmt in node.body:
                self.validate(stmt)
        elif isinstance(node, Routine):
            # Validate routine expressions
            for stmt in node.body:
                self.validate(stmt)
        elif isinstance(node, Await):
            # Validate await expressions
            self.validate(node.expression)
        elif isinstance(node, WhileLoop):
            self.validate(node.condition)
            for stmt in node.body:
                self.validate(stmt)
        elif isinstance(node, ForLoop):
            if not node.variable.isidentifier():
                raise ValidationError(
                    f"Invalid loop variable name: {node.variable}")
            self.validate(node.iterable)
            for stmt in node.body:
                self.validate(stmt)
        elif isinstance(node, ImportStatement):
            # Validate import statements
            if not isinstance(node.source, str) or not node.source:
                raise ValidationError(
                    "Import source must be a non-empty string")
            if not isinstance(node.items, list) or not node.items:
                raise ValidationError("Import items must be a non-empty list")
            for item in node.items:
                if not isinstance(item, str) or not item.isidentifier():
                    raise ValidationError(f"Invalid import item: {item}")
        elif isinstance(node, LambdaExpression):
            for param in node.params:
                param_name, param_type = param
                if not param_name.name.isidentifier():
                    raise ValidationError(
                        f"Invalid lambda parameter name: {param_name.name}")

                # Handle param_type as either string or Identifier object
                if param_type:
                    param_type_str = param_type.name if hasattr(
                        param_type, 'name') else param_type
                    if not param_type_str.isidentifier():
                        raise ValidationError(
                            f"Invalid lambda parameter type: {param_type_str}")
            # Handle return_type as either string or Identifier object
            if node.return_type:
                return_type_str = node.return_type.name if hasattr(
                    node.return_type, 'name') else node.return_type
                if not return_type_str.isidentifier():
                    raise ValidationError(
                        f"Invalid lambda return type: {return_type_str}")
            for stmt in node.body:
                self.validate(stmt)

            for stmt in node.body:
                self.validate(stmt)
        elif isinstance(node, ReturnStatement):
            if node.expression is not None:
                self.validate(node.expression)
        elif isinstance(node, StructInstantiation):
            # Handle struct_name as either string or Identifier object
            struct_name_str = node.struct_name.name if hasattr(
                node.struct_name, 'name') else node.struct_name
            if not struct_name_str.isidentifier():
                raise ValidationError(
                    f"Invalid struct instantiation name: {struct_name_str}")
            for field_name, expr in node.field_inits:
                # Handle field_name as either string or Identifier object
                field_name_str = field_name.name if hasattr(
                    field_name, 'name') else field_name
                if not field_name_str.isidentifier():
                    raise ValidationError(
                        f"Invalid field name in struct instantiation: {field_name_str}")
                self.validate(expr)
        elif isinstance(node, EnumVariantConstruction):
            # Handle enum_name as either string or Identifier object
            enum_name_str = node.enum_name.name if hasattr(
                node.enum_name, 'name') else node.enum_name
            if not enum_name_str.isidentifier():
                raise ValidationError(
                    f"Invalid enum name in variant construction: {enum_name_str}")
            # Handle variant_name as either string or Identifier object
            variant_name_str = node.variant_name.name if hasattr(
                node.variant_name, 'name') else node.variant_name
            if not variant_name_str.isidentifier():
                raise ValidationError(
                    f"Invalid variant name in enum construction: {variant_name_str}")
            for field_name, expr in node.field_inits:
                # Handle field_name as either string or Identifier object
                field_name_str = field_name.name if hasattr(
                    field_name, 'name') else field_name
                if not field_name_str.isidentifier():
                    raise ValidationError(
                        f"Invalid field name in enum variant construction: {field_name_str}")
                self.validate(expr)
        elif isinstance(node, MatchStatement):
            self.validate(node.condition)
            for arm in node.arms:
                self.validate(arm)
        elif isinstance(node, MatchArm):
            self.validate(node.pattern)
            if node.guard:
                self.validate(node.guard)
            for stmt in node.body:
                self.validate(stmt)
        elif isinstance(node, TryFinally):
            for stmt in node.try_block:
                self.validate(stmt)
            for stmt in node.finally_block:
                self.validate(stmt)
        elif isinstance(node, TryCatchFinally):
            for stmt in node.try_block:
                self.validate(stmt)
            for error_type, error_var, catch_block in node.catch_blocks:
                if not error_type.isidentifier():
                    raise ValidationError(
                        f"Invalid error type name: {error_type}")
                if not error_var.isidentifier():
                    raise ValidationError(
                        f"Invalid error variable name: {error_var}")
                for stmt in catch_block:
                    self.validate(stmt)
            if node.finally_block:
                for stmt in node.finally_block:
                    self.validate(stmt)
        elif isinstance(node, NumberPattern):
            pass  # Numbers are always valid in patterns
        elif isinstance(node, WildcardPattern):
            pass  # Wildcard patterns are always valid
        elif isinstance(node, TaggedPattern):
            # Handle type_name as either string or Identifier object
            type_name_str = node.type_name.name if hasattr(
                node.type_name, 'name') else node.type_name
            if not type_name_str.isidentifier():
                raise ValidationError(
                    f"Invalid tagged pattern type name: {type_name_str}")
            for field in node.fields:
                # Handle field as either string or Identifier object
                field_str = field.name if hasattr(field, 'name') else field
                if not field_str.isidentifier():
                    raise ValidationError(
                        f"Invalid tagged pattern field: {field_str}")
        elif isinstance(node, FunctionExpression):
            for param in node.params:
                # FunctionExpression parameters can be 2-tuples (param_name, param_type) or 3-tuples (param_name, param_type, default)
                if len(param) == 2:
                    param_name, param_type = param
                else:
                    param_name, param_type, _ = param

                if not param_name.name.isidentifier():
                    raise ValidationError(
                        f"Invalid parameter name: {param_name.name}")

                if param_type:
                    # Convert param_type to a string representation if needed.
                    param_type_str = param_type if isinstance(
                        param_type, str) else stringify_type(param_type)
                    if not self.is_valid_type(param_type_str):
                        raise ValidationError(
                            f"Invalid parameter type: {param_type_str}")
            for stmt in node.body:
                self.validate(stmt)
        elif isinstance(node, RangeExpression):
            # Validate the start and end expressions of the range
            self.validate(node.start)
            self.validate(node.end)
        else:
            raise ValidationError(f"Unknown AST node: {type(node).__name__}")
