"""Lightweight effect validation for the bootstrap compiler.

This module performs a conservative pass over the parsed Sailfin AST to ensure
that constructs which require explicit capability annotations declare the
corresponding effects.  It currently enforces:

* `model` – required when a routine contains a `prompt` block.
* `io` – required when runtime filesystem helpers (`fs.*`) are invoked.
* `net` – required for network helpers (`http.*`, `websocket.*`, or `serve`).

The intent is to provide fast feedback inside the bootstrap compiler while the
full static analysis for the self-hosted implementation matures.
"""

from __future__ import annotations

from typing import Iterable, List, Set

from stage0.ast_nodes import (
    ArrayLiteral,
    Assignment,
    Block,
    CatchClause,
    Decorator,
    Expression,
    ExpressionStatement,
    ForStatement,
    FunctionDeclaration,
    Identifier,
    IfStatement,
    LoopStatement,
    MatchCase,
    MatchExpression,
    MatchStatement,
    MethodDeclaration,
    MemberExpression,
    PipelineDeclaration,
    Program,
    PromptStatement,
    RangeExpression,
    ReturnStatement,
    RoutineDeclaration,
    StructDeclaration,
    StructLiteral,
    TestDeclaration,
    ToolDeclaration,
    TryStatement,
    TypeCheckExpression,
    VariableDeclaration,
    WhileStatement,
    WithStatement,
    CallExpression,
    AwaitExpression,
    BinaryExpression,
    UnaryExpression,
    ObjectLiteral,
    LambdaExpression,
    ParallelExpression,
)


MODEL_EFFECT = "model"


_DECORATOR_EFFECTS_BY_PATH = {
    ("logExecution",): {"io"},
    ("runtime", "logExecution"): {"io"},
}


_DECORATOR_EFFECTS_BY_NAME = {
    "logexecution": {"io"},
    "trace": {"io"},
}


class EffectValidationError(ValueError):
    """Raised when the AST violates the conservative effect rules."""


class _EffectVisitor:
    def __init__(self) -> None:
        self._errors: List[str] = []

    def validate(self, program: Program) -> None:
        for statement in program.statements:
            self._check_top_level(statement)
        if self._errors:
            raise EffectValidationError("\n".join(self._errors))

    # ------------------------------------------------------------------
    # Top-level dispatch
    # ------------------------------------------------------------------

    def _check_top_level(self, statement):  # type: ignore[override]
        if isinstance(statement, FunctionDeclaration):
            self._check_routine(
                statement.name,
                statement.effects,
                statement.body,
                decorators=statement.decorators,
            )
        elif isinstance(statement, PipelineDeclaration):
            self._check_routine(f"pipeline {statement.name}", statement.effects, statement.body)
        elif isinstance(statement, ToolDeclaration):
            self._check_routine(f"tool {statement.name}", statement.effects, statement.body)
        elif isinstance(statement, TestDeclaration):
            self._check_routine(f"test {statement.name}", statement.effects, statement.body)
        elif isinstance(statement, StructDeclaration):
            for member in statement.members:
                if isinstance(member, MethodDeclaration):
                    self._check_routine(
                        f"method {statement.name}.{member.name}",
                        member.effects,
                        member.body,
                        decorators=member.decorators,
                    )
        else:
            # Other declarations do not yet participate in effect checking.
            return

    # ------------------------------------------------------------------
    # Routine analysis
    # ------------------------------------------------------------------

    def _check_routine(
        self,
        name: str,
        declared: Iterable[str],
        body: Block,
        decorators: Iterable[Decorator] = (),
    ) -> None:
        declared_set = {effect.lower() for effect in declared}
        required = self._scan_block(body)
        required |= self._effects_for_decorators(decorators)
        missing = required - declared_set
        if missing:
            missing_list = ", ".join(sorted(missing))
            self._errors.append(f"{name} is missing effect annotation(s): {missing_list}")

    # ------------------------------------------------------------------
    # Scanners
    # ------------------------------------------------------------------

    def _effects_for_decorators(self, decorators: Iterable[Decorator]) -> Set[str]:
        required: Set[str] = set()
        for decorator in decorators:
            parts = tuple(decorator.name.parts)
            if not parts:
                continue
            direct = _DECORATOR_EFFECTS_BY_PATH.get(parts)
            if direct:
                required |= direct
                continue
            tail_effects = _DECORATOR_EFFECTS_BY_NAME.get(parts[-1].lower())
            if tail_effects:
                required |= tail_effects
        return required

    def _scan_block(self, block: Block) -> Set[str]:
        required: Set[str] = set()
        for statement in block.statements:
            required |= self._scan_statement(statement)
        return required

    def _scan_statement(self, statement) -> Set[str]:  # type: ignore[override]
        if isinstance(statement, PromptStatement):
            return {MODEL_EFFECT}
        if isinstance(statement, ExpressionStatement):
            return self._scan_expression(statement.expression)
        if isinstance(statement, ReturnStatement):
            return self._scan_expression(statement.value)
        if isinstance(statement, Assignment):
            return self._scan_expression(statement.value)
        if isinstance(statement, VariableDeclaration):
            return self._scan_expression(statement.initializer)
        if isinstance(statement, IfStatement):
            required = self._scan_expression(statement.condition)
            required |= self._scan_block(statement.then_block)
            if isinstance(statement.else_branch, Block):
                required |= self._scan_block(statement.else_branch)
            elif isinstance(statement.else_branch, IfStatement):
                required |= self._scan_statement(statement.else_branch)
            return required
        if isinstance(statement, ForStatement):
            required = self._scan_expression(statement.iterable)
            return required | self._scan_block(statement.body)
        if isinstance(statement, WhileStatement):
            required = self._scan_expression(statement.condition)
            return required | self._scan_block(statement.body)
        if isinstance(statement, LoopStatement):
            return self._scan_block(statement.body)
        if isinstance(statement, RoutineDeclaration):
            return self._scan_block(statement.body)
        if isinstance(statement, TryStatement):
            required = self._scan_block(statement.try_block)
            if isinstance(statement.catch, CatchClause):
                required |= self._scan_block(statement.catch.body)
            if statement.finally_block:
                required |= self._scan_block(statement.finally_block)
            return required
        if isinstance(statement, MatchStatement):
            required: Set[str] = self._scan_expression(statement.value)
            for case in statement.cases:
                required |= self._scan_match_case(case)
            return required
        if isinstance(statement, WithStatement):
            required = set()
            for clause in statement.clauses:
                required |= self._scan_expression(clause)
            return required | self._scan_block(statement.body)
        if isinstance(statement, Block):
            return self._scan_block(statement)
        # Other statements currently have no effect implications.
        return set()

    def _scan_match_case(self, case: MatchCase) -> Set[str]:
        if isinstance(case.body, Block):
            return self._scan_block(case.body)
        return self._scan_expression(case.body)

    # ------------------------------------------------------------------
    # Expression analysis
    # ------------------------------------------------------------------

    def _scan_expression(self, expression: Expression | None) -> Set[str]:
        if expression is None:
            return set()
        if isinstance(expression, CallExpression):
            required = self._scan_expression(expression.callee)
            for argument in expression.arguments:
                required |= self._scan_expression(argument)
            required |= self._effects_for_call(expression.callee)
            return required
        if isinstance(expression, MemberExpression):
            return self._scan_expression(expression.object)
        if isinstance(expression, AwaitExpression):
            return self._scan_expression(expression.expression)
        if isinstance(expression, BinaryExpression):
            return self._scan_expression(expression.left) | self._scan_expression(expression.right)
        if isinstance(expression, UnaryExpression):
            return self._scan_expression(expression.operand)
        if isinstance(expression, ArrayLiteral):
            required: Set[str] = set()
            for element in expression.elements:
                required |= self._scan_expression(element)
            return required
        if isinstance(expression, StructLiteral):
            required: Set[str] = set()
            for field in expression.fields:
                required |= self._scan_expression(field.value)
            return required
        if isinstance(expression, ObjectLiteral):
            required: Set[str] = set()
            for field in expression.fields:
                required |= self._scan_expression(field.value)
            return required
        if isinstance(expression, LambdaExpression):
            return self._scan_block(expression.body)
        if isinstance(expression, ParallelExpression):
            required: Set[str] = set()
            for thunk in expression.thunks:
                required |= self._scan_expression(thunk)
            return required
        if isinstance(expression, RangeExpression):
            return self._scan_expression(expression.start) | self._scan_expression(expression.end)
        if isinstance(expression, MatchExpression):
            required = self._scan_expression(expression.value)
            for case in expression.cases:
                required |= self._scan_match_case(case)
            return required
        if isinstance(expression, TypeCheckExpression):
            return self._scan_expression(expression.value)
        # Identifiers, literals, etc. carry no effects by themselves.
        return set()

    def _effects_for_call(self, callee: Expression) -> Set[str]:
        path = self._member_path(callee)
        if path:
            root = path[0]
            member = path[-1]
            if root == "fs":
                return {"io"}
            if root in {"http", "websocket"}:
                return {"net"}
            if root in {"print", "console"}:
                return {"io"}
            if root == "runtime":
                if len(path) >= 2:
                    runtime_helper = path[1]
                    if runtime_helper == "console":
                        return {"io"}
                    if runtime_helper == "fs":
                        return {"io"}
                    if runtime_helper in {"http", "websocket"}:
                        return {"net"}
                if member == "spawn":
                    return {"io"}
                if member == "serve":
                    return {"net"}
                if member == "sleep":
                    return {"clock"}
        if isinstance(callee, Identifier):
            if callee.name == "serve":
                return {"net"}
            if callee.name == "spawn":
                return {"io"}
            if callee.name == "sleep":
                return {"clock"}
        root = self._root_identifier(callee)
        if root in {"http", "websocket"}:
            return {"net"}
        if root == "fs":
            return {"io"}
        if root == "runtime":
            if isinstance(callee, MemberExpression):
                if callee.member == "spawn":
                    return {"io"}
                if callee.member == "serve":
                    return {"net"}
                if callee.member == "sleep":
                    return {"clock"}
                if isinstance(callee.object, MemberExpression):
                    helper = callee.object.member
                    if helper == "console":
                        return {"io"}
                    if helper == "fs":
                        return {"io"}
                    if helper in {"http", "websocket"}:
                        return {"net"}
        return set()

    def _root_identifier(self, expression: Expression) -> str | None:
        current = expression
        while isinstance(current, MemberExpression):
            current = current.object
        if isinstance(current, Identifier):
            return current.name
        return None

    def _member_path(self, expression: Expression) -> List[str] | None:
        parts: List[str] = []
        current = expression
        while isinstance(current, MemberExpression):
            parts.append(current.member)
            current = current.object
        if isinstance(current, Identifier):
            parts.append(current.name)
            return list(reversed(parts))
        return None


def validate_effects(program: Program) -> None:
    """Validate the declared effects for the given program.

    Raises:
        EffectValidationError: if any routine is missing required effects.
    """

    _EffectVisitor().validate(program)


__all__ = ["validate_effects", "EffectValidationError"]
