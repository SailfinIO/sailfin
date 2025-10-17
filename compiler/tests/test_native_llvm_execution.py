import ctypes
import textwrap

import llvmlite.binding as llvm
import pytest

from compiler.build.emit_native import NativeArtifact, NativeModule
from compiler.build.native_llvm_lowering import lower_to_llvm
from runtime.stage2_runner import Stage2Runner, current_capability_grant

pytestmark = [pytest.mark.stage2, pytest.mark.usefixtures("stage1_environment")]

_LLVM_TARGET_INITIALIZED = False


@pytest.fixture()
def compile_stage2(stage2_environment):
    def _compile(source: str, *, module_name: str = "<memory>"):
        return stage2_environment.compile_to_native_llvm(source, module_name=module_name)

    return _compile


def _assert_only_pointer_layout_warnings(diagnostics):
    unexpected = [
        diag for diag in diagnostics if "defaulting to pointer layout" not in diag]
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
        artifacts=[NativeArtifact(name="test.sfn-asm", format="sailfin-native-text",
                                  contents=textwrap.dedent(artifact_text).strip())],
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


class _Pair(ctypes.Structure):
    _fields_ = [
        ("left", ctypes.c_double),
        ("right", ctypes.c_double),
    ]


class _ArrayPair(ctypes.Structure):
    _fields_ = [
        ("data", ctypes.POINTER(_Pair)),
        ("length", ctypes.c_longlong),
    ]


def _build_pair_array(values):
    pair_array_type = _Pair * len(values)
    pairs = [_Pair(left, right) for left, right in values]
    buffer = pair_array_type(*pairs)
    struct = _ArrayPair(data=buffer, length=len(values))
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


def test_native_llvm_execution_invokes_runtime_console(compile_stage2):
    result = compile_stage2(
        """
fn emit() ![io] {
    print.info("Stage2 runtime bridge!");
}

fn main() -> number {
    emit();
    return 7;
}
"""
    )
    _assert_only_pointer_layout_warnings(result.diagnostics)

    call_count = {"value": 0}

    def _runtime_print_info(_message):
        call_count["value"] += 1

    runtime_print_info_stub = ctypes.CFUNCTYPE(None, ctypes.c_void_p)(_runtime_print_info)
    llvm.add_symbol(
        "sailfin_runtime_print_info",
        ctypes.cast(runtime_print_info_stub, ctypes.c_void_p).value,
    )

    engine, _ = _compile_ir(result.ir)
    output = _invoke_double(engine, "main")
    assert output == pytest.approx(7.0)
    assert call_count["value"] == 1


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
def test_native_llvm_execution_runs_program(source: str, expected: float, compile_stage2) -> None:
    lowered = compile_stage2(source)
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


def test_native_llvm_execution_supports_boolean_and_integer_primitives(compile_stage2) -> None:
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

    lowered = compile_stage2(source)
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
        assert _invoke_bool(engine, "is_positive",
                            (ctypes.c_longlong,), -3) is False
        assert _invoke_bool(engine, "is_positive",
                            (ctypes.c_longlong,), 3) is True
        assert _invoke(engine, "spill_to_number", ctypes.c_double,
                       (ctypes.c_longlong,), 7) == pytest.approx(7.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_iterates_number_arrays(compile_stage2) -> None:
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

    lowered = compile_stage2(source)
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


def test_native_llvm_execution_lowers_struct_literals(compile_stage2) -> None:
    source = """
struct Pair {
    left -> number;
    right -> number;
}

fn make_pair(a -> number, b -> number) -> Pair {
    return Pair { left: a, right: b };
}

fn sum_pair(value -> Pair) -> number {
    return value.left + value.right;
}

fn use_literal() -> number {
    let pair -> Pair = Pair { left: 1, right: 2 };
    return pair.left + pair.right;
}

fn main() -> number {
    let constructed -> Pair = make_pair(10, 5);
    return sum_pair(constructed) + use_literal();
}
"""

    lowered = compile_stage2(source, module_name="struct_literals")
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    assert "%Pair = type { double, double }" in lowered.ir

    engine, module = _compile_ir(lowered.ir)
    try:
        assert _invoke_double(engine, "main") == pytest.approx(18.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_calls_struct_methods(compile_stage2) -> None:
    source = """
struct Pair {
    left -> number;
    right -> number;

    fn sum(self -> Pair) -> number {
        return self.left + self.right;
    }

    fn translate(self -> Pair, delta -> number) -> Pair {
        let new_left -> number = self.left + delta;
        let new_right -> number = self.right + delta;
        return Pair { left: new_left, right: new_right };
    }
}

fn accumulate(value -> Pair) -> number {
    return value.sum();
}

fn main() -> number {
    let base -> Pair = Pair { left: 1, right: 2 };
    let shifted -> Pair = base.translate(3);
    return base.sum() + accumulate(shifted);
}
"""

    lowered = compile_stage2(source, module_name="struct_methods")
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    ir = lowered.ir
    assert "define double @Pairsum(%Pair %self)" in ir
    assert "call double @Pairsum(%Pair" in ir

    engine, module = _compile_ir(ir)
    try:
        assert _invoke_double(engine, "main") == pytest.approx(12.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_iterates_array_bindings_without_annotations(compile_stage2) -> None:
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

    lowered = compile_stage2(source, module_name="array_bindings")
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

        assert _invoke_double(
            engine, "sum_literal_binding") == pytest.approx(10.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_reports_interface_metadata(compile_stage2) -> None:
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

    lowered = compile_stage2(source, module_name="interface_metadata")
    _assert_only_pointer_layout_warnings(lowered.diagnostics)

    ir = lowered.ir
    assert "; -- Trait Metadata" in ir
    assert "; interface Greeter" in ir
    assert ";   fn greet(self -> Greeter) -> string" in ir
    assert "; interface Formatter" in ir
    assert "; struct FriendlyUser implements Greeter, Formatter" in ir

    trait_metadata = lowered.trait_metadata
    interface_names = [
        descriptor.name for descriptor in trait_metadata.interfaces]
    assert interface_names == ["Greeter", "Formatter"]
    greeter_descriptor = trait_metadata.interfaces[0]
    assert [signature.name for signature in greeter_descriptor.signatures] == [
        "greet"]
    formatter_descriptor = trait_metadata.interfaces[1]
    assert [signature.name for signature in formatter_descriptor.signatures] == [
        "format"]
    assert len(trait_metadata.implementations) == 1
    implementation = trait_metadata.implementations[0]
    assert implementation.struct_name == "FriendlyUser"
    assert implementation.interfaces == ["Greeter", "Formatter"]


def test_native_llvm_execution_emits_lifetime_regions(compile_stage2) -> None:
    source = """
fn forward(value -> number) -> number {
    let mut slot -> number = value;
    let alias -> &mut number = &mut slot;
    return slot;
}

fn main() -> number {
    return forward(3);
}
"""

    lowered = compile_stage2(source, module_name="lifetime_regions")
    _assert_only_pointer_layout_warnings(lowered.diagnostics)

    regions = lowered.lifetime_regions
    assert len(regions) == 1

    alias_region = regions[0]
    assert alias_region.binding == "alias"
    assert alias_region.base == "slot"
    assert alias_region.mutable is True
    assert alias_region.scope_id == "fn:forward"
    assert alias_region.scope_depth == 0
    assert alias_region.start_span is not None
    assert alias_region.start_span.start_line > 0
    assert alias_region.start_span.start_column > 0


def test_native_llvm_execution_reports_borrow_lifetime_violation(compile_stage2) -> None:
    source = """
fn leak(flag -> number) -> number {
    let mut outer -> number = 1;
    let mut alias -> &number = &outer;
    if flag {
        let mut inner -> number = 2;
        alias = &inner;
    }
    return outer;
}

fn main() -> number {
    return leak(1);
}
"""

    lowered = compile_stage2(source, module_name="borrow_violation")
    diagnostics = lowered.diagnostics
    violation = [
        diag for diag in diagnostics if "borrow `alias` of `inner` escapes lifetime" in diag
    ]
    assert violation, f"expected lifetime violation diagnostic, saw: {diagnostics}"


def test_native_llvm_execution_allows_scoped_reborrow(compile_stage2) -> None:
    source = """
fn reborrow(flag -> number) -> number {
    let mut outer -> number = 1;
    let mut alias -> &number = &outer;
    if flag {
        let mut inner -> number = 2;
        alias = &inner;
        alias = &outer;
    }
    return outer;
}

fn main() -> number {
    return reborrow(1);
}
"""

    lowered = compile_stage2(source, module_name="scoped_reborrow")
    diagnostics = lowered.diagnostics
    violation = [
        diag for diag in diagnostics if "escapes lifetime" in diag
    ]
    assert not violation, f"unexpected lifetime diagnostics: {diagnostics}"

    regions = [region for region in lowered.lifetime_regions if region.binding == "alias" and region.base == "inner"]
    assert regions, "expected alias borrow metadata for inner"
    for region in regions:
        assert region.released is True
        assert region.end_scope_id
        assert "then" in region.end_scope_id


def test_native_llvm_execution_iterates_non_number_arrays(compile_stage2) -> None:
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

    lowered = compile_stage2(source, module_name="non_number_arrays")
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


def test_native_llvm_execution_iterates_struct_arrays(compile_stage2) -> None:
    source = """
struct Pair {
    left -> number;
    right -> number;
}

fn sum_pairs(values -> Pair[]) -> number {
    let mut total -> number = 0;
    for value in values {
        total = total + value.left + value.right;
    }
    return total;
}

fn sum_non_zero(values -> Pair[]) -> number {
    let mut total -> number = 0;
    for value in values {
        if value.left == 0 {
            continue;
        }
        total = total + value.left + value.right;
    }
    return total;
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_stage2(source, module_name="struct_arrays")
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    ir = lowered.ir
    assert "%Pair = type { double, double }" in ir
    assert "{ %Pair*, i64 }*" in ir

    engine, module = _compile_ir(ir)
    buffers = []
    try:
        buf_pairs, arr_pairs = _build_pair_array([(1.0, 2.0), (3.0, 4.0)])
        buffers.append(buf_pairs)
        assert _invoke(
            engine,
            "sum_pairs",
            ctypes.c_double,
            (ctypes.POINTER(_ArrayPair),),
            ctypes.byref(arr_pairs),
        ) == pytest.approx(10.0)

        buf_skip, arr_skip = _build_pair_array([(0.0, 1.0), (5.5, -0.5)])
        buffers.append(buf_skip)
        assert _invoke(
            engine,
            "sum_non_zero",
            ctypes.c_double,
            (ctypes.POINTER(_ArrayPair),),
            ctypes.byref(arr_skip),
        ) == pytest.approx(5.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_lowers_borrow_expressions(compile_stage2) -> None:
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

    lowered = compile_stage2(source, module_name="borrow_expressions")
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


def test_native_llvm_execution_reports_conflicting_mut_borrows(compile_stage2) -> None:
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

    lowered = compile_stage2(source, module_name="conflicting_mut_borrows")
    non_pointer = [
        diag for diag in lowered.diagnostics if "defaulting to pointer layout" not in diag]
    assert non_pointer, "expected conflict diagnostics"
    assert all("conflicts with" in diag for diag in non_pointer)


def test_native_llvm_execution_reports_use_after_move(compile_stage2) -> None:
    source = """
    fn reuse(value -> Affine<number>) -> number {
        let alias = value;
        return value;
    }

    fn main() -> number {
        return 0;
    }
    """

    lowered = compile_stage2(source, module_name="use_after_move")
    use_after_move_diags = [
        diag for diag in lowered.diagnostics if "use-after-move" in diag]
    assert use_after_move_diags, "expected use-after-move diagnostics"
    assert any(" at " in diag and diag.split(" at ")[-1].count(":") >= 2 for diag in use_after_move_diags), (
        "use-after-move diagnostics did not include span information",
        use_after_move_diags,
    )
    assert not any(
        "unsupported parameter type" in diag for diag in lowered.diagnostics)


def test_native_llvm_execution_reports_use_after_move_for_affine_array(compile_stage2) -> None:
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

    lowered = compile_stage2(source, module_name="use_after_move_affine")
    use_after_move_diags = [
        diag for diag in lowered.diagnostics if "use-after-move" in diag]
    assert use_after_move_diags, "expected use-after-move diagnostics"
    assert any(" at " in diag and diag.split(" at ")[-1].count(":") >= 2 for diag in use_after_move_diags), (
        "use-after-move diagnostics did not include span information",
        use_after_move_diags,
    )
    assert not any(
        "unsupported parameter type" in diag for diag in lowered.diagnostics)


def test_native_llvm_execution_reports_conflicting_shared_borrows(compile_stage2) -> None:
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

    lowered = compile_stage2(source, module_name="conflicting_shared_borrows")
    non_pointer = [
        diag for diag in lowered.diagnostics if "defaulting to pointer layout" not in diag]
    assert non_pointer, "expected conflict diagnostics"
    assert all("shared borrow" in diag for diag in non_pointer)


def test_native_llvm_rejects_mutable_borrow_across_await() -> None:
    artifact_text = """
    ; Sailfin Native Prototype
    .module main

    .fn borrow_then_await(value -> &mut number) -> number
    .meta return number
    .meta effects none
        .span 4 9 4 38
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
    borrow_diags = [
        diag for diag in lowered.diagnostics if "await suspends while mutable borrow" in diag]
    assert borrow_diags, lowered.diagnostics
    assert any("`alias`" in diag and "`value`" in diag for diag in borrow_diags)
    assert any(
        "`alias`" in diag and "borrow at" in diag and "await at" in diag for diag in borrow_diags)
    assert any(
        "parameter `value`" in diag and "borrow at" in diag and "await at" in diag for diag in borrow_diags)


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
    borrow_diags = [
        diag for diag in lowered.diagnostics if "await suspends while mutable borrow" in diag]
    assert not borrow_diags, lowered.diagnostics


def test_native_llvm_execution_surfaces_function_borrow_effects(compile_stage2) -> None:
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

    lowered = compile_stage2(source, module_name="borrow_effects")
    effect_map = {
        entry.name: entry.effects for entry in lowered.function_effects}
    assert "borrow_mutable" in effect_map
    assert "mut" in effect_map["borrow_mutable"], effect_map
    assert "read" in effect_map["borrow_mutable"], effect_map
    manifest_map = {
        entry.symbol: entry.effects for entry in lowered.capability_manifest.entries}
    assert manifest_map.get("borrow_mutable"), manifest_map
    assert "mut" in manifest_map["borrow_mutable"] and "read" in manifest_map["borrow_mutable"]
    comment_lines = [line for line in lowered.ir.splitlines(
    ) if line.startswith("; fn borrow_mutable effects:")]
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
        artifacts=[NativeArtifact(name="composite_effects.sfn-asm",
                                  format="sailfin-native-text", contents=artifact_text)],
        entry_points=["borrow_mutable", "wrapper", "main"],
        symbol_count=3,
    )
    lowered = lower_to_llvm(module)
    effect_map = {
        entry.name: entry.effects for entry in lowered.function_effects}
    assert set(effect_map.get("borrow_mutable", [])) == {
        "io", "mut", "read"}, effect_map
    assert set(effect_map.get("wrapper", [])) == {
        "io", "mut", "read"}, effect_map
    assert set(effect_map.get("main", [])) == {"io", "mut", "read"}, effect_map
    manifest_map = {
        entry.symbol: entry.effects for entry in lowered.capability_manifest.entries}
    assert set(manifest_map.get("borrow_mutable", [])) == {
        "io", "mut", "read"}, manifest_map
    assert set(manifest_map.get("wrapper", [])) == {
        "io", "mut", "read"}, manifest_map
    assert set(manifest_map.get("main", [])) == {
        "io", "mut", "read"}, manifest_map


def test_stage2_runner_applies_capability_manifest(compile_stage2) -> None:
    source = """
fn main() -> number ![io] {
    print.info("grant check");
    return 3;
}
"""

    lowered = compile_stage2(source, module_name="stage2_runner_manifest")
    observed: list[bool] = []

    def _on_print(_ptr):
        grant = current_capability_grant()
        assert grant is not None
        observed.append(grant.allow("io"))

    runner = Stage2Runner(lowered, runtime_hooks={"print.info": _on_print})
    result = runner.invoke("main")
    assert result == pytest.approx(3.0)
    assert observed == [True]
    assert current_capability_grant() is None


def test_stage2_runner_denies_missing_capabilities(compile_stage2) -> None:
    source = """
fn main() -> number ![io] {
    print.info("denied");
    return 1;
}
    """

    lowered = compile_stage2(source, module_name="stage2_runner_denied")
    runner = Stage2Runner(lowered)
    assert "io" in runner.manifest.get("main", [])
    runner.set_manifest_effects("main", [])
    with pytest.raises(PermissionError):
        runner.invoke("main")


def test_native_llvm_execution_supports_range_strides(compile_stage2) -> None:
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

    lowered = compile_stage2(source, module_name="range_strides")
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    ir = lowered.ir
    assert "0..limit..stride" not in ir  # ensure lowered IR not raw range text

    engine, module = _compile_ir(ir)
    try:
        assert _invoke_double(engine, "sum_stride", 5.0,
                              2.0) == pytest.approx(6.0)
        assert _invoke_double(engine, "sum_descending",
                              5.0, -2.0) == pytest.approx(9.0)
        assert _invoke_double(engine, "sum_literal") == pytest.approx(6.0)
        assert _invoke_double(
            engine, "sum_negative_literal") == pytest.approx(9.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_reports_zero_literal_stride(compile_stage2) -> None:
    source = """
fn main() -> number {
    let mut total -> number = 0;
    for value in 0..4..0 {
        total = total + value;
    }
    return total;
}
"""

    lowered = compile_stage2(source, module_name="zero_stride")
    assert any(
        "stride must not be zero" in diagnostic for diagnostic in lowered.diagnostics)


def test_native_llvm_execution_emits_phi_for_straight_line_if(compile_stage2) -> None:
    """Verify phi nodes are emitted for conditionally mutated locals in if without else."""
    source = """
fn conditional_update(condition -> boolean, base -> number) -> number {
    let mut value -> number = base;
    if condition {
        value = base + 10;
    }
    return value;
}

fn main() -> number {
    let result_true = conditional_update(true, 5);
    let result_false = conditional_update(false, 5);
    return result_true + result_false;
}
"""

    lowered = compile_stage2(source, module_name="phi_test")
    _assert_only_pointer_layout_warnings(lowered.diagnostics)

    assert "phi double" in lowered.ir, "Expected phi node in generated IR"
    assert "define double @conditional_update" in lowered.ir

    ir = lowered.ir
    engine, module = _compile_ir(ir)
    try:
        conditional_true = _invoke(engine, "conditional_update", ctypes.c_double, (ctypes.c_bool, ctypes.c_double), True, 5.0)
        assert conditional_true == pytest.approx(15.0), "When condition is true, should return base + 10"

        conditional_false = _invoke(engine, "conditional_update", ctypes.c_double, (ctypes.c_bool, ctypes.c_double), False, 5.0)
        assert conditional_false == pytest.approx(5.0), "When condition is false, should return base unchanged"

        main_result = _invoke_double(engine, "main")
        assert main_result == pytest.approx(20.0), "Main should return 15 + 5 = 20"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


@pytest.mark.stage2
def test_native_llvm_execution_emits_phi_for_if_else(compile_stage2) -> None:
    """Verify phi nodes are emitted for locals mutated in both if and else branches."""
    source = """
fn select_value(condition -> boolean, a -> number, b -> number) -> number {
    let mut result -> number = 0;
    let mut bonus -> number = 0;
    if condition {
        result = a + 10;
        bonus = 5;
    } else {
        result = b + 20;
        bonus = 3;
    }
    return result + bonus;
}

fn partial_mutation(condition -> boolean, base -> number) -> number {
    let mut shared -> number = base;
    let mut then_only -> number = 0;
    let mut else_only -> number = 0;
    if condition {
        shared = base + 10;
        then_only = 100;
    } else {
        shared = base + 20;
        else_only = 200;
    }
    return shared + then_only + else_only;
}

fn main() -> number {
    let result_true = select_value(true, 5, 10);
    let result_false = select_value(false, 5, 10);
    let partial_true = partial_mutation(true, 5);
    let partial_false = partial_mutation(false, 5);
    return result_true + result_false + partial_true + partial_false;
}
"""

    lowered = compile_stage2(source, module_name="phi_if_else_test")
    _assert_only_pointer_layout_warnings(lowered.diagnostics)

    # Verify phi nodes are present in the generated IR
    assert "phi double" in lowered.ir, "Expected phi nodes for double values in generated IR"
    assert "define double @select_value" in lowered.ir
    assert "define double @partial_mutation" in lowered.ir

    ir = lowered.ir
    engine, module = _compile_ir(ir)
    try:
        # Test select_value with both branches
        result_true = _invoke(engine, "select_value", ctypes.c_double, (ctypes.c_bool, ctypes.c_double, ctypes.c_double), True, 5.0, 10.0)
        assert result_true == pytest.approx(20.0), "When condition is true, should return (5 + 10) + 5 = 20"

        result_false = _invoke(engine, "select_value", ctypes.c_double, (ctypes.c_bool, ctypes.c_double, ctypes.c_double), False, 5.0, 10.0)
        assert result_false == pytest.approx(33.0), "When condition is false, should return (10 + 20) + 3 = 33"

        # Test partial_mutation where different locals are mutated in each branch
        partial_true = _invoke(engine, "partial_mutation", ctypes.c_double, (ctypes.c_bool, ctypes.c_double), True, 5.0)
        assert partial_true == pytest.approx(115.0), "When condition is true, should return (5 + 10) + 100 + 0 = 115"

        partial_false = _invoke(engine, "partial_mutation", ctypes.c_double, (ctypes.c_bool, ctypes.c_double), False, 5.0)
        assert partial_false == pytest.approx(225.0), "When condition is false, should return (5 + 20) + 0 + 200 = 225"

        # Test main to ensure all paths work together
        main_result = _invoke_double(engine, "main")
        assert main_result == pytest.approx(393.0), "Main should return 20 + 33 + 115 + 225 = 393"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


@pytest.mark.stage2
def test_native_llvm_execution_emits_phi_for_match(compile_stage2) -> None:
    """Verify phi nodes are emitted for locals mutated across match arms."""
    source = """
fn classify_number(value -> number) -> number {
    let mut category -> number = 0;
    let mut bonus -> number = 0;
    match value {
        0 => {
            category = 10;
            bonus = 1;
        },
        1 => {
            category = 20;
            bonus = 2;
        },
        2 => {
            category = 30;
            bonus = 3;
        },
        _ => {
            category = 40;
            bonus = 4;
        },
    }
    return category + bonus;
}

fn partial_match_mutations(value -> number) -> number {
    let mut shared -> number = 0;
    let mut arm0_only -> number = 0;
    let mut arm1_only -> number = 0;
    let mut arm2_only -> number = 0;
    match value {
        0 => {
            shared = 100;
            arm0_only = 5;
        },
        1 => {
            shared = 200;
            arm1_only = 10;
        },
        2 => {
            shared = 300;
            arm2_only = 15;
        },
        _ => {
            shared = 400;
        },
    }
    return shared + arm0_only + arm1_only + arm2_only;
}

fn main() -> number {
    let c0 = classify_number(0);
    let c1 = classify_number(1);
    let c2 = classify_number(2);
    let c3 = classify_number(99);
    let p0 = partial_match_mutations(0);
    let p1 = partial_match_mutations(1);
    let p2 = partial_match_mutations(2);
    let p3 = partial_match_mutations(99);
    return c0 + c1 + c2 + c3 + p0 + p1 + p2 + p3;
}
"""

    lowered = compile_stage2(source, module_name="phi_match_test")
    _assert_only_pointer_layout_warnings(lowered.diagnostics)

    # Verify phi nodes are present in the generated IR for match merges
    assert "phi double" in lowered.ir, "Expected phi nodes for double values in generated IR"
    assert "define double @classify_number" in lowered.ir
    assert "define double @partial_match_mutations" in lowered.ir

    ir = lowered.ir
    engine, module = _compile_ir(ir)
    try:
        # Test classify_number with all match arms
        c0 = _invoke(engine, "classify_number", ctypes.c_double, (ctypes.c_double,), 0.0)
        assert c0 == pytest.approx(11.0), "Value 0 should return 10 + 1 = 11"

        c1 = _invoke(engine, "classify_number", ctypes.c_double, (ctypes.c_double,), 1.0)
        assert c1 == pytest.approx(22.0), "Value 1 should return 20 + 2 = 22"

        c2 = _invoke(engine, "classify_number", ctypes.c_double, (ctypes.c_double,), 2.0)
        assert c2 == pytest.approx(33.0), "Value 2 should return 30 + 3 = 33"

        c3 = _invoke(engine, "classify_number", ctypes.c_double, (ctypes.c_double,), 99.0)
        assert c3 == pytest.approx(44.0), "Default case should return 40 + 4 = 44"

        # Test partial_match_mutations where different locals are mutated in each arm
        p0 = _invoke(engine, "partial_match_mutations", ctypes.c_double, (ctypes.c_double,), 0.0)
        assert p0 == pytest.approx(105.0), "Value 0 should return 100 + 5 + 0 + 0 = 105"

        p1 = _invoke(engine, "partial_match_mutations", ctypes.c_double, (ctypes.c_double,), 1.0)
        assert p1 == pytest.approx(210.0), "Value 1 should return 200 + 0 + 10 + 0 = 210"

        p2 = _invoke(engine, "partial_match_mutations", ctypes.c_double, (ctypes.c_double,), 2.0)
        assert p2 == pytest.approx(315.0), "Value 2 should return 300 + 0 + 0 + 15 = 315"

        p3 = _invoke(engine, "partial_match_mutations", ctypes.c_double, (ctypes.c_double,), 99.0)
        assert p3 == pytest.approx(400.0), "Default case should return 400 + 0 + 0 + 0 = 400"

        # Test main to ensure all paths work together
        main_result = _invoke_double(engine, "main")
        # c0=11, c1=22, c2=33, c3=44, p0=105, p1=210, p2=315, p3=400
        # 11 + 22 + 33 + 44 + 105 + 210 + 315 + 400 = 1140
        assert main_result == pytest.approx(1140.0), "Main should return sum of all results = 1140"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)
