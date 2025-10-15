import ctypes
import textwrap

import llvmlite.binding as llvm
import pytest

from compiler.build.emit_native import NativeArtifact, NativeModule
from compiler.build.main import compile_to_native_llvm
from compiler.build.native_llvm_lowering import lower_to_llvm

_LLVM_TARGET_INITIALIZED = False


def _assert_only_pointer_layout_warnings(diagnostics):
    unexpected = [diag for diag in diagnostics if "defaulting to pointer layout" not in diag]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"


def _create_execution_engine():
    global _LLVM_TARGET_INITIALIZED
    if not _LLVM_TARGET_INITIALIZED:
        llvm.initialize_native_target()
        llvm.initialize_native_asmprinter()
        _LLVM_TARGET_INITIALIZED = True
    target = llvm.Target.from_default_triple()
    target_machine = target.create_target_machine()
    backing_module = llvm.parse_assembly("")
    engine = llvm.create_mcjit_compiler(backing_module, target_machine)
    return engine


def _compile_ir(ir: str):
    engine = _create_execution_engine()
    module = llvm.parse_assembly(ir)
    module.verify()
    engine.add_module(module)
    engine.finalize_object()
    engine.run_static_constructors()
    return engine, module


def _lower_native_text(artifact_text: str):
    module = NativeModule(
        artifacts=[NativeArtifact(name="test.sfn-asm", format="sailfin-native-text", contents=textwrap.dedent(artifact_text).strip())],
        entry_points=[],
        symbol_count=0,
    )
    return lower_to_llvm(module)


class _ArrayNumber(ctypes.Structure):
    _fields_ = [
        ("data", ctypes.POINTER(ctypes.c_double)),
        ("length", ctypes.c_longlong),
    ]


def _build_number_array(values):
    array_type = ctypes.c_double * len(values)
    buffer = array_type(*values)
    struct = _ArrayNumber(data=buffer, length=len(values))
    return buffer, struct


class _ArrayInt(ctypes.Structure):
    _fields_ = [
        ("data", ctypes.POINTER(ctypes.c_longlong)),
        ("length", ctypes.c_longlong),
    ]


def _build_int_array(values):
    array_type = ctypes.c_longlong * len(values)
    buffer = array_type(*values)
    struct = _ArrayInt(data=buffer, length=len(values))
    return buffer, struct


class _ArrayBool(ctypes.Structure):
    _fields_ = [
        ("data", ctypes.POINTER(ctypes.c_bool)),
        ("length", ctypes.c_longlong),
    ]


def _build_bool_array(values):
    array_type = ctypes.c_bool * len(values)
    buffer = array_type(*values)
    struct = _ArrayBool(data=buffer, length=len(values))
    return buffer, struct


def _invoke(engine, name: str, restype, arg_types, *args):
    address = engine.get_function_address(name)
    assert address != 0, f"function {name} not found"
    function_type = ctypes.CFUNCTYPE(restype, *arg_types)
    function = function_type(address)
    return function(*args)


def _invoke_double(engine, name: str, *args: float) -> float:
    arg_types = (ctypes.c_double,) * len(args)
    return _invoke(engine, name, ctypes.c_double, arg_types, *args)


def _invoke_int(engine, name: str, *args: int) -> int:
    arg_types = (ctypes.c_longlong,) * len(args)
    return _invoke(engine, name, ctypes.c_longlong, arg_types, *args)


def _invoke_bool(engine, name: str, arg_types, *args) -> bool:
    return bool(_invoke(engine, name, ctypes.c_bool, arg_types, *args))


@pytest.mark.parametrize(
    "source, expected",
    [
        (
            """
fn add(a -> number, b -> number) -> number {
    return a + b;
}

fn main() -> number {
    return add(2, 40);
}
""",
            42.0,
        ),
        (
            """
fn choose(flag -> number, a -> number, b -> number) -> number {
    let selected -> number = 0;
    if flag {
        selected = a;
    } else {
        selected = b;
    }
    return selected;
}

fn main() -> number {
    return choose(1, 7, -3) + choose(0, -1, 5);
}
""",
            12.0,
        ),
        (
            """
fn loop_and_match(limit -> number) -> number {
    let mut total -> number = 0;
    let mut current -> number = 0;
    loop {
        if current == limit {
            break;
        }
        if current == 3 {
            current = current + 1;
            continue;
        }
        total = total + current;
        current = current + 1;
    }
    return total + classify(limit);
}

fn classify(value -> number) -> number {
    match value {
        0 => return 10,
        1 => return 20,
        _ => return -1,
    }
}

fn main() -> number {
    return loop_and_match(5);
}
""",
            6.0,
        ),
        (
            """
fn sum_for(limit -> number) -> number {
    let mut total -> number = 0;
    for i in 0..limit {
        if i == 2 {
            continue;
        }
        if i == 4 {
            break;
        }
        total = total + i;
    }
    return total;
}

fn main() -> number {
    return sum_for(6);
}
""",
            4.0,
        ),
    ],
)
def test_native_llvm_execution_runs_program(source: str, expected: float) -> None:
    lowered = compile_to_native_llvm(source)
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    assert "define double @add" in lowered.ir
    assert "define double @main" in lowered.ir

    if "choose" in source:
        assert "define double @choose" in lowered.ir
        assert "br i1" in lowered.ir

    engine, module = _compile_ir(lowered.ir)
    try:
        main_result = _invoke_double(engine, "main")
        assert main_result == pytest.approx(expected)

        add_result = _invoke_double(engine, "add", 3.0, 4.0)
        assert add_result == pytest.approx(7.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_supports_boolean_and_integer_primitives() -> None:
    source = """
fn toggle(value -> boolean) -> boolean {
    if value {
        return false;
    }
    return true;
}

fn choose(flag -> boolean, a -> number, b -> number) -> number {
    if flag {
        return a;
    }
    return b;
}

fn add_ints(a -> int, b -> int) -> int {
    let mut total -> int = a;
    total = total + b;
    return total;
}

fn increment_if_positive(value -> int) -> int {
    if value > 0 {
        return value + 1;
    }
    return value;
}

fn is_positive(value -> int) -> boolean {
    return value > 0;
}

fn spill_to_number(value -> int) -> number {
    return value;
}

fn main() -> number {
    return choose(true, 2, -2);
}
"""

    lowered = compile_to_native_llvm(source)
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    ir = lowered.ir
    assert "define i1 @toggle" in ir
    assert "define double @choose" in ir
    assert "define i64 @add_ints" in ir

    engine, module = _compile_ir(ir)
    try:
        assert _invoke_double(engine, "main") == pytest.approx(2.0)
        assert _invoke_bool(engine, "toggle", (ctypes.c_bool,), True) is False
        assert _invoke_bool(engine, "toggle", (ctypes.c_bool,), False) is True
        assert _invoke(
            engine,
            "choose",
            ctypes.c_double,
            (ctypes.c_bool, ctypes.c_double, ctypes.c_double),
            True,
            1.5,
            -4.0,
        ) == pytest.approx(1.5)
        assert _invoke(
            engine,
            "choose",
            ctypes.c_double,
            (ctypes.c_bool, ctypes.c_double, ctypes.c_double),
            False,
            1.5,
            -4.0,
        ) == pytest.approx(-4.0)
        assert _invoke_int(engine, "add_ints", 3, 5) == 8
        assert _invoke_int(engine, "increment_if_positive", -2) == -2
        assert _invoke_int(engine, "increment_if_positive", 4) == 5
        assert _invoke_bool(engine, "is_positive", (ctypes.c_longlong,), -3) is False
        assert _invoke_bool(engine, "is_positive", (ctypes.c_longlong,), 3) is True
        assert _invoke(engine, "spill_to_number", ctypes.c_double, (ctypes.c_longlong,), 7) == pytest.approx(7.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_iterates_number_arrays() -> None:
    source = """
fn sum(values -> number[]) -> number {
    let mut total -> number = 0;
    for value in values {
        total = total + value;
    }
    return total;
}

fn sum_positive(values -> number[]) -> number {
    let mut total -> number = 0;
    for value in values {
        if value < 0 {
            continue;
        }
        total = total + value;
    }
    return total;
}

fn sum_until(values -> number[], limit -> number) -> number {
    let mut total -> number = 0;
    for value in values {
        if value == limit {
            break;
        }
        total = total + value;
    }
    return total;
}

fn sum_literal() -> number {
    let mut total -> number = 0;
    for value in [1, 2, 3, 4] {
        total = total + value;
    }
    return total;
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_to_native_llvm(source)
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    ir = lowered.ir
    assert "{ double*, i64 }* %values" in ir

    engine, module = _compile_ir(ir)
    buffers = []
    try:
        buf_all, arr_all = _build_number_array([1.0, 2.0, 3.0, 4.0])
        buffers.append(buf_all)
        assert _invoke(
            engine,
            "sum",
            ctypes.c_double,
            (ctypes.POINTER(_ArrayNumber),),
            ctypes.byref(arr_all),
        ) == pytest.approx(10.0)

        buf_pos, arr_pos = _build_number_array([-5.0, 1.0, -2.0, 4.0])
        buffers.append(buf_pos)
        assert _invoke(
            engine,
            "sum_positive",
            ctypes.c_double,
            (ctypes.POINTER(_ArrayNumber),),
            ctypes.byref(arr_pos),
        ) == pytest.approx(5.0)

        buf_until, arr_until = _build_number_array([2.0, 3.0, 5.0, 11.0])
        buffers.append(buf_until)
        assert _invoke(
            engine,
            "sum_until",
            ctypes.c_double,
            (ctypes.POINTER(_ArrayNumber), ctypes.c_double),
            ctypes.byref(arr_until),
            5.0,
        ) == pytest.approx(5.0)

        assert _invoke_double(engine, "sum_literal") == pytest.approx(10.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_iterates_array_bindings_without_annotations() -> None:
    source = """
fn sum_alias(values -> number[]) -> number {
    let alias = values;
    let mut total -> number = 0;
    for value in alias {
        total = total + value;
    }
    return total;
}

fn sum_literal_binding() -> number {
    let values = [1, 2, 3, 4];
    let mut total -> number = 0;
    for value in values {
        total = total + value;
    }
    return total;
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_to_native_llvm(source)
    _assert_only_pointer_layout_warnings(lowered.diagnostics)

    engine, module = _compile_ir(lowered.ir)
    buffers = []
    try:
        buf_alias, arr_alias = _build_number_array([1.0, 2.0, 3.0])
        buffers.append(buf_alias)
        assert _invoke(
            engine,
            "sum_alias",
            ctypes.c_double,
            (ctypes.POINTER(_ArrayNumber),),
            ctypes.byref(arr_alias),
        ) == pytest.approx(6.0)

        assert _invoke_double(engine, "sum_literal_binding") == pytest.approx(10.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_reports_interface_metadata() -> None:
    source = """
interface Greeter {
    fn greet(self -> Greeter) -> string;
}

interface Formatter {
    fn format(self -> Formatter) -> string;
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

fn main() -> number {
    return 0;
}
"""

    lowered = compile_to_native_llvm(source)
    _assert_only_pointer_layout_warnings(lowered.diagnostics)

    ir = lowered.ir
    assert "; -- Trait Metadata" in ir
    assert "; interface Greeter" in ir
    assert ";   fn greet(self -> Greeter) -> string" in ir
    assert "; interface Formatter" in ir
    assert "; struct FriendlyUser implements Greeter, Formatter" in ir

    trait_metadata = lowered.trait_metadata
    interface_names = [descriptor.name for descriptor in trait_metadata.interfaces]
    assert interface_names == ["Greeter", "Formatter"]
    greeter_descriptor = trait_metadata.interfaces[0]
    assert [signature.name for signature in greeter_descriptor.signatures] == ["greet"]
    formatter_descriptor = trait_metadata.interfaces[1]
    assert [signature.name for signature in formatter_descriptor.signatures] == ["format"]

    assert len(trait_metadata.implementations) == 1
    implementation = trait_metadata.implementations[0]
    assert implementation.struct_name == "FriendlyUser"
    assert implementation.interfaces == ["Greeter", "Formatter"]


def test_native_llvm_execution_iterates_non_number_arrays() -> None:
    source = """
fn any_true(values -> boolean[]) -> boolean {
    for value in values {
        if value {
            return true;
        }
    }
    return false;
}

fn all_true(values -> boolean[]) -> boolean {
    for value in values {
        if value == false {
            return false;
        }
    }
    return true;
}

fn count_true_literal() -> int {
    let mut total -> int = 0;
    for value in [true, false, true, true] {
        if value {
            total = total + 1;
        }
    }
    return total;
}

fn sum_ints(values -> int[]) -> int {
    let mut total -> int = 0;
    for value in values {
        total = total + value;
    }
    return total;
}

fn sum_int_literal() -> int {
    let mut total -> int = 0;
    for value in [1, 2, 3, 4] {
        total = total + value;
    }
    return total;
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_to_native_llvm(source)
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    ir = lowered.ir
    assert "define i1 @any_true" in ir
    assert "define i64 @count_true_literal" in ir
    assert "define i64 @sum_int_literal" in ir

    engine, module = _compile_ir(ir)
    buffers = []
    try:
        buf_bool_any, arr_bool_any = _build_bool_array([True, False, True])
        buf_bool_all, arr_bool_all = _build_bool_array([True, True, True])
        buffers.extend([buf_bool_any, buf_bool_all])
        assert _invoke_bool(
            engine,
            "any_true",
            (ctypes.POINTER(_ArrayBool),),
            ctypes.byref(arr_bool_any),
        ) is True
        assert _invoke_bool(
            engine,
            "all_true",
            (ctypes.POINTER(_ArrayBool),),
            ctypes.byref(arr_bool_any),
        ) is False
        assert _invoke_bool(
            engine,
            "all_true",
            (ctypes.POINTER(_ArrayBool),),
            ctypes.byref(arr_bool_all),
        ) is True
        assert _invoke_int(engine, "count_true_literal") == 3

        buf_int, arr_int = _build_int_array([-1, 2, 4, 5])
        buffers.append(buf_int)
        assert _invoke(
            engine,
            "sum_ints",
            ctypes.c_longlong,
            (ctypes.POINTER(_ArrayInt),),
            ctypes.byref(arr_int),
        ) == 10
        assert _invoke_int(engine, "sum_int_literal") == 10
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_lowers_borrow_expressions() -> None:
    source = """
fn project(view -> &number) -> number {
    if 1 == 0 {
        return 0;
    }
    return 1;
}

fn forward(value -> number) -> number {
    let mut slot -> number = value;
    let alias -> &mut number = &mut slot;
    let shared -> &number = alias;
    let extra -> number = project(shared);
    return slot + extra;
}

fn main() -> number {
    return forward(5);
}
"""

    lowered = compile_to_native_llvm(source)
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    ir = lowered.ir
    assert "define double @project(double* %view)" in ir
    assert "alloca double*" in ir

    engine, module = _compile_ir(ir)
    try:
        assert _invoke_double(engine, "main") == pytest.approx(6.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_reports_conflicting_mut_borrows() -> None:
    source = """
fn conflict() -> number {
    let mut slot -> number = 0;
    let first -> &mut number = &mut slot;
    let second -> &mut number = &mut slot;
    return slot;
}

fn main() -> number {
    return conflict();
}
"""

    lowered = compile_to_native_llvm(source)
    non_pointer = [diag for diag in lowered.diagnostics if "defaulting to pointer layout" not in diag]
    assert non_pointer, "expected conflict diagnostics"
    assert all("conflicts with" in diag for diag in non_pointer)
def test_native_llvm_execution_reports_use_after_move() -> None:
    source = """
    fn reuse(value -> Affine<number>) -> number {
        let alias = value;
        return value;
    }

    fn main() -> number {
        return 0;
    }
    """

    lowered = compile_to_native_llvm(source)
    use_after_move_diags = [diag for diag in lowered.diagnostics if "use-after-move" in diag]
    assert use_after_move_diags, "expected use-after-move diagnostics"
    assert any(" at " in diag and diag.split(" at ")[-1].count(":") >= 2 for diag in use_after_move_diags), (
        "use-after-move diagnostics did not include span information",
        use_after_move_diags,
    )
    assert not any("unsupported parameter type" in diag for diag in lowered.diagnostics)





def test_native_llvm_execution_reports_use_after_move_for_affine_array() -> None:
    source = """
    fn reuse(values -> Affine<number[]>) -> number {
        let alias = values;
        let again = values;
        return 0;
    }

    fn main() -> number {
        return 0;
    }
    """

    lowered = compile_to_native_llvm(source)
    use_after_move_diags = [diag for diag in lowered.diagnostics if "use-after-move" in diag]
    assert use_after_move_diags, "expected use-after-move diagnostics"
    assert any(" at " in diag and diag.split(" at ")[-1].count(":") >= 2 for diag in use_after_move_diags), (
        "use-after-move diagnostics did not include span information",
        use_after_move_diags,
    )
    assert not any("unsupported parameter type" in diag for diag in lowered.diagnostics)

def test_native_llvm_execution_reports_conflicting_shared_borrows() -> None:
    source = """
fn conflict_shared() -> number {
    let mut slot -> number = 0;
    let guard -> &mut number = &mut slot;
    let view -> &number = &slot;
    return slot;
}

fn main() -> number {
    return conflict_shared();
}
"""

    lowered = compile_to_native_llvm(source)
    non_pointer = [diag for diag in lowered.diagnostics if "defaulting to pointer layout" not in diag]
    assert non_pointer, "expected conflict diagnostics"
    assert all("shared borrow" in diag for diag in non_pointer)


def test_native_llvm_rejects_mutable_borrow_across_await() -> None:
    artifact_text = """
    ; Sailfin Native Prototype
    .module main

    .fn borrow_then_await(value -> &mut number) -> number
    .meta return number
    .meta effects none
        .param value -> &mut number
        .span 5 9 5 36
        .init-span 5 21 5 38
        eval let alias = &mut *value
        .span 6 9 6 37
        eval let result = await compute()
        ret 0
    .endfn

    .fn compute() -> number
    .meta return number
    .meta effects none
        ret 1
    .endfn
    """

    lowered = _lower_native_text(artifact_text)
    borrow_diags = [diag for diag in lowered.diagnostics if "await suspends while mutable borrow" in diag]
    assert borrow_diags, lowered.diagnostics
    assert any("`alias`" in diag and "`value`" in diag for diag in borrow_diags)
    assert any("`alias`" in diag and "borrow at" in diag and "await at" in diag for diag in borrow_diags)
    assert any("parameter `value`" in diag and "await at" in diag for diag in borrow_diags)


def test_native_llvm_allows_await_without_mutable_borrow() -> None:
    artifact_text = """
    ; Sailfin Native Prototype
    .module main

    .fn await_without_borrow(value -> number) -> number
    .meta return number
    .meta effects none
        .param value -> number
        eval let result = await compute()
        ret value
    .endfn

    .fn compute() -> number
    .meta return number
    .meta effects none
        ret 1
    .endfn
    """

    lowered = _lower_native_text(artifact_text)
    borrow_diags = [diag for diag in lowered.diagnostics if "await suspends while mutable borrow" in diag]
    assert not borrow_diags, lowered.diagnostics


def test_native_llvm_execution_surfaces_function_borrow_effects() -> None:
    source = """
fn borrow_mutable() -> number {
    let mut slot -> number = 0;
    let shared -> &number = &slot;
    let alias -> &mut number = &mut slot;
    return slot;
}

fn main() -> number {
    return borrow_mutable();
}
"""

    lowered = compile_to_native_llvm(source)
    effect_map = {entry.name: entry.effects for entry in lowered.function_effects}
    assert "borrow_mutable" in effect_map
    assert "mut" in effect_map["borrow_mutable"], effect_map
    assert "read" in effect_map["borrow_mutable"], effect_map
    manifest_map = {entry.symbol: entry.effects for entry in lowered.capability_manifest.entries}
    assert manifest_map.get("borrow_mutable"), manifest_map
    assert "mut" in manifest_map["borrow_mutable"] and "read" in manifest_map["borrow_mutable"]
    comment_lines = [line for line in lowered.ir.splitlines() if line.startswith("; fn borrow_mutable effects:")]
    assert comment_lines, lowered.ir
    assert "mut" in comment_lines[0] and "read" in comment_lines[0]


def test_native_llvm_execution_capability_manifest_propagates_composite_effects() -> None:
    artifact_text = """
; Sailfin Native Prototype
.module main

.fn borrow_mutable() ![io]
.meta return number
.meta effects io
    .span 3 5 3 36
    eval let mut slot -> number = 0
    .span 4 5 4 38
    eval let shared -> &number = &slot
    .span 5 5 5 45
    eval let alias -> &mut number = &mut slot
    .span 6 5 6 17
    ret slot
.endfn

.fn wrapper() -> number
.meta return number
.meta effects none
    .span 10 5 10 29
    ret borrow_mutable()
.endfn

.fn main() -> number
.meta return number
.meta effects none
    .span 14 5 14 22
    ret wrapper()
.endfn
""".strip()

    module = NativeModule(
        artifacts=[NativeArtifact(name="composite_effects.sfn-asm", format="sailfin-native-text", contents=artifact_text)],
        entry_points=["borrow_mutable", "wrapper", "main"],
        symbol_count=3,
    )
    lowered = lower_to_llvm(module)
    effect_map = {entry.name: entry.effects for entry in lowered.function_effects}
    assert set(effect_map.get("borrow_mutable", [])) == {"io", "mut", "read"}, effect_map
    assert set(effect_map.get("wrapper", [])) == {"io", "mut", "read"}, effect_map
    assert set(effect_map.get("main", [])) == {"io", "mut", "read"}, effect_map
    manifest_map = {entry.symbol: entry.effects for entry in lowered.capability_manifest.entries}
    assert set(manifest_map.get("borrow_mutable", [])) == {"io", "mut", "read"}, manifest_map
    assert set(manifest_map.get("wrapper", [])) == {"io", "mut", "read"}, manifest_map
    assert set(manifest_map.get("main", [])) == {"io", "mut", "read"}, manifest_map


def test_native_llvm_execution_supports_range_strides() -> None:
    source = """
fn sum_stride(limit -> number, stride -> number) -> number {
    let mut total -> number = 0;
    for value in 0..limit..stride {
        total = total + value;
    }
    return total;
}

fn sum_descending(start -> number, stride -> number) -> number {
    let mut total -> number = 0;
    for value in start..0..stride {
        total = total + value;
    }
    return total;
}

fn sum_literal() -> number {
    let mut total -> number = 0;
    for value in 0..5..2 {
        total = total + value;
    }
    return total;
}

fn sum_negative_literal() -> number {
    let mut total -> number = 0;
    for value in 5..0..-2 {
        total = total + value;
    }
    return total;
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_to_native_llvm(source)
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    ir = lowered.ir
    assert "0..limit..stride" not in ir  # ensure lowered IR not raw range text

    engine, module = _compile_ir(ir)
    try:
        assert _invoke_double(engine, "sum_stride", 5.0, 2.0) == pytest.approx(6.0)
        assert _invoke_double(engine, "sum_descending", 5.0, -2.0) == pytest.approx(9.0)
        assert _invoke_double(engine, "sum_literal") == pytest.approx(6.0)
        assert _invoke_double(engine, "sum_negative_literal") == pytest.approx(9.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_reports_zero_literal_stride() -> None:
    source = """
fn main() -> number {
    let mut total -> number = 0;
    for value in 0..4..0 {
        total = total + value;
    }
    return total;
}
"""

    lowered = compile_to_native_llvm(source)
    assert any("stride must not be zero" in diagnostic for diagnostic in lowered.diagnostics)
