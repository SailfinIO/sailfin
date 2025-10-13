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

MODULE_REEXPORT_SOURCE = """
import { substring as slice, find_char } from "./string_utils";
export { substring, find_char as locate } from "./string_utils";

fn main() ![io] {
  let prefix = slice("sailfin", 0, 4);
  print.info(prefix);
}
"""

STRUCT_METHOD_SOURCE = """
struct Pair {
  left -> number;
  right -> number;

  fn sum(self -> Pair) -> number {
    return self.left + self.right;
  }
}

fn main() ![io] {
  let pair = Pair { left: 1, right: 2 };
  print.info(pair.sum());
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


@pytest.mark.usefixtures("stage1_environment")
def test_import_export_alias_round_trip() -> None:
  stage1_main = importlib.import_module("compiler.build.main")

  result = stage1_main.compile_to_native_python(MODULE_REEXPORT_SOURCE)
  assert not result.diagnostics, f"unexpected diagnostics: {result.diagnostics}"

  python_source = result.source
  assert "from compiler.build.string_utils import substring as slice" in python_source
  assert "from compiler.build.string_utils import substring, find_char as locate" in python_source

  namespace: dict[str, object] = {"__builtins__": __builtins__}
  exec(python_source, namespace)

  exports = namespace.get("__all__")
  assert isinstance(exports, list), "__all__ missing from lowered module"
  assert set(exports) == {"substring", "locate"}

  slice_fn = namespace.get("slice")
  locate_fn = namespace.get("locate")
  assert callable(slice_fn)
  assert callable(locate_fn)
  assert slice_fn("sailfin", 0, 4) == "sail"
  assert locate_fn("sailfin", "f", 0) == 4


@pytest.mark.usefixtures("stage1_environment")
def test_struct_method_lowering() -> None:
    stage1_main = importlib.import_module("compiler.build.main")

    result = stage1_main.compile_to_native_python(STRUCT_METHOD_SOURCE)
    assert not result.diagnostics, f"unexpected diagnostics: {result.diagnostics}"

    python_source = result.source
    assert "class Pair" in python_source
    assert "def sum(self" in python_source

    namespace: dict[str, object] = {"__builtins__": __builtins__}
    exec(python_source, namespace)

    pair_class = namespace.get("Pair")
    assert callable(pair_class), "Pair class missing from lowered module"

    pair_instance = pair_class(1, 2)
    assert hasattr(pair_instance, "sum"), "sum method missing on struct facade"
    assert pair_instance.sum() == 3
