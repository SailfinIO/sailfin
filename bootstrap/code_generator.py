# bootstrap/code_generator.py

import enum
import re
import uuid
from ast_nodes import (
    ArrayLiteral, EnumDeclaration, EnumVariant, ExpressionStatement, ImportStatement,
    LambdaExpression, MatchStatement, MethodDeclaration, NumberPattern, Program,
    FunctionDeclaration, TypeAliasDeclaration, VariableDeclaration, ConstantDeclaration,
    PrintStatement, IfStatement, ReturnStatement, StructDeclaration,
    FieldDeclaration, BinOp, Number, String, Identifier, FunctionCall,
    MemberAccess, Assignment, WildcardPattern
)


class CodeGenerator:
    def __init__(self):
        self.imports_set = set()
        self.global_code = []

    def generate_code(self, ast, indent_level=0, top_level=True, global_vars=None):
        if top_level:
            # Reset imports_set for each top-level generation
            self.imports_set.clear()

        if global_vars is None:
            global_vars = set()

        # Collect global variable declarations if top level
        if top_level:
            for stmt in ast.statements:
                if isinstance(stmt, VariableDeclaration) or isinstance(stmt, ConstantDeclaration):
                    global_vars.add(stmt.name)

        # Generate code for statements
        code = ""
        for stmt in ast.statements:
            code += self.generate_statement(stmt, indent_level, global_vars)

        # Only at the very end (top-level = True) do we prepend imports & global lambdas
        if top_level:
            if self.imports_set:
                sorted_imports = sorted(self.imports_set)
                print(f"Imports to prepend: {sorted_imports}")  # Debugging
                imports_str = "\n".join(sorted_imports) + "\n\n"
                code = imports_str + code
            else:
                print("No imports to prepend.")

            if self.global_code:
                print(f"Global code to prepend: {
                      self.global_code}")  # Debugging
                code = "".join(self.global_code) + "\n" + code

            # And if there's a main, add the "if __name__..." snippet
            if any(isinstance(stmt, FunctionDeclaration) and stmt.name == 'main'
                   for stmt in ast.statements):
                code += '\nif __name__ == "__main__":\n    main()\n'

        return code

    def generate_statement(self, stmt, indent_level, global_vars):
        indent = "    " * indent_level
        code = ""
        if isinstance(stmt, PrintStatement):
            expr = self.generate_expression(stmt.expression)
            code += f"{indent}print({expr})\n"
        elif isinstance(stmt, VariableDeclaration):
            var = stmt.name
            value = self.generate_expression(stmt.value)
            if stmt.mutable:
                code += f"{indent}{var} = {value}  # Mutable variable\n"
            else:
                code += f"{indent}{var} = {value}\n"
        elif isinstance(stmt, ConstantDeclaration):
            var = stmt.name
            value = self.generate_expression(stmt.value)
            code += f"{indent}{var} = {value}  # Constant\n"
        elif isinstance(stmt, FunctionDeclaration):
            decorators = ""
            for decorator in stmt.decorators:
                decorators += f"{indent}@{decorator}\n"
            params = ", ".join([param[0] for param in stmt.params])
            code += decorators
            code += f"{indent}def {stmt.name}({params}):\n"
            if not stmt.body:
                code += f"{indent}    pass\n"
            else:
                # Detect if the function modifies any global variables
                modified_globals = self.find_modified_globals(
                    stmt.body, global_vars)
                if modified_globals:
                    # Insert global declarations
                    for var in modified_globals:
                        code += f"{indent}    global {var}\n"
                # Recursively generate code for the function body with increased indentation
                function_body_ast = Program(stmt.body)
                code += self.generate_code(function_body_ast,
                                           indent_level + 1, top_level=False, global_vars=global_vars)
        elif isinstance(stmt, MethodDeclaration):
            decorators = ""
            for decorator in stmt.decorators:
                decorators += f"{indent}@{decorator}\n"
            method_params = ", ".join([param[0] for param in stmt.params])
            # Ensure 'self' is included
            if not method_params.startswith('self'):
                method_params = "self, " + method_params
            code += decorators
            code += f"{indent}def {stmt.name}({method_params}):\n"
            if not stmt.body:
                code += f"{indent}    pass\n"
            else:
                method_body_ast = Program(stmt.body)
                code += self.generate_code(method_body_ast,
                                           indent_level + 2, top_level=False, global_vars=global_vars)
        elif isinstance(stmt, IfStatement):
            condition = self.generate_expression(stmt.condition)
            code += f"{indent}if {condition}:\n"
            if not stmt.then_branch:
                code += f"{indent}    pass\n"
            else:
                then_branch_ast = Program(stmt.then_branch)
                code += self.generate_code(then_branch_ast,
                                           indent_level + 1, global_vars=global_vars, top_level=False)
            if stmt.else_branch:
                code += f"{indent}else:\n"
                else_branch_ast = Program(stmt.else_branch)
                code += self.generate_code(else_branch_ast,
                                           indent_level + 1, global_vars=global_vars, top_level=False)
        elif isinstance(stmt, EnumDeclaration):
            # Add import enum to imports_set
            self.imports_set.add("import enum")
            print("Added 'import enum' to imports_set")  # Debugging
            code += f"{indent}class {stmt.name}(enum.Enum):\n"
            if not stmt.variants:
                code += f"{indent}    pass\n"
            else:
                for variant in stmt.variants:
                    if variant.fields:
                        # Handle variants with fields using tuple values
                        field_count = len(variant.fields)
                        fields_placeholder = ", ".join(['...'] * field_count)
                        code += f"{indent}    {
                            variant.name} = ({fields_placeholder})\n"
                    else:
                        code += f"{indent}    {variant.name} = enum.auto()\n"
            code += "\n"
        elif isinstance(stmt, ReturnStatement):
            if stmt.expression:
                expr = self.generate_expression(stmt.expression)
                code += f"{indent}return {expr}\n"
            else:
                code += f"{indent}return\n"
        elif isinstance(stmt, StructDeclaration):
            code += f"{indent}class {stmt.name}:\n"
            if not stmt.members:
                code += f"{indent}    pass\n"
            else:
                # Separate fields and methods
                fields = [m for m in stmt.members if isinstance(
                    m, FieldDeclaration)]
                methods = [m for m in stmt.members if isinstance(
                    m, MethodDeclaration)]

                # Constructor
                init_params = ['self']
                init_body = ""
                for field in fields:
                    init_params.append(field.name)
                    init_body += f"{indent}        self.{field.name} = {field.name}\n"
                params_str = ", ".join(init_params)
                code += f"{indent}    def __init__({params_str}):\n"
                if not init_body:
                    code += f"{indent}        pass\n"
                else:
                    code += init_body

                # Methods
                for method in methods:
                    method_decorators = ""
                    for decorator in method.decorators:
                        method_decorators += f"{indent}    @{decorator}\n"
                    method_params = ", ".join(
                        [param[0] for param in method.params])
                    # Ensure 'self' is included
                    if not method_params.startswith('self'):
                        method_params = "self, " + method_params
                    code += method_decorators
                    code += f"{indent}    def {
                        method.name}({method_params}):\n"
                    if not method.body:
                        code += f"{indent}        pass\n"
                    else:
                        method_body_ast = Program(method.body)
                        code += self.generate_code(method_body_ast,
                                                   indent_level + 2, global_vars=global_vars, top_level=False)
                # Add __repr__ method for better debugging
                code += f"{indent}    def __repr__(self):\n"
                repr_fields = ", ".join(
                    [f"{field.name}={{self.{field.name}!r}}" for field in fields])
                code += f"{indent}        return f\"{
                    stmt.name}({repr_fields})\"\n"
        elif isinstance(stmt, Assignment):
            target = self.generate_expression(stmt.target)
            value = self.generate_expression(stmt.value)
            code += f"{indent}{target} = {value}\n"
        elif isinstance(stmt, ExpressionStatement):
            expr_code = self.generate_expression(stmt.expression)
            code += f"{indent}{expr_code}\n"
        elif isinstance(stmt, ImportStatement):
            items = ", ".join(stmt.items)
            source = stmt.source
            code += f"{indent}from {source} import {items}\n"
        elif isinstance(stmt, TypeAliasDeclaration):
            code += f"{indent}{stmt.name} = {stmt.aliased_type}  # Type Alias\n"
        elif isinstance(stmt, MatchStatement):
            # Use stmt.condition instead of stmt.value
            cond_expr = self.generate_expression(stmt.condition)
            code += f"{indent}match {cond_expr}:\n"

            # Loop over stmt.arms (not stmt.cases)
            for arm in stmt.arms:
                pattern_code = self.generate_pattern_expression(arm.pattern)
                code += f"{indent}    case {pattern_code}:\n"

                # Generate code for the arm's body
                case_body_ast = Program(arm.body)
                code += self.generate_code(case_body_ast,
                                           indent_level + 2, global_vars=global_vars, top_level=False)
        else:
            # Debugging aid
            print(f"Unhandled statement type: {type(stmt).__name__}")
            raise NotImplementedError(f"Code generation for {
                                      type(stmt).__name__} not implemented.")
        return code

    def generate_expression(self, expr):
        if isinstance(expr, BinOp):
            left = self.generate_expression(expr.left)
            right = self.generate_expression(expr.right)
            return f"({left} {expr.operator} {right})"
        elif isinstance(expr, Number):
            return str(expr.value)
        elif isinstance(expr, String):
            # Detect interpolation patterns like {{variable}}
            pattern = re.compile(r'\{\{(\w+)\}\}')
            matches = pattern.findall(expr.value)
            if matches:
                # Replace all occurrences of {{variable}} with {variable}
                interpolated = pattern.sub(r'{\1}', expr.value)
                # Prepend 'f' to make it an f-string
                return f"f\"{interpolated}\""
            else:
                return f"\"{expr.value}\""
        elif isinstance(expr, Identifier):
            return expr.name
        elif isinstance(expr, FunctionCall):
            if isinstance(expr.func_name, MemberAccess):
                obj_code = self.generate_expression(expr.func_name.object)
                member = expr.func_name.member
                if member == 'map':
                    # Handle map: map(fn, obj)
                    fn_code = self.generate_expression(expr.arguments[0])
                    # No additional imports needed for map
                    return f"list(map({fn_code}, {obj_code}))"
                elif member == 'reduce':
                    # Handle reduce: functools.reduce(fn, obj, initial)
                    if len(expr.arguments) != 2:
                        raise NotImplementedError(
                            "reduce requires two arguments: initial and function")
                    initial = self.generate_expression(expr.arguments[0])
                    fn_code = self.generate_expression(expr.arguments[1])
                    self.imports_set.add("import functools")
                    return f"functools.reduce({fn_code}, {obj_code}, {initial})"
                else:
                    # Handle other member functions: obj.member(args)
                    func_full = self.generate_expression(expr.func_name)
                    args = ", ".join([self.generate_expression(arg)
                                     for arg in expr.arguments])
                    return f"{func_full}({args})"
            else:
                # Handle regular function calls
                func_name = self.generate_expression(expr.func_name)
                args = ", ".join([self.generate_expression(arg)
                                 for arg in expr.arguments])
                return f"{func_name}({args})"
        elif isinstance(expr, MemberAccess):
            obj = self.generate_expression(expr.object)
            member = expr.member
            return f"{obj}.{member}"
        elif isinstance(expr, LambdaExpression):
            params = ", ".join([param[0] for param in expr.params])
            if len(expr.body) == 1 and isinstance(expr.body[0], ReturnStatement):
                body_expr = self.generate_expression(expr.body[0].expression)
                return f"lambda {params}: {body_expr}"
            else:
                # Generate a unique function name
                func_name = f"_lambda_{uuid.uuid4().hex}"
                # Generate the function definition
                func_def = f"def {func_name}({params}):\n"
                for stmt in expr.body:
                    func_def += self.generate_statement(
                        stmt, indent_level=1, global_vars=set())
                # Add the function definition to the global code
                self.global_code.append(func_def)
                # Return the function name
                return func_name
        elif isinstance(expr, ArrayLiteral):
            elements = ", ".join([self.generate_expression(el)
                                 for el in expr.elements])
            return f"[{elements}]"
        else:
            raise NotImplementedError(
                f"Expression type {type(expr).__name__} not implemented.")

    def generate_pattern_expression(self, pattern):
        if isinstance(pattern, NumberPattern):
            return str(pattern.value)
        elif isinstance(pattern, WildcardPattern):
            return "_"
        else:
            raise NotImplementedError(
                f"Pattern type {type(pattern).__name__} not implemented.")

    def find_modified_globals(self, statements, global_vars):
        """
        Traverse the list of statements and identify any assignments
        to variables that are in the global_vars set.
        """
        modified = set()
        for stmt in statements:
            if isinstance(stmt, Assignment):
                target = self.get_assignment_target(stmt.target)
                if target and target in global_vars:
                    modified.add(target)
            elif isinstance(stmt, FunctionDeclaration):
                # Nested functions: handle separately if needed
                pass
            elif isinstance(stmt, IfStatement):
                # Recursively check then and else branches
                modified.update(self.find_modified_globals(
                    stmt.then_branch, global_vars))
                if stmt.else_branch:
                    modified.update(self.find_modified_globals(
                        stmt.else_branch, global_vars))
            # Handle other statement types as needed
        return modified

    def get_assignment_target(self, target):
        """
        Extract the variable name from the assignment target.
        """
        if isinstance(target, Identifier):
            return target.name
        elif isinstance(target, MemberAccess):
            # For simplicity, ignore member accesses (e.g., obj.attr)
            return None
        else:
            return None
