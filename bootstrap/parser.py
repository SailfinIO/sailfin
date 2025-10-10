"""Recursive-descent parser for the Sailfin bootstrap compiler.

The previous parser relied on PLY's yacc module but had diverged from the
current AST definitions and language design.  This module implements a
purpose-built parser that produces the richer dataclasses defined in
``bootstrap.ast_nodes`` and focuses on the subset of the grammar required by
the bootstrap compiler and examples.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Iterable, Iterator, List, Optional, Sequence

from bootstrap.ast_nodes import (
    ArrayLiteral,
    Assignment,
    AssertStatement,
    AwaitExpression,
    BinaryExpression,
    Block,
    BooleanLiteral,
    CallExpression,
    CatchClause,
    ConstructorPattern,
    Decorator,
    EnumDeclaration,
    EnumVariant,
    Expression,
    ExpressionStatement,
    LambdaExpression,
    FieldDeclaration,
    FunctionDeclaration,
    FunctionSignature,
    Identifier,
    IdentifierPattern,
    IfStatement,
    ImportDeclaration,
    InterfaceDeclaration,
    LiteralPattern,
    MatchCase,
    MatchStatement,
    MemberExpression,
    IndexExpression,
    MethodDeclaration,
    ModelDeclaration,
    ModelProperty,
    NullLiteral,
    NumberLiteral,
    ObjectField,
    ObjectLiteral,
    OptionalType,
    ParallelExpression,
    Parameter,
    Pattern,
    PatternField,
    PipelineDeclaration,
    Program,
    PromptStatement,
    QualifiedName,
    RoutineDeclaration,
    ForStatement,
    LoopStatement,
    RangeExpression,
    SimpleType,
    Statement,
    StringLiteral,
    StructDeclaration,
    StructLiteral,
    TypeCheckExpression,
    ToolDeclaration,
    TestDeclaration,
    UnaryExpression,
    ReturnStatement,
    ThrowStatement,
    TryStatement,
    TypeAnnotation,
    TypeAliasDeclaration,
    TypeParameter,
    TupleType,
    ArrayType,
    IntersectionType,
    FunctionType,
    UnionType,
    VariableDeclaration,
    WithStatement,
    WildcardPattern,
)


class ParseError(SyntaxError):
    """Raised when the parser encounters an unexpected token."""


@dataclass(frozen=True)
class Token:
    type: str
    value: object
    lineno: int
    column: int


def _compute_column(lexpos: int, text: str) -> int:
    line_start = text.rfind("\n", 0, lexpos) + 1
    return lexpos - line_start + 1


def _tokenize(source: str, lexer) -> List[Token]:
    lexer.input(source)
    tokens: List[Token] = []
    tok = lexer.token()
    while tok is not None:
        column = _compute_column(getattr(tok, "lexpos", 0), source)
        tokens.append(Token(tok.type, tok.value, tok.lineno, column))
        tok = lexer.token()
    tokens.append(Token("EOF", "<eof>", tokens[-1].lineno if tokens else 1, 0))
    return tokens


class _TokenStream:
    def __init__(self, tokens: Sequence[Token]):
        self._tokens = tokens
        self._index = 0

    @property
    def current(self) -> Token:
        return self._tokens[self._index]

    @property
    def previous(self) -> Token:
        return self._tokens[self._index - 1]

    def peek(self, offset: int = 0) -> Token:
        new_index = self._index + offset
        if new_index < 0:
            new_index = 0
        if new_index >= len(self._tokens):
            return self._tokens[-1]
        return self._tokens[new_index]

    def advance(self) -> Token:
        token = self.current
        if token.type != "EOF":
            self._index += 1
        return token

    def match(self, *token_types: str) -> Optional[Token]:
        if self.current.type in token_types:
            token = self.current
            self.advance()
            return token
        return None

    def expect(self, token_type: str, message: Optional[str] = None) -> Token:
        token = self.match(token_type)
        if token is None:
            current = self.current
            expected = message or f"Expected {token_type}, found {current.type}"
            raise ParseError(f"{expected} at line {current.lineno}, column {current.column}")
        return token

    def check(self, token_type: str) -> bool:
        return self.current.type == token_type

    def at_end(self) -> bool:
        return self.current.type == "EOF"


class _SailParser:
    def __init__(self, stream: _TokenStream):
        self.tokens = stream

    # ------------------------------------------------------------------
    # Entry point
    # ------------------------------------------------------------------

    def parse_program(self) -> Program:
        statements: List[Statement] = []
        while not self.tokens.at_end():
            if self.tokens.match("SEMICOLON"):
                continue
            statements.append(self._parse_top_level())
        return Program(statements)

    # ------------------------------------------------------------------
    # Top level constructs
    # ------------------------------------------------------------------

    def _parse_top_level(self) -> Statement:
        if self.tokens.check("IMPORT"):
            return self._parse_import()
        if self.tokens.check("STRUCT"):
            return self._parse_struct()
        if self.tokens.check("ENUM"):
            return self._parse_enum()
        if self.tokens.check("INTERFACE"):
            return self._parse_interface()
        if self.tokens.check("MODEL"):
            return self._parse_model()
        if self.tokens.check("PIPELINE"):
            return self._parse_pipeline()
        if self.tokens.check("TOOL"):
            return self._parse_tool()
        if self.tokens.check("TYPE"):
            return self._parse_type_alias()
        if self.tokens.check("LET"):
            return self._parse_variable_declaration()
        if self.tokens.check("TEST"):
            return self._parse_test()
        decorators = self._parse_decorators()
        if self.tokens.check("ASYNC") or self.tokens.check("FN"):
            return self._parse_function(decorators=decorators)
        if decorators:
            current = self.tokens.current
            raise ParseError(
                f"Unexpected token {current.type} after decorator at line {current.lineno}, column {current.column}"
            )
        return self._parse_statement()

    # ------------------------------------------------------------------
    # Imports & type aliases
    # ------------------------------------------------------------------

    def _parse_import(self) -> ImportDeclaration:
        self.tokens.expect("IMPORT")
        self.tokens.expect("LBRACE")
        items: List[str] = []
        if not self.tokens.check("RBRACE"):
            while True:
                ident = self.tokens.expect("IDENTIFIER")
                items.append(str(ident.value))
                if not self.tokens.match("COMMA"):
                    break
                if self.tokens.check("RBRACE"):
                    break
        self.tokens.expect("RBRACE")
        self.tokens.expect("FROM")
        source = self.tokens.expect("STRING").value
        self.tokens.expect("SEMICOLON")
        return ImportDeclaration(items=items, source=source)

    def _parse_type_alias(self) -> TypeAliasDeclaration:
        self.tokens.expect("TYPE")
        name = self.tokens.expect("IDENTIFIER").value
        type_params = self._parse_type_parameters()
        self.tokens.expect("ASSIGN")
        aliased = self._parse_type()
        self.tokens.expect("SEMICOLON")
        return TypeAliasDeclaration(name=name, type_parameters=type_params, aliased_type=aliased)

    def _parse_model(self) -> ModelDeclaration:
        self.tokens.expect("MODEL")
        name = self.tokens.expect("IDENTIFIER").value
        self.tokens.expect("COLON")
        model_type = self._parse_type()
        effects = self._parse_effect_list()
        self.tokens.expect("LBRACE")
        properties: List[ModelProperty] = []
        while not self.tokens.match("RBRACE"):
            prop_name = self.tokens.expect("IDENTIFIER").value
            self.tokens.expect("ASSIGN")
            value = self._parse_expression()
            self.tokens.expect("SEMICOLON")
            properties.append(ModelProperty(name=prop_name, value=value))
        return ModelDeclaration(name=name, model_type=model_type, properties=properties, effects=effects)

    def _parse_pipeline(self) -> PipelineDeclaration:
        self.tokens.expect("PIPELINE")
        name = self.tokens.expect("IDENTIFIER").value
        parameters = self._parse_parameter_list()
        return_type: Optional[TypeAnnotation] = None
        if self.tokens.match("ARROW"):
            return_type = self._parse_type()
        effects = self._parse_effect_list()
        body = self._parse_block()
        return PipelineDeclaration(name=name, parameters=parameters, body=body, return_type=return_type, effects=effects)

    def _parse_tool(self) -> ToolDeclaration:
        self.tokens.expect("TOOL")
        name = self.tokens.expect("IDENTIFIER").value
        parameters = self._parse_parameter_list()
        return_type: Optional[TypeAnnotation] = None
        if self.tokens.match("ARROW"):
            return_type = self._parse_type()
        effects = self._parse_effect_list()
        body = self._parse_block()
        return ToolDeclaration(name=name, parameters=parameters, body=body, return_type=return_type, effects=effects)

    # ------------------------------------------------------------------
    # Structs and enums
    # ------------------------------------------------------------------

    def _parse_struct(self) -> StructDeclaration:
        self.tokens.expect("STRUCT")
        name = self.tokens.expect("IDENTIFIER").value
        type_params = self._parse_type_parameters()
        implements: List[SimpleType] = []
        if self.tokens.match("IMPLEMENTS"):
            implements = self._parse_implements_list()
        self.tokens.expect("LBRACE")
        members: List = []
        while not self.tokens.match("RBRACE"):
            if self._current_starts_decorator() or self.tokens.check("ASYNC") or self.tokens.check("FN"):
                decorators = self._parse_decorators()
                member = self._parse_function(decorators=decorators, is_method=True)
            else:
                member = self._parse_struct_field()
            members.append(member)
        return StructDeclaration(name=name, members=members, type_parameters=type_params, implements=implements)

    def _parse_implements_list(self) -> List[SimpleType]:
        items: List[SimpleType] = []
        while True:
            items.append(self._parse_nominal_type())
            if not self.tokens.match("COMMA"):
                break
        return items

    def _parse_struct_field(self) -> FieldDeclaration:
        mutable = bool(self.tokens.match("MUT"))
        self.tokens.match("LET")  # Allow optional `let` for readability
        name_tok = self.tokens.expect("IDENTIFIER")
        if not self._match_type_separator():
            token = self.tokens.current
            raise ParseError(
                f"Expected type annotation for field '{name_tok.value}' at line {token.lineno}, column {token.column}"
            )
        field_type = self._parse_type()
        self.tokens.expect("SEMICOLON")
        return FieldDeclaration(name=name_tok.value, type_annotation=field_type, mutable=mutable)

    def _parse_enum(self) -> EnumDeclaration:
        self.tokens.expect("ENUM")
        name = self.tokens.expect("IDENTIFIER").value
        self.tokens.expect("LBRACE")
        variants: List[EnumVariant] = []
        while not self.tokens.match("RBRACE"):
            variant_name = self.tokens.expect("IDENTIFIER").value
            fields: List[FieldDeclaration] = []
            if self.tokens.match("LBRACE"):
                while True:
                    if self.tokens.check("RBRACE"):
                        self.tokens.advance()
                        break
                    mutable = bool(self.tokens.match("MUT"))
                    field_name = self.tokens.expect("IDENTIFIER").value
                    if not self._match_type_separator():
                        token = self.tokens.current
                        raise ParseError(
                            f"Expected type annotation for enum field '{field_name}' at line {token.lineno}, column {token.column}"
                        )
                    field_type = self._parse_type()
                    fields.append(FieldDeclaration(field_name, field_type, mutable))
                    if self.tokens.match("COMMA") or self.tokens.match("SEMICOLON"):
                        continue
                    if self.tokens.check("RBRACE"):
                        continue
                    token = self.tokens.current
                    raise ParseError(
                        f"Expected ',' or '}}' after enum field at line {token.lineno}, column {token.column}"
                    )
            variants.append(EnumVariant(name=variant_name, fields=fields))
            self.tokens.match("COMMA")
        return EnumDeclaration(name=name, variants=variants)

    def _parse_interface(self) -> InterfaceDeclaration:
        self.tokens.expect("INTERFACE")
        name = self.tokens.expect("IDENTIFIER").value
        type_params = self._parse_type_parameters()
        self.tokens.expect("LBRACE")
        members: List[FunctionSignature] = []
        while not self.tokens.match("RBRACE"):
            if self.tokens.check("FN"):
                members.append(self._parse_function_signature())
            else:
                prop_name = self.tokens.expect("IDENTIFIER").value
                if not self._match_type_separator():
                    token = self.tokens.current
                    raise ParseError(
                        f"Expected type annotation for interface member '{prop_name}' at line {token.lineno}, column {token.column}"
                    )
                return_type = self._parse_type()
                self.tokens.expect("SEMICOLON")
                members.append(FunctionSignature(name=prop_name, parameters=[], return_type=return_type))
        return InterfaceDeclaration(name=name, members=members, type_parameters=type_params)

    # ------------------------------------------------------------------
    # Functions & methods
    # ------------------------------------------------------------------

    def _parse_decorators(self) -> List[Decorator]:
        decorators: List[Decorator] = []
        while self._current_starts_decorator():
            self.tokens.expect("AT")
            name = self._parse_qualified_name()
            arguments: List[Expression] = []
            if self.tokens.match("LPAREN"):
                if not self.tokens.check("RPAREN"):
                    while True:
                        arguments.append(self._parse_expression())
                        if not self.tokens.match("COMMA"):
                            break
                self.tokens.expect("RPAREN")
            decorators.append(Decorator(name=name, arguments=arguments))
        return decorators

    def _current_starts_decorator(self) -> bool:
        return self.tokens.check("AT")

    def _parse_type_parameters(self) -> List[TypeParameter]:
        if not self.tokens.match("LT"):
            return []
        params: List[TypeParameter] = []
        while True:
            name = self.tokens.expect("IDENTIFIER").value
            bound = None
            if self.tokens.match("COLON"):
                bound = self._parse_type()
            params.append(TypeParameter(name=name, bound=bound))
            if not self.tokens.match("COMMA"):
                break
        self.tokens.expect("GT")
        return params

    def _match_type_separator(self) -> bool:
        if self.tokens.match("ARROW"):
            return True
        if self.tokens.match("COLON"):
            return True
        return False

    def _parse_effect_list(self) -> List[str]:
        if not (self.tokens.check("NOT") and self.tokens.peek(1).type == "LBRACKET"):
            return []
        self.tokens.advance()  # '!'
        self.tokens.expect("LBRACKET")
        effects: List[str] = []
        if not self.tokens.check("RBRACKET"):
            while True:
                token = self.tokens.current
                if token.type == "IDENTIFIER" or token.type in {"MODEL"}:
                    effect_name = token.value
                    self.tokens.advance()
                else:
                    raise ParseError(
                        f"Expected effect identifier, found {token.type} at line {token.lineno}, column {token.column}"
                    )
                effects.append(effect_name)
                if not self.tokens.match("COMMA"):
                    break
        self.tokens.expect("RBRACKET")
        return effects

    def _parse_function(self, *, decorators: Optional[List[Decorator]] = None, is_method: bool = False) -> Statement:
        decorators = decorators or []
        is_async = bool(self.tokens.match("ASYNC"))
        self.tokens.expect("FN")
        name = self.tokens.expect("IDENTIFIER").value
        type_parameters = self._parse_type_parameters()
        parameters = self._parse_parameter_list()
        return_type: Optional[TypeAnnotation] = None
        if self.tokens.match("ARROW"):
            return_type = self._parse_type()
        effects = self._parse_effect_list()
        body = self._parse_block()
        if is_method:
            return MethodDeclaration(
                name=name,
                parameters=parameters,
                body=body,
                return_type=return_type,
                decorators=decorators,
                type_parameters=type_parameters,
                is_async=is_async,
                effects=effects,
            )
        return FunctionDeclaration(
            name=name,
            parameters=parameters,
            body=body,
            return_type=return_type,
            decorators=decorators,
            type_parameters=type_parameters,
            is_async=is_async,
            effects=effects,
        )

    def _parse_parameter_list(self) -> List[Parameter]:
        self.tokens.expect("LPAREN")
        params: List[Parameter] = []
        if not self.tokens.check("RPAREN"):
            while True:
                params.append(self._parse_parameter())
                if not self.tokens.match("COMMA"):
                    break
        self.tokens.expect("RPAREN")
        return params

    def _parse_parameter(self) -> Parameter:
        mutable = bool(self.tokens.match("MUT"))
        name_tok = self.tokens.expect("IDENTIFIER")
        type_annotation: Optional[TypeAnnotation] = None
        default: Optional[Expression] = None
        if self._match_type_separator():
            type_annotation = self._parse_type()
        if self.tokens.match("ASSIGN"):
            default = self._parse_expression()
        return Parameter(name=name_tok.value, type_annotation=type_annotation, default=default, mutable=mutable)

    def _parse_function_signature(self) -> FunctionSignature:
        self.tokens.expect("FN")
        name = self.tokens.expect("IDENTIFIER").value
        parameters = self._parse_parameter_list()
        return_type: Optional[TypeAnnotation] = None
        if self.tokens.match("ARROW"):
            return_type = self._parse_type()
        effects = self._parse_effect_list()
        self.tokens.expect("SEMICOLON")
        return FunctionSignature(name=name, parameters=parameters, return_type=return_type, effects=effects)

    def _parse_lambda_expression(self) -> LambdaExpression:
        self.tokens.expect("FN")
        parameters = self._parse_parameter_list()
        return_type: Optional[TypeAnnotation] = None
        if self.tokens.match("ARROW"):
            return_type = self._parse_type()
        body = self._parse_block()
        return LambdaExpression(parameters=parameters, body=body, return_type=return_type)

    def _parse_test(self) -> TestDeclaration:
        self.tokens.expect("TEST")
        if self.tokens.match("STRING"):
            name = self.tokens.previous.value
        else:
            name = self.tokens.expect("IDENTIFIER").value
        effects = self._parse_effect_list()
        body = self._parse_block()
        return TestDeclaration(name=name, body=body, effects=effects)

    # ------------------------------------------------------------------
    # Statements
    # ------------------------------------------------------------------

    def _parse_block(self) -> Block:
        self.tokens.expect("LBRACE")
        statements: List[Statement] = []
        while not self.tokens.match("RBRACE"):
            if self.tokens.match("SEMICOLON"):
                continue
            statements.append(self._parse_statement())
        return Block(statements)

    def _parse_statement(self) -> Statement:
        if self.tokens.check("LET"):
            return self._parse_variable_declaration()
        if self.tokens.check("RETURN"):
            return self._parse_return()
        if self.tokens.check("IF"):
            return self._parse_if()
        if self.tokens.check("MATCH"):
            return self._parse_match_statement()
        if self.tokens.check("FOR"):
            return self._parse_for()
        if self.tokens.check("LOOP"):
            return self._parse_loop()
        if self.tokens.check("ROUTINE"):
            return self._parse_routine()
        if self.tokens.check("TRY"):
            return self._parse_try()
        if self.tokens.check("THROW"):
            return self._parse_throw()
        if self.tokens.check("ASSERT"):
            return self._parse_assert()
        if self.tokens.check("PROMPT"):
            return self._parse_prompt_statement()
        if self.tokens.check("WITH"):
            return self._parse_with_statement()
        if self.tokens.check("LBRACE"):
            return self._parse_block()
        # Fallback: expression or assignment
        expr = self._parse_expression()
        operator_token = self.tokens.match("ASSIGN", "PLUS_ASSIGN", "MINUS_ASSIGN", "MULTIPLY_ASSIGN", "DIVIDE_ASSIGN")
        if operator_token:
            value = self._parse_expression()
            self.tokens.expect("SEMICOLON")
            operator = operator_token.value or operator_token.type.lower()
            return Assignment(target=expr, value=value, operator=operator)
        self.tokens.expect("SEMICOLON")
        return ExpressionStatement(expr)

    def _parse_assert(self) -> AssertStatement:
        self.tokens.expect("ASSERT")
        expression = self._parse_expression()
        self.tokens.expect("SEMICOLON")
        return AssertStatement(expression=expression)

    def _parse_prompt_statement(self) -> PromptStatement:
        self.tokens.expect("PROMPT")
        channel_token = self.tokens.expect("IDENTIFIER")
        channel = channel_token.value
        body = self._parse_block()
        return PromptStatement(channel=channel, body=body)

    def _parse_with_statement(self) -> WithStatement:
        self.tokens.expect("WITH")
        clauses: List[Expression] = []
        while True:
            clauses.append(self._parse_expression())
            if not self.tokens.match("COMMA"):
                break
        body = self._parse_block()
        return WithStatement(clauses=clauses, body=body)

    def _parse_variable_declaration(self) -> VariableDeclaration:
        self.tokens.expect("LET")
        mutable = bool(self.tokens.match("MUT"))
        name = self.tokens.expect("IDENTIFIER").value
        type_annotation = None
        if self._match_type_separator():
            type_annotation = self._parse_type()
        initializer = None
        if self.tokens.match("ASSIGN"):
            initializer = self._parse_expression()
        self.tokens.expect("SEMICOLON")
        return VariableDeclaration(name=name, initializer=initializer, type_annotation=type_annotation, mutable=mutable)

    def _parse_return(self) -> Statement:
        self.tokens.expect("RETURN")
        if self.tokens.match("SEMICOLON"):
            return ReturnStatement(value=None)
        value = self._parse_expression()
        self.tokens.expect("SEMICOLON")
        return ReturnStatement(value=value)

    def _parse_if(self) -> IfStatement:
        self.tokens.expect("IF")
        condition = self._parse_optional_parenthesised_expression()
        then_block = self._parse_block()
        else_branch = None
        if self.tokens.match("ELSE"):
            if self.tokens.check("IF"):
                else_branch = self._parse_if()
            else:
                else_branch = self._parse_block()
        return IfStatement(condition=condition, then_block=then_block, else_branch=else_branch)

    def _parse_match_statement(self) -> MatchStatement:
        self.tokens.expect("MATCH")
        value = self._parse_expression()
        self.tokens.expect("LBRACE")
        cases: List[MatchCase] = []
        while not self.tokens.match("RBRACE"):
            case = self._parse_match_case()
            cases.append(case)
            self.tokens.match("COMMA")
        return MatchStatement(value=value, cases=cases)

    def _parse_match_case(self) -> MatchCase:
        pattern = self._parse_pattern()
        guard = None
        if self.tokens.match("IF"):
            guard = self._parse_expression()
        if not self.tokens.match("ARROW") and not self.tokens.match("FAT_ARROW"):
            current = self.tokens.current
            raise ParseError(
                f"Expected '->' or '=>', found {current.type} at line {current.lineno}, column {current.column}"
            )
        if self.tokens.check("LBRACE"):
            body = self._parse_block()
        elif self.tokens.check("RETURN"):
            self.tokens.advance()
            if self.tokens.match("SEMICOLON"):
                value = None
            else:
                value = self._parse_expression()
                self.tokens.match("SEMICOLON")
            body = Block([ReturnStatement(value=value)])
        else:
            expr = self._parse_expression()
            self.tokens.match("SEMICOLON")
            body = Block([ExpressionStatement(expr)])
        return MatchCase(pattern=pattern, body=body, guard=guard)

    def _parse_for(self) -> ForStatement:
        self.tokens.expect("FOR")
        pattern = self._parse_pattern()
        self.tokens.expect("IN")
        iterable_expr = self._parse_expression()
        body = self._parse_block()
        return ForStatement(pattern=pattern, iterable=iterable_expr, body=body)

    def _parse_loop(self) -> LoopStatement:
        self.tokens.expect("LOOP")
        body = self._parse_block()
        return LoopStatement(body=body)

    def _parse_routine(self) -> RoutineDeclaration:
        self.tokens.expect("ROUTINE")
        name: Optional[str] = None
        if self.tokens.match("STRING"):
            name = self.tokens.previous.value
        elif self.tokens.check("IDENTIFIER") and self.tokens.peek(1).type != "LBRACE":
            name = self.tokens.advance().value
        body = self._parse_block()
        return RoutineDeclaration(body=body, name=name)

    def _parse_try(self) -> TryStatement:
        self.tokens.expect("TRY")
        try_block = self._parse_block()
        catch_clause: Optional[CatchClause] = None
        finally_block: Optional[Block] = None
        if self.tokens.match("CATCH"):
            identifier = None
            pattern = None
            if self.tokens.match("LPAREN"):
                identifier = self.tokens.expect("IDENTIFIER").value
                self.tokens.expect("RPAREN")
            catch_body = self._parse_block()
            catch_clause = CatchClause(identifier=identifier, pattern=pattern, body=catch_body)
        if self.tokens.match("FINALLY"):
            finally_block = self._parse_block()
        return TryStatement(try_block=try_block, catch=catch_clause, finally_block=finally_block)

    def _parse_throw(self) -> ThrowStatement:
        self.tokens.expect("THROW")
        expr = self._parse_expression()
        self.tokens.expect("SEMICOLON")
        return ThrowStatement(expression=expr)

    # ------------------------------------------------------------------
    # Patterns
    # ------------------------------------------------------------------

    def _parse_pattern(self) -> Pattern:
        if self.tokens.match("UNDERSCORE"):
            return WildcardPattern()
        if self.tokens.match("MINUS"):
            number_token = self.tokens.expect("NUMBER")
            value = number_token.value
            if isinstance(value, (int, float)):
                value = -value
            return LiteralPattern(NumberLiteral(value=value))
        if self.tokens.check("NUMBER"):
            value = self.tokens.advance().value
            return LiteralPattern(NumberLiteral(value=value))
        if self.tokens.check("STRING"):
            value = self.tokens.advance().value
            return LiteralPattern(StringLiteral(value=value))
        if self.tokens.check("IDENTIFIER"):
            ident = self.tokens.advance().value
            parts = [ident]
            while self.tokens.match("DOT"):
                parts.append(self.tokens.expect("IDENTIFIER").value)
            type_name = QualifiedName(parts)
            if self.tokens.match("LBRACE"):
                fields: List[PatternField] = []
                while not self.tokens.match("RBRACE"):
                    field_name = self.tokens.expect("IDENTIFIER").value
                    field_pattern = None
                    if self.tokens.match("COLON"):
                        field_pattern = self._parse_pattern()
                    fields.append(PatternField(name=field_name, pattern=field_pattern))
                    self.tokens.match("COMMA")
                return ConstructorPattern(type_name=type_name, fields=fields)
            if len(parts) > 1:
                return ConstructorPattern(type_name=type_name, fields=[])
            return IdentifierPattern(name=ident)
        token = self.tokens.current
        raise ParseError(f"Unexpected token {token.type} in pattern at line {token.lineno}, column {token.column}")

    # ------------------------------------------------------------------
    # Types
    # ------------------------------------------------------------------

    def _parse_type(self) -> TypeAnnotation:
        annotation = self._parse_intersection_type()
        while self.tokens.match("PIPE"):
            right = self._parse_intersection_type()
            if isinstance(annotation, UnionType):
                annotation.options.append(right)
            else:
                annotation = UnionType(options=[annotation, right])
        return annotation

    def _parse_intersection_type(self) -> TypeAnnotation:
        annotation = self._parse_postfix_type()
        components: List[TypeAnnotation] = []
        while self.tokens.match("AMPERSAND"):
            if not components:
                components.append(annotation)
            components.append(self._parse_postfix_type())
        if components:
            return IntersectionType(components=components)
        return annotation

    def _parse_postfix_type(self) -> TypeAnnotation:
        annotation = self._parse_primary_type()
        while True:
            if self.tokens.match("LBRACKET"):
                self.tokens.expect("RBRACKET")
                annotation = ArrayType(element_type=annotation)
                continue
            if self.tokens.match("QUESTION_MARK"):
                annotation = OptionalType(base=annotation)
                continue
            break
        return annotation

    def _parse_primary_type(self) -> TypeAnnotation:
        if self.tokens.match("FN"):
            self.tokens.expect("LPAREN")
            parameters: List[TypeAnnotation] = []
            if not self.tokens.check("RPAREN"):
                while True:
                    parameters.append(self._parse_type())
                    if not self.tokens.match("COMMA"):
                        break
            self.tokens.expect("RPAREN")
            self.tokens.expect("ARROW")
            return_type = self._parse_type()
            return FunctionType(parameters=parameters, return_type=return_type)
        if self.tokens.match("LPAREN"):
            elements: List[TypeAnnotation] = []
            if not self.tokens.check("RPAREN"):
                while True:
                    elements.append(self._parse_type())
                    if not self.tokens.match("COMMA"):
                        break
            self.tokens.expect("RPAREN")
            if self.tokens.match("ARROW"):
                return_type = self._parse_type()
                return FunctionType(parameters=elements, return_type=return_type)
            if len(elements) == 1:
                return elements[0]
            return TupleType(elements=elements)
        if self.tokens.match("NULL"):
            return SimpleType(name=QualifiedName(["null"]))
        name = self._parse_qualified_name()
        type_arguments: List[TypeAnnotation] = []
        if self.tokens.match("LT"):
            type_arguments = self._parse_type_arguments()
        return SimpleType(name=name, type_arguments=type_arguments)

    def _parse_type_arguments(self) -> List[TypeAnnotation]:
        arguments: List[TypeAnnotation] = []
        if self.tokens.check("GT"):
            self.tokens.advance()
            return arguments
        while True:
            arguments.append(self._parse_type())
            if not self.tokens.match("COMMA"):
                break
        self.tokens.expect("GT")
        return arguments

    def _parse_nominal_type(self) -> SimpleType:
        name = self._parse_qualified_name()
        type_arguments: List[TypeAnnotation] = []
        if self.tokens.match("LT"):
            type_arguments = self._parse_type_arguments()
        return SimpleType(name=name, type_arguments=type_arguments)

    def _parse_qualified_name(self) -> QualifiedName:
        parts = [self.tokens.expect("IDENTIFIER").value]
        while self.tokens.match("DOT"):
            parts.append(self.tokens.expect("IDENTIFIER").value)
        return QualifiedName(parts)

    # ------------------------------------------------------------------
    # Expressions
    # ------------------------------------------------------------------

    def _parse_optional_parenthesised_expression(self) -> Expression:
        if self.tokens.match("LPAREN"):
            expr = self._parse_expression()
            self.tokens.expect("RPAREN")
            return expr
        return self._parse_expression()

    def _parse_expression(self) -> Expression:
        if self.tokens.check("FN"):
            return self._parse_lambda_expression()
        return self._parse_range_expression()

    def _parse_range_expression(self) -> Expression:
        expr = self._parse_logical_or()
        while self.tokens.match("RANGE"):
            end = self._parse_logical_or()
            expr = RangeExpression(start=expr, end=end)
        return expr

    def _parse_logical_or(self) -> Expression:
        expr = self._parse_logical_and()
        while self.tokens.match("OR"):
            right = self._parse_logical_and()
            expr = BinaryExpression(operator="||", left=expr, right=right)
        return expr

    def _parse_logical_and(self) -> Expression:
        expr = self._parse_equality()
        while self.tokens.match("AND"):
            right = self._parse_equality()
            expr = BinaryExpression(operator="&&", left=expr, right=right)
        return expr

    def _parse_equality(self) -> Expression:
        expr = self._parse_comparison()
        while True:
            if self.tokens.match("EQ"):
                right = self._parse_comparison()
                expr = BinaryExpression(operator="==", left=expr, right=right)
            elif self.tokens.match("NEQ"):
                right = self._parse_comparison()
                expr = BinaryExpression(operator="!=", left=expr, right=right)
            elif self.tokens.match("IS"):
                type_annotation = self._parse_type()
                expr = TypeCheckExpression(value=expr, type_annotation=type_annotation)
            else:
                break
        return expr

    def _parse_comparison(self) -> Expression:
        expr = self._parse_term()
        while True:
            if self.tokens.match("LT"):
                right = self._parse_term()
                expr = BinaryExpression(operator="<", left=expr, right=right)
            elif self.tokens.match("LEQ"):
                right = self._parse_term()
                expr = BinaryExpression(operator="<=", left=expr, right=right)
            elif self.tokens.match("GT"):
                right = self._parse_term()
                expr = BinaryExpression(operator=">", left=expr, right=right)
            elif self.tokens.match("GEQ"):
                right = self._parse_term()
                expr = BinaryExpression(operator=">=", left=expr, right=right)
            else:
                break
        return expr

    def _parse_term(self) -> Expression:
        expr = self._parse_factor()
        while True:
            if self.tokens.match("PLUS"):
                right = self._parse_factor()
                expr = BinaryExpression(operator="+", left=expr, right=right)
            elif self.tokens.match("MINUS"):
                right = self._parse_factor()
                expr = BinaryExpression(operator="-", left=expr, right=right)
            else:
                break
        return expr

    def _parse_factor(self) -> Expression:
        expr = self._parse_unary()
        while True:
            if self.tokens.match("MULTIPLY"):
                right = self._parse_unary()
                expr = BinaryExpression(operator="*", left=expr, right=right)
            elif self.tokens.match("DIVIDE"):
                right = self._parse_unary()
                expr = BinaryExpression(operator="/", left=expr, right=right)
            else:
                break
        return expr

    def _parse_unary(self) -> Expression:
        if self.tokens.match("MINUS"):
            operand = self._parse_unary()
            return UnaryExpression(operator="-", operand=operand)
        if self.tokens.match("PLUS"):
            return self._parse_unary()
        if self.tokens.match("NOT"):
            operand = self._parse_unary()
            return UnaryExpression(operator="!", operand=operand)
        if self.tokens.match("AWAIT"):
            expression = self._parse_unary()
            return AwaitExpression(expression=expression)
        return self._parse_call()

    def _parse_call(self) -> Expression:
        expr = self._parse_primary()
        while True:
            if self.tokens.match("LPAREN"):
                arguments: List[Expression] = []
                if not self.tokens.check("RPAREN"):
                    while True:
                        arguments.append(self._parse_expression())
                        if not self.tokens.match("COMMA"):
                            break
                self.tokens.expect("RPAREN")
                expr = CallExpression(callee=expr, arguments=arguments)
            elif self.tokens.match("DOT"):
                member_token = self.tokens.match("IDENTIFIER", "INFO", "PRINT")
                if member_token is None:
                    current = self.tokens.current
                    raise ParseError(
                        f"Expected identifier after '.', found {current.type} at line {current.lineno}, column {current.column}"
                    )
                member = member_token.value
                expr = MemberExpression(object=expr, member=member)
            elif isinstance(expr, Identifier) and self.tokens.check("LT") and self._looks_like_type_arguments():
                self.tokens.advance()  # consume '<'
                expr.type_arguments = self._parse_type_arguments()
                continue
            elif isinstance(expr, Identifier) and expr.name == "parallel" and self.tokens.check("LBRACKET"):
                thunks = self._parse_parallel_thunks()
                expr = ParallelExpression(thunks=thunks)
            elif self.tokens.match("LBRACKET"):
                index = self._parse_expression()
                self.tokens.expect("RBRACKET")
                expr = IndexExpression(sequence=expr, index=index)
            elif isinstance(expr, Identifier) and self.tokens.check("LBRACE") and self._looks_like_struct_literal():
                self.tokens.advance()  # Consume '{'
                fields = self._parse_struct_literal_fields()
                expr = StructLiteral(
                    type_name=QualifiedName([expr.name]),
                    fields=fields,
                    type_arguments=expr.type_arguments,
                )
            elif isinstance(expr, MemberExpression) and self.tokens.check("LBRACE") and self._looks_like_struct_literal():
                self.tokens.advance()
                fields = self._parse_struct_literal_fields()
                qualified = self._qualified_name_from_member(expr)
                expr = StructLiteral(type_name=qualified, fields=fields, type_arguments=[])
            else:
                break
        return expr

    def _looks_like_struct_literal(self) -> bool:
        first = self.tokens.peek(1)
        if first.type == "RBRACE":
            return True
        if first.type != "IDENTIFIER":
            return False
        second = self.tokens.peek(2)
        return second.type == "COLON"

    def _qualified_name_from_member(self, expr: MemberExpression) -> QualifiedName:
        parts: List[str] = []
        current: Expression = expr
        while isinstance(current, MemberExpression):
            parts.append(current.member)
            current = current.object
        if isinstance(current, Identifier):
            parts.append(current.name)
        else:
            token = self.tokens.current
            raise ParseError(
                f"Unsupported struct literal target at line {token.lineno}, column {token.column}"
            )
        parts.reverse()
        return QualifiedName(parts)

    def _looks_like_type_arguments(self) -> bool:
        depth = 0
        index = 0
        while True:
            token = self.tokens.peek(index)
            if token.type == "EOF":
                return False
            if token.type == "LT":
                depth += 1
            elif token.type == "GT":
                depth -= 1
                if depth == 0:
                    next_token = self.tokens.peek(index + 1)
                    return next_token.type in {
                        "LBRACE",
                        "LPAREN",
                        "DOT",
                        "SEMICOLON",
                        "COMMA",
                        "RPAREN",
                        "RBRACKET",
                        "ARROW",
                        "ASSIGN",
                        "PLUS_ASSIGN",
                        "MINUS_ASSIGN",
                        "MULTIPLY_ASSIGN",
                        "DIVIDE_ASSIGN",
                    }
            elif depth == 0 and token.type in {"SEMICOLON", "COMMA", "RPAREN", "RBRACE"}:
                return False
            elif depth > 0 and token.type in {"PLUS", "MINUS", "MULTIPLY", "DIVIDE", "EQ", "NEQ", "LEQ", "GEQ"}:
                return False
            index += 1

    def _parse_parallel_thunks(self) -> List[Expression]:
        self.tokens.expect("LBRACKET")
        thunks: List[Expression] = []
        if not self.tokens.check("RBRACKET"):
            while True:
                thunks.append(self._parse_expression())
                if self.tokens.match("COMMA"):
                    if self.tokens.check("RBRACKET"):
                        break
                    continue
                break
        self.tokens.expect("RBRACKET")
        return thunks

    def _parse_struct_literal_fields(self) -> List[ObjectField]:
        fields: List[ObjectField] = []
        while not self.tokens.match("RBRACE"):
            name = self.tokens.expect("IDENTIFIER").value
            self.tokens.expect("COLON")
            value = self._parse_expression()
            fields.append(ObjectField(name=name, value=value))
            self.tokens.match("COMMA")
        return fields

    def _parse_primary(self) -> Expression:
        if self.tokens.match("NUMBER"):
            return NumberLiteral(value=self.tokens.previous.value)
        if self.tokens.match("STRING"):
            return StringLiteral(value=self.tokens.previous.value)
        if self.tokens.match("TRUE"):
            return BooleanLiteral(value=True)
        if self.tokens.match("FALSE"):
            return BooleanLiteral(value=False)
        if self.tokens.match("NULL"):
            return NullLiteral()
        if self.tokens.match("PRINT"):
            return Identifier(name="print")
        if self.tokens.match("INFO"):
            return Identifier(name="info")
        if self.tokens.match("IDENTIFIER"):
            name = self.tokens.previous.value
            return Identifier(name=name)
        if self.tokens.match("LPAREN"):
            expr = self._parse_expression()
            self.tokens.expect("RPAREN")
            return expr
        if self.tokens.match("LBRACKET"):
            elements: List[Expression] = []
            if not self.tokens.check("RBRACKET"):
                while True:
                    elements.append(self._parse_expression())
                    if not self.tokens.match("COMMA"):
                        break
            self.tokens.expect("RBRACKET")
            return ArrayLiteral(elements=elements)
        if self.tokens.match("LBRACE"):
            fields: List[ObjectField] = []
            if not self.tokens.check("RBRACE"):
                while True:
                    key = self.tokens.expect("IDENTIFIER").value
                    self.tokens.expect("COLON")
                    value = self._parse_expression()
                    fields.append(ObjectField(name=key, value=value))
                    if self.tokens.match("COMMA"):
                        if self.tokens.check("RBRACE"):
                            break
                        continue
                    break
            self.tokens.expect("RBRACE")
            return ObjectLiteral(fields=fields)
        token = self.tokens.current
        raise ParseError(f"Unexpected token {token.type} at line {token.lineno}, column {token.column}")


class Parser:
    """Public parser facade mimicking the legacy PLY API."""

    def parse(self, source: str, lexer=None) -> Program:
        from bootstrap.lexer import lexer as default_lexer  # Local import to avoid cycles

        if lexer is None:
            active_lexer = default_lexer.clone()
        elif hasattr(lexer, "clone"):
            active_lexer = lexer.clone()
        else:
            active_lexer = lexer
        tokens = _tokenize(source, active_lexer)
        stream = _TokenStream(tokens)
        parser_impl = _SailParser(stream)
        program = parser_impl.parse_program()
        stream.expect("EOF")
        return program


parser = Parser()


__all__ = ["parser", "Parser", "ParseError"]
