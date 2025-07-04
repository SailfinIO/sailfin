from ast_nodes import *
from utils import interpolate_string, generate_unique_name
from abc import ABC, abstractmethod
from typing import Union


class CodeGeneratorVisitor(ABC):
    @abstractmethod
    def visit(self, node):
        pass


class PythonCodeGenerator(CodeGeneratorVisitor):
    def __init__(self):
        self.imports = set()
        self.code = []
        self.indent_level = 0
        self.test_functions = []  # Track test function names
        self.global_variables = set()  # Track global variable names
        self.in_function = False  # Track if we're inside a function
        self.top_level_routines = []  # Track top-level routine function names

    def indent(self):
        return '    ' * self.indent_level

    def _find_global_assignments(self, statements):
        """Find which global variables are assigned to in the given statements."""
        global_assignments = set()

        def check_node(node):
            if isinstance(node, Assignment):
                if isinstance(node.target, Identifier) and node.target.name in self.global_variables:
                    global_assignments.add(node.target.name)
            elif isinstance(node, ExpressionStatement):
                check_node(node.expression)
            elif hasattr(node, 'body') and node.body:
                for stmt in node.body:
                    check_node(stmt)

        for stmt in statements:
            check_node(stmt)

        return global_assignments

    def map_type(self, t: Union[str, ASTNode]) -> str:
        # Handle ArrayType nodes
        if isinstance(t, ArrayType):
            self.imports.add("from typing import List")
            inner = self.map_type(t.element_type)
            return f"List[{inner}]"
        # Handle OptionalType nodes
        if isinstance(t, OptionalType):
            self.imports.add("from typing import Optional")
            inner = self.map_type(t.base)
            return f"Optional[{inner}]"
        # Handle generic TypeApplication nodes
        if isinstance(t, TypeApplication):
            base_str = self.map_type(t.base) if isinstance(
                t.base, (str, ASTNode)) else self.visit(t.base)
            args_str = ', '.join([self.map_type(arg) for arg in t.type_args])
            return f"{base_str}[{args_str}]"
        # Handle UnionType nodes
        if isinstance(t, UnionType):
            self.imports.add("from typing import Union")
            left = self.map_type(t.left)
            right = self.map_type(t.right)
            return f"Union[{left}, {right}]"
        # Handle identifier AST nodes
        if isinstance(t, Identifier):
            # Apply type mapping to identifier names
            type_mapping = {
                "number": "float",
                "string": "str",
                "void": "None",
                # add other mappings as needed...
            }
            return type_mapping.get(t.name, t.name)
        # Fallback: raw string type names
        if isinstance(t, str):
            # Map simple types
            type_mapping = {
                "number": "float",
                "string": "str",
                "void": "None",
                # add other mappings as needed...
            }
            return type_mapping.get(t, t)
        # Unknown ASTNode type
        return str(t)

    def visit(self, node):
        if isinstance(node, list):
            return self.visit_list(node)
        method_name = f'visit_{type(node).__name__}'
        visitor = getattr(self, method_name, self.generic_visit)
        return visitor(node)

    def visit_list(self, nodes):
        return ', '.join([self.visit(node) for node in nodes])

    def generic_visit(self, node):
        raise NotImplementedError(f"No visit_{type(node).__name__} method")

    def visit_Program(self, node: Program):
        # Visit all statements
        for stmt in node.statements:
            self.visit(stmt)

        # Check if there's a main function and add a call to it
        main_function = None
        for stmt in node.statements:
            if isinstance(stmt, FunctionDeclaration) and stmt.name == 'main':
                main_function = stmt
                break

        has_main = main_function is not None
        has_routines = len(self.top_level_routines) > 0

        # Add test runner, main execution, and routine execution
        if self.test_functions or has_main or has_routines:
            self.code.append('')
            self.code.append('if __name__ == "__main__":')
            if self.test_functions:
                self.code.append('    # Run tests')
                for test_func in self.test_functions:
                    self.code.append(f'    try:')
                    self.code.append(f'        {test_func}()')
                    self.code.append(
                        f'        print("✓ Test passed: {test_func}")')
                    self.code.append(f'    except AssertionError as e:')
                    self.code.append(
                        f'        print("✗ Test failed: {test_func}")')
                    self.code.append(
                        f'        print(f"  Assertion error: {{e}}")')
                    self.code.append(f'    except Exception as e:')
                    self.code.append(
                        f'        print("✗ Test error: {test_func}")')
                    self.code.append(f'        print(f"  Error: {{e}}")')
            if has_main:
                if self.test_functions:
                    self.code.append('    # Run main')
                if main_function.is_async:
                    self.imports.add("import asyncio")
                    self.code.append('    asyncio.run(main())')
                else:
                    self.code.append('    main()')
            elif has_routines:
                # Run top-level routines if no main function
                self.imports.add("import asyncio")
                self.code.append('    # Run top-level routines')
                self.code.append('    async def run_routines():')
                routine_calls = [f'{routine}()' for routine in self.top_level_routines]
                self.code.append(f'        await asyncio.gather({", ".join(routine_calls)})')
                self.code.append('    asyncio.run(run_routines())')

        # Prepare the __future__ import
        future_import = "from __future__ import annotations"

        # Get other imports (if any) and sort them
        # Remove the __future__ import if it is accidentally added in self.imports
        other_imports = sorted(
            imp for imp in self.imports if imp != future_import)

        # Prepend the __future__ import and other import statements to the generated code
        self.code = [future_import] + other_imports + [''] + self.code

        return '\n'.join(self.code)

    def visit_Identifier(self, node: Identifier):
        # Handle boolean literals
        if node.name == 'true':
            return 'True'
        elif node.name == 'false':
            return 'False'
        return node.name

    def visit_ImportStatement(self, node: ImportStatement):
        items = ', '.join(node.items)
        source = node.source

        # Handle built-in sailfin modules
        if source.startswith('sailfin/'):
            source = source.replace('/', '.')
        # Handle relative imports
        elif source.startswith('./') or source.startswith('../'):
            source = source.replace('/', '.').rstrip('.sfn')

        self.code.append(f"from {source} import {items}")

    def visit_PrintStatement(self, node: PrintStatement):
        expr = self.visit(node.expression)
        self.code.append(f"{self.indent()}print({expr})")

    def visit_AssertStatement(self, node: AssertStatement):
        condition = self.visit(node.condition)
        self.code.append(f"{self.indent()}assert {condition}")

    def visit_ExpressionStatement(self, node: ExpressionStatement):
        # Handle ExpressionStatement nodes by visiting the inner expression.
        expr = self.visit(node.expression)
        self.code.append(f"{self.indent()}{expr}")

    def visit_Number(self, node: Number):
        return str(node.value)

    def visit_String(self, node: String):
        return interpolate_string(node.value)

    def visit_BinOp(self, node: BinOp):
        left = self.visit(node.left)
        right = self.visit(node.right)
        operator = node.operator
        # Map C-like logical operators to Python equivalents.
        if operator == '&&':
            operator = 'and'
        elif operator == '||':
            operator = 'or'
        return f"({left} {operator} {right})"

    def visit_UnaryOp(self, node: UnaryOp):
        operand = self.visit(node.operand)
        return f"({node.operator} {operand})"

    def visit_FunctionCall(self, node: FunctionCall):
        func_name = self.visit(node.func_name)
        args = ', '.join([self.visit(arg) for arg in node.arguments])

        # Special case: array.filter(lambda) becomes list(filter(lambda, array))
        if isinstance(node.func_name, MemberAccess) and node.func_name.member == "filter":
            obj = self.visit(node.func_name.object_)
            return f"list(filter({args}, {obj}))"

        # Special case: array.concat(other) becomes array + other (but as an expression)
        if isinstance(node.func_name, MemberAccess) and node.func_name.member == "concat":
            obj = self.visit(node.func_name.object_)
            return f"({obj} + {args})"

        return f"{func_name}({args})"

    def visit_MemberAccess(self, node: MemberAccess):
        obj = self.visit(node.object_)
        # Special case: print.info() and print.error() become print() in Python
        if obj == "print" and node.member in ["info", "debug", "warn", "error"]:
            return "print"
        # Special case: .length on arrays becomes len() in Python
        if node.member == "length":
            return f"len({obj})"
        return f"{obj}.{node.member}"

    def visit_VariableDeclaration(self, node: VariableDeclaration):
        var_type = node.var_type
        name = node.name
        value = self.visit(node.value)
        comment = "  # Mutable" if node.mutable else ""

        # Track global variables (variables declared at module level)
        if not self.in_function:
            self.global_variables.add(name)

        if var_type:
            py_type = self.map_type(var_type)
            # Emit variable declaration with type annotation
            self.code.append(
                f"{self.indent()}{name}: {py_type} = {value}{comment}")
        else:
            self.code.append(f"{self.indent()}{name} = {value}{comment}")

    def visit_ArrayLiteral(self, node: ArrayLiteral):
        elements = ', '.join([self.visit(element)
                             for element in node.elements])
        return f"[{elements}]"

    def visit_ArrayIndexing(self, node: ArrayIndexing):
        object_str = self.visit(node.object_)
        index_str = self.visit(node.index)
        return f"{object_str}[{index_str}]"

    def visit_WhileLoop(self, node: WhileLoop):
        condition = self.visit(node.condition)
        self.code.append(f"{self.indent()}while {condition}:")
        self.indent_level += 1
        if not node.body:
            self.code.append(f"{self.indent()}pass")
        else:
            for stmt in node.body:
                self.visit(stmt)
        self.indent_level -= 1

    def visit_TestDeclaration(self, node: TestDeclaration):
        # Generate a standalone test function that can be run
        test_name = generate_unique_name('test')
        test_func_name = f"test_{test_name}"
        self.test_functions.append(test_func_name)
        self.code.append(f"{self.indent()}def {test_func_name}():")
        self.indent_level += 1
        for stmt in node.body:
            self.visit(stmt)
        self.indent_level -= 1
        self.code.append('')  # Add a newline after test

    def visit_ForLoop(self, node: ForLoop):
        iterable = self.visit(node.iterable)
        self.code.append(f"{self.indent()}for {node.variable} in {iterable}:")
        self.indent_level += 1
        if not node.body:
            self.code.append(f"{self.indent()}pass")
        else:
            for stmt in node.body:
                self.visit(stmt)
        self.indent_level -= 1

    def visit_RangeExpression(self, node: RangeExpression):
        start = self.visit(node.start)
        end = self.visit(node.end)
        return f"range({start}, {end})"

    def visit_ConstantDeclaration(self, node: ConstantDeclaration):
        name = node.name
        value = self.visit(node.value)
        # Emit constant declaration with type annotation
        if node.var_type:
            py_type = self.map_type(node.var_type)
            self.code.append(
                f"{self.indent()}{name}: {py_type} = {value}  # Constant")
        else:
            self.code.append(f"{self.indent()}{name} = {value}  # Constant")

    def visit_FunctionDeclaration(self, node: FunctionDeclaration):
        async_str = 'async ' if node.is_async else ''

        # Handle decorators - emit each on its own line before the function
        for decorator in node.decorators:
            self.code.append(f"{self.indent()}@{decorator}")

        # Handle parameters with default values
        param_strings = []
        for param in node.params:
            name, param_type, default_value = param
            param_str = self.visit(name)
            if default_value is not None:
                default_str = self.visit(default_value)
                param_str += f"={default_str}"
            param_strings.append(param_str)
        params = ', '.join(param_strings)

        # Generate return type annotation from ASTNode
        if node.return_type:
            mapped_return = self.map_type(node.return_type)
            return_type = f" -> {mapped_return}"
        else:
            return_type = ""
        # Emit function declaration with return type
        self.code.append(
            f"{self.indent()}{async_str}def {node.name}({params}){return_type}:")
        self.indent_level += 1

        # Track that we're now inside a function
        old_in_function = self.in_function
        self.in_function = True

        # Find global variables that are modified in this function
        global_vars_modified = self._find_global_assignments(node.body)
        if global_vars_modified:
            global_decl = ', '.join(sorted(global_vars_modified))
            self.code.append(f"{self.indent()}global {global_decl}")

        if not node.body:
            self.code.append(f"{self.indent()}pass")
        else:
            for stmt in node.body:
                self.visit(stmt)

        # Restore function context
        self.in_function = old_in_function
        self.indent_level -= 1
        self.code.append('')  # newline after function

    def visit_IfStatement(self, node: IfStatement):
        condition = self.visit(node.condition)
        self.code.append(f"{self.indent()}if {condition}:")
        self.indent_level += 1
        if not node.then_branch:
            self.code.append(f"{self.indent()}pass")
        else:
            for stmt in node.then_branch:
                self.visit(stmt)
        self.indent_level -= 1
        if node.else_branch:
            self.code.append(f"{self.indent()}else:")
            self.indent_level += 1
            if not node.else_branch:
                self.code.append(f"{self.indent()}pass")
            else:
                for stmt in node.else_branch:
                    self.visit(stmt)
            self.indent_level -= 1

    def visit_ReturnStatement(self, node: ReturnStatement):
        if node.expression:
            expr = self.visit(node.expression)
            self.code.append(f"{self.indent()}return {expr}")
        else:
            self.code.append(f"{self.indent()}return")

    def visit_Assignment(self, node: Assignment):
        target = self.visit(node.target)
        value = self.visit(node.value)
        self.code.append(f"{self.indent()}{target} = {value}")

    def visit_StructDeclaration(self, node: StructDeclaration):
        # Ensure the dataclass decorator is available.
        self.imports.add("from dataclasses import dataclass")
        self.code.append(f"{self.indent()}@dataclass")
        base_classes = ', '.join(node.interfaces) if node.interfaces else ''
        inheritance = f"({base_classes})" if base_classes else ''
        self.code.append(f"{self.indent()}class {node.name}{inheritance}:")
        self.indent_level += 1
        if not node.members:
            self.code.append(f"{self.indent()}pass")
        else:
            for member in node.members:
                if isinstance(member, FieldDeclaration):
                    mutable = member.mutable
                    var_type = member.field_type
                    name = member.name
                    comment = "  # Mutable" if mutable else ""
                    py_type = self.map_type(var_type)
                    self.code.append(
                        f"{self.indent()}{name}: {py_type}{comment}")
                elif isinstance(member, MethodDeclaration):
                    self.visit(member)
        self.indent_level -= 1
        self.code.append('')  # Add a newline after class

    def visit_MethodDeclaration(self, node: MethodDeclaration):
        # Determine if this is a constructor method.
        is_constructor = node.name == "new"

        # Check if this is a static method (no 'self' parameter)
        has_self_param = (node.params and
                          hasattr(node.params[0][0], 'name') and
                          node.params[0][0].name == "self")
        is_static = not has_self_param and not is_constructor

        # Build decorators. Start with an empty list.
        decorator_lines = []

        # For a constructor, add @classmethod.
        if is_constructor:
            decorator_lines.append(f"{self.indent()}@classmethod")
        elif is_static:
            # For static methods (methods without self), add @classmethod
            decorator_lines.append(f"{self.indent()}@classmethod")

        # Also add any other decorators provided in the AST.
        for dec in node.decorators:
            decorator_lines.append(f"{self.indent()}@{dec}")

        # Join the decorators into one string.
        decorators = "\n".join(decorator_lines)
        if decorators:
            # Ensure there is a newline after the decorators.
            decorators += "\n"

        # Handle parameters with default values, similar to FunctionDeclaration
        param_strings = []

        # For instance methods, the first parameter should be "self".
        # For class methods, use "cls".
        if is_constructor or is_static:
            first_param = "cls"
            # Process all parameters since there's no 'self' to skip
            params_to_process = node.params
        else:
            first_param = "self"
            # Skip the first parameter if it's 'self'
            if has_self_param:
                params_to_process = node.params[1:]
            else:
                params_to_process = node.params

        # Process parameters with default values
        for param in params_to_process:
            name, param_type, default_value = param
            param_str = self.visit(name)
            if default_value is not None:
                default_str = self.visit(default_value)
                param_str += f"={default_str}"
            param_strings.append(param_str)

        params = ', '.join(param_strings)

        # Handle the return type from ASTNode
        if node.return_type:
            ret_type = self.map_type(node.return_type)
            if is_constructor:
                # Quote the return type for forward references.
                ret_type = f"'{ret_type}'"
            return_type = f" -> {ret_type}"
        else:
            return_type = ""

        # Build the method signature.
        if params:
            method_signature = f"def {node.name}({first_param}, {params}){return_type}:"
        else:
            method_signature = f"def {node.name}({first_param}){return_type}:"

        # Append the decorator lines and the method signature.
        self.code.append(f"{decorators}{self.indent()}{method_signature}")
        self.indent_level += 1
        if not node.body:
            self.code.append(f"{self.indent()}pass")
        else:
            for stmt in node.body:
                self.visit(stmt)
        self.indent_level -= 1
        self.code.append('')  # Add a newline after the method

    def visit_InterfaceDeclaration(self, node: InterfaceDeclaration):
        # This line should add the import needed for interfaces.
        self.imports.add("from abc import ABC, abstractmethod")
        self.code.append(f"{self.indent()}class {node.name}(ABC):")
        self.indent_level += 1
        if not node.methods:
            self.code.append(f"{self.indent()}pass")
        else:
            for method in node.methods:
                self.code.append(f"{self.indent()}@abstractmethod")
                # Extract parameter names, skipping the first parameter if it's "self"
                params_list = []
                for param in method.params:
                    param_name = param[0].name if hasattr(
                        param[0], 'name') else param[0]
                    # Skip "self" parameter since we add it automatically in the method signature
                    if param_name != "self":
                        params_list.append(param_name)

                params = ', '.join(params_list)
                if method.return_type and method.return_type != "void":
                    return_type = f" -> {self.map_type(method.return_type)}"
                else:
                    return_type = ""

                if params:
                    # Emit abstract method signature with parameters
                    self.code.append(
                        f"{self.indent()}def {method.name}(self, {params}){return_type}:")
                else:
                    # Emit abstract method signature without additional parameters
                    self.code.append(
                        f"{self.indent()}def {method.name}(self){return_type}:")
                self.code.append(f"{self.indent()}    pass")
        self.indent_level -= 1
        self.code.append('')  # Newline after interface

    def visit_EnumDeclaration(self, node: EnumDeclaration):
        # Generate a class with class variables for each variant
        # This allows enum variants to be referenced as Class.Variant
        self.code.append(f"{self.indent()}class {node.name}:")
        self.indent_level += 1
        if not node.variants:
            self.code.append(f"{self.indent()}pass")
        else:
            for variant in node.variants:
                # Each variant is just a string constant for type identification
                self.code.append(
                    f"{self.indent()}{variant.name} = \"{variant.name}\"")
        self.indent_level -= 1
        self.code.append('')  # Add a newline after enum

    def visit_MatchStatement(self, node: MatchStatement):
        condition = self.visit(node.condition)
        self.code.append(f"{self.indent()}match {condition}:")
        self.indent_level += 1
        for arm in node.arms:
            pattern = self.visit(arm.pattern)
            self.code.append(f"{self.indent()}case {pattern}:")
            self.indent_level += 1
            if not arm.body:
                self.code.append(f"{self.indent()}pass")
            else:
                # For match expressions, we need to return the result
                # Check if the body is a single expression statement
                if len(arm.body) == 1 and hasattr(arm.body[0], 'expression'):
                    # Single expression - return it
                    expr = self.visit(arm.body[0].expression)
                    self.code.append(f"{self.indent()}return {expr}")
                else:
                    # Multiple statements
                    for stmt in arm.body:
                        self.visit(stmt)
            self.indent_level -= 1
        self.indent_level -= 1

    def visit_NumberPattern(self, node: NumberPattern):
        return str(node.value)

    def visit_WildcardPattern(self, node: WildcardPattern):
        return "_"

    def visit_TaggedPattern(self, node: TaggedPattern):
        # For enum variant patterns like Shape.Circle { radius }
        # Generate Python match pattern that matches the dict structure
        # e.g. {"type": "Circle", "radius": radius} where radius is bound to the variable
        if node.fields:
            # Create pattern for destructuring dict fields
            field_patterns = ", ".join(
                [f'"{field}": {field}' for field in node.fields])
            return f'{{"type": "{node.variant}", {field_patterns}}}'
        else:
            # No fields to destructure, just match the type
            return f'{{"type": "{node.variant}"}}'

    def visit_TryFinally(self, node: TryFinally):
        self.code.append(f"{self.indent()}try:")
        self.indent_level += 1
        if not node.try_block:
            self.code.append(f"{self.indent()}pass")
        else:
            for stmt in node.try_block:
                self.visit(stmt)
        self.indent_level -= 1
        self.code.append(f"{self.indent()}finally:")
        self.indent_level += 1
        if not node.finally_block:
            self.code.append(f"{self.indent()}pass")
        else:
            for stmt in node.finally_block:
                self.visit(stmt)
        self.indent_level -= 1

    def visit_TryCatchFinally(self, node: TryCatchFinally):
        self.code.append(f"{self.indent()}try:")
        self.indent_level += 1
        if not node.try_block:
            self.code.append(f"{self.indent()}pass")
        else:
            for stmt in node.try_block:
                self.visit(stmt)
        self.indent_level -= 1
        for error_type, error_var, catch_block in node.catch_blocks:
            # Emit except clause for catch blocks
            self.code.append(
                f"{self.indent()}except {error_type} as {error_var}:")
            self.indent_level += 1
            if not catch_block:
                self.code.append(f"{self.indent()}pass")
            else:
                for stmt in catch_block:
                    self.visit(stmt)
            self.indent_level -= 1
        if node.finally_block is not None:
            self.code.append(f"{self.indent()}finally:")
            self.indent_level += 1
            if not node.finally_block:
                self.code.append(f"{self.indent()}pass")
            else:
                for stmt in node.finally_block:
                    self.visit(stmt)
            self.indent_level -= 1

    def visit_ThrowStatement(self, node: ThrowStatement):
        expr = self.visit(node.expression)
        # Ensure that thrown expressions are wrapped in Exception
        self.code.append(f"{self.indent()}raise Exception({expr})")

    def visit_StructInstantiation(self, node: StructInstantiation):
        # For example, generate a call to a constructor function
        fields = ', '.join(
            [f"{name}={self.visit(expr)}" for name, expr in node.field_inits])
        return f"{node.struct_name}({fields})"

    def visit_EnumVariantConstruction(self, node: EnumVariantConstruction):
        # Generate enum variant construction as a dictionary with type and fields
        # Example: Shape.Circle { radius: 5 } -> {"type": "Circle", "radius": 5}
        fields = ', '.join(
            [f'"{name}": {self.visit(expr)}' for name, expr in node.field_inits])
        return f'{{"type": "{node.variant_name}", {fields}}}'

    def visit_TypeApplication(self, node: TypeApplication):
        # Generate generic constructor or call with type arguments
        base = self.map_type(node.base) if isinstance(
            node.base, ASTNode) else str(node.base)
        args_types = ', '.join(self.map_type(arg) for arg in node.type_args)
        args_vals = ', '.join(self.visit(arg) for arg in node.arguments)
        return f"{base}[{args_types}]({args_vals})"

    def visit_LambdaExpression(self, node: LambdaExpression):
        # If the lambda's body consists of a single ReturnStatement, generate an inline lambda.
        if len(node.body) == 1 and isinstance(node.body[0], ReturnStatement) and node.body[0].expression is not None:
            expr = self.visit(node.body[0].expression)
            params = ', '.join([self.visit(param[0]) for param in node.params])
            return f"(lambda {params}: {expr})"
        else:
            # Otherwise, generate a nested function definition and return its name.
            func_name = generate_unique_name("lambda_func")
            params = ', '.join([param[0] for param in node.params])
            self.code.append(f"{self.indent()}def {func_name}({params}):")
            self.indent_level += 1
            for stmt in node.body:
                self.visit(stmt)
            self.indent_level -= 1
            return func_name

    def visit_FunctionExpression(self, node: FunctionExpression):
        # Handle parameters
        param_strings = []
        for param in node.params:
            # Parameters can be 2-tuples (name, type) or 3-tuples (name, type, default)
            if len(param) == 2:
                name, param_type = param
            else:
                name, param_type, _ = param  # Ignore default for function expressions
            param_str = self.visit(name)
            param_strings.append(param_str)
        params = ', '.join(param_strings)

        # For simple single-expression functions, use lambda
        if (len(node.body) == 1 and
                isinstance(node.body[0], (ExpressionStatement, ReturnStatement))):
            # Extract the expression
            if isinstance(node.body[0], ExpressionStatement):
                expr = self.visit(node.body[0].expression)
            else:  # ReturnStatement
                expr = self.visit(
                    node.body[0].expression) if node.body[0].expression else "None"

            return f"lambda {params}: {expr}"
        else:
            # For complex functions, generate an inline function definition
            func_name = generate_unique_name("inline_func")

            # Generate return type annotation if present
            if node.return_type:
                mapped_return = self.map_type(node.return_type)
                return_type = f" -> {mapped_return}"
            else:
                return_type = ""

            # Generate the function definition
            self.code.append(
                f"{self.indent()}def {func_name}({params}){return_type}:")
            self.indent_level += 1

            # Track that we're now inside a function
            old_in_function = self.in_function
            self.in_function = True

            if not node.body:
                self.code.append(f"{self.indent()}pass")
            else:
                for stmt in node.body:
                    self.visit(stmt)

            # Restore function context
            self.in_function = old_in_function
            self.indent_level -= 1

            # Return the function name as the expression value
            return func_name

    def visit_AsyncBlock(self, node: AsyncBlock):
        # Generate an async function and return a coroutine
        self.imports.add("import asyncio")
        func_name = generate_unique_name("async_block")

        # Generate async function definition
        self.code.append(f"{self.indent()}async def {func_name}():")
        self.indent_level += 1

        # Track that we're now inside a function
        old_in_function = self.in_function
        self.in_function = True

        if not node.body:
            self.code.append(f"{self.indent()}pass")
        else:
            # Process all statements except the last one
            for stmt in node.body[:-1]:
                self.visit(stmt)

            # For the last statement, if it's an expression statement, return its value
            last_stmt = node.body[-1]
            if isinstance(last_stmt, ExpressionStatement):
                expr_result = self.visit(last_stmt.expression)
                self.code.append(f"{self.indent()}return {expr_result}")
            else:
                self.visit(last_stmt)

        # Restore function context
        self.in_function = old_in_function
        self.indent_level -= 1

        # Return the coroutine call
        return f"{func_name}()"

    def visit_Routine(self, node: Routine):
        # Generate an async function and create a task for concurrent execution
        self.imports.add("import asyncio")
        func_name = generate_unique_name("routine")

        # Generate async function definition
        self.code.append(f"{self.indent()}async def {func_name}():")
        self.indent_level += 1

        # Track that we're now inside a function
        old_in_function = self.in_function
        self.in_function = True

        if not node.body:
            self.code.append(f"{self.indent()}pass")
        else:
            # Process all statements 
            for stmt in node.body:
                self.visit(stmt)

        # Restore function context
        self.in_function = old_in_function
        self.indent_level -= 1

        # If we're at the top level, collect the routine to run later
        # If we're inside a function, create and return a task for concurrent execution
        if not old_in_function:
            self.top_level_routines.append(func_name)
            return func_name  # Return function name for potential use
        else:
            return f"asyncio.create_task({func_name}())"

    def visit_Await(self, node: Await):
        # Special case: await [future1, future2] should become await asyncio.gather(future1, future2)
        if isinstance(node.expression, ArrayLiteral):
            self.imports.add("import asyncio")
            elements = ', '.join([self.visit(element)
                                 for element in node.expression.elements])
            return f"await asyncio.gather({elements})"

        expr = self.visit(node.expression)
        return f"await {expr}"
