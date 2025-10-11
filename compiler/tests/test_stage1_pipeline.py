from __future__ import annotations

import importlib

import pytest

HELLO_WORLD_SOURCE = """
fn main() ![io] {
  print.info("Hello, Sailfin!");
}
"""

DUPLICATE_FUNCTION_SOURCE = """
fn main() ![io] {
  print.info("one");
}

fn main() ![io] {
  print.info("two");
}
"""


@pytest.mark.usefixtures("stage1_environment")
def test_compile_to_native_python_produces_source() -> None:
    stage1_main = importlib.import_module("compiler.build.main")
    result = stage1_main.compile_to_native_python(HELLO_WORLD_SOURCE)
    assert result.source.strip(), "Stage1 native lowering returned an empty body"
    unexpected = [
        message for message in result.diagnostics if "unsupported statement" not in message
    ]
    assert not unexpected, "Stage1 native lowering surfaced unexpected diagnostics"


@pytest.mark.usefixtures("stage1_environment")
def test_typechecker_reports_duplicate_functions() -> None:
    parser_module = importlib.import_module("compiler.build.parser")
    typecheck_module = importlib.import_module("compiler.build.typecheck")

    parse_program = getattr(parser_module, "parse_program")
    typecheck_program = getattr(typecheck_module, "typecheck_program")

    program = parse_program(DUPLICATE_FUNCTION_SOURCE)
    result = typecheck_program(program)

    messages = [diagnostic.message for diagnostic in result.diagnostics]
    assert messages, "Stage1 typechecker returned no diagnostics for duplicate functions"
    assert any("duplicate function `main`" in message for message in messages), (
        "Stage1 typechecker did not surface duplicate function diagnostics"
    )
