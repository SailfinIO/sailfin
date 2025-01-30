# bootstrap/code_generator.py

import enum
import re
import uuid
from ast_nodes import (
    ArrayLiteral, EnumDeclaration, EnumVariant, ExpressionStatement, ImportStatement, InterfaceDeclaration,
    LambdaExpression, MatchStatement, MethodDeclaration, NumberPattern, Program,
    FunctionDeclaration, StructInstantiation, TryFinally, TypeAliasDeclaration, VariableDeclaration, ConstantDeclaration,
    PrintStatement, IfStatement, ReturnStatement, StructDeclaration,
    FieldDeclaration, BinOp, Number, String, Identifier, FunctionCall,
    MemberAccess, Assignment, WildcardPattern, Await
)
from http_client_def import http_client_def


class CodeGenerator:
    def __init__(self):
        self.imports_set = set()
        self.global_code = []
        self.has_async = False  # Flag to indicate presence of async features
        self.async_functions = set()  # Set of async function names
        self.requires_http = False  # Flag to indicate if 'http' is used
        self.async_stack = []  # Stack to track async context
        self.interfaces = {}  # Dictionary to store interface declarations

    def map_type(self, type_name):
        """
        Maps your language's types to Python's types.
        Extend this method as needed for additional type mappings.
        """
        type_mappings = {
            'string': 'str',
            'number': 'float',  # or 'int', depending on your language's semantics
            'bool': 'bool',
            'void': 'None',
            # Add more mappings as needed
        }
        # Default to the same name if not mapped
        return type_mappings.get(type_name, type_name)

    def generate_code(self, ast, indent_level=0, top_level=True, global_vars=None):
        if top_level:
            # Reset imports_set and flags for each top-level generation
            self.imports_set.clear()
            self.global_code.clear()  # Ensure global_code is reset
            self.has_async = False
            self.async_functions.clear()
            self.requires_http = False
            self.async_stack = []
            self.interfaces = {}  # Reset interfaces

        if global_vars is None:
            global_vars = set()

        # Collect global variable declarations if top level
        if top_level:
            for stmt in ast.statements:
                if isinstance(stmt, VariableDeclaration) or isinstance(stmt, ConstantDeclaration):
                    global_vars.add(stmt.name)

        # **Move the main function modification BEFORE code generation loop**
        if top_level:
            main_func = next((stmt for stmt in ast.statements if isinstance(
                stmt, FunctionDeclaration) and stmt.name == 'main'), None)
            if main_func:
                if main_func.is_async:
                    self.has_async = True
                    self.async_functions.add(main_func.name)
                    # Preserve original body
                    original_body = main_func.body.copy()
                    # Modify main_func.body to include init and close
                    main_func.body = [
                        Await(
                            expression=FunctionCall(
                                func_name=Identifier('http.init'),
                                arguments=[]
                            )
                        ),
                        TryFinally(
                            try_block=original_body,
                            finally_block=[
                                Await(
                                    expression=FunctionCall(
                                        func_name=Identifier('http.close'),
                                        arguments=[]
                                    )
                                )
                            ]
                        )
                    ]

        # First pass: Collect interface declarations
        if top_level:
            for stmt in ast.statements:
                if isinstance(stmt, InterfaceDeclaration):
                    self.interfaces[stmt.name] = stmt

        # Generate code for statements
        code = ""
        for stmt in ast.statements:
            if isinstance(stmt, InterfaceDeclaration):
                code += self.generate_statement(stmt,
                                                indent_level, global_vars)
                code += "\n"
            elif isinstance(stmt, StructDeclaration):
                code += self.generate_statement(stmt,
                                                indent_level, global_vars)
                code += "\n"
            else:
                code += self.generate_statement(stmt,
                                                indent_level, global_vars)
                code += "\n"

        # Only at the very end (top_level = True) do we prepend imports & global lambdas
        if top_level:
            # Handle imports
            if self.has_async:
                self.imports_set.add("import asyncio")
            if self.requires_http:
                self.imports_set.add("import aiohttp")
            if self.interfaces:
                self.imports_set.add("from abc import ABC, abstractmethod")

            # Prepend imports
            if self.imports_set:
                sorted_imports = sorted(self.imports_set)
                print(f"Imports to prepend: {sorted_imports}")  # Debugging
                imports_str = "\n".join(sorted_imports) + "\n\n"
            else:
                print("No imports to prepend.")
                imports_str = ""

            # Inject 'HTTPClient' class definition
            if self.requires_http:
                http_def = http_client_def()
                self.global_code.append(http_def)
                print("Injected HTTPClient definitions.")  # Debugging

            # Combine imports and global code
            global_code_str = "".join(
                self.global_code) + "\n" if self.global_code else ""
            code = imports_str + global_code_str + code

            # Adjust main execution based on whether 'main' is async
            if main_func:
                if main_func.is_async:
                    code += '\nif __name__ == "__main__":\n    asyncio.run(main())\n'
                else:
                    code += '\nif __name__ == "__main__":\n    main()\n'

        return code

    def generate_statement(self, stmt, indent_level, global_vars):
        indent = "    " * indent_level
        code = ""
        if isinstance(stmt, PrintStatement):
            expr = self.generate_expression(stmt.expression)
            code += f"{indent}print({expr})\n"
        elif isinstance(stmt, InterfaceDeclaration):
            # Handle Interface Declaration
            code += self.generate_interface(stmt, indent_level)
            return code
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
        elif isinstance(stmt, TryFinally):
            code += f"{indent}try:\n"
            if not stmt.try_block:
                code += f"{indent}    pass\n"
            else:
                try_block_ast = Program(stmt.try_block)
                code += self.generate_code(try_block_ast, indent_level + 1,
                                           top_level=False, global_vars=global_vars)
            code += f"{indent}finally:\n"
            if not stmt.finally_block:
                code += f"{indent}    pass\n"
            else:
                finally_block_ast = Program(stmt.finally_block)
                code += self.generate_code(finally_block_ast, indent_level + 1,
                                           top_level=False, global_vars=global_vars)
        elif isinstance(stmt, FunctionDeclaration):
            if stmt.is_async:
                self.has_async = True
                self.async_functions.add(stmt.name)
                self.async_stack.append(True)
            else:
                self.async_stack.append(False)
            decorators = ""
            for decorator in stmt.decorators:
                decorators += f"{indent}@{decorator}\n"
            params = ", ".join([param[0] for param in stmt.params])
            if stmt.is_async:
                code += decorators
                code += f"{indent}async def {stmt.name}({params}):\n"
            else:
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
                code += self.generate_code(function_body_ast, indent_level + 1,
                                           top_level=False, global_vars=global_vars)
            self.async_stack.pop()
        elif isinstance(stmt, MethodDeclaration):
            if stmt.is_async:
                self.has_async = True
                self.async_functions.add(stmt.name)
                self.async_stack.append(True)
            else:
                self.async_stack.append(False)
            decorators = ""
            for decorator in stmt.decorators:
                decorators += f"{indent}@{decorator}\n"
            method_params = ", ".join([param[0] for param in stmt.params])
            # Ensure 'self' is included
            if not method_params.startswith('self'):
                method_params = "self, " + method_params
            if stmt.is_async:
                code += decorators
                code += f"{indent}async def {stmt.name}({method_params}):\n"
            else:
                code += decorators
                code += f"{indent}def {stmt.name}({method_params}):\n"
            if not stmt.body:
                code += f"{indent}    pass\n"
            else:
                method_body_ast = Program(stmt.body)
                code += self.generate_code(
                    method_body_ast, indent_level + 2, global_vars=global_vars, top_level=False)
            self.async_stack.pop()
        elif isinstance(stmt, IfStatement):
            condition = self.generate_expression(stmt.condition)
            code += f"{indent}if {condition}:\n"
            if not stmt.then_branch:
                code += f"{indent}    pass\n"
            else:
                then_branch_ast = Program(stmt.then_branch)
                code += self.generate_code(then_branch_ast, indent_level + 1,
                                           global_vars=global_vars, top_level=False)
            if stmt.else_branch:
                code += f"{indent}else:\n"
                else_branch_ast = Program(stmt.else_branch)
                code += self.generate_code(else_branch_ast, indent_level + 1,
                                           global_vars=global_vars, top_level=False)
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
            # Handle Struct Declaration (possibly implementing interfaces)
            code += self.generate_struct(stmt, indent_level, global_vars)
            return code
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
            if source == "aiohttp":
                # Special handling for aiohttp if needed
                self.imports_set.add("import aiohttp")
                code += f"{indent}import aiohttp\n"
            else:
                code += f"{indent}from {source} import {items}\n"
        elif isinstance(stmt, TypeAliasDeclaration):
            code += f"{indent}{stmt.name} = {stmt.aliased_type}  # Type Alias\n"
        elif isinstance(stmt, MatchStatement):
            cond_expr = self.generate_expression(stmt.condition)
            code += f"{indent}match {cond_expr}:\n"

            for arm in stmt.arms:
                pattern_code = self.generate_pattern_expression(arm.pattern)
                code += f"{indent}    case {pattern_code}:\n"

                # Generate code for the arm's body
                case_body_ast = Program(arm.body)
                code += self.generate_code(case_body_ast, indent_level + 2,
                                           global_vars=global_vars, top_level=False)
        elif isinstance(stmt, Await):
            # Direct Await statement, rare outside expressions
            if not any(self.async_stack):
                raise SyntaxError(
                    f"'await' used outside of an async function.")
            self.has_async = True
            expr_code = self.generate_expression(stmt.expression)
            code += f"{indent}await {expr_code}\n"
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
        elif isinstance(expr, Await):
            if not any(self.async_stack):
                raise SyntaxError("'await' used outside of an async function")
            self.has_async = True
            inner_expr = self.generate_expression(expr.expression)
            return f"await {inner_expr}"
        elif isinstance(expr, StructInstantiation):
            struct_name = self.generate_expression(expr.struct_name)
            fields = ", ".join([f"{key}={self.generate_expression(
                value)}" for key, value in expr.fields.items()])
            return f"{struct_name}({fields})"
        elif isinstance(expr, Number):
            return str(expr.value)
        elif isinstance(expr, String):
            # Detect interpolation patterns like {{variable}}
            pattern = re.compile(r'\{\{([^{}]+)\}\}')
            matches = pattern.findall(expr.value)
            if matches:
                # Replace all occurrences of {{variable}} with {variable}
                interpolated = pattern.sub(r'{\1}', expr.value)
                # Prepend 'f' to make it an f-string
                return f"f\"{interpolated}\""
            else:
                return f"\"{expr.value}\""
        elif isinstance(expr, Identifier):
            if expr.name == 'http':
                self.requires_http = True
            return expr.name
        elif isinstance(expr, FunctionCall):
            if isinstance(expr.func_name, MemberAccess):
                if isinstance(expr.func_name.object, Identifier) and expr.func_name.object.name == 'http':
                    self.requires_http = True
            elif isinstance(expr.func_name, Identifier) and expr.func_name.name == 'http':
                self.requires_http = True
            # Handle other function calls as before
            if isinstance(expr.func_name, MemberAccess):
                obj_code = self.generate_expression(expr.func_name.object)
                member = expr.func_name.member
                if member == 'map':
                    # Handle map: map(fn, obj)
                    fn_code = self.generate_expression(expr.arguments[0])
                    return f"list(map({fn_code}, {obj_code}))"
                elif member == 'reduce':
                    # Handle reduce: functools.reduce(fn, obj, initial)
                    if len(expr.arguments) != 2:
                        raise NotImplementedError(
                            "reduce requires two arguments: function and initial")
                    initial = self.generate_expression(expr.arguments[1])
                    fn_code = self.generate_expression(expr.arguments[0])
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
        elif isinstance(expr, str):
            return expr
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

    def generate_interface(self, interface_decl, indent_level):
        """
        Generates Python code for an interface using Abstract Base Classes.
        """
        indent = "    " * indent_level
        code = ""
        # Ensure the ABC module is imported
        self.imports_set.add("from abc import ABC, abstractmethod")

        # Start class definition
        parents = interface_decl.parents.copy() if hasattr(
            interface_decl, 'parents') else []
        if parents:
            parents_str = f"({', '.join(parents)}, ABC)"
        else:
            parents_str = "(ABC)"
        code += f"{indent}class {interface_decl.name}{parents_str}:\n"

        if not interface_decl.methods:
            code += f"{indent}    pass\n"
        else:
            for method in interface_decl.methods:
                code += f"{indent}    @abstractmethod\n"
                params = ", ".join([param[0] for param in method.params])
                if not params.startswith('self'):
                    params = "self, " + params
                return_type = self.map_type(method.return_type)
                code += f"{indent}    def {method.name}({params}) -> {
                    return_type}:\n"
                code += f"{indent}        pass\n\n"

        return code

    def generate_struct(self, struct_decl, indent_level, global_vars):
        """
        Generates Python code for a struct, handling interface implementations.
        """
        indent = "    " * indent_level
        code = ""

        # Handle interface inheritance
        base_classes = struct_decl.interfaces.copy() if hasattr(
            struct_decl, 'interfaces') else []
        if base_classes:
            base_classes_str = f"({', '.join(base_classes)})"
        else:
            base_classes_str = ""

        code += f"{indent}class {struct_decl.name}{base_classes_str}:\n"

        if not struct_decl.members:
            code += f"{indent}    pass\n"
            return code

        # Separate fields and methods
        fields = [m for m in struct_decl.members if isinstance(
            m, FieldDeclaration)]
        methods = [m for m in struct_decl.members if isinstance(
            m, MethodDeclaration)]

        # Constructor (__init__)
        if fields:
            init_params = ['self']
            init_body = ""
            for field in fields:
                init_params.append(field.name)
                init_body += f"{indent}        self.{field.name} = {field.name}\n"
            params_str = ", ".join(init_params)
            code += f"{indent}    def __init__({params_str}):\n"
            code += init_body
        else:
            code += f"{indent}    pass\n"

        # Methods
        for method in methods:
            if method.is_async:
                self.has_async = True
                self.async_functions.add(method.name)
                self.async_stack.append(True)
            else:
                self.async_stack.append(False)

            decorators = ""
            for decorator in method.decorators:
                decorators += f"{indent}    @{decorator}\n"

            method_params = ", ".join([param[0] for param in method.params])
            if not method_params.startswith('self'):
                method_params = "self, " + method_params

            return_type = self.map_type(method.return_type)

            if method.is_async:
                code += decorators
                code += f"{indent}    async def {method.name}({method_params}) -> {
                    return_type}:\n"
            else:
                code += decorators
                code += f"{indent}    def {method.name}({method_params}) -> {
                    return_type}:\n"

            if not method.body:
                code += f"{indent}        pass\n"
            else:
                # Recursively generate code for the method body with increased indentation
                method_body_ast = Program(method.body)
                method_body_code = self.generate_code(
                    method_body_ast, indent_level + 2, global_vars=global_vars, top_level=False)
                code += method_body_code

            self.async_stack.pop()

        # Add __repr__ method for better debugging (optional)
        if fields:
            repr_fields = ", ".join(
                [f"{field.name}={{self.{field.name}!r}}" for field in fields])
            code += f"{indent}    def __repr__(self):\n"
            code += f"{indent}        return f\"{
                struct_decl.name}({repr_fields})\"\n"

        return code
