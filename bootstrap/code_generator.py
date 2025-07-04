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
        self.functions_with_routines = set()  # Track functions that contain routines
        self.current_function_name = None  # Track the current function being processed
        self.type_vars = set()  # Track TypeVar declarations needed for generics

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

            # Special case: Channel<T> becomes asyncio.Queue
            if (isinstance(t.base, Identifier) and t.base.name == "Channel") or base_str == "Channel":
                self.imports.add("import asyncio")
                return "asyncio.Queue"

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
                "boolean": "bool",
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
                "boolean": "bool",
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
        # First pass: detect which functions contain routines
        self._detect_functions_with_routines(node)

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
                # Check if main function should be async (explicitly marked or contains routines)
                if main_function.is_async or 'main' in self.functions_with_routines:
                    self.imports.add("import asyncio")
                    if has_routines:
                        # If we have both main and routines, run them concurrently
                        self.code.append(
                            '    # Run main and top-level routines concurrently')
                        self.code.append('    async def run_all():')
                        routine_calls = [
                            f'{routine}()' for routine in self.top_level_routines]
                        all_calls = routine_calls + ['main()']
                        self.code.append(
                            f'        await asyncio.gather({", ".join(all_calls)})')
                        self.code.append('    asyncio.run(run_all())')
                    else:
                        self.code.append('    asyncio.run(main())')
                else:
                    self.code.append('    main()')
            elif has_routines:
                # Run top-level routines if no main function
                self.imports.add("import asyncio")
                self.code.append('    # Run top-level routines')
                self.code.append('    async def run_routines():')
                routine_calls = [
                    f'{routine}()' for routine in self.top_level_routines]
                self.code.append(
                    f'        await asyncio.gather({", ".join(routine_calls)})')
                self.code.append('    asyncio.run(run_routines())')

        # Prepare the __future__ import
        future_import = "from __future__ import annotations"

        # Get other imports (if any) and sort them
        # Remove the __future__ import if it is accidentally added in self.imports
        other_imports = sorted(
            imp for imp in self.imports if imp != future_import)

        # Generate TypeVar declarations for generic types
        type_var_declarations = []
        if self.type_vars:
            for type_var in sorted(self.type_vars):
                type_var_declarations.append(
                    f"{type_var} = TypeVar('{type_var}')")

        # Prepare the imports and type variable declarations
        imports_and_type_vars = [future_import] + other_imports
        if type_var_declarations:
            imports_and_type_vars.extend([''] + type_var_declarations)
        imports_and_type_vars.append('')

        # Prepend the __future__ import, other imports, and type variables to the generated code
        self.code = imports_and_type_vars + self.code

        return '\n'.join(self.code)

    def _detect_functions_with_routines(self, node):
        """Pre-process the AST to detect which functions contain routines"""
        class RoutineDetector:
            def __init__(self, generator):
                self.generator = generator
                self.current_function = None

            def visit(self, node):
                method_name = f'visit_{node.__class__.__name__}'
                method = getattr(self, method_name, self.generic_visit)
                return method(node)

            def generic_visit(self, node):
                for field, value in node.__dict__.items():
                    if isinstance(value, list):
                        for item in value:
                            if hasattr(item, '__dict__'):
                                self.visit(item)
                    elif hasattr(value, '__dict__'):
                        self.visit(value)

            def visit_FunctionDeclaration(self, node):
                old_function = self.current_function
                self.current_function = node.name
                for stmt in node.body:
                    self.visit(stmt)
                self.current_function = old_function

            def visit_Routine(self, node):
                if self.current_function:
                    self.generator.functions_with_routines.add(
                        self.current_function)
                # Continue visiting the routine body
                for stmt in node.body:
                    self.visit(stmt)

        detector = RoutineDetector(self)
        detector.visit(node)

    def visit_Identifier(self, node: Identifier):
        # Handle boolean literals
        if node.name == 'true':
            return 'True'
        elif node.name == 'false':
            return 'False'
        elif node.name == 'null':
            return 'None'
        return node.name

    def visit_TypeCheck(self, node: TypeCheck):
        expr = self.visit(node.expr)
        type_name = self.visit(node.type_name)

        # Map Sailfin types to Python types for isinstance checks
        type_map = {
            'string': 'str',
            'number': '(int, float)',
            'boolean': 'bool',
            'void': 'type(None)'
        }

        python_type = type_map.get(type_name, type_name)
        return f"isinstance({expr}, {python_type})"

    def visit_UnionType(self, node: UnionType):
        # Union types in Python can use Union from typing
        left = self.map_type(node.left)
        right = self.map_type(node.right)
        self.imports.add("from typing import Union")
        return f"Union[{left}, {right}]"

    def visit_TypeAliasDeclaration(self, node: TypeAliasDeclaration):
        # In Python, type aliases are just simple assignments
        if isinstance(node.aliased_type, IntersectionType):
            # Handle intersection types specially for type aliases
            left = self.map_type(node.aliased_type.left)
            right = self.map_type(node.aliased_type.right)
            self.imports.add("from typing import Any")
            self.code.append(
                f"{self.indent()}{node.name} = Any  # Intersection of {left} & {right}")
        else:
            aliased_type = self.map_type(node.aliased_type)
            self.code.append(f"{self.indent()}{node.name} = {aliased_type}")

    def visit_IntersectionType(self, node: IntersectionType):
        # For intersection types, we can't generate perfect Python equivalent
        # But we can return a comment or a Union annotation
        left = self.map_type(node.left)
        right = self.map_type(node.right)
        # Python doesn't have true intersection types, so we approximate with a comment
        self.imports.add("from typing import Any")
        return f"Any  # Intersection of {left} & {right}"

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
        # Special case: fix misparsed generic constructor calls
        # Pattern: Channel<number>(10) gets parsed as ((Channel < number) > 10)
        if (node.operator == '>' and
            isinstance(node.left, BinOp) and node.left.operator == '<' and
            isinstance(node.left.left, Identifier) and
            isinstance(node.left.right, Identifier) and
                isinstance(node.right, Number)):

            # This is likely a misparsed generic constructor call
            # Convert ((Channel < number) > 10) to Channel<number>(10)
            type_name = node.left.left.name  # "Channel"
            type_arg = node.left.right.name  # "number"
            first_arg = node.right.value      # 10

            # Special case for Channel<T>(args) -> asyncio.Queue(args)
            if type_name == "Channel":
                self.imports.add("import asyncio")
                return f"asyncio.Queue({first_arg})"

            # For other generic types, we'd handle them here
            # For now, just return a generic constructor call
            return f"{type_name}({first_arg})"

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
        # Special case: fix misparsed generic constructor calls
        # Pattern: Channel<number>(10) gets parsed as ((Channel < number) > 10)
        # We detect this pattern and fix it
        if (isinstance(node.func_name, BinOp) and node.func_name.operator == '>' and
            isinstance(node.func_name.left, BinOp) and node.func_name.left.operator == '<' and
            isinstance(node.func_name.left.left, Identifier) and
            isinstance(node.func_name.left.right, Identifier) and
                isinstance(node.func_name.right, Number)):

            # This is likely a misparsed generic constructor call
            # Convert ((Channel < number) > 10) to Channel<number>(10)
            type_name = node.func_name.left.left.name  # "Channel"
            type_arg = node.func_name.left.right.name  # "number"
            first_arg = node.func_name.right.value      # 10

            # Special case for Channel<T>(args) -> asyncio.Queue(args)
            if type_name == "Channel":
                self.imports.add("import asyncio")
                return f"asyncio.Queue({first_arg})"

            # For other generic types, we'd handle them here
            # For now, just return a generic constructor call
            return f"{type_name}({first_arg})"

        func_name = self.visit(node.func_name)
        args = ', '.join([self.visit(arg) for arg in node.arguments])

        # Special case: Channel() constructor becomes asyncio.Queue()
        if isinstance(node.func_name, Identifier) and node.func_name.name == "Channel":
            self.imports.add("import asyncio")
            return "asyncio.Queue()"

        # Special case: Channel<T>(...) constructor becomes asyncio.Queue(...)
        if isinstance(node.func_name, TypeApplication) and isinstance(node.func_name.base, Identifier) and node.func_name.base.name == "Channel":
            self.imports.add("import asyncio")
            return f"asyncio.Queue({args})"

        # Special case: array.filter(lambda) becomes list(filter(lambda, array))
        if isinstance(node.func_name, MemberAccess) and node.func_name.member == "filter":
            obj = self.visit(node.func_name.object_)
            return f"list(filter({args}, {obj}))"

        # Special case: array.map(lambda) becomes list(map(lambda, array))
        if isinstance(node.func_name, MemberAccess) and node.func_name.member == "map":
            obj = self.visit(node.func_name.object_)
            return f"list(map({args}, {obj}))"

        # Special case: array.reduce(initial, lambda) becomes functools.reduce(lambda, array, initial)
        if isinstance(node.func_name, MemberAccess) and node.func_name.member == "reduce":
            self.imports.add("import functools")
            obj = self.visit(node.func_name.object_)
            arg_list = [self.visit(arg) for arg in node.arguments]
            if len(arg_list) == 2:
                initial, reducer = arg_list
                return f"functools.reduce({reducer}, {obj}, {initial})"
            else:
                # If no initial value provided, use default reduce behavior
                return f"functools.reduce({args}, {obj})"

        # Special case: array.concat(other) becomes array + other (but as an expression)
        if isinstance(node.func_name, MemberAccess) and node.func_name.member == "concat":
            obj = self.visit(node.func_name.object_)
            return f"({obj} + {args})"

        # Special case: channel.send(value) becomes channel.put_nowait(value)
        # But NOT for WebSocket clients or other objects
        if isinstance(node.func_name, MemberAccess) and node.func_name.member == "send":
            obj = self.visit(node.func_name.object_)
            # Only apply this transformation to variables that clearly look like channels
            if isinstance(node.func_name.object_, Identifier):
                var_name = node.func_name.object_.name.lower()
                # Only transform if the variable name suggests it's a channel
                # or if we know it was created via Channel() constructor
                if ("channel" in var_name or "buffer" in var_name or var_name in ["ch", "c", "chan", "tasks", "queue", "q"]):
                    return f"{obj}.put_nowait({args})"
            # For all other cases (like WebSocket clients), keep the original .send()
            return f"{obj}.send({args})"

        # Special case: channel.receive() becomes channel.get()
        if isinstance(node.func_name, MemberAccess) and node.func_name.member == "receive":
            obj = self.visit(node.func_name.object_)
            return f"{obj}.get()"

        # Special case: sleep(ms) becomes await asyncio.sleep(ms/1000) or time.sleep(ms/1000)
        if isinstance(node.func_name, Identifier) and node.func_name.name == "sleep":
            # Check if we're in an async function
            is_in_async_function = (hasattr(self, 'async_functions') and
                                    self.current_function_name and
                                    self.current_function_name in self.async_functions)

            if is_in_async_function:
                # Use async sleep in async functions
                self.imports.add("import asyncio")
                if args:
                    # Convert milliseconds to seconds
                    return f"await asyncio.sleep({args} / 1000)"
                else:
                    return "await asyncio.sleep(0)"
            else:
                # Use regular sleep in sync functions
                self.imports.add("import time")
                if args:
                    # Convert milliseconds to seconds
                    return f"time.sleep({args} / 1000)"
                else:
                    return "time.sleep(0)"

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

    def visit_ParallelExpression(self, node: ParallelExpression):
        # Ensure asyncio is imported
        self.imports.add("import asyncio")

        # Generate async wrapper function
        wrapper_name = generate_unique_name("parallel_wrapper")

        # Generate function calls for each task
        task_calls = []
        for task in node.tasks:
            if isinstance(task, FunctionExpression):
                # Generate async lambda for parallel execution
                task_name = self.visit_async_function_expression(task)
                task_calls.append(f"{task_name}()")
            else:
                # For other expressions, just call them
                task_calls.append(self.visit(task))

        # Use asyncio.gather to run tasks in parallel
        tasks_str = ', '.join(task_calls)

        # Generate async wrapper function
        self.code.append(f"{self.indent()}async def {wrapper_name}():")
        self.indent_level += 1
        self.code.append(
            f"{self.indent()}return await asyncio.gather({tasks_str})")
        self.indent_level -= 1

        # Return call to asyncio.run with the wrapper
        return f"asyncio.run({wrapper_name}())"

    def visit_DictionaryLiteral(self, node: DictionaryLiteral):
        pairs = []
        for key, value in node.pairs:
            # If the key is an identifier, convert it to a string literal
            if isinstance(key, Identifier):
                key_str = f'"{key.name}"'
            else:
                key_str = self.visit(key)
            value_str = self.visit(value)
            pairs.append(f"{key_str}: {value_str}")

        pairs_str = ', '.join(pairs)
        return f"{{{pairs_str}}}"

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
        # Store the current function name for tracking routines
        old_function_name = self.current_function_name
        self.current_function_name = node.name

        # Check if this function should be async (either explicitly marked or contains routines)
        should_be_async = node.is_async or node.name in self.functions_with_routines
        async_str = 'async ' if should_be_async else ''

        # Track which functions are async for sleep() handling
        if should_be_async:
            if not hasattr(self, 'async_functions'):
                self.async_functions = set()
            self.async_functions.add(node.name)

        # Handle generic type parameters - generate TypeVar declarations
        if node.type_params:
            self.imports.add("from typing import TypeVar")
            for type_param in node.type_params:
                self.code.append(
                    f"{self.indent()}{type_param} = TypeVar('{type_param}')")

        # Handle decorators - emit each on its own line before the function
        for decorator in node.decorators:
            self.code.append(f"{self.indent()}@{decorator}")

        # Handle parameters with default values
        param_strings = []
        for param in node.params:
            name, param_type, default_value = param
            param_str = self.visit(name)
            if param_type and param_type != "void":
                # Check if this is a generic type parameter
                if isinstance(param_type, Identifier) and param_type.name in node.type_params:
                    type_annotation = param_type.name
                else:
                    type_annotation = self.map_type(param_type)
                param_str += f": {type_annotation}"
            if default_value is not None:
                default_str = self.visit(default_value)
                param_str += f"={default_str}"
            param_strings.append(param_str)
        params = ', '.join(param_strings)

        # Generate return type annotation from ASTNode
        if node.return_type:
            # Check if this is a generic type parameter
            if isinstance(node.return_type, Identifier) and node.return_type.name in node.type_params:
                return_type = f" -> {node.return_type.name}"
            else:
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
        self.current_function_name = old_function_name
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

        # Add TypeVar imports for generic types and track type variables
        if node.type_params:
            self.imports.add("from typing import TypeVar, Generic")
            for type_param in node.type_params:
                self.type_vars.add(type_param)

        self.code.append(f"{self.indent()}@dataclass")

        # Build inheritance clause
        base_classes = []
        if node.type_params:
            base_classes.append("Generic[" + ", ".join(node.type_params) + "]")
        if node.interfaces:
            base_classes.extend(node.interfaces)

        inheritance = f"({', '.join(base_classes)})" if base_classes else ''
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
            if param_type is not None:
                type_str = self.map_type(param_type)
                param_str += f": {type_str}"
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
        if not node.members:
            self.code.append(f"{self.indent()}pass")
        else:
            for member in node.members:
                if hasattr(member, 'params'):  # It's an InterfaceMethod
                    self.code.append(f"{self.indent()}@abstractmethod")
                    # Extract parameter names, skipping the first parameter if it's "self"
                    params_list = []
                    for param in member.params:
                        param_name = param[0] if isinstance(
                            param[0], str) else param[0].name
                        # Skip "self" parameter since we add it automatically in the method signature
                        if param_name != "self":
                            param_type = f": {self.map_type(param[1])}" if param[1] else ""
                            params_list.append(f"{param_name}{param_type}")

                    params = ', '.join(params_list)
                    if member.return_type and member.return_type != "void":
                        return_type = f" -> {self.map_type(member.return_type)}"
                    else:
                        return_type = ""

                    if params:
                        # Emit abstract method signature with parameters
                        self.code.append(
                            f"{self.indent()}def {member.name}(self, {params}){return_type}:")
                    else:
                        # Emit abstract method signature without additional parameters
                        self.code.append(
                            f"{self.indent()}def {member.name}(self){return_type}:")
                    self.code.append(f"{self.indent()}    pass")
                else:  # It's an InterfaceProperty
                    # For properties, we generate abstract property getters/setters
                    property_type = f" -> {self.map_type(member.property_type)}" if member.property_type else ""
                    self.code.append(f"{self.indent()}@property")
                    self.code.append(f"{self.indent()}@abstractmethod")
                    self.code.append(
                        f"{self.indent()}def {member.name}(self){property_type}:")
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
        # Generate generic type annotation with type arguments
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

    def visit_async_function_expression(self, node: FunctionExpression):
        """Generate async function expressions for parallel execution"""
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

        # For simple single-expression functions, use async lambda
        if (len(node.body) == 1 and
                isinstance(node.body[0], (ExpressionStatement, ReturnStatement))):
            # Extract the expression
            if isinstance(node.body[0], ExpressionStatement):
                expr = self.visit(node.body[0].expression)
            else:  # ReturnStatement
                expr = self.visit(
                    node.body[0].expression) if node.body[0].expression else "None"

            # Use async lambda for parallel execution
            # Since Python doesn't have async lambdas, we create an async function
            func_name = generate_unique_name("async_task")
            if params:
                self.code.append(
                    f"{self.indent()}async def {func_name}({params}):")
            else:
                self.code.append(f"{self.indent()}async def {func_name}():")
            self.indent_level += 1
            self.code.append(f"{self.indent()}return {expr}")
            self.indent_level -= 1
            return func_name
        else:
            # For complex functions, generate an inline async function definition
            func_name = generate_unique_name("async_task")

            # Generate return type annotation if present
            if node.return_type:
                mapped_return = self.map_type(node.return_type)
                return_type = f" -> {mapped_return}"
            else:
                return_type = ""

            # Generate the async function definition
            self.code.append(
                f"{self.indent()}async def {func_name}({params}){return_type}:")
            self.indent_level += 1

            # Generate function body
            for stmt in node.body:
                self.visit(stmt)

            self.indent_level -= 1

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
        # If we're inside a function, mark it as containing routines
        if self.current_function_name:
            self.functions_with_routines.add(self.current_function_name)

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
            return ""  # Return empty string to avoid generating immediate code
        else:
            # If we're inside a function that's now marked as containing routines,
            # we can use await instead of create_task since the function will be async
            if self.current_function_name in self.functions_with_routines:
                return f"await {func_name}()"
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
