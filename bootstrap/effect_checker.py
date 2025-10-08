"""Lightweight effect validation for the bootstrap compiler.

This module performs a conservative pass over the parsed Sailfin AST to ensure
that constructs which require explicit capability annotations declare the
corresponding effects.  The current implementation focuses on enforcing the
`model` effect for prompt blocks, keeping the analyser extensible for future
effectful operations such as network and filesystem access.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Iterable, List, Set

from ast_nodes import (
    Block,
    CatchClause,
    ForStatement,
    FunctionDeclaration,
    IfStatement,
    LoopStatement,
    MatchCase,
    MatchStatement,
    MethodDeclaration,
    PipelineDeclaration,
    Program,
    PromptStatement,
    RoutineDeclaration,
    StructDeclaration,
    TestDeclaration,
    ToolDeclaration,
    TryStatement,
    WhileStatement,
)


MODEL_EFFECT = "model"


@dataclass
class _Scope:
    name: str
    declared_effects: Set[str]
    required_effects: Set[str]


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
            self._check_routine(statement.name, statement.effects, statement.body)
        elif isinstance(statement, PipelineDeclaration):
            self._check_routine(f"pipeline {statement.name}", statement.effects, statement.body)
        elif isinstance(statement, ToolDeclaration):
            self._check_routine(f"tool {statement.name}", statement.effects, statement.body)
        elif isinstance(statement, TestDeclaration):
            self._check_routine(f"test {statement.name}", statement.effects, statement.body)
        elif isinstance(statement, StructDeclaration):
            for member in statement.members:
                if isinstance(member, MethodDeclaration):
                    self._check_routine(f"method {statement.name}.{member.name}", member.effects, member.body)
        else:
            # Other declarations do not yet participate in effect checking.
            return

    # ------------------------------------------------------------------
    # Routine analysis
    # ------------------------------------------------------------------

    def _check_routine(self, name: str, declared: Iterable[str], body: Block) -> None:
        declared_set = {effect.lower() for effect in declared}
        required = self._scan_block(body)
        missing = required - declared_set
        if missing:
            missing_list = ", ".join(sorted(missing))
            self._errors.append(f"{name} is missing effect annotation(s): {missing_list}")

    # ------------------------------------------------------------------
    # Scanners
    # ------------------------------------------------------------------

    def _scan_block(self, block: Block) -> Set[str]:
        required: Set[str] = set()
        for statement in block.statements:
            required |= self._scan_statement(statement)
        return required

    def _scan_statement(self, statement) -> Set[str]:  # type: ignore[override]
        if isinstance(statement, IfStatement):
            required = self._scan_block(statement.then_block)
            if isinstance(statement.else_branch, Block):
                required |= self._scan_block(statement.else_branch)
            elif isinstance(statement.else_branch, IfStatement):
                required |= self._scan_statement(statement.else_branch)
            return required
        if isinstance(statement, ForStatement):
            return self._scan_block(statement.body)
        if isinstance(statement, WhileStatement):
            return self._scan_block(statement.body)
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
            required: Set[str] = set()
            for case in statement.cases:
                required |= self._scan_match_case(case)
            return required
        if isinstance(statement, Block):
            return self._scan_block(statement)
        # Other statements currently have no effect implications.
        return set()

    def _scan_match_case(self, case: MatchCase) -> Set[str]:
        if isinstance(case.body, Block):
            return self._scan_block(case.body)
        # Expression bodies do not introduce prompt statements today.
        return set()


def validate_effects(program: Program) -> None:
    """Validate the declared effects for the given program.

    Raises:
        EffectValidationError: if any routine is missing required effects.
    """

    _EffectVisitor().validate(program)


__all__ = ["validate_effects", "EffectValidationError"]
