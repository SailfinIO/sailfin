"""Python code generation for the Sailfin bootstrap compiler.

This emitter walks the high-level Sailfin AST and produces Python 3
source that targets the helpers defined in `runtime_support.py`. The
implementation is intentionally conservative: the goal is to unlock
experimentation with the new grammar rather than to deliver a
feature-complete backend. Wherever behaviour is still undefined, the
emitter raises `NotImplementedError` to make the remaining work explicit.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import List, Optional, Tuple

from ast_nodes import (
    ArrayLiteral,
    AssertStatement,
    Assignment,
    AsyncBlockExpression,
    AwaitExpression,
    BinaryExpression,
    Block,
    BooleanLiteral,
    BreakStatement,
    CallExpression,
    CatchClause,
    ConstantDeclaration,
    ConstructorPattern,
    ContinueStatement,
    Decorator,
    EnumDeclaration,
    EnumVariant,
    Expression,
    ExpressionStatement,
    FieldDeclaration,
    ForStatement,
    FunctionDeclaration,
    Identifier,
    IdentifierPattern,
    IfStatement,
    ImportDeclaration,
    IndexExpression,
    InterfaceDeclaration,
    LambdaExpression,
    LiteralPattern,
    LoopStatement,
    MatchCase,
    MatchExpression,
    MatchStatement,
    MemberExpression,
    MethodDeclaration,
    NullLiteral,
    NumberLiteral,
    ObjectField,
    ObjectLiteral,
    OptionalType,
    ParallelExpression,
    Parameter,
    Pattern,
    PatternField,
    Program,
    QualifiedName,
    RangeExpression,
    ReturnStatement,
    RoutineDeclaration,
    SimpleType,
    StringLiteral,
    StructDeclaration,
    StructLiteral,
    ThrowStatement,
    TryStatement,
    TupleType,
    TypeAliasDeclaration,
    TypeCheckExpression,
    TypeParameter,
    UnionType,
    VariableDeclaration,
    WhileStatement,
    WildcardPattern,
    UnaryExpression,
)
from ast_nodes import ArrayType


@dataclass
class _PatternCompileResult:
    condition: str
    bindings: List[str]


class CodeGenerator:
    def __init__(self) -> None:
        self._lines: List[str] = []
        self._indent: int = 0
        self._temp_counter: int = 0
        self._async_stack: List[bool] = [False]
        self._imports: List[str] = [
            "import asyncio",
            "from bootstrap import runtime_support as runtime",
        ]
        self._preamble: List[str] = []
        self._functions: List[str] = []
        self._async_functions: set[str] = set()
        self._global_mutables: set[str] = set()

    # ------------------------------------------------------------------
    # Public API
    # ------------------------------------------------------------------

    def generate_code(self, program: Program) -> str:
        self._lines.clear()
        self._temp_counter = 0
        self._preamble = [
            "print = runtime.console",
            "sleep = runtime.sleep",
            "channel = runtime.channel",
            "parallel = runtime.parallel",
            "spawn = runtime.spawn",
        ]

        for stmt in program.statements:
            self._emit_statement(stmt)

        code_lines: List[str] = []
        code_lines.extend(self._imports)
        code_lines.append("")
        code_lines.extend(self._preamble)
        code_lines.append("")
        code_lines.extend(self._lines)

        if 'main' in self._functions:
            code_lines.append("")
            code_lines.append("if __name__ == '__main__':")
            if 'main' in self._async_functions:
                code_lines.append("    asyncio.run(main())")
            else:
                code_lines.append("    main()")
        return "\n".join(code_lines).rstrip() + "\n"

    # ------------------------------------------------------------------
    # Helpers
    # ------------------------------------------------------------------

    def _emit(self, text: str) -> None:
        indent = "    " * self._indent
        self._lines.append(f"{indent}{text}")

    def _new_temp(self, prefix: str) -> str:
        self._temp_counter += 1
        return f"__{prefix}_{self._temp_counter}"

    def _push_async(self, is_async: bool) -> None:
        self._async_stack.append(is_async)

    def _pop_async(self) -> None:
        self._async_stack.pop()

    @property
    def _in_async(self) -> bool:
        return bool(self._async_stack and self._async_stack[-1])

    # ------------------------------------------------------------------
    # Statements
    # ------------------------------------------------------------------

    def _emit_statement(self, stmt) -> None:  # type: ignore[override]
        if isinstance(stmt, ImportDeclaration):
            items = ", ".join(stmt.items)
            self._emit(f"# TODO import {items} from {stmt.source}")
        elif isinstance(stmt, TypeAliasDeclaration):
            self._emit(f"# type alias {stmt.name}")
        elif isinstance(stmt, InterfaceDeclaration):
            self._emit(f"# interface {stmt.name}")
        elif isinstance(stmt, StructDeclaration):
            self._emit_struct(stmt)
        elif isinstance(stmt, EnumDeclaration):
            self._emit_enum(stmt)
        elif isinstance(stmt, FunctionDeclaration):
            self._emit_function(stmt)
        elif isinstance(stmt, VariableDeclaration):
            if self._indent == 0 and stmt.mutable:
                self._global_mutables.add(stmt.name)
            self._emit_variable(stmt)
        elif isinstance(stmt, ConstantDeclaration):
            self._emit_constant(stmt)
        elif isinstance(stmt, ReturnStatement):
            self._emit_return(stmt)
        elif isinstance(stmt, ExpressionStatement):
            expr_code = self._emit_expression(stmt.expression)
            self._emit(expr_code)
        elif isinstance(stmt, Assignment):
            target = self._emit_expression(stmt.target)
            value = self._emit_expression(stmt.value)
            operator = stmt.operator or '='
            if operator == '=':
                self._emit(f"{target} = {value}")
            else:
                op = operator[0]
                self._emit(f"{target} {operator} {value}")
        elif isinstance(stmt, IfStatement):
            self._emit_if(stmt)
        elif isinstance(stmt, WhileStatement):
            condition = self._emit_expression(stmt.condition)
            self._emit(f"while {condition}:")
            self._indent += 1
            self._emit_block(stmt.body)
            self._indent -= 1
        elif isinstance(stmt, LoopStatement):
            self._emit("while True:")
            self._indent += 1
            self._emit_block(stmt.body)
            self._indent -= 1
        elif isinstance(stmt, ForStatement):
            iterable = self._emit_expression(stmt.iterable)
            pattern_code = self._emit_pattern_assignment(stmt.pattern, "__item")
            self._emit(f"for __item in {iterable}:")
            self._indent += 1
            for line in pattern_code:
                self._emit(line)
            self._emit_block(stmt.body)
            self._indent -= 1
        elif isinstance(stmt, BreakStatement):
            self._emit("break")
        elif isinstance(stmt, ContinueStatement):
            self._emit("continue")
        elif isinstance(stmt, ThrowStatement):
            expr = self._emit_expression(stmt.expression)
            self._emit(f"raise Exception({expr})")
        elif isinstance(stmt, AssertStatement):
            expr = self._emit_expression(stmt.expression)
            self._emit(f"assert {expr}")
        elif isinstance(stmt, TryStatement):
            self._emit_try(stmt)
        elif isinstance(stmt, RoutineDeclaration):
            self._emit_routine(stmt)
        elif isinstance(stmt, MatchStatement):
            self._emit_match_statement(stmt)
        elif isinstance(stmt, MatchExpression):
            temp = self._emit_match_expression(stmt)
            self._emit(temp)
        elif isinstance(stmt, ParallelExpression):
            expr = self._emit_expression(stmt)
            self._emit(expr)
        else:  # pragma: no cover - future extensions
            raise NotImplementedError(f"Unhandled statement: {type(stmt).__name__}")

    def _emit_block(self, block: Block) -> None:
        if not block.statements:
            self._emit("pass")
            return
        for inner in block.statements:
            self._emit_statement(inner)

    def _emit_struct(self, decl: StructDeclaration) -> None:
        self._emit(f"class {decl.name}:")
        self._indent += 1
        fields = [m for m in decl.members if isinstance(m, FieldDeclaration)]
        methods = [m for m in decl.members if isinstance(m, MethodDeclaration)]
        if not fields and not methods:
            self._emit("pass")
        else:
            params = ["self"] + [field.name for field in fields]
            self._emit(f"def __init__({', '.join(params)}):")
            self._indent += 1
            if not fields:
                self._emit("pass")
            else:
                for field in fields:
                    self._emit(f"self.{field.name} = {field.name}")
            self._indent -= 1
            for method in methods:
                self._emit_method(method)
        self._indent -= 1
        self._emit("")

    def _emit_enum(self, decl: EnumDeclaration) -> None:
        enum_var = decl.name
        self._emit(f"{enum_var} = runtime.EnumType('{enum_var}')")
        for variant in decl.variants:
            field_names = [field.name for field in variant.fields]
            args = ", ".join(f"'{name}'" for name in field_names)
            self._emit(
                f"{enum_var}.{variant.name} = {enum_var}.variant('{variant.name}', [{args}])"
            )
        self._emit("")

    def _emit_method(self, method: MethodDeclaration) -> None:
        param_entries = []
        has_self = any(param.name == 'self' for param in method.parameters)
        decorator_strings = [self._emit_decorator(decorator) for decorator in method.decorators]
        if not has_self:
            decorator_strings.append("@staticmethod")

        for param in method.parameters:
            if has_self and param.name == 'self':
                continue
            entry = param.name
            if param.default is not None:
                entry += f"={self._emit_expression(param.default)}"
            param_entries.append(entry)
        signature_parts = ['self'] + param_entries if has_self else param_entries
        signature = ", ".join(signature_parts)
        header = "async def" if method.is_async else "def"
        for deco in decorator_strings:
            self._emit(deco)
        self._emit(f"{header} {method.name}({signature}):")
        self._indent += 1
        self._push_async(method.is_async)
        self._emit_block(method.body)
        self._pop_async()
        self._indent -= 1

    def _emit_function(self, func: FunctionDeclaration) -> None:
        params = ", ".join(param.name for param in func.parameters)
        header = "async def" if func.is_async else "def"
        for decorator in func.decorators:
            deco = self._emit_decorator(decorator)
            self._emit(deco)
        param_entries = []
        for param in func.parameters:
            entry = param.name
            if param.default is not None:
                entry += f"={self._emit_expression(param.default)}"
            param_entries.append(entry)
        params = ", ".join(param_entries)
        self._emit(f"{header} {func.name}({params}):")
        self._indent += 1
        self._push_async(func.is_async)
        if self._global_mutables:
            for name in sorted(self._global_mutables):
                self._emit(f"global {name}")
        if not func.body.statements:
            self._emit("pass")
        else:
            self._emit_block(func.body)
        self._pop_async()
        self._indent -= 1
        self._emit("")
        self._functions.append(func.name)
        if func.is_async:
            self._async_functions.add(func.name)

    def _emit_variable(self, decl: VariableDeclaration) -> None:
        name = decl.name
        if decl.initializer is not None:
            value = self._emit_expression(decl.initializer)
        else:
            value = "None"
        self._emit(f"{name} = {value}")

    def _emit_constant(self, decl: ConstantDeclaration) -> None:
        value = self._emit_expression(decl.initializer)
        self._emit(f"{decl.name} = {value}")

    def _emit_return(self, stmt: ReturnStatement) -> None:
        if stmt.value is None:
            self._emit("return")
        else:
            expr = self._emit_expression(stmt.value)
            self._emit(f"return {expr}")

    def _emit_if(self, stmt: IfStatement) -> None:
        condition = self._emit_expression(stmt.condition)
        self._emit(f"if {condition}:")
        self._indent += 1
        self._emit_block(stmt.then_block)
        self._indent -= 1
        if stmt.else_branch:
            if isinstance(stmt.else_branch, IfStatement):
                self._emit("else:")
                self._indent += 1
                self._emit_if(stmt.else_branch)
                self._indent -= 1
            else:
                self._emit("else:")
                self._indent += 1
                self._emit_block(stmt.else_branch)
                self._indent -= 1

    def _emit_try(self, stmt: TryStatement) -> None:
        self._emit("try:")
        self._indent += 1
        self._emit_block(stmt.try_block)
        self._indent -= 1
        if stmt.catch:
            var = stmt.catch.identifier
            self._emit(f"except Exception as {var}:")
            self._indent += 1
            if stmt.catch.pattern:
                self._emit("# TODO pattern matching in catch")
            self._emit_block(stmt.catch.body)
            self._indent -= 1
        if stmt.finally_block:
            self._emit("finally:")
            self._indent += 1
            self._emit_block(stmt.finally_block)
            self._indent -= 1

    def _emit_routine(self, stmt: RoutineDeclaration) -> None:
        routine_name = self._new_temp("routine")
        self._emit(f"async def {routine_name}():")
        self._indent += 1
        self._push_async(True)
        self._emit_block(stmt.body)
        self._pop_async()
        self._indent -= 1
        if stmt.name:
            self._emit(f"spawn({routine_name}, name='{stmt.name}')")
        else:
            self._emit(f"spawn({routine_name})")

    def _emit_match_statement(self, stmt: MatchStatement) -> None:
        value_var = self._new_temp("match_value")
        matched_var = self._new_temp("match_flag")
        self._emit(f"{value_var} = {self._emit_expression(stmt.value)}")
        self._emit(f"{matched_var} = False")
        for case in stmt.cases:
            compiled = self._compile_pattern(case.pattern, value_var)
            condition = compiled.condition or "True"
            self._emit(f"if (not {matched_var}) and ({condition}):")
            self._indent += 1
            for binding in compiled.bindings:
                self._emit(binding)
            if case.guard:
                guard = self._emit_expression(case.guard)
                self._emit(f"if {guard}:")
                self._indent += 1
                self._emit(f"{matched_var} = True")
                self._emit_case_body(case.body)
                self._indent -= 1
            else:
                self._emit(f"{matched_var} = True")
                self._emit_case_body(case.body)
            self._indent -= 1
        self._emit(f"if not {matched_var}:")
        self._indent += 1
        self._emit(f"runtime.match_exhaustive_failed({value_var})")
        self._indent -= 1

    def _emit_case_body(self, body) -> None:  # type: ignore[override]
        if isinstance(body, Block):
            self._emit_block(body)
        else:
            expr = self._emit_expression(body)
            self._emit(expr)

    def _emit_match_expression(self, expr: MatchExpression) -> str:
        result_var = self._new_temp("match_result")
        value_var = self._new_temp("match_value")
        matched_var = self._new_temp("match_flag")
        self._emit(f"{value_var} = {self._emit_expression(expr.value)}")
        self._emit(f"{matched_var} = False")
        self._emit(f"{result_var} = None")
        for case in expr.cases:
            compiled = self._compile_pattern(case.pattern, value_var)
            condition = compiled.condition or "True"
            self._emit(f"if (not {matched_var}) and ({condition}):")
            self._indent += 1
            for binding in compiled.bindings:
                self._emit(binding)
            if case.guard:
                guard = self._emit_expression(case.guard)
                self._emit(f"if {guard}:")
                self._indent += 1
                self._emit(f"{matched_var} = True")
                result_expr = self._emit_expression(case.body) if not isinstance(case.body, Block) else None
                if result_expr is None:
                    raise NotImplementedError("Blocks as match expressions are not supported yet")
                self._emit(f"{result_var} = {result_expr}")
                self._indent -= 1
            else:
                self._emit(f"{matched_var} = True")
                result_expr = self._emit_expression(case.body) if not isinstance(case.body, Block) else None
                if result_expr is None:
                    raise NotImplementedError("Blocks as match expressions are not supported yet")
                self._emit(f"{result_var} = {result_expr}")
            self._indent -= 1
        self._emit(f"if not {matched_var}:")
        self._indent += 1
        self._emit(f"runtime.match_exhaustive_failed({value_var})")
        self._indent -= 1
        return result_var

    # ------------------------------------------------------------------
    # Expressions
    # ------------------------------------------------------------------

    def _emit_expression(self, expr: Expression) -> str:  # type: ignore[override]
        if isinstance(expr, Identifier):
            if expr.type_arguments:
                raise NotImplementedError("Generic type arguments at runtime")
            return expr.name
        if isinstance(expr, NumberLiteral):
            return repr(expr.value)
        if isinstance(expr, StringLiteral):
            value = expr.value
            if "{{" in value and "}}" in value:
                literal = repr(value)
                return f"runtime.format_string({literal}, locals(), globals())"
            return repr(value)
        if isinstance(expr, BooleanLiteral):
            return "True" if expr.value else "False"
        if isinstance(expr, NullLiteral):
            return "None"
        if isinstance(expr, ArrayLiteral):
            elements = ", ".join(self._emit_expression(el) for el in expr.elements)
            return f"[{elements}]"
        if isinstance(expr, ObjectLiteral):
            items = ", ".join(f"{field.name!r}: {self._emit_expression(field.value)}" for field in expr.fields)
            return f"{{{items}}}"
        if isinstance(expr, StructLiteral):
            args = ", ".join(f"{field.name}={self._emit_expression(field.value)}" for field in expr.fields)
            return f"{self._emit_qualified_name(expr.type_name)}({args})"
        if isinstance(expr, MemberExpression):
            target = self._emit_expression(expr.object)
            return f"{target}.{expr.member}"
        if isinstance(expr, IndexExpression):
            sequence = self._emit_expression(expr.sequence)
            index = self._emit_expression(expr.index)
            return f"{sequence}[{index}]"
        if isinstance(expr, CallExpression):
            callee = self._emit_expression(expr.callee)
            args = ", ".join(self._emit_expression(arg) for arg in expr.arguments)
            return f"{callee}({args})"
        if isinstance(expr, BinaryExpression):
            left = self._emit_expression(expr.left)
            right = self._emit_expression(expr.right)
            operator = expr.operator
            if operator == '&&':
                operator = 'and'
            elif operator == '||':
                operator = 'or'
            return f"({left} {operator} {right})"
        if isinstance(expr, UnaryExpression):
            operand = self._emit_expression(expr.operand)
            operator = expr.operator
            if operator == '!':
                operator = 'not '
                return f"({operator}{operand})"
            return f"({operator}{operand})"
        if isinstance(expr, AwaitExpression):
            if not self._in_async:
                raise NotImplementedError("'await' used outside of an async context")
            inner = self._emit_expression(expr.expression)
            return f"await {inner}"
        if isinstance(expr, RangeExpression):
            start = self._emit_expression(expr.start)
            end = self._emit_expression(expr.end)
            return f"range({start}, {end})"
        if isinstance(expr, LambdaExpression):
            return self._emit_lambda(expr)
        if isinstance(expr, ParallelExpression):
            thunks = ", ".join(self._emit_expression(arg) for arg in expr.thunks)
            return f"parallel([{thunks}])"
        if isinstance(expr, AsyncBlockExpression):
            raise NotImplementedError("async blocks as expressions are not supported yet")
        if isinstance(expr, MatchExpression):
            temp = self._emit_match_expression(expr)
            return temp
        if isinstance(expr, TypeCheckExpression):
            value = self._emit_expression(expr.value)
            type_expr = self._emit_type(expr.type_annotation)
            return f"isinstance({value}, {type_expr})"
        raise NotImplementedError(f"Unhandled expression: {type(expr).__name__}")

    def _emit_lambda(self, expr: LambdaExpression) -> str:
        names = [param.name for param in expr.parameters]
        simple = (
            len(expr.body.statements) == 1
            and isinstance(expr.body.statements[0], ReturnStatement)
            and expr.body.statements[0].value is not None
        )
        if simple:
            value = self._emit_expression(expr.body.statements[0].value)
            return f"lambda {', '.join(names)}: {value}"
        func_name = self._new_temp("lambda")
        self._emit(f"def {func_name}({', '.join(names)}):")
        self._indent += 1
        self._emit_block(expr.body)
        self._indent -= 1
        return func_name

    # ------------------------------------------------------------------
    # Pattern compilation
    # ------------------------------------------------------------------

    def _compile_pattern(self, pattern: Pattern, value_expr: str) -> _PatternCompileResult:
        if isinstance(pattern, WildcardPattern):
            return _PatternCompileResult(condition="True", bindings=[])
        if isinstance(pattern, IdentifierPattern):
            binding = f"{pattern.name} = {value_expr}"
            return _PatternCompileResult(condition="True", bindings=[binding])
        if isinstance(pattern, LiteralPattern):
            literal = self._emit_expression(pattern.value)
            return _PatternCompileResult(condition=f"{value_expr} == {literal}", bindings=[])
        if isinstance(pattern, ConstructorPattern):
            type_expr = self._emit_qualified_name(pattern.type_name)
            condition_parts = [f"isinstance({value_expr}, {type_expr})"]
            bindings: List[str] = []
            for field in pattern.fields:
                field_expr = f"{value_expr}.{field.name}"
                if field.pattern is None:
                    bindings.append(f"{field.name} = {field_expr}")
                else:
                    sub = self._compile_pattern(field.pattern, field_expr)
                    if sub.condition:
                        condition_parts.append(sub.condition)
                    bindings.extend(sub.bindings)
            condition = " and ".join(condition_parts)
            return _PatternCompileResult(condition=condition, bindings=bindings)
        raise NotImplementedError(f"Pattern type {type(pattern).__name__} not supported")

    def _emit_pattern_assignment(self, pattern: Pattern, source: str) -> List[str]:
        compiled = self._compile_pattern(pattern, source)
        lines = []
        if compiled.condition != "True":
            lines.append(f"if not ({compiled.condition}):")
            lines.append("    continue")
        lines.extend(compiled.bindings)
        return lines

    # ------------------------------------------------------------------
    # Type helpers
    # ------------------------------------------------------------------

    def _emit_type(self, annotation) -> str:  # type: ignore[override]
        if isinstance(annotation, SimpleType):
            return self._emit_qualified_name(annotation.name)
        if isinstance(annotation, ArrayType):
            element = self._emit_type(annotation.element_type)
            return f"List[{element}]"
        if isinstance(annotation, TupleType):
            elements = ", ".join(self._emit_type(el) for el in annotation.elements)
            return f"Tuple[{elements}]"
        if isinstance(annotation, OptionalType):
            inner = self._emit_type(annotation.base)
            return f"Optional[{inner}]"
        if isinstance(annotation, UnionType):
            members = ", ".join(self._emit_type(option) for option in annotation.options)
            return f"Union[{members}]"
        return "object"

    def _emit_decorator(self, decorator: Decorator) -> str:
        if decorator.arguments:
            args = ", ".join(self._emit_expression(arg) for arg in decorator.arguments)
            return f"@{self._emit_qualified_name(decorator.name)}({args})"
        return f"@{self._emit_qualified_name(decorator.name)}"

    def _emit_qualified_name(self, name: QualifiedName) -> str:
        return ".".join(name.parts)


__all__ = ["CodeGenerator"]
