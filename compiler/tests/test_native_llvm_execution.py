import ctypes

import llvmlite.binding as llvm
import pytest

from compiler.build.main import compile_to_native_llvm

_LLVM_TARGET_INITIALIZED = False


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
    assert lowered.diagnostics == []
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
    assert lowered.diagnostics == []
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
