from __future__ import annotations

import importlib

import pytest

pytestmark = pytest.mark.unit

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

ARRAY_METADATA_SOURCE = """
fn make_numbers() -> number[] {
  return [1, 2, 3];
}

fn make_booleans() -> boolean[] {
  return [true, false];
}
"""

LAYOUT_DESCRIPTOR_SOURCE = """
struct Person {
  name -> string;
  age -> int;
}

enum Shape {
  Circle { radius -> number; }
  Unit;
}

fn main() -> number {
  return 0;
}
"""

INTERFACE_METADATA_SOURCE = """
interface Greeter {
  fn greet(self) -> string;
}

interface Formatter {
  fn format(self) -> string;
}

struct FriendlyUser implements Greeter, Formatter {
  name -> string;

  fn greet(self -> FriendlyUser) -> string {
    return "Hello, {{self.name}}!";
  }

  fn format(self -> FriendlyUser) -> string {
    return self.name;
  }
}

fn main() -> string {
  let value = FriendlyUser { name: "Ada" };
  return value.format();
}
"""

PARAMETER_SPAN_SOURCE = (
    "fn annotate(value -> number, mut scale -> number = 1) -> number {\n"
    "  return value * scale;\n"
    "}\n"
)


@pytest.mark.usefixtures("stage1_environment")
def test_compile_to_native_python_produces_source() -> None:
    stage1_main = importlib.import_module("compiler.build.main")
    result = stage1_main.compile_to_native_python(HELLO_WORLD_SOURCE)
    assert result.source.strip(), "Stage1 native lowering returned an empty body"
    unexpected = [
        message
        for message in result.diagnostics
        if "unsupported statement" not in message
        and "defaulting to pointer layout" not in message
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

    matching = [
        diagnostic for diagnostic in result.diagnostics if "duplicate function `main`" in diagnostic.message]
    assert any(diagnostic.primary is not None for diagnostic in matching), (
        "duplicate function diagnostic did not include a primary token"
    )


@pytest.mark.usefixtures("stage1_environment")
def test_import_export_alias_round_trip() -> None:
    stage1_main = importlib.import_module("compiler.build.main")

    result = stage1_main.compile_to_native_python(MODULE_REEXPORT_SOURCE)
    unexpected = [
        diag for diag in result.diagnostics if "defaulting to pointer layout" not in diag]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

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
    unexpected = [
        diag for diag in result.diagnostics if "defaulting to pointer layout" not in diag]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

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


@pytest.mark.usefixtures("stage1_environment")
def test_native_backend_tags_array_literals_with_metadata() -> None:
    stage1_main = importlib.import_module("compiler.build.main")

    result = stage1_main.compile_to_native(ARRAY_METADATA_SOURCE)
    unexpected = [
        diag for diag in result.diagnostics if "defaulting to pointer layout" not in diag]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    artifact = next(
        (artifact for artifact in result.module.artifacts if artifact.name == "module.sfn-asm"), None)
    assert artifact is not None, "native artifact missing from emit_native output"

    contents = artifact.contents
    assert "[#element:number, 1, 2, 3]" in contents
    assert "[#element:boolean, true, false]" in contents


@pytest.mark.usefixtures("stage1_environment")
def test_native_backend_emits_layout_descriptors() -> None:
    stage1_main = importlib.import_module("compiler.build.main")
    native_ir_module = importlib.import_module("compiler.build.native_ir")

    result = stage1_main.compile_to_native(LAYOUT_DESCRIPTOR_SOURCE)
    unexpected = [
        diag for diag in result.diagnostics if "defaulting to pointer layout" not in diag]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    artifact = next(
        (artifact for artifact in result.module.artifacts if artifact.name == "module.sfn-asm"), None)
    assert artifact is not None, "native artifact missing from emit_native output"

    contents = artifact.contents
    assert ".layout struct size=16 align=8" in contents
    assert ".layout field name type=string offset=0 size=8 align=8" in contents
    assert ".layout field age type=int offset=8 size=8 align=8" in contents
    assert ".layout enum size=16 align=8 tag_type=i32 tag_size=4 tag_align=4" in contents
    assert ".layout variant Circle tag=0 offset=8 size=8 align=8" in contents
    assert ".layout variant Unit tag=1 offset=4 size=0 align=1" in contents
    assert ".layout payload Circle.radius type=number offset=8 size=8 align=8" in contents

    parse_native_artifact = getattr(native_ir_module, "parse_native_artifact")
    parse_result = parse_native_artifact(artifact.contents)

    person_struct = next(
        (definition for definition in parse_result.structs if definition.name == "Person"), None)
    assert person_struct is not None, "parsed struct metadata missing"
    assert person_struct.layout is not None, "struct layout metadata missing"
    assert person_struct.layout.size == 16
    assert person_struct.layout.align == 8
    assert [field.name for field in person_struct.layout.fields] == [
        "name", "age"]
    assert [field.offset for field in person_struct.layout.fields] == [0, 8]

    shape_enum = next(
        (definition for definition in parse_result.enums if definition.name == "Shape"), None)
    assert shape_enum is not None, "parsed enum metadata missing"
    assert shape_enum.layout is not None, "enum layout metadata missing"
    assert shape_enum.layout.size == 16
    assert shape_enum.layout.align == 8
    assert shape_enum.layout.tag_type == "i32"
    assert shape_enum.layout.tag_size == 4
    assert shape_enum.layout.tag_align == 4

    circle_layout = next(
        (variant for variant in shape_enum.layout.variants if variant.name == "Circle"), None)
    assert circle_layout is not None, "Circle layout metadata missing"
    assert circle_layout.offset == 8
    assert circle_layout.size == 8
    assert circle_layout.align == 8
    assert [field.name for field in circle_layout.fields] == ["radius"]
    assert [field.offset for field in circle_layout.fields] == [8]

    unit_layout = next(
        (variant for variant in shape_enum.layout.variants if variant.name == "Unit"), None)
    assert unit_layout is not None, "Unit layout metadata missing"
    assert unit_layout.offset == 4
    assert unit_layout.size == 0
    assert unit_layout.align == 1


@pytest.mark.usefixtures("stage1_environment")
def test_native_backend_records_interface_metadata() -> None:
    stage1_main = importlib.import_module("compiler.build.main")
    native_ir_module = importlib.import_module("compiler.build.native_ir")

    result = stage1_main.compile_to_native(INTERFACE_METADATA_SOURCE)
    unexpected = [
        diag for diag in result.diagnostics if "defaulting to pointer layout" not in diag]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    artifact = next(
        (artifact for artifact in result.module.artifacts if artifact.name == "module.sfn-asm"), None)
    assert artifact is not None, "native artifact missing from emit_native output"

    parse_native_artifact = getattr(native_ir_module, "parse_native_artifact")
    parse_result = parse_native_artifact(artifact.contents)

    greeter = next(
        (definition for definition in parse_result.interfaces if definition.name == "Greeter"), None)
    assert greeter is not None, "Greeter interface metadata missing"
    assert len(greeter.signatures) == 1, "Greeter signatures not captured"
    greet_sig = greeter.signatures[0]
    assert greet_sig.name == "greet"
    assert greet_sig.return_type == "string"
    assert [parameter.name for parameter in greet_sig.parameters] == [
        "self"], "Greeter signature parameters incorrect"

    formatter = next(
        (definition for definition in parse_result.interfaces if definition.name == "Formatter"), None)
    assert formatter is not None, "Formatter interface metadata missing"
    assert [signature.name for signature in formatter.signatures] == ["format"]

    friendly_user = next(
        (definition for definition in parse_result.structs if definition.name == "FriendlyUser"), None)
    assert friendly_user is not None, "FriendlyUser struct metadata missing"
    assert friendly_user.implements == [
        "Greeter", "Formatter"], "struct implements metadata incorrect"


@pytest.mark.usefixtures("stage1_environment")
def test_native_backend_emits_parameter_spans() -> None:
    stage1_main = importlib.import_module("compiler.build.main")
    native_ir_module = importlib.import_module("compiler.build.native_ir")

    result = stage1_main.compile_to_native(PARAMETER_SPAN_SOURCE)
    unexpected = [
        diag for diag in result.diagnostics if "defaulting to pointer layout" not in diag]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    artifact = next(
        (artifact for artifact in result.module.artifacts if artifact.name == "module.sfn-asm"), None)
    assert artifact is not None, "native artifact missing from emit_native output"

    lines = artifact.contents.splitlines()
    value_index = next((index for index, line in enumerate(
        lines) if ".param value -> number" in line), -1)
    assert value_index > 0, "value parameter entry missing"
    assert lines[value_index - 1].strip().startswith(
        ".span "), "value parameter span metadata missing"

    scale_index = next((index for index, line in enumerate(
        lines) if ".param mut scale -> number = 1" in line), -1)
    assert scale_index > 0, "scale parameter entry missing"
    assert lines[scale_index - 1].strip().startswith(
        ".span "), "scale parameter span metadata missing"

    parse_native_artifact = getattr(native_ir_module, "parse_native_artifact")
    parse_result = parse_native_artifact(artifact.contents)
    annotate = next(
        (function for function in parse_result.functions if function.name == "annotate"), None)
    assert annotate is not None, "annotate function metadata missing"
    assert annotate.parameters, "annotate parameters missing"
    assert all(
        parameter.span is not None for parameter in annotate.parameters), "parameter spans not captured"

    first_span = annotate.parameters[0].span
    assert first_span is not None and first_span.start_line == 1 and first_span.start_column < first_span.end_column
