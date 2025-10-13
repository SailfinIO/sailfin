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
    ],
)
def test_native_llvm_execution_runs_program(source: str, expected: float) -> None:
    lowered = compile_to_native_llvm(source)
    assert lowered.diagnostics == []
    assert "define double @add" in lowered.ir
    assert "define double @main" in lowered.ir

    engine, module = _compile_ir(lowered.ir)
    try:
        main_result = _invoke_double(engine, "main")
        assert main_result == pytest.approx(expected)

        add_result = _invoke_double(engine, "add", 3.0, 4.0)
        assert add_result == pytest.approx(7.0)
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)
