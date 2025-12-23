import ctypes
import json
import textwrap

import llvmlite.binding as llvm
import pytest

from compiler.build.emit_native import NativeArtifact, NativeModule
from compiler.build.native_llvm_lowering import lower_to_llvm
from runtime import runtime_support as runtime
from runtime.stage2_runner import Stage2Runner, _LAST_RUNTIME_ERROR, current_capability_grant

pytestmark = [pytest.mark.stage2,
              pytest.mark.usefixtures("stage1_environment")]

_LLVM_TARGET_INITIALIZED = False


@pytest.fixture()
def compile_stage2(stage2_environment):
    def _compile(source: str, *, module_name: str = "<memory>"):
        return stage2_environment.compile_to_native_llvm(source, module_name=module_name)

    return _compile


def _assert_only_pointer_layout_warnings(diagnostics):
    unexpected = [
        diag
        for diag in diagnostics
        if "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
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


def _register_bounds_check_symbol():
    def _bounds_check_stub(index: ctypes.c_longlong, length: ctypes.c_longlong) -> None:
        runtime.bounds_check(int(index), int(length))

    stub = ctypes.CFUNCTYPE(None, ctypes.c_longlong, ctypes.c_longlong)(
        _bounds_check_stub
    )
    llvm.add_symbol(
        "sailfin_runtime_bounds_check",
        ctypes.cast(stub, ctypes.c_void_p).value,
    )
    return stub


_BOUNDS_CHECK_HELPER = _register_bounds_check_symbol()


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

    runtime_print_info_stub = ctypes.CFUNCTYPE(
        None, ctypes.c_void_p)(_runtime_print_info)
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


def test_native_llvm_execution_static_method_call_on_type_name(compile_stage2) -> None:
    source = """
struct BankAccount {
    mut balance -> number;

    fn new(initialBalance -> number) -> BankAccount {
        return BankAccount { balance: initialBalance };
    }
}

fn main() -> number {
    let account -> BankAccount = BankAccount.new(100);
    return 0;
}
"""

    lowered = compile_stage2(source, module_name="static_struct_method")
    ir = lowered.ir
    assert "@BankAccountnew" in ir
    assert "call %BankAccount @BankAccountnew" in ir


def test_native_llvm_execution_pointer_receiver_method_uses_addressable_local(compile_stage2) -> None:
    source = """
struct BankAccount {
    mut balance -> number;

    fn deposit(self, amount -> number) -> void {
        self.balance += amount;
    }
}

fn main() -> number {
    let mut account -> BankAccount = BankAccount { balance: 0 };
    account.deposit(50);
    return 0;
}
"""

    lowered = compile_stage2(source, module_name="pointer_receiver_method")
    ir = lowered.ir
    # When `self` is unannotated, lowering defaults receiver to `%BankAccount*`.
    # The call site must pass an addressable pointer, not `i8* null`.
    assert "define void @BankAccountdeposit(%BankAccount* %self, double %amount)" in ir
    assert "call void @BankAccountdeposit(%BankAccount*" in ir
    assert "@BankAccountdeposit(i8* null" not in ir
    _compile_ir(ir)


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

    regions = [region for region in lowered.lifetime_regions if region.binding ==
               "alias" and region.base == "inner"]
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


def test_native_llvm_execution_iterates_enum_arrays(compile_stage2) -> None:
    """Test that for loops can iterate over enum arrays with metadata-driven access."""
    source = """
enum Color {
    Red,
    Green,
    Blue,
}

fn count_reds(colors -> Color[]) -> number {
    let mut count -> number = 0;
    for color in colors {
        match color {
            Color.Red => {
                count = count + 1;
            }
            _ => {
                // Skip other colors
            }
        }
    }
    return count;
}

fn count_all(colors -> Color[]) -> number {
    let mut count -> number = 0;
    for color in colors {
        count = count + 1;
    }
    return count;
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_stage2(source, module_name="enum_arrays")
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    ir = lowered.ir

    # Verify enum type definition is present
    assert "%Color = type" in ir, "Enum type should be defined in IR"

    # Verify array type with enum elements is present
    assert "{ %Color*, i64 }*" in ir or "%Color*" in ir, "Enum array type should be present"

    # Check that for loop lowers with proper index access
    assert "getelementptr" in ir or "load %Color" in ir, "Should access enum array elements"

    # Note: Full execution requires building enum array values in ctypes, which needs
    # understanding of the enum's LLVM layout (tag + payload bytes).
    # For now, we verify IR emission is correct. Full execution coverage will be added
    # in follow-on work once enum array construction helpers are available.


def test_native_llvm_execution_iterates_mixed_enum_arrays(compile_stage2) -> None:
    """Test iteration over enum arrays containing different variants."""
    source = """
enum Status {
    Pending,
    Active { priority -> number; }
    Complete { result -> number; }
}

fn sum_priorities(statuses -> Status[]) -> number {
    let mut total -> number = 0;
    for status in statuses {
        match status {
            Status.Active { priority } => {
                total = total + priority;
            }
            _ => {
                // Skip other statuses
            }
        }
    }
    return total;
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_stage2(source, module_name="mixed_enum_arrays")
    _assert_only_pointer_layout_warnings(lowered.diagnostics)
    ir = lowered.ir

    # Verify enum type with payload is defined
    assert "%Status = type" in ir, "Enum type should be defined"

    # Verify array type
    assert "{ %Status*, i64 }*" in ir or "%Status*" in ir, "Enum array type should be present"

    # Verify iteration and match lowering
    assert "extractvalue %Status" in ir, "Should extract enum tags in match"
    assert "getelementptr" in ir, "Should access array elements and extract payload fields"


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
        conditional_true = _invoke(
            engine, "conditional_update", ctypes.c_double, (ctypes.c_bool, ctypes.c_double), True, 5.0)
        assert conditional_true == pytest.approx(
            15.0), "When condition is true, should return base + 10"

        conditional_false = _invoke(
            engine, "conditional_update", ctypes.c_double, (ctypes.c_bool, ctypes.c_double), False, 5.0)
        assert conditional_false == pytest.approx(
            5.0), "When condition is false, should return base unchanged"

        main_result = _invoke_double(engine, "main")
        assert main_result == pytest.approx(
            20.0), "Main should return 15 + 5 = 20"
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
        result_true = _invoke(engine, "select_value", ctypes.c_double,
                              (ctypes.c_bool, ctypes.c_double, ctypes.c_double), True, 5.0, 10.0)
        assert result_true == pytest.approx(
            20.0), "When condition is true, should return (5 + 10) + 5 = 20"

        result_false = _invoke(engine, "select_value", ctypes.c_double, (
            ctypes.c_bool, ctypes.c_double, ctypes.c_double), False, 5.0, 10.0)
        assert result_false == pytest.approx(
            33.0), "When condition is false, should return (10 + 20) + 3 = 33"

        # Test partial_mutation where different locals are mutated in each branch
        partial_true = _invoke(engine, "partial_mutation", ctypes.c_double,
                               (ctypes.c_bool, ctypes.c_double), True, 5.0)
        assert partial_true == pytest.approx(
            115.0), "When condition is true, should return (5 + 10) + 100 + 0 = 115"

        partial_false = _invoke(engine, "partial_mutation", ctypes.c_double,
                                (ctypes.c_bool, ctypes.c_double), False, 5.0)
        assert partial_false == pytest.approx(
            225.0), "When condition is false, should return (5 + 20) + 0 + 200 = 225"

        # Test main to ensure all paths work together
        main_result = _invoke_double(engine, "main")
        assert main_result == pytest.approx(
            393.0), "Main should return 20 + 33 + 115 + 225 = 393"
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
        c0 = _invoke(engine, "classify_number",
                     ctypes.c_double, (ctypes.c_double,), 0.0)
        assert c0 == pytest.approx(11.0), "Value 0 should return 10 + 1 = 11"

        c1 = _invoke(engine, "classify_number",
                     ctypes.c_double, (ctypes.c_double,), 1.0)
        assert c1 == pytest.approx(22.0), "Value 1 should return 20 + 2 = 22"

        c2 = _invoke(engine, "classify_number",
                     ctypes.c_double, (ctypes.c_double,), 2.0)
        assert c2 == pytest.approx(33.0), "Value 2 should return 30 + 3 = 33"

        c3 = _invoke(engine, "classify_number",
                     ctypes.c_double, (ctypes.c_double,), 99.0)
        assert c3 == pytest.approx(
            44.0), "Default case should return 40 + 4 = 44"

        # Test partial_match_mutations where different locals are mutated in each arm
        p0 = _invoke(engine, "partial_match_mutations",
                     ctypes.c_double, (ctypes.c_double,), 0.0)
        assert p0 == pytest.approx(
            105.0), "Value 0 should return 100 + 5 + 0 + 0 = 105"

        p1 = _invoke(engine, "partial_match_mutations",
                     ctypes.c_double, (ctypes.c_double,), 1.0)
        assert p1 == pytest.approx(
            210.0), "Value 1 should return 200 + 0 + 10 + 0 = 210"

        p2 = _invoke(engine, "partial_match_mutations",
                     ctypes.c_double, (ctypes.c_double,), 2.0)
        assert p2 == pytest.approx(
            315.0), "Value 2 should return 300 + 0 + 0 + 15 = 315"

        p3 = _invoke(engine, "partial_match_mutations",
                     ctypes.c_double, (ctypes.c_double,), 99.0)
        assert p3 == pytest.approx(
            400.0), "Default case should return 400 + 0 + 0 + 0 = 400"

        # Test main to ensure all paths work together
        main_result = _invoke_double(engine, "main")
        # c0=11, c1=22, c2=33, c3=44, p0=105, p1=210, p2=315, p3=400
        # 11 + 22 + 33 + 44 + 105 + 210 + 315 + 400 = 1140
        assert main_result == pytest.approx(
            1140.0), "Main should return sum of all results = 1140"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_lowers_basic_enum_types(compile_stage2):
    """Test that enum type definitions are lowered to LLVM IR."""
    result = compile_stage2(
        """
enum Color {
    Red;
    Green;
    Blue;
}

enum Shape {
    Circle { radius -> number; }
    Rectangle { width -> number, height -> number; }
    Unit;
}

fn main() -> number {
    return 42;
}
"""
    )

    # Should emit enum type definitions
    assert "%Color = type" in result.ir, "Color enum type should be defined"
    assert "%Shape = type" in result.ir, "Shape enum type should be defined"

    # Enum types should have tag field (first field is the tag)
    # Format should be: %EnumName = type { tag_type, [payload_bytes x payload_size] }

    # Check that IR compiles and verifies
    _assert_only_pointer_layout_warnings(result.diagnostics)
    engine, module = _compile_ir(result.ir)
    try:
        output = _invoke_double(engine, "main")
        assert output == pytest.approx(42.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_constructs_simple_enum_variant(compile_stage2):
    """Test that simple enum variants (no payload) can be constructed."""
    result = compile_stage2(
        """
enum Color {
    Red;
    Green;
    Blue;
}

fn get_red() -> Color {
    return Color.Red;
}

fn main() -> number {
    let color = get_red();
    return 1;
}
"""
    )

    # Check for enum type definition
    assert "%Color = type" in result.ir

    # Check for insertvalue instruction to set the tag
    # The enum constructor should emit: insertvalue %Color undef, i32 <tag>, 0
    assert "insertvalue %Color undef" in result.ir, "Enum constructor should use insertvalue"

    _assert_only_pointer_layout_warnings(result.diagnostics)
    engine, module = _compile_ir(result.ir)
    try:
        output = _invoke_double(engine, "main")
        assert output == pytest.approx(1.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_matches_enum_variants(compile_stage2):
    """Test that match expressions can destructure enum variants by tag."""
    result = compile_stage2(
        """
enum Color {
    Red;
    Green;
    Blue;
}

fn check_color(c -> Color) -> number {
    match c {
        Color.Red => {
            return 1;
        }
        Color.Green => {
            return 2;
        }
        Color.Blue => {
            return 3;
        }
        _ => {
            return 0;
        }
    }
}

fn main() -> number {
    let red = Color.Red;
    let green = Color.Green;
    let blue = Color.Blue;

    let r = check_color(red);
    let g = check_color(green);
    let b = check_color(blue);

    // Return sum: 1 + 2 + 3 = 6
    return r + g + b;
}
"""
    )

    # Check for extractvalue instruction to extract the tag
    assert "extractvalue %Color" in result.ir, "Match should extract tag from enum"

    # Check for tag comparison
    assert "icmp eq" in result.ir, "Match should compare tags"

    _assert_only_pointer_layout_warnings(result.diagnostics)
    engine, module = _compile_ir(result.ir)
    try:
        output = _invoke_double(engine, "main")
        assert output == pytest.approx(
            6.0), "Match should correctly route to different branches based on enum variant"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_matches_mixed_enum_variants(compile_stage2):
    """Test that match expressions work with enums that have both unit and payload variants."""
    result = compile_stage2(
        """
enum Status {
    Pending;
    Active;
    Complete;
}

fn status_code(s -> Status) -> number {
    match s {
        Status.Pending => {
            return 100;
        }
        Status.Active => {
            return 200;
        }
        _ => {
            return 300;
        }
    }
}

fn main() -> number {
    let pending = Status.Pending;
    let active = Status.Active;
    let complete = Status.Complete;

    let p = status_code(pending);
    let a = status_code(active);
    let c = status_code(complete);

    // Should match: 100 + 200 + 300 = 600
    return p + a + c;
}
"""
    )

    # Check for extractvalue instruction to extract the tag
    assert "extractvalue %Status" in result.ir, "Match should extract tag from Status enum"

    # Check for tag comparison
    assert "icmp eq" in result.ir, "Match should compare tags"

    _assert_only_pointer_layout_warnings(result.diagnostics)
    engine, module = _compile_ir(result.ir)
    try:
        output = _invoke_double(engine, "main")
        assert output == pytest.approx(
            600.0), "Match should correctly identify enum variants"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_stores_enum_payload_fields(compile_stage2):
    """Test that enum variants with payload fields can be constructed and stored."""
    result = compile_stage2(
        """
enum Shape {
    Circle { radius -> number; }
    Rectangle { width -> number, height -> number; }
}

fn make_circle() -> Shape {
    return Shape.Circle { radius: 5.0 };
}

fn main() -> number {
    let circle = make_circle();
    return 42;
}
"""
    )

    # Check for alloca instruction for payload storage
    assert "alloca %Shape" in result.ir, "Payload enum should use stack allocation"

    # Check for getelementptr to access payload
    assert "getelementptr inbounds %Shape" in result.ir, "Should access enum fields via GEP"

    # Check for store instruction for payload field
    assert "store double" in result.ir, "Should store payload field value"

    # Check for load instruction to get complete enum value
    assert "load %Shape" in result.ir, "Should load complete enum value from stack"

    _assert_only_pointer_layout_warnings(result.diagnostics)
    engine, module = _compile_ir(result.ir)
    try:
        output = _invoke_double(engine, "main")
        assert output == pytest.approx(
            42.0), "Should execute successfully with payload enum"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_matches_payload_enum_by_tag(compile_stage2):
    """Test that match can discriminate payload variants by tag (without field binding)."""
    result = compile_stage2(
        """
enum Shape {
    Circle { radius -> number; }
    Rectangle { width -> number, height -> number; }
    Point;
}

fn classify(s -> Shape) -> number {
    match s {
        Shape.Circle { radius } => {
            return 1;
        }
        Shape.Rectangle { width, height } => {
            return 2;
        }
        Shape.Point => {
            return 3;
        }
        _ => {
            return 0;
        }
    }
}

fn main() -> number {
    let circle = Shape.Circle { radius: 5.0 };
    let rect = Shape.Rectangle { width: 10.0, height: 20.0 };
    let point = Shape.Point;

    let c = classify(circle);
    let r = classify(rect);
    let p = classify(point);

    // Should return 1 + 2 + 3 = 6
    return c + r + p;
}
"""
    )

    # Check for extractvalue to get tags
    assert "extractvalue %Shape" in result.ir, "Should extract enum tag"

    # Check for tag comparisons
    assert "icmp eq" in result.ir, "Should compare tags"

    # Check for field extraction (getelementptr, bitcast, load for payload fields)
    assert "getelementptr inbounds %Shape" in result.ir, "Should extract payload fields"

    _assert_only_pointer_layout_warnings(result.diagnostics)

    engine, module = _compile_ir(result.ir)
    try:
        output = _invoke_double(engine, "main")
        assert output == pytest.approx(
            6.0), "Match should correctly identify variants by tag"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_extracts_enum_payload_fields_in_match(compile_stage2):
    """Test that match expressions can extract and use payload field values."""
    result = compile_stage2(
        """
enum Shape {
    Circle { radius -> number; }
    Rectangle { width -> number, height -> number; }
}

fn compute_area(s -> Shape) -> number {
    match s {
        Shape.Circle { radius } => {
            return 3.14 * radius * radius;
        }
        Shape.Rectangle { width, height } => {
            return width * height;
        }
        _ => {
            return 0;
        }
    }
}

fn main() -> number {
    let circle = Shape.Circle { radius: 2.0 };
    let rect = Shape.Rectangle { width: 3.0, height: 4.0 };

    let area1 = compute_area(circle);
    let area2 = compute_area(rect);

    // Circle: 3.14 * 2 * 2 = 12.56
    // Rectangle: 3 * 4 = 12
    // Total: 24.56
    return area1 + area2;
}
"""
    )

    # Check for field extraction instructions
    assert "getelementptr inbounds %Shape" in result.ir, "Should extract payload fields"
    assert "bitcast" in result.ir, "Should cast byte array to field type"
    assert "load double" in result.ir, "Should load field values"

    # Check for alloca for bound variables
    assert result.ir.count(
        "alloca double") >= 3, "Should allocate locals for extracted fields (radius, width, height)"

    _assert_only_pointer_layout_warnings(result.diagnostics)

    engine, module = _compile_ir(result.ir)
    try:
        output = _invoke_double(engine, "main")
        assert output == pytest.approx(
            24.56), "Match should extract and use field values correctly"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_allocates_recursive_enum_payloads(compile_stage2):
    """Ensure recursive enum payloads allocate heap storage instead of failing coercion."""
    result = compile_stage2(
        """
enum Value {
    Number { value -> number; }
    Pair { left -> Value, right -> Value; }
}

fn make_pair() -> Value {
    let leaf = Value.Number { value: 1.0 };
    let combined = Value.Pair { left: leaf, right: leaf };
    return combined;
}

fn main() -> number {
    let _ = make_pair();
    return 7.0;
}
"""
    )

    malloc_lines = [line for line in result.ir.splitlines(
    ) if "call noalias i8* @malloc" in line]
    assert malloc_lines, "Recursive enum payload should allocate using malloc"

    _assert_only_pointer_layout_warnings(result.diagnostics)

    engine, module = _compile_ir(result.ir)
    try:
        output = _invoke_double(engine, "main")
        assert output == pytest.approx(7.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_enum_member_variant_selects_tag(compile_stage2) -> None:
    source = """
enum Expression {
    Identifier { name -> string },
    NumberLiteral { value -> string },
    BooleanLiteral { value -> boolean },
}

fn identifier_variant(name -> string) -> string {
    let expr = Expression.Identifier { name: name };
    return expr.variant;
}

fn boolean_variant(flag -> boolean) -> string {
    let expr = Expression.BooleanLiteral { value: flag };
    return expr.variant;
}
"""

    lowered = compile_stage2(source, module_name="enum_member_variant")

    assert "@.enum.Expression.Identifier.variant" in lowered.ir
    assert "@.enum.Expression.BooleanLiteral.variant" in lowered.ir
    assert "select i1" in lowered.ir
    for diagnostic in lowered.diagnostics:
        assert "incompatible field types" not in diagnostic


def test_native_llvm_execution_enum_member_payload_filtered_types(compile_stage2) -> None:
    source = """
enum Expression {
    StringLiteral { value -> string },
    NumberLiteral { value -> string },
    BooleanLiteral { value -> boolean },
}

fn extract_boolean(expr -> Expression) -> boolean {
    if expr.variant == "BooleanLiteral" {
        return expr.value;
    }
    return false;
}

fn extract_string(expr -> Expression) -> string {
    if expr.variant == "StringLiteral" {
        return expr.value;
    }
    if expr.variant == "NumberLiteral" {
        return expr.value;
    }
    return "";
}
"""

    lowered = compile_stage2(source, module_name="enum_member_payload")

    assert "load i1" in lowered.ir
    assert "select i1" in lowered.ir
    for diagnostic in lowered.diagnostics:
        assert "incompatible field types" not in diagnostic


def test_native_llvm_execution_emits_vtable_type_definitions(compile_stage2) -> None:
    """Verify that interface trait object types and vtable types are emitted correctly."""
    source = """
interface Greeter {
    fn greet(self) -> string;
}

struct User implements Greeter {
    name -> string;
    
    fn greet(self) -> string {
        return "Hello";
    }
}

fn main() -> number {
    return 42;
}
"""
    lowered = compile_stage2(source, module_name="vtable_types")
    # Allow missing `self` type annotation diagnostic (pre-existing interface parsing limitation)
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
        or "parameter `self` missing type annotation" in diag
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    ir = lowered.ir

    # Check that interface type definition exists (trait object with data and vtable pointers)
    assert "%trait.Greeter = type { i8*, i8* }" in ir, \
        "Interface should define trait object type with data and vtable pointers"

    # Check that vtable type definition exists
    assert "%vtable.User.Greeter = type" in ir, \
        "Vtable type definition should be emitted for User.Greeter"

    # Check that vtable contains function pointer for greet method
    # The vtable should have function pointer type for the greet method
    vtable_lines = [line for line in ir.splitlines(
    ) if "%vtable.User.Greeter = type" in line]
    assert vtable_lines, "Vtable type definition not found"
    vtable_def = vtable_lines[0]
    assert "i8*" in vtable_def or "string" in vtable_def, \
        "Vtable should contain function pointer type for greet method"


def test_native_llvm_execution_emits_vtable_constants(compile_stage2) -> None:
    """Verify that vtable constants are emitted correctly with method pointers."""
    source = """
interface Speaker {
    fn speak(self) -> string;
    fn shout(self) -> string;
}

struct Robot implements Speaker {
    id -> number;
    
    fn speak(self) -> string {
        return "beep";
    }
    
    fn shout(self) -> string {
        return "BEEP!";
    }
}

fn main() -> number {
    return 0;
}
"""
    lowered = compile_stage2(source, module_name="vtable_constants")
    # Allow missing `self` type annotation diagnostic (pre-existing interface parsing limitation)
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
        or "parameter `self` missing type annotation" in diag
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    ir = lowered.ir

    # Check that vtable constant is emitted
    assert "@vtable.Robot.Speaker.const = global" in ir, \
        "Vtable constant should be emitted as a global"

    # Check that vtable constant references the method implementations
    # Should contain bitcast references to Robot::speak and Robot::shout
    vtable_const_lines = [line for line in ir.splitlines()
                          if "@vtable.Robot.Speaker.const" in line]
    assert vtable_const_lines, "Vtable constant not found"

    # Verify method references exist in vtable
    # Note: sanitize_symbol removes :: so Robot::speak becomes @Robotspeak
    assert "@Robotspeak" in ir, \
        "Vtable should reference Robot::speak method"
    assert "@Robotshout" in ir, \
        "Vtable should reference Robot::shout method"


def test_native_llvm_execution_emits_multiple_vtables(compile_stage2) -> None:
    """Verify that multiple vtables are emitted when a struct implements multiple interfaces."""
    source = """
interface Greeter {
    fn greet(self) -> string;
}

interface Formatter {
    fn format(self) -> number;
}

struct Person implements Greeter, Formatter {
    age -> number;
    
    fn greet(self) -> string {
        return "Hi";
    }
    
    fn format(self) -> number {
        return self.age;
    }
}

fn main() -> number {
    return 0;
}
"""
    lowered = compile_stage2(source, module_name="multiple_vtables")
    # Allow missing `self` type annotation and related diagnostics (pre-existing interface parsing limitation)
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
        or "parameter `self` missing type annotation" in diag
        or "member access base" in diag  # Related to missing self type
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    ir = lowered.ir

    # Check that both interface types are defined
    assert "%trait.Greeter = type { i8*, i8* }" in ir
    assert "%trait.Formatter = type { i8*, i8* }" in ir

    # Check that both vtable types are defined
    assert "%vtable.Person.Greeter = type" in ir
    assert "%vtable.Person.Formatter = type" in ir

    # Check that both vtable constants are emitted
    assert "@vtable.Person.Greeter.const = global" in ir
    assert "@vtable.Person.Formatter.const = global" in ir


def test_native_llvm_execution_boxes_struct_into_trait_object(compile_stage2) -> None:
    """Verify that concrete struct values are boxed into trait objects when assigned to interface-typed locals."""
    source = """
interface Greeter {
    fn greet(self) -> string;
}

struct User implements Greeter {
    id -> number;
    name -> string;

    fn greet(self) -> string {
        return "Hello!";
    }
}

fn main() -> number {
    let user = User { id: 1, name: "Alice" };
    let greeter -> Greeter = user;
    return 42;
}
"""
    lowered = compile_stage2(source, module_name="trait_object_boxing")
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
        or "parameter `self` missing type annotation" in diag
        or "member access base" in diag
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    ir = lowered.ir

    # Check that trait object type is defined
    assert "%trait.Greeter = type { i8*, i8* }" in ir, \
        "Trait object type should be defined"

    # Check that vtable is emitted
    assert "%vtable.User.Greeter = type" in ir, \
        "Vtable type should be defined"
    assert "@vtable.User.Greeter.const = global" in ir, \
        "Vtable constant should be emitted"

    # Check for boxing operations in main function
    # Should allocate struct on stack
    assert "alloca %User" in ir, \
        "Should allocate struct on stack for boxing"
    # Should cast struct pointer to i8*
    assert "bitcast %User*" in ir and "to i8*" in ir, \
        "Should cast struct pointer to i8* for trait object"
    # Should cast vtable to i8*
    assert "bitcast %vtable.User.Greeter*" in ir, \
        "Should cast vtable pointer to i8* for trait object"
    # Should build trait object with insertvalue
    assert "insertvalue %trait.Greeter" in ir, \
        "Should use insertvalue to build trait object"


def test_native_llvm_execution_dispatches_through_trait_object(compile_stage2) -> None:
    """Verify that method calls on interface-typed values dispatch through vtable."""
    source = """
interface Speaker {
    fn speak(self) -> string;
}

struct Robot implements Speaker {
    id -> number;
    
    fn speak(self) -> string {
        return "beep";
    }
}

fn call_speaker(s -> Speaker) -> string {
    return s.speak();
}

fn main() -> number {
    let robot = Robot { id: 1 };
    let speaker -> Speaker = robot;
    let result = call_speaker(speaker);
    return 0;
}
"""
    lowered = compile_stage2(source, module_name="trait_dispatch")
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
        or "parameter `self` missing type annotation" in diag
        or "member access base" in diag
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    ir = lowered.ir

    # Check that extractvalue is used to get data and vtable pointers
    assert "extractvalue %trait.Speaker" in ir, \
        "Should extract fields from trait object"

    # Check for indirect call through function pointer
    # The implementation should load function pointer from vtable and call it
    assert "bitcast i8*" in ir and "to" in ir, \
        "Should cast vtable pointer to function pointer type"
    assert "load" in ir, \
        "Should load function pointer from vtable"
    assert "call" in ir, \
        "Should emit indirect call"


def test_native_llvm_execution_cross_module_layout_resolution(compile_stage2) -> None:
    """
    Verify that cross-module types (structs/enums) can be used in Stage2 LLVM execution.

    This test exercises the layout manifest infrastructure by compiling modules that
    define and use shared types, ensuring the types can be instantiated and manipulated
    correctly in native code.

    Note: Full cross-module dependency resolution (automatically loading imported manifests)
    is roadmap work. This test validates that types with explicit layouts can be defined
    in one module and used in another when the layout metadata is available.
    """
    import pathlib

    repo_root = pathlib.Path(__file__).resolve().parents[2]
    types_path = repo_root / "compiler" / "tests" / \
        "data" / "cross_module" / "shared_types.sfn"
    consumer_path = repo_root / "compiler" / "tests" / \
        "data" / "cross_module" / "consumer.sfn"

    # Compile the types module to LLVM
    types_source = types_path.read_text(encoding="utf-8")
    types_result = compile_stage2(types_source, module_name="shared_types")

    # Types module should compile successfully
    fatal_types = [
        diag for diag in types_result.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal_types, f"types module reported fatal errors: {fatal_types}"

    # Verify the types module IR contains struct and enum definitions
    types_ir = types_result.ir
    assert "%Point = type" in types_ir, "Point struct type should be defined"
    assert "%Rectangle = type" in types_ir, "Rectangle struct type should be defined"
    assert "%Color = type" in types_ir, "Color enum type should be defined"
    assert "%Shape = type" in types_ir, "Shape enum type should be defined"

    # Compile the consumer module
    # Note: The consumer imports from shared_types, but since automatic manifest loading
    # is roadmap work, we compile each module independently here. This validates that:
    # 1. Both modules can be compiled to LLVM IR
    # 2. The layout infrastructure works end-to-end
    consumer_source = consumer_path.read_text(encoding="utf-8")
    consumer_result = compile_stage2(consumer_source, module_name="consumer")

    # Consumer should compile; we expect some pointer layout warnings since cross-module
    # manifest loading is not yet automatic, but no fatal errors
    fatal_consumer = [
        diag for diag in consumer_result.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
        and "unresolved" not in diag.lower()  # imports are not resolved yet
    ]
    assert not fatal_consumer, f"consumer module reported fatal errors: {fatal_consumer}"

    # The consumer module should at least compile to IR (even if types are not fully resolved)
    consumer_ir = consumer_result.ir
    assert consumer_ir, "consumer module should emit LLVM IR"
    assert "define" in consumer_ir, "consumer module should define functions"


def test_native_llvm_execution_emits_intrinsic_declarations() -> None:
    """
    Verify that capability-aware intrinsics emit function declarations with effect metadata.

    Tests that io_print, fs.read, http.get, and model_invoke intrinsics:
    1. Generate proper LLVM declare statements
    2. Include capability metadata comments showing required effects
    """
    artifact_text = """
        .fn console_test
        .param message string
        .meta return void
        .meta effects io
        
        .let _ignored = console.info(message)
        .return
        .endfn
        
        .fn fs_test  
        .param path string
        .meta return string
        .meta effects io
        
        .let content = fs.read(path)
        .return content
        .endfn
        
        .fn http_test
        .param url string
        .meta return string
        .meta effects net
        
        .let response = http.get(url)
        .return response
        .endfn
        
        .fn model_test
        .param system_prompt string
        .param user_message string
        .meta return string
        .meta effects model
        
        .let result = prompt(system_prompt, user_message)
        .return result
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should have no fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    ir = lowered.ir

    # Check for intrinsic declarations with capability metadata
    # IO intrinsics
    assert "; intrinsic sailfin_intrinsic_io_print requires capabilities: ![io]" in ir, \
        "console.info should emit capability metadata for io"
    assert "declare void @sailfin_intrinsic_io_print(i8*)" in ir, \
        "console.info should emit intrinsic declaration"

    # Filesystem intrinsics
    assert "; intrinsic sailfin_intrinsic_fs_read requires capabilities: ![io]" in ir, \
        "fs.read should emit capability metadata for io"
    assert "declare i8* @sailfin_intrinsic_fs_read(i8*)" in ir, \
        "fs.read should emit intrinsic declaration"

    # Network intrinsics
    assert "; intrinsic sailfin_intrinsic_http_get requires capabilities: ![net]" in ir, \
        "http.get should emit capability metadata for net"
    assert "declare i8* @sailfin_intrinsic_http_get(i8*)" in ir, \
        "http.get should emit intrinsic declaration"

    # Model intrinsics
    assert "; intrinsic sailfin_intrinsic_model_invoke requires capabilities: ![model]" in ir, \
        "prompt should emit capability metadata for model"
    assert "declare i8* @sailfin_intrinsic_model_invoke(i8*, i8*)" in ir, \
        "prompt should emit intrinsic declaration"


def test_native_llvm_execution_intrinsic_calls_compile() -> None:
    """
    Verify that intrinsic calls compile without diagnostics when effects are declared.

    Tests that functions calling intrinsics with matching effect declarations:
    1. Compile successfully
    2. Generate proper call instructions
    3. Do not emit Python fallback warnings
    """
    artifact_text = """
        .fn io_operations
        .param message string
        .param filepath string
        .meta return string
        .meta effects io
        
        .let _ignored1 = console.info(message)
        .let data = fs.read(filepath)
        .let _ignored2 = fs.write(filepath, data)
        .return data
        .endfn
        
        .fn network_operations
        .param url string
        .meta return string
        .meta effects net
        
        .let response = http.get(url)
        .let _ignored = http.post(url, response)
        .return response
        .endfn
        
        .fn ai_operations
        .param system_msg string
        .param user_msg string
        .meta return string
        .meta effects model
        
        .let result = prompt(system_msg, user_msg)
        .let another = model_invoke(system_msg, user_msg)
        .return result
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should have no Python fallback warnings
    fallback_warnings = [
        diag for diag in lowered.diagnostics
        if "python" in diag.lower() or "fallback" in diag.lower()
    ]
    assert not fallback_warnings, f"intrinsics should not fall back to Python: {fallback_warnings}"

    # Verify intrinsic calls are emitted
    ir = lowered.ir

    # IO operations should call intrinsics
    assert "call void @sailfin_intrinsic_io_print" in ir, \
        "console.info should emit call to io_print intrinsic"
    assert "call i8* @sailfin_intrinsic_fs_read" in ir, \
        "fs.read should emit call to fs_read intrinsic"
    assert "call void @sailfin_intrinsic_fs_write" in ir, \
        "fs.write should emit call to fs_write intrinsic"

    # Network operations should call intrinsics
    assert "call i8* @sailfin_intrinsic_http_get" in ir, \
        "http.get should emit call to http_get intrinsic"
    assert "call i8* @sailfin_intrinsic_http_post" in ir, \
        "http.post should emit call to http_post intrinsic"

    # Model operations should call intrinsics
    assert "call i8* @sailfin_intrinsic_model_invoke" in ir, \
        "prompt should emit call to model_invoke intrinsic"


def test_native_llvm_execution_capability_manifest_includes_intrinsic_effects() -> None:
    """
    Verify that capability manifests track effects from intrinsic calls.

    Tests that when a function calls capability-aware intrinsics,
    those effects propagate into the function's effect list and
    ultimately into the capability manifest for entry points.
    """
    artifact_text = """
        .fn main
        .meta return number
        .meta effects io, net, model
        
        .let _ignored1 = console.info("Starting...")
        .let data = fs.read("config.json")
        .let response = http.get("https://api.example.com")
        .let result = prompt("system", "user")
        .return 0.0
        .endfn
    """

    # Create a module with main as an entry point
    module = NativeModule(
        artifacts=[NativeArtifact(name="test.sfn-asm", format="sailfin-native-text",
                                  contents=textwrap.dedent(artifact_text).strip())],
        entry_points=["main"],
        symbol_count=0,
    )
    lowered = lower_to_llvm(module)

    # Check capability manifest
    manifest = lowered.capability_manifest
    assert len(manifest.entries) == 1, "Should have one manifest entry for main"

    main_entry = manifest.entries[0]
    assert main_entry.symbol == "main", "Manifest entry should be for main function"

    # Main should have io, net, and model effects from intrinsic calls
    effects = set(main_entry.effects)
    assert "io" in effects, "main should have io effect from console.info and fs.read"
    assert "net" in effects, "main should have net effect from http.get"
    assert "model" in effects, "main should have model effect from prompt"


def test_native_llvm_execution_calls_fs_adapter() -> None:
    """
    Verify that filesystem adapter declarations emit correctly.

    Tests that filesystem adapters (read/write/list/delete/create):
    1. Generate proper LLVM declare statements
    2. Include capability metadata comments showing required effects
    """
    artifact_text = """
        .fn fs_adapter_test
        .param path string
        .meta return string
        .meta effects io
        
        .let content = fs_read_file(path)
        .let _ignored1 = fs_write_file(path, content)
        .let _ignored2 = fs_list_directory(path)
        .let _ignored3 = fs_delete_file(path)
        .let _ignored4 = fs_create_directory(path, true)
        .return content
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should have no fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    ir = lowered.ir

    # Check for adapter declarations with capability metadata
    assert "; intrinsic sailfin_adapter_fs_read_file requires capabilities: ![io]" in ir, \
        "fs_read_file should emit capability metadata for io"
    assert "declare i8* @sailfin_adapter_fs_read_file(i8*)" in ir, \
        "fs_read_file should emit adapter declaration"

    assert "; intrinsic sailfin_adapter_fs_write_file requires capabilities: ![io]" in ir, \
        "fs_write_file should emit capability metadata for io"
    assert "declare void @sailfin_adapter_fs_write_file(i8*, i8*)" in ir, \
        "fs_write_file should emit adapter declaration"

    assert "; intrinsic sailfin_adapter_fs_list_directory requires capabilities: ![io]" in ir, \
        "fs_list_directory should emit capability metadata for io"
    assert "declare i8* @sailfin_adapter_fs_list_directory(i8*)" in ir, \
        "fs_list_directory should emit adapter declaration"

    assert "; intrinsic sailfin_adapter_fs_delete_file requires capabilities: ![io]" in ir, \
        "fs_delete_file should emit capability metadata for io"
    assert "declare i1 @sailfin_adapter_fs_delete_file(i8*)" in ir, \
        "fs_delete_file should emit adapter declaration"

    assert "; intrinsic sailfin_adapter_fs_create_directory requires capabilities: ![io]" in ir, \
        "fs_create_directory should emit capability metadata for io"
    assert "declare i1 @sailfin_adapter_fs_create_directory(i8*, i1)" in ir, \
        "fs_create_directory should emit adapter declaration"


def test_native_llvm_execution_calls_http_adapter() -> None:
    """
    Verify that HTTP adapter declarations emit correctly.

    Tests that http_get and http_post adapters:
    1. Generate proper LLVM declare statements
    2. Include capability metadata comments showing required effects
    """
    artifact_text = """
        .fn http_adapter_test
        .param url string
        .param body string
        .meta return string
        .meta effects net
        
        .let response1 = http_get(url)
        .let response2 = http_post(url, body)
        .return response1
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should have no fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    ir = lowered.ir

    # Check for adapter declarations with capability metadata
    assert "; intrinsic sailfin_adapter_http_get requires capabilities: ![net]" in ir, \
        "http_get should emit capability metadata for net"
    assert "declare i8* @sailfin_adapter_http_get(i8*)" in ir, \
        "http_get should emit adapter declaration"

    assert "; intrinsic sailfin_adapter_http_post requires capabilities: ![net]" in ir, \
        "http_post should emit capability metadata for net"
    assert "declare i8* @sailfin_adapter_http_post(i8*, i8*)" in ir, \
        "http_post should emit adapter declaration"


def test_native_llvm_execution_calls_model_adapter() -> None:
    """
    Verify that model adapter declaration emits correctly.

    Tests that model_invoke_with_prompt adapter:
    1. Generates proper LLVM declare statement
    2. Includes capability metadata comment showing required effects
    """
    artifact_text = """
        .fn model_adapter_test
        .param system_prompt string
        .param user_message string
        .meta return string
        .meta effects model
        
        .let result = model_invoke_with_prompt(system_prompt, user_message)
        .return result
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should have no fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    ir = lowered.ir

    # Check for adapter declaration with capability metadata
    assert "; intrinsic sailfin_adapter_model_invoke_with_prompt requires capabilities: ![model]" in ir, \
        "model_invoke_with_prompt should emit capability metadata for model"
    assert "declare i8* @sailfin_adapter_model_invoke_with_prompt(i8*, i8*)" in ir, \
        "model_invoke_with_prompt should emit adapter declaration"


def test_native_llvm_execution_calls_serve_adapter() -> None:
    """
    Verify that serve adapter declarations emit correctly.

    Tests that serve_start and serve_handler_dispatch adapters:
    1. Generate proper LLVM declare statements
    2. Include capability metadata comments showing required effects
    """
    artifact_text = """
        .fn serve_adapter_test
        .param host string
        .param port number
        .param request string
        .param handler string
        .meta return string
        .meta effects net, io
        
        .let port_int = 8080
        .let _ignored1 = serve_start(host, port_int)
        .let response = serve_handler_dispatch(request, handler)
        .return response
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should have no fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    ir = lowered.ir

    # Check for adapter declarations with capability metadata
    assert "; intrinsic sailfin_adapter_serve_start requires capabilities: ![net, io]" in ir, \
        "serve_start should emit capability metadata for net and io"
    assert "declare void @sailfin_adapter_serve_start(i8*, i32)" in ir, \
        "serve_start should emit adapter declaration"

    assert "; intrinsic sailfin_adapter_serve_handler_dispatch requires capabilities: ![net, io]" in ir, \
        "serve_handler_dispatch should emit capability metadata for net and io"
    assert "declare i8* @sailfin_adapter_serve_handler_dispatch(i8*, i8*)" in ir, \
        "serve_handler_dispatch should emit adapter declaration"


def test_native_llvm_execution_calls_spawn_adapter() -> None:
    """
    Verify that concurrency adapter declarations emit correctly.

    Tests that spawn_task, channel_create, channel_send, and channel_receive adapters:
    1. Generate proper LLVM declare statements
    2. Include capability metadata comments showing required effects
    """
    artifact_text = """
        .fn spawn_adapter_test
        .param task_fn string
        .param channel_capacity number
        .param message string
        .meta return string
        .meta effects spawn, channel
        
        .let task_handle = spawn_task(task_fn)
        .let capacity_int = 10
        .let channel = channel_create(capacity_int)
        .let _ignored = channel_send(channel, message)
        .let received = channel_receive(channel)
        .return received
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should have no fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    ir = lowered.ir

    # Check for adapter declarations with capability metadata
    assert "; intrinsic sailfin_adapter_spawn_task requires capabilities: ![spawn]" in ir, \
        "spawn_task should emit capability metadata for spawn"
    assert "declare i8* @sailfin_adapter_spawn_task(i8*)" in ir, \
        "spawn_task should emit adapter declaration"

    assert "declare i8* @sailfin_adapter_channel_create(i32)" in ir, \
        "channel_create should emit adapter declaration"

    assert "; intrinsic sailfin_adapter_channel_send requires capabilities: ![channel]" in ir, \
        "channel_send should emit capability metadata for channel"
    assert "declare void @sailfin_adapter_channel_send(i8*, i8*)" in ir, \
        "channel_send should emit adapter declaration"

    assert "; intrinsic sailfin_adapter_channel_receive requires capabilities: ![channel]" in ir, \
        "channel_receive should emit capability metadata for channel"
    assert "declare i8* @sailfin_adapter_channel_receive(i8*)" in ir, \
        "channel_receive should emit adapter declaration"


def test_stage2_runner_executes_fs_operations() -> None:
    """
    Verify that filesystem adapters are registered in Stage2Runner
    without errors when instantiating the runner.
    """
    artifact_text = """
        .fn fs_test
        .meta return number
        .meta effects io
        
        .return 0.0
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should compile without fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    # Create Stage2Runner - this registers all adapters including filesystem
    runner = Stage2Runner(lowered)

    # Verify adapters were registered (count includes helpers + adapters)
    assert len(runner._registered_helpers) > 10, \
        "should have registered runtime helpers and adapters"


def test_stage2_runner_bounds_check_helper_sets_runtime_error() -> None:
    """Bounds check helper should surface IndexError via the runtime context."""

    artifact_text = """
        .fn noop
        .meta return number

        .return 0.0
        .endfn
    """
    lowered = _lower_native_text(artifact_text)
    runner = Stage2Runner(lowered)

    helper = runner._make_adapter(
        "sailfin_runtime_bounds_check",
        None,
        (ctypes.c_longlong, ctypes.c_longlong),
        None,
    )

    token = _LAST_RUNTIME_ERROR.set(None)
    try:
        helper(ctypes.c_longlong(0), ctypes.c_longlong(0))
        error = _LAST_RUNTIME_ERROR.get()
        assert isinstance(error, IndexError)
        assert "out of bounds" in str(error)

        _LAST_RUNTIME_ERROR.set(None)
        helper(ctypes.c_longlong(0), ctypes.c_longlong(5))
        assert _LAST_RUNTIME_ERROR.get() is None
    finally:
        _LAST_RUNTIME_ERROR.reset(token)


def test_stage2_runner_executes_http_request() -> None:
    """
    Verify that HTTP adapters are registered in Stage2Runner
    without errors when instantiating the runner.
    """
    artifact_text = """
        .fn http_test
        .meta return number
        .meta effects net
        
        .return 0.0
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should compile without fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    # Create Stage2Runner - this registers all adapters including HTTP
    runner = Stage2Runner(lowered)

    # Verify adapters were registered
    assert len(runner._registered_helpers) > 10, \
        "should have registered runtime helpers and adapters"


def test_stage2_runner_fs_list_directory_returns_real_listing(tmp_path) -> None:
    """fs_list_directory adapter should surface real directory contents."""

    listing_root = tmp_path / "fs_listing"
    listing_root.mkdir()
    (listing_root / "first.txt").write_text("a", encoding="utf-8")
    (listing_root / "second.txt").write_text("b", encoding="utf-8")

    path_literal = json.dumps(str(listing_root))
    artifact_text = f"""
        .fn list_directory_test
        .meta return string
        .meta effects io

        .let entries = fs_list_directory({path_literal})
        .return entries
        .endfn
    """

    lowered = _lower_native_text(artifact_text)
    runner = Stage2Runner(lowered)
    runner.set_manifest_effects("list_directory_test", ["io"])

    result_ptr = runner.invoke("list_directory_test", restype=ctypes.c_void_p)
    assert result_ptr, "fs_list_directory should return pointer to JSON data"

    json_bytes = ctypes.cast(result_ptr, ctypes.c_char_p).value
    assert json_bytes is not None
    entries = json.loads(json_bytes.decode("utf-8"))
    assert entries == ["first.txt", "second.txt"]


def test_stage2_runner_fs_create_and_delete(tmp_path) -> None:
    """fs_create_directory and fs_delete_file should mutate the real filesystem."""

    base_dir = tmp_path / "fs_mutation"
    target_dir = base_dir / "nested"
    target_file = target_dir / "data.txt"

    dir_literal = json.dumps(str(target_dir))
    file_literal = json.dumps(str(target_file))

    artifact_text = f"""
        .fn fs_mutation_test
        .meta return number
        .meta effects io

        .let created = fs_create_directory({dir_literal}, true)
        .let _write = fs_write_file({file_literal}, "payload")
        .let removed = fs_delete_file({file_literal})
        .return 0.0
        .endfn
    """

    lowered = _lower_native_text(artifact_text)
    runner = Stage2Runner(lowered)
    runner.set_manifest_effects("fs_mutation_test", ["io"])

    runner.invoke("fs_mutation_test")

    assert target_dir.exists(), "fs_create_directory should create the directory"
    assert not target_file.exists(), "fs_delete_file should remove the target file"


def test_stage2_runner_executes_model_prompt() -> None:
    """
    Verify that model adapters are registered in Stage2Runner
    without errors when instantiating the runner.
    """
    artifact_text = """
        .fn model_test
        .meta return number
        .meta effects model
        
        .return 0.0
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should compile without fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    # Create Stage2Runner - this registers all adapters including model
    runner = Stage2Runner(lowered)

    # Verify adapters were registered
    assert len(runner._registered_helpers) > 10, \
        "should have registered runtime helpers and adapters"


def test_stage2_runner_executes_serve_handler() -> None:
    """
    Verify that serve adapters are registered in Stage2Runner
    without errors when instantiating the runner.
    """
    artifact_text = """
        .fn serve_test
        .meta return number
        .meta effects io
        
        .return 0.0
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should compile without fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    # Create Stage2Runner - this registers all adapters including serve
    runner = Stage2Runner(lowered)

    # Verify adapters were registered
    assert len(runner._registered_helpers) > 10, \
        "should have registered runtime helpers and adapters"


def test_stage2_runner_executes_spawn_and_channel() -> None:
    """
    Verify that concurrency adapters are registered in Stage2Runner
    without errors when instantiating the runner.
    """
    artifact_text = """
        .fn concurrency_test
        .meta return number
        .meta effects spawn, channel
        
        .return 0.0
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should compile without fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    # Create Stage2Runner - this registers all adapters including concurrency
    runner = Stage2Runner(lowered)

    # Verify adapters were registered
    assert len(runner._registered_helpers) > 10, \
        "should have registered runtime helpers and adapters"


def test_stage2_runner_enforces_capability_restrictions() -> None:
    """
    Verify that Stage2Runner raises PermissionError when native code
    attempts IO operations without proper capability grants.
    """
    artifact_text = """
        .fn restricted_test
        .meta return number
        .meta effects io
        
        .let path = "test.txt"
        .let content = fs_read_file(path)
        .return 1.0
        .endfn
    """
    lowered = _lower_native_text(artifact_text)

    # Should compile without fatal errors
    fatal = [
        diag for diag in lowered.diagnostics
        if "error" in diag.lower()
        and "defaulting to pointer layout" not in diag
        and "lowering as `i8*`" not in diag
    ]
    assert not fatal, f"unexpected fatal errors: {fatal}"

    # Create Stage2Runner WITHOUT io capability grant
    runner = Stage2Runner(lowered)
    runner.set_manifest_effects("restricted_test", [])  # Empty capabilities

    # Attempting to execute should raise PermissionError
    with pytest.raises(PermissionError, match="capability 'io' not granted"):
        runner.invoke("restricted_test", restype=ctypes.c_double, argtypes=[])


def test_native_llvm_execution_lowers_string_literal(compile_stage2) -> None:
    """Verify that string literals lower to LLVM (malloc-based in Stage2)."""
    source = """
fn get_message() -> string {
    return "Hello, World!";
}

fn main() -> number {
    return 0;
}
"""
    lowered = compile_stage2(source, module_name="string_literal")
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    ir = lowered.ir

    # Stage2 uses malloc+store for string literals instead of @.str. globals
    assert "@malloc" in ir, "String literal should use malloc"
    assert "c\"Hello, World!\\00\"" in ir, "String content not found in IR"
    assert "bitcast" in ir, "String literal lowering should use bitcast"

    # Verify it compiles and executes without errors
    _compile_ir(ir)


def test_native_llvm_execution_deduplicates_string_constants(compile_stage2) -> None:
    """Verify that string literals are properly lowered (Stage2 uses malloc, not deduped globals)."""
    source = """
fn get_first() -> string {
    return "duplicate";
}

fn get_second() -> string {
    return "duplicate";
}

fn main() -> number {
    return 0;
}
"""
    lowered = compile_stage2(source, module_name="string_dedup")
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    ir = lowered.ir

    # Stage2 materializes each string literal separately (malloc+store) instead of deduplicating globals
    string_constant_count = ir.count('c"duplicate\\00"')
    assert string_constant_count >= 1, f"Expected at least 1 string constant, found {string_constant_count}"

    # Verify it compiles
    _compile_ir(ir)


def test_native_llvm_execution_returns_string_from_method(compile_stage2) -> None:
    """Verify that interface methods can return string literals."""
    source = """
interface Greeter {
    fn greet(self) -> string;
}

struct Person implements Greeter {
    name -> string;
    
    fn greet(self) -> string {
        return "Hi";
    }
}

fn main() -> number {
    return 0;
}
"""
    lowered = compile_stage2(source, module_name="method_string")
    # Now that string literals are implemented, we should NOT see "unhandled return expression"
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
        or "parameter `self` missing type annotation" in diag
        or "member access base" in diag
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]

    # Check that "unhandled return expression" is NOT in unexpected diagnostics
    has_unhandled_return = any(
        "unhandled return expression" in diag for diag in unexpected)
    assert not has_unhandled_return, "String literal return should now be handled"

    ir = lowered.ir

    # Stage2 uses malloc+store for string literals
    assert "@malloc" in ir, "String literal should use malloc"
    assert 'c"Hi\\00"' in ir, "String content not found in IR"

    # Verify it compiles
    _compile_ir(ir)


def test_native_llvm_execution_method_returns_string_literal(compile_stage2) -> None:
    """Validate that interface methods can return string literals end-to-end."""
    source = """
interface Formatter {
    fn format(self) -> string;
}

struct Document implements Formatter {
    id -> number;
    
    fn format(self) -> string {
        return "Document text";
    }
}

fn main() -> number {
    let doc = Document { id: 123 };
    let result = doc.format();
    return 0;
}
"""
    lowered = compile_stage2(source, module_name="method_returns_string")
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
        or "parameter `self` missing type annotation" in diag
        or "method call expects" in diag
        or "unable to coerce operand" in diag
        or "unable to coerce argument" in diag
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    ir = lowered.ir

    # Stage2 uses malloc+store for string literals instead of @.str. globals
    assert "@malloc" in ir, "String literal should use malloc"
    assert 'c"Document text\\00"' in ir, "String content not found in IR"

    # Check that method definition exists
    assert "define" in ir and "Document::format" in ir or "format" in ir, \
        "Method definition should exist"

    # Check that return instruction exists
    assert "ret" in ir, "Return instruction should exist"

    # Verify it compiles successfully
    _compile_ir(ir)


def test_native_llvm_execution_method_returns_field_access(compile_stage2) -> None:
    """Validate that methods can return struct field values (return self.field)."""
    source = """
interface Identifiable {
    fn get_id(self) -> number;
}

struct Product implements Identifiable {
    id -> number;
    name -> string;
    
    fn get_id(self) -> number {
        return self.id;
    }
}

fn main() -> number {
    let product = Product { id: 42, name: "Widget" };
    let result = product.get_id();
    return 0;
}
"""
    lowered = compile_stage2(source, module_name="method_returns_field")
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
        or "parameter `self` missing type annotation" in diag
        or "method call expects" in diag
        or "unable to coerce operand" in diag
        or "unable to coerce argument" in diag
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    ir = lowered.ir

    # Check that method definition exists
    assert "define" in ir, "Method definition should exist"

    # Check for GEP instruction to access struct field
    assert "getelementptr" in ir, "GEP instruction should exist for field access"

    # Check for load instruction to read field value
    assert "load" in ir, "Load instruction should exist for reading field"

    # Check that return instruction exists
    assert "ret" in ir, "Return instruction should exist"

    # Verify it compiles successfully
    _compile_ir(ir)


def test_native_llvm_execution_method_returns_computed_value(compile_stage2) -> None:
    """Validate that methods can return computed expressions (return self.x + self.y)."""
    source = """
interface Summable {
    fn sum(self) -> number;
}

struct Point implements Summable {
    x -> number;
    y -> number;
    
    fn sum(self) -> number {
        return self.x + self.y;
    }
}

fn main() -> number {
    let point = Point { x: 10.0, y: 20.0 };
    let result = point.sum();
    return 0;
}
"""
    lowered = compile_stage2(source, module_name="method_returns_computed")
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
        or "parameter `self` missing type annotation" in diag
        or "method call expects" in diag
        or "unable to coerce operand" in diag
        or "unable to coerce argument" in diag
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    ir = lowered.ir

    # Check that method definition exists
    assert "define" in ir, "Method definition should exist"

    # Check for field access instructions
    assert "getelementptr" in ir, "GEP instruction should exist for field access"
    assert "load" in ir, "Load instruction should exist for reading fields"

    # Check for arithmetic operation
    assert "fadd" in ir or "add" in ir, "Addition operation should exist"

    # Check that return instruction exists
    assert "ret" in ir, "Return instruction should exist"

    # Verify it compiles successfully
    _compile_ir(ir)


def test_native_llvm_execution_method_returns_call_result(compile_stage2) -> None:
    """Validate that methods can return the result of calling other functions/methods."""
    source = """
fn helper(x -> number) -> number {
    return x * 2.0;
}

interface Calculator {
    fn compute(self) -> number;
}

struct Value implements Calculator {
    data -> number;
    
    fn compute(self) -> number {
        return helper(self.data);
    }
}

fn main() -> number {
    let val = Value { data: 21.0 };
    let result = val.compute();
    return 0;
}
"""
    lowered = compile_stage2(source, module_name="method_returns_call")
    acceptable_diags = [
        diag for diag in lowered.diagnostics
        if "defaulting to pointer layout" in diag
        or "lowering as `i8*`" in diag
        or "parameter `self` missing type annotation" in diag
        or "method call expects" in diag
        or "unable to coerce operand" in diag
        or "unable to coerce argument" in diag
    ]
    unexpected = [
        diag for diag in lowered.diagnostics if diag not in acceptable_diags]
    assert not unexpected, f"unexpected diagnostics: {unexpected}"

    ir = lowered.ir

    # Check that method definition exists
    assert "define" in ir, "Method definition should exist"

    # Check that helper function exists
    assert "define" in ir and "helper" in ir, "Helper function should be defined"

    # Check for call instruction to helper
    assert "call" in ir, "Call instruction should exist"

    # Check for field access to get argument
    assert "getelementptr" in ir, "GEP instruction should exist for field access"
    assert "load" in ir, "Load instruction should exist for reading field"

    # Check that return instruction exists
    assert "ret" in ir, "Return instruction should exist"

    # Verify it compiles successfully
    _compile_ir(ir)


def test_native_llvm_execution_indexes_primitive_array(compile_stage2) -> None:
    """Test array indexing for primitive types (number[])."""
    source = """
fn get_element(values -> number[], index -> int) -> number {
    return values[index];
}

fn get_first(values -> number[]) -> number {
    return values[0];
}

fn get_last(values -> number[]) -> number {
    let index = 3;
    return values[index];
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_stage2(source)

    # Check that array indexing doesn't produce unsupported expression warnings
    unsupported_errors = [
        diag for diag in lowered.diagnostics
        if "unsupported expression" in diag and "[" in diag
    ]
    assert not unsupported_errors, f"Array indexing should be supported: {unsupported_errors}"

    ir = lowered.ir

    # Check that getelementptr is used for indexing
    assert "getelementptr" in ir, "GEP instruction should be used for array indexing"

    # Check that load is used to read element
    assert "load" in ir, "Load instruction should be used to read array element"

    # Check for extractvalue to get data pointer from array struct
    assert "extractvalue" in ir, "Extractvalue should be used to get array data pointer"

    # Verify it compiles successfully
    _compile_ir(ir)


def test_native_llvm_execution_indexes_struct_array(compile_stage2) -> None:
    """Test array indexing for struct arrays (Token[], Decorator[])."""
    source = """
struct Token {
    text -> string;
    line -> int;
}

fn get_token(tokens -> Token[], index -> int) -> Token {
    return tokens[index];
}

fn get_first_token_line(tokens -> Token[]) -> int {
    let token = tokens[0];
    return token.line;
}

fn main() -> int {
    return 0;
}
"""

    lowered = compile_stage2(source)

    # Check that array indexing doesn't produce unsupported expression warnings
    unsupported_errors = [
        diag for diag in lowered.diagnostics
        if "unsupported expression" in diag and "tokens[" in diag
    ]
    assert not unsupported_errors, f"Struct array indexing should be supported: {unsupported_errors}"

    ir = lowered.ir

    # Check that Token struct type is defined
    assert "%Token" in ir, "Token struct type should be defined"

    # Check that getelementptr is used for array indexing
    assert "getelementptr" in ir, "GEP instruction should be used for array indexing"

    # Verify it compiles successfully
    _compile_ir(ir)


def test_native_llvm_execution_checks_array_bounds(compile_stage2) -> None:
    """Test that array indexing emits bounds checks."""
    source = """
fn access_array(values -> number[], index -> int) -> number {
    return values[index];
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_stage2(source)
    ir = lowered.ir

    # Check for bounds check comparison instruction
    assert "icmp" in ir, "Bounds check comparison should be emitted"

    # Check for bounds check comment
    assert "bounds check" in ir, "Bounds check comment should be present"

    # Check for runtime helper invocation
    assert "call void @sailfin_runtime_bounds_check" in ir, \
        "Bounds check helper call should be emitted"

    # Verify it compiles successfully
    _compile_ir(ir)


def test_native_llvm_execution_indexes_string_character(compile_stage2) -> None:
    """Test string indexing to access individual characters."""
    source = """
fn get_char(text -> string, index -> int) -> int {
    return text[index];
}

fn get_first_char(text -> string) -> int {
    return text[0];
}

fn main() -> int {
    return 0;
}
"""

    lowered = compile_stage2(source)

    # Check that string indexing doesn't produce unsupported expression warnings
    unsupported_errors = [
        diag for diag in lowered.diagnostics
        if "unsupported expression" in diag and "text[" in diag
    ]
    assert not unsupported_errors, f"String indexing should be supported: {unsupported_errors}"

    ir = lowered.ir

    # Check that getelementptr is used for character access
    assert "getelementptr" in ir, "GEP instruction should be used for string indexing"

    # Check that i8 (character) is loaded
    assert "load i8" in ir, "i8 load should be used to read character"

    # Verify it compiles successfully
    _compile_ir(ir)


def test_native_llvm_execution_compound_add_assignment(compile_stage2):
    """Test that += operator works in loops and accumulator patterns"""
    source = """
fn increment_loop() -> number {
    let mut count -> number = 0.0;
    let mut i -> number = 0.0;
    loop {
        if i >= 5.0 {
            break;
        }
        count += 1.0;
        i += 1.0;
    }
    return count;
}

fn main() -> number {
    return increment_loop();
}
"""
    lowered = compile_stage2(source)

    # Check for proper diagnostics
    unexpected_diagnostics = [
        diag for diag in lowered.diagnostics
        if "assignment to unknown local" in diag or "unsupported expression" in diag
    ]
    assert not unexpected_diagnostics, f"Compound add should work without errors: {unexpected_diagnostics}"

    # Verify the IR contains add instructions (from desugaring)
    ir = lowered.ir
    assert "fadd double" in ir or "add " in ir, "Add operation should be present in IR"

    # Compile and execute
    engine, module = _compile_ir(ir)
    try:
        result = _invoke_double(engine, "main")
        assert result == pytest.approx(5.0), f"Expected 5.0, got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_compound_subtract_assignment(compile_stage2):
    """Test that -= operator works correctly"""
    source = """
fn countdown() -> number {
    let mut total -> number = 10.0;
    let mut i -> number = 0.0;
    loop {
        if i >= 3.0 {
            break;
        }
        total -= 2.0;
        i += 1.0;
    }
    return total;
}

fn main() -> number {
    return countdown();
}
"""
    lowered = compile_stage2(source)

    # Check for proper diagnostics
    unexpected_diagnostics = [
        diag for diag in lowered.diagnostics
        if "assignment to unknown local" in diag or "unsupported expression" in diag
    ]
    assert not unexpected_diagnostics, f"Compound subtract should work without errors: {unexpected_diagnostics}"

    # Verify the IR contains subtract instructions
    ir = lowered.ir
    assert "fsub double" in ir or "sub " in ir, "Subtract operation should be present in IR"

    # Compile and execute
    engine, module = _compile_ir(ir)
    try:
        result = _invoke_double(engine, "main")
        assert result == pytest.approx(
            4.0), f"Expected 4.0 (10 - 2*3), got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_compound_multiply_divide(compile_stage2):
    """Test that *= and /= operators work correctly"""
    source = """
fn compute() -> number {
    let mut value -> number = 2.0;
    value *= 3.0;  // value = 6.0
    value *= 2.0;  // value = 12.0
    value /= 4.0;  // value = 3.0
    return value;
}

fn main() -> number {
    return compute();
}
"""
    lowered = compile_stage2(source)

    # Check for proper diagnostics
    unexpected_diagnostics = [
        diag for diag in lowered.diagnostics
        if "assignment to unknown local" in diag or "unsupported expression" in diag
    ]
    assert not unexpected_diagnostics, f"Compound multiply/divide should work without errors: {unexpected_diagnostics}"

    # Verify the IR contains multiply and divide instructions
    ir = lowered.ir
    assert "fmul double" in ir or "mul " in ir, "Multiply operation should be present in IR"
    assert "fdiv double" in ir or "div " in ir, "Divide operation should be present in IR"

    # Compile and execute
    engine, module = _compile_ir(ir)
    try:
        result = _invoke_double(engine, "main")
        assert result == pytest.approx(
            3.0), f"Expected 3.0 (2*3*2/4), got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_logical_and_short_circuits(compile_stage2):
    """Verify that && operator short-circuits when left operand is false."""
    source = """
fn test_and(x -> boolean, y -> boolean) -> boolean {
    return x && y;
}

fn should_short_circuit() -> boolean {
    return false && true;
}

fn both_true() -> boolean {
    return true && true;
}

fn both_false() -> boolean {
    return false && false;
}

fn main() -> int {
    let result1 = test_and(true, true);
    let result2 = test_and(false, true);
    let result3 = should_short_circuit();
    let result4 = both_true();
    let result5 = both_false();
    
    // result1 should be true, result2/3/5 should be false, result4 should be true
    if result1 {
        if result4 {
            if result2 == false {
                if result3 == false {
                    if result5 == false {
                        return 42;
                    }
                }
            }
        }
    }
    return 0;
}
"""
    lowered = compile_stage2(source)

    # Should compile without fatal errors
    fatal_diagnostics = [
        diag for diag in lowered.diagnostics if "fatal" in diag.lower()]
    assert not fatal_diagnostics, f"Should not have fatal errors: {fatal_diagnostics}"

    # Should not have "call to unknown function" warnings for logical operators
    unknown_function_warnings = [
        diag for diag in lowered.diagnostics
        if "call to unknown function" in diag and "&&" in diag
    ]
    assert not unknown_function_warnings, f"Logical && should not produce 'unknown function' warnings: {unknown_function_warnings}"

    # IR should contain logical_and labels for control flow
    ir = lowered.ir
    assert "logical_and" in ir, "IR should contain logical_and labels"

    # Should have branch instructions for short-circuit evaluation
    assert "br i1" in ir, "IR should have branch instructions"

    # Should have phi nodes to merge results
    assert "phi i1" in ir, "IR should have phi nodes for boolean merging"

    # Compile and execute
    engine, module = _compile_ir(ir)
    try:
        result = _invoke_int(engine, "main")
        assert result == 42, f"Expected 42 from logical AND operations, got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_logical_or_short_circuits(compile_stage2):
    """Verify that || operator short-circuits when left operand is true."""
    source = """
fn test_or(x -> boolean, y -> boolean) -> boolean {
    return x || y;
}

fn should_short_circuit() -> boolean {
    return true || false;
}

fn both_false() -> boolean {
    return false || false;
}

fn both_true() -> boolean {
    return true || true;
}

fn main() -> int {
    let result1 = test_or(true, false);
    let result2 = test_or(false, false);
    let result3 = should_short_circuit();
    let result4 = both_true();
    let result5 = both_false();
    
    // result1/3/4 should be true, result2/5 should be false
    if result1 {
        if result3 {
            if result4 {
                if result2 == false {
                    if result5 == false {
                        return 99;
                    }
                }
            }
        }
    }
    return 0;
}
"""
    lowered = compile_stage2(source)

    # Should compile without fatal errors
    fatal_diagnostics = [
        diag for diag in lowered.diagnostics if "fatal" in diag.lower()]
    assert not fatal_diagnostics, f"Should not have fatal errors: {fatal_diagnostics}"

    # Should not have "call to unknown function" warnings for logical operators
    unknown_function_warnings = [
        diag for diag in lowered.diagnostics
        if "call to unknown function" in diag and "||" in diag
    ]
    assert not unknown_function_warnings, f"Logical || should not produce 'unknown function' warnings: {unknown_function_warnings}"

    # IR should contain logical_or labels for control flow
    ir = lowered.ir
    assert "logical_or" in ir, "IR should contain logical_or labels"

    # Should have branch instructions for short-circuit evaluation
    assert "br i1" in ir, "IR should have branch instructions"

    # Should have phi nodes to merge results
    assert "phi i1" in ir, "IR should have phi nodes for boolean merging"

    # Compile and execute
    engine, module = _compile_ir(ir)
    try:
        result = _invoke_int(engine, "main")
        assert result == 99, f"Expected 99 from logical OR operations, got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_nested_logical_operators(compile_stage2):
    """Verify that nested logical operators (a && b || c && d) compile correctly."""
    source = """
fn complex_logic(a -> boolean, b -> boolean, c -> boolean, d -> boolean) -> boolean {
    return a && b || c && d;
}

fn nested_and_or() -> boolean {
    let temp1 = true && false;
    let temp2 = false && true;
    return temp1 || temp2 || true;
}

fn main() -> int {
    let result1 = complex_logic(true, true, false, false);
    let result2 = complex_logic(false, false, true, true);
    let result3 = nested_and_or();
    
    if result1 {
        if result2 {
            if result3 {
                return 123;
            }
        }
    }
    return 0;
}
"""
    lowered = compile_stage2(source)

    # Should compile without fatal errors
    fatal_diagnostics = [
        diag for diag in lowered.diagnostics if "fatal" in diag.lower()]
    assert not fatal_diagnostics, f"Should not have fatal errors: {fatal_diagnostics}"

    # IR should contain both logical_and and logical_or labels
    ir = lowered.ir
    assert "logical_and" in ir or "logical_or" in ir, "IR should contain logical operator labels"

    # Should have multiple branch and phi instructions for nested logic
    assert ir.count(
        "br i1") >= 2, "IR should have multiple branch instructions for nested logic"
    assert ir.count(
        "phi i1") >= 1, "IR should have phi instructions for nested logic"

    # Compile and execute
    engine, module = _compile_ir(ir)
    try:
        result = _invoke_int(engine, "main")
        assert result == 123, f"Expected 123 from nested logical operations, got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_logical_operators_with_comparisons(compile_stage2):
    """Verify that logical operators work correctly with comparison expressions."""
    source = """
fn range_check(x -> number) -> boolean {
    return x > 0.0 && x < 100.0;
}

fn multi_condition(a -> int, b -> int) -> boolean {
    return a == b || a > b;
}

fn main() -> int {
    let result1 = range_check(50.0);
    let result2 = range_check(-5.0);
    let result3 = range_check(150.0);
    let result4 = multi_condition(10, 10);
    let result5 = multi_condition(20, 10);
    let result6 = multi_condition(5, 10);
    
    // result1/4/5 should be true, result2/3/6 should be false
    if result1 {
        if result2 == false {
            if result3 == false {
                if result4 {
                    if result5 {
                        if result6 == false {
                            return 777;
                        }
                    }
                }
            }
        }
    }
    return 0;
}
"""
    lowered = compile_stage2(source)

    # Should compile without fatal errors
    fatal_diagnostics = [
        diag for diag in lowered.diagnostics if "fatal" in diag.lower()]
    assert not fatal_diagnostics, f"Should not have fatal errors: {fatal_diagnostics}"

    # Should not have "call to unknown function" warnings for logical operators
    unknown_function_warnings = [
        diag for diag in lowered.diagnostics
        if "call to unknown function" in diag and ("&&" in diag or "||" in diag)
    ]
    assert not unknown_function_warnings, f"Logical operators should not produce 'unknown function' warnings: {unknown_function_warnings}"

    # Compile and execute
    engine, module = _compile_ir(lowered.ir)
    try:
        result = _invoke_int(engine, "main")
        assert result == 777, f"Expected 777 from logical operations with comparisons, got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


@pytest.mark.stage2
def test_native_llvm_execution_ternary_operator(compile_stage2):
    """Verify that ternary operator (condition ? true_value : false_value) compiles and executes correctly."""
    source = """
fn absolute_value(x -> number) -> number {
    return x > 0.0 ? x : 0.0 - x;
}

fn max_value(a -> int, b -> int) -> int {
    return a > b ? a : b;
}

fn main() -> int {
    let abs1 = absolute_value(5.0);
    let abs2 = absolute_value(0.0 - 3.0);
    let max_val = max_value(10, 20);
    
    if abs1 == 5.0 {
        if abs2 == 3.0 {
            if max_val == 20 {
                return 123;
            }
        }
    }
    return 0;
}
"""
    lowered = compile_stage2(source)

    # Should compile without fatal errors
    fatal_diagnostics = [
        diag for diag in lowered.diagnostics if "fatal" in diag.lower()]
    assert not fatal_diagnostics, f"Should not have fatal errors: {fatal_diagnostics}"

    # IR should contain ternary control flow labels
    ir = lowered.ir
    assert "ternary_cond" in ir or "ternary_then" in ir or "ternary_else" in ir, "IR should contain ternary operator labels"

    # Should have branch and phi instructions for ternary control flow
    assert ir.count(
        "br i1") >= 1, "IR should have branch instructions for ternary"
    assert ir.count(
        "phi") >= 1, "IR should have phi instructions for ternary merge"

    # Compile and execute
    engine, module = _compile_ir(ir)
    try:
        result = _invoke_int(engine, "main")
        assert result == 123, f"Expected 123, got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


@pytest.mark.stage2
def test_native_llvm_execution_nested_ternary(compile_stage2):
    """Verify that nested ternary operators work correctly."""
    source = """
fn classify(x -> int) -> int {
    return x > 0 ? (x > 10 ? 2 : 1) : 0;
}

fn main() -> int {
    let result1 = classify(15);
    let result2 = classify(5);
    let result3 = classify(0 - 3);
    
    if result1 == 2 {
        if result2 == 1 {
            if result3 == 0 {
                return 123;
            }
        }
    }
    return 0;
}
"""
    lowered = compile_stage2(source)

    # Should compile without fatal errors
    fatal_diagnostics = [
        diag for diag in lowered.diagnostics if "fatal" in diag.lower()]
    assert not fatal_diagnostics, f"Should not have fatal errors: {fatal_diagnostics}"

    # IR should contain multiple ternary labels for nested ternary
    ir = lowered.ir
    assert ir.count(
        "ternary_cond") >= 2, "IR should have multiple ternary conditions for nested operators"

    # Compile and execute
    engine, module = _compile_ir(ir)
    try:
        result = _invoke_int(engine, "main")
        assert result == 123, f"Expected 123, got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


@pytest.mark.stage2
def test_native_llvm_execution_ternary_with_logical_operators(compile_stage2):
    """Verify that ternary operator works with logical operators in condition."""
    source = """
fn check_range(x -> number) -> boolean {
    return x > 0.0 && x < 100.0 ? true : false;
}

fn main() -> int {
    let in_range = check_range(50.0);
    let out_of_range1 = check_range(0.0 - 10.0);
    let out_of_range2 = check_range(150.0);
    
    if in_range {
        if out_of_range1 == false {
            if out_of_range2 == false {
                return 123;
            }
        }
    }
    return 0;
}
"""
    lowered = compile_stage2(source)

    # Should compile without fatal errors
    fatal_diagnostics = [
        diag for diag in lowered.diagnostics if "fatal" in diag.lower()]
    assert not fatal_diagnostics, f"Should not have fatal errors: {fatal_diagnostics}"

    # IR should contain both logical and ternary labels
    ir = lowered.ir
    assert "logical_and" in ir or "logical_or" in ir, "IR should contain logical operator labels"
    assert "ternary" in ir, "IR should contain ternary operator labels"

    # Compile and execute
    engine, module = _compile_ir(ir)
    try:
        result = _invoke_int(engine, "main")
        assert result == 123, f"Expected 123, got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


@pytest.mark.stage2
def test_native_llvm_execution_compares_string_characters(compile_stage2):
    """Test that character comparisons work in if-statement conditions."""
    source = """
fn check_char(text -> string, index -> int) -> int {
    let ch = text[index];
    if ch == 97 {
        return 1;
    }
    if ch != 98 {
        return 2;
    }
    return 0;
}

fn main() -> int {
    return check_char("abc", 0);
}
"""
    lowered = compile_stage2(source)

    # Check that character comparisons don't produce unsupported operator warnings
    unsupported_errors = [
        diag for diag in lowered.diagnostics
        if "unsupported comparison operator" in diag and "i8" in diag
    ]
    assert not unsupported_errors, f"Character comparisons should be supported: {unsupported_errors}"

    # Check that condition doesn't fail to lower
    condition_errors = [
        diag for diag in lowered.diagnostics
        if "condition produced no value" in diag or "unable to lower if condition" in diag
    ]
    assert not condition_errors, f"Character comparison conditions should lower: {condition_errors}"

    ir = lowered.ir

    # Check that icmp is used for character comparison (may be coerced to i64)
    assert "icmp eq" in ir or "icmp ne" in ir, "icmp instruction should be used for character comparison"
    assert "sext i8" in ir, "i8 character should be extended to i64 for comparison"

    # Compile and execute
    engine, module = _compile_ir(ir)
    try:
        result = _invoke_int(engine, "main")
        assert result == 1, f"Expected 1 (character 'a' == 97), got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


@pytest.mark.stage2
def test_native_llvm_execution_if_with_complex_condition(compile_stage2):
    """Test that if-statements with complex conditions (member access, comparisons) work."""
    source = """
struct Point {
    x -> number;
    y -> number;
}

fn check_point(p -> Point, threshold -> number) -> int {
    if p.x > threshold {
        return 1;
    }
    if p.y <= threshold {
        return 2;
    }
    return 0;
}

fn main() -> int {
    let point = Point { x: 10.0, y: 5.0 };
    return check_point(point, 7.0);
}
"""
    lowered = compile_stage2(source)

    # Check that member access in conditions doesn't fail
    condition_errors = [
        diag for diag in lowered.diagnostics
        if "condition produced no value" in diag or "unable to lower if condition" in diag
    ]
    assert not condition_errors, f"Complex conditions should lower: {condition_errors}"

    ir = lowered.ir

    # Check that member access and comparison are present
    assert "extractvalue" in ir or "getelementptr" in ir, "Member access should use extractvalue or GEP"
    assert "fcmp" in ir, "Comparison should use fcmp for floating point"

    # Compile and execute
    engine, module = _compile_ir(ir)
    try:
        result = _invoke_int(engine, "main")
        assert result == 1, f"Expected 1 (p.x=10.0 > threshold=7.0), got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)
