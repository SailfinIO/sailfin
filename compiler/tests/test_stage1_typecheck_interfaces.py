from __future__ import annotations

# pyright: reportMissingImports=false

import importlib

import pytest


@pytest.mark.usefixtures("stage1_environment")
def test_struct_missing_interface_member_reports_diagnostic() -> None:
    source = """
interface Greeter {
    fn greet(self) -> string;
}

struct Person implements Greeter {
    fn wave(self -> Person) -> string {
        return "hi";
    }
}
"""

    parser_module = importlib.import_module("compiler.build.parser")
    typecheck_module = importlib.import_module("compiler.build.typecheck")

    program = getattr(parser_module, "parse_program")(source)
    result = getattr(typecheck_module, "typecheck_program")(program)

    messages = [diagnostic.message for diagnostic in result.diagnostics]
    assert any(
        "struct Person implements Greeter but is missing member `greet`" in message
        for message in messages
    ), f"missing interface member diagnostic not reported: {messages}"


@pytest.mark.usefixtures("stage1_environment")
def test_struct_missing_generic_interface_member_reports_diagnostic() -> None:
    source = """
interface Formatter<T> {
    fn format(self) -> T;
}

struct Document implements Formatter<string> {
    title -> string;

    fn rename(self -> Document) -> string {
        return self.title;
    }
}
"""

    parser_module = importlib.import_module("compiler.build.parser")
    typecheck_module = importlib.import_module("compiler.build.typecheck")

    program = getattr(parser_module, "parse_program")(source)
    result = getattr(typecheck_module, "typecheck_program")(program)

    messages = [diagnostic.message for diagnostic in result.diagnostics]
    assert any(
        "struct Document implements Formatter but is missing member `format`" in message
        for message in messages
    ), f"generic interface diagnostic missing: {messages}"


@pytest.mark.usefixtures("stage1_environment")
def test_struct_implements_interface_without_diagnostics() -> None:
    source = """
interface Greeter {
    fn greet(self) -> string;
}

struct Person implements Greeter {
    fn greet(self -> Person) -> string {
        return "hello";
    }
}
"""

    parser_module = importlib.import_module("compiler.build.parser")
    typecheck_module = importlib.import_module("compiler.build.typecheck")

    program = getattr(parser_module, "parse_program")(source)
    result = getattr(typecheck_module, "typecheck_program")(program)

    messages = [diagnostic.message for diagnostic in result.diagnostics]
    assert (
        not messages
    ), f"expected no diagnostics when struct satisfies interface, saw: {messages}"
