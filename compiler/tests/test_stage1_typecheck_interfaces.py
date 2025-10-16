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


@pytest.mark.usefixtures("stage1_environment")
def test_struct_missing_type_arguments_for_generic_interface_reports_diagnostic() -> None:
    source = """
interface Formatter<T> {
    fn format(self) -> T;
}

struct Document implements Formatter {
    title -> string;

    fn format(self -> Document) -> string {
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
        "implements Formatter but must specify Formatter<T> type arguments" in message
        for message in messages
    ), f"missing generic interface arguments diagnostic not reported: {messages}"


@pytest.mark.usefixtures("stage1_environment")
def test_struct_mismatched_type_argument_count_reports_diagnostic() -> None:
    source = """
interface Formatter<T> {
    fn format(self) -> T;
}

struct Printer implements Formatter<string, number> {
    fn format(self -> Printer) -> string {
        return "ready";
    }
}
"""

    parser_module = importlib.import_module("compiler.build.parser")
    typecheck_module = importlib.import_module("compiler.build.typecheck")

    program = getattr(parser_module, "parse_program")(source)
    result = getattr(typecheck_module, "typecheck_program")(program)

    messages = [diagnostic.message for diagnostic in result.diagnostics]
    assert any(
        "implements Formatter<string, number> but must match Formatter<T> type arguments" in message
        for message in messages
    ), f"mismatched generic argument diagnostic not reported: {messages}"
