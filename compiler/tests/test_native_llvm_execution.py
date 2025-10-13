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


def _invoke_double(engine, name: str, *args: float) -> float:
    address = engine.get_function_address(name)
    assert address != 0, f"function {name} not found"
    arg_types = (ctypes.c_double,) * len(args)
    function_type = ctypes.CFUNCTYPE(ctypes.c_double, *arg_types)
    function = function_type(address)
    return function(*args)


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
