from __future__ import annotations

import importlib
from typing import Iterable

import pytest

DUPLICATE_CASES = (
    (
        "struct fields",
        """
struct User {
    name -> string;
    name -> string;
}
        """,
        "duplicate struct field `name`",
    ),
    (
        "struct methods",
        """
struct Worker {
    fn run() -> void {}
    fn run() -> void {}
}
        """,
        "duplicate method `run`",
    ),
    (
        "enum variants",
        """
enum Color {
    Red;
    Red;
}
        """,
        "duplicate enum variant `Red`",
    ),
    (
        "interface members",
        """
interface Handler {
    fn handle();
    fn handle();
}
        """,
        "duplicate interface member `handle`",
    ),
    (
        "model properties",
        """
model Document : Model<Text, Summary> {
    schema = Summary;
    schema = Summary;
}
        """,
        "duplicate model property `schema`",
    ),
    (
        "function type parameters",
        """
fn identity<T, T>(value -> T) -> T {
    return value;
}
        """,
        "duplicate type parameter `T`",
    ),
    (
        "struct type parameters",
        """
struct Box<T, T> {
    value -> T;
}
        """,
        "duplicate type parameter `T`",
    ),
)


@pytest.mark.usefixtures("stage1_environment")
@pytest.mark.parametrize("_label", [case[0] for case in DUPLICATE_CASES])
def test_typechecker_reports_duplicate_symbols(_label: str) -> None:
    # Collect sources lazily to keep parametrization skimmable.
    source, expected = _select_case(_label)

    parser_module = importlib.import_module("compiler.build.parser")
    typecheck_module = importlib.import_module("compiler.build.typecheck")

    parse_program = getattr(parser_module, "parse_program")
    typecheck_program = getattr(typecheck_module, "typecheck_program")

    program = parse_program(source)
    result = typecheck_program(program)

    messages = [diagnostic.message for diagnostic in result.diagnostics]
    assert messages, f"typechecker emitted no diagnostics for {_label} case"
    assert _contains_expected(messages, expected), (
        f"typechecker did not report expected diagnostic for {_label} case; "
        f"expected substring: {expected!r}, messages: {messages}"
    )


def _select_case(label: str) -> tuple[str, str]:
    for case in DUPLICATE_CASES:
        if case[0] == label:
            return case[1], case[2]
    raise KeyError(f"missing duplicate case fixture for label: {label}")


def _contains_expected(messages: Iterable[str], expected: str) -> bool:
    return any(expected in message for message in messages)
