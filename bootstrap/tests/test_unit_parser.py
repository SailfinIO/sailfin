from __future__ import annotations

from bootstrap.lexer import lexer as base_lexer
from bootstrap.parser import parser, ParseError
from ast_nodes import Program, FunctionDeclaration, VariableDeclaration, ReturnStatement
import pytest


def parse(src: str):
    return parser.parse(src, lexer=base_lexer.clone())


def test_parse_simple_function():
    ast = parse("fn add(a: number, b: number) -> number { return a + b; }")
    assert isinstance(ast, Program)
    fn = ast.statements[0]
    assert isinstance(fn, FunctionDeclaration)
    assert fn.name == "add"
    assert fn.return_type is not None


def test_variable_declaration_and_return():
    ast = parse("fn main() { let x: number = 1; return x; }")
    fn = ast.statements[0]
    assert isinstance(fn.body.statements[0], VariableDeclaration)
    assert isinstance(fn.body.statements[-1], ReturnStatement)


def test_parse_error_position():
    with pytest.raises(ParseError) as ei:
        parse("fn oops( { return 1; }")
    msg = str(ei.value)
    # Should include the word 'Expected' and a line/column reference
    assert "Expected" in msg and "line" in msg and "column" in msg
