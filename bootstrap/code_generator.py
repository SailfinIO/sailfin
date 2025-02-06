from ast_nodes import *
from utils import interpolate_string, generate_unique_name
from abc import ABC, abstractmethod


class CodeGeneratorVisitor(ABC):
    @abstractmethod
    def visit(self, node):
        pass


class PythonCodeGenerator(CodeGeneratorVisitor):
    def __init__(self):
        self.imports = set()
        self.code = []
        self.indent_level = 0

    def indent(self):
        return '    ' * self.indent_level

    def map_type(self, t: str) -> str:
        type_mapping = {
            "number": "int",   # or "float" depending on your design
            "string": "str",
            # add additional mappings as needed
        }
        return type_mapping.get(t, t)

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
        # Visit all statements first
        for stmt in node.statements:
            self.visit(stmt)
        # Prepend all import statements (sorted for consistency) at the beginning of the code.
        if self.imports:
            import_lines = sorted(self.imports)
            # Insert a newline after the imports for separation.
            self.code = import_lines + [''] + self.code
        return '\n'.join(self.code)

    def visit_ImportStatement(self, node: ImportStatement):
        items = ', '.join(node.items)
        source = node.source
        # Handle relative imports if needed
        if source.startswith('./') or source.startswith('../'):
            source = source.replace('/', '.').rstrip('.sfn')
        self.code.append(f"from {source} import {items}")

    def visit_PrintStatement(self, node: PrintStatement):
        expr = self.visit(node.expression)
        self.code.append(f"{self.indent()}print({expr})")

    def visit_ExpressionStatement(self, node: ExpressionStatement):
        # Handle ExpressionStatement nodes by visiting the inner expression.
        expr = self.visit(node.expression)
        self.code.append(f"{self.indent()}{expr}")

    def visit_Number(self, node: Number):
        return str(node.value)

    def visit_String(self, node: String):
        return interpolate_string(node.value)

    def visit_Identifier(self, node: Identifier):
        return node.name

    def visit_BinOp(self, node: BinOp):
        left = self.visit(node.left)
        right = self.visit(node.right)
        return f"({left} {node.operator} {right})"

    def visit_UnaryOp(self, node: UnaryOp):
        operand = self.visit(node.operand)
        return f"({node.operator} {operand})"

    def visit_FunctionCall(self, node: FunctionCall):
        func_name = self.visit(node.func_name)
        args = ', '.join([self.visit(arg) for arg in node.arguments])
        return f"{func_name}({args})"

    def visit_MemberAccess(self, node: MemberAccess):
        obj = self.visit(node.object_)
        return f"{obj}.{node.member}"

    def visit_VariableDeclaration(self, node: VariableDeclaration):
        var_type = node.var_type
        name = node.name
        value = self.visit(node.value)
        comment = "  # Mutable" if node.mutable else ""
        if var_type:
            py_type = self.map_type(var_type)
            self.code.append(f"{self.indent()}{name}: {
                             py_type} = {value}{comment}")
        else:
            self.code.append(f"{self.indent()}{name} = {value}{comment}")

    def visit_ArrayLiteral(self, node: ArrayLiteral):
        elements = ', '.join([self.visit(element)
                             for element in node.elements])
        return f"[{elements}]"

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
        self.code.append(f"{self.indent()}def test_{
                         generate_unique_name('test')}(self):")
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
        var_type = node.var_type
        value = self.visit(node.value)
        self.code.append(f"{self.indent()}{name}: {
                         var_type} = {value}  # Constant")

    def visit_FunctionDeclaration(self, node: FunctionDeclaration):
        decorators = ''.join([f"@{dec}\n" for dec in node.decorators])
        async_str = 'async ' if node.is_async else ''
        params = ', '.join([param[0] for param in node.params])
        # Only include a return type if it is not 'void'
        if node.return_type and node.return_type != 'void':
            return_type = f" -> {node.return_type}"
        else:
            return_type = ""
        self.code.append(f"{self.indent()}{decorators}{async_str}def {
                         node.name}({params}){return_type}:")
        self.indent_level += 1
        if not node.body:
            self.code.append(f"{self.indent()}pass")
        else:
            for stmt in node.body:
                self.visit(stmt)
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
                    self.code.append(f"{self.indent()}{name}: {
                                     py_type}{comment}")

                elif isinstance(member, MethodDeclaration):
                    self.visit(member)
        self.indent_level -= 1
        self.code.append('')  # Add a newline after class

    def visit_MethodDeclaration(self, node: MethodDeclaration):
        decorators = ''.join([f"@{dec}\n" for dec in node.decorators])
        async_str = 'async ' if node.is_async else ''
        # If the first parameter is "self", don't duplicate it.
        if node.params and node.params[0][0] == "self":
            params_list = [param[0] for param in node.params[1:]]
        else:
            params_list = [param[0] for param in node.params]
        params = ', '.join(params_list)
        # Map the return type if provided and not 'void'
        if node.return_type and node.return_type != 'void':
            return_type = f" -> {self.map_type(node.return_type)}"
        else:
            return_type = ""
        # If there are additional parameters, include a comma after 'self'
        if params:
            method_signature = f"def {node.name}(self, {params}){return_type}:"
        else:
            method_signature = f"def {node.name}(self){return_type}:"
        self.code.append(f"{decorators}{self.indent()}{
                         async_str}{method_signature}")
        self.indent_level += 1
        if not node.body:
            self.code.append(f"{self.indent()}pass")
        else:
            for stmt in node.body:
                self.visit(stmt)
        self.indent_level -= 1
        self.code.append('')  # Add a newline after method

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
                if method.params and method.params[0][0] == "self":
                    params_list = [param[0] for param in method.params[1:]]
                else:
                    params_list = [param[0] for param in method.params]
                params = ', '.join(params_list)
                if method.return_type and method.return_type != "void":
                    return_type = f" -> {self.map_type(method.return_type)}"
                else:
                    return_type = ""
                if params:
                    self.code.append(f"{self.indent()}def {
                                     method.name}(self, {params}){return_type}:")
                else:
                    self.code.append(f"{self.indent()}def {
                                     method.name}(self){return_type}:")
                self.code.append(f"{self.indent()}    pass")
        self.indent_level -= 1
        self.code.append('')  # Newline after interface

    def visit_EnumDeclaration(self, node: EnumDeclaration):
        self.imports.add("import enum")
        self.code.append(f"{self.indent()}class {node.name}(enum.Enum):")
        self.indent_level += 1
        if not node.variants:
            self.code.append(f"{self.indent()}pass")
        else:
            for variant in node.variants:
                if variant.fields:
                    fields = ', '.join(
                        [field.name for field in variant.fields])
                    self.code.append(f"{self.indent()}{
                                     variant.name} = ({fields},)")
                else:
                    self.code.append(f"{self.indent()}{
                                     variant.name} = enum.auto()")
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
                for stmt in arm.body:
                    self.visit(stmt)
            self.indent_level -= 1
        self.indent_level -= 1

    def visit_NumberPattern(self, node: NumberPattern):
        return str(node.value)

    def visit_WildcardPattern(self, node: WildcardPattern):
        return "_"

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
            self.code.append(f"{self.indent()}except {
                             error_type} as {error_var}:")
            self.indent_level += 1
            if not catch_block:
                self.code.append(f"{self.indent()}pass")
            else:
                for stmt in catch_block:
                    self.visit(stmt)
            self.indent_level -= 1
        if node.finally_block:
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

    def visit_LambdaExpression(self, node: LambdaExpression):
        # If the lambda's body consists of a single ReturnStatement, generate an inline lambda.
        if len(node.body) == 1 and isinstance(node.body[0], ReturnStatement) and node.body[0].expression is not None:
            expr = self.visit(node.body[0].expression)
            params = ', '.join([param[0] for param in node.params])
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
