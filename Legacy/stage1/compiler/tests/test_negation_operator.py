"""Test negation operator in LLVM lowering."""
import ctypes
import pytest

from compiler.build.emit_native import NativeArtifact, NativeModule
from compiler.build.native_llvm_lowering import lower_to_llvm

pytestmark = [pytest.mark.stage2,
              pytest.mark.usefixtures("stage1_environment")]


@pytest.fixture()
def compile_stage2(stage2_environment):
    def _compile(source: str, *, module_name: str = "<memory>"):
        return stage2_environment.compile_to_native_llvm(source, module_name=module_name)
    return _compile


def test_native_llvm_execution_negates_boolean_value(compile_stage2):
    """Test that the! operator correctly negates boolean values."""
    source = """
fn negate(value -> boolean) -> boolean {
    return !value;
}

fn double_negate(value -> boolean) -> boolean {
    return !!value;
}

fn main() -> int {
    let result1 = negate(true);
    let result2 = negate(false);
    let result3 = double_negate(true);
    let result4 = double_negate(false);
    
    // result1/result4 should be false, result2/result3 should be true
    if result1 == false {
        if result2 == true {
            if result3 == true {
                if result4 == false {
                    return 42;
                }
            }
        }
    }
    return 0;
}
"""
    lowered = compile_stage2(source)

    # Should not have "call to unknown function `!...`" warnings
    unknown_function_warnings = [
        diag for diag in lowered.diagnostics
        if "call to unknown function `!" in diag
    ]
    assert not unknown_function_warnings, f"Negation operator should be supported: {unknown_function_warnings}"

    # IR should contain xor instruction for boolean negation
    ir = lowered.ir
    assert "xor i1" in ir, "IR should contain xor i1 instruction for boolean negation"

    # Compile and verify execution
    import llvmlite.binding as llvm
    llvm.initialize_native_target()
    llvm.initialize_native_asmprinter()
    target = llvm.Target.from_default_triple()
    target_machine = target.create_target_machine()
    backing_module = llvm.parse_assembly("")
    engine = llvm.create_mcjit_compiler(backing_module, target_machine)

    module = llvm.parse_assembly(ir)
    module.verify()
    engine.add_module(module)
    engine.finalize_object()

    try:
        main_address = engine.get_function_address("main")
        assert main_address != 0, "main function not found"
        main_func = ctypes.CFUNCTYPE(ctypes.c_longlong)(main_address)
        result = main_func()
        assert result == 42, f"Expected 42, got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)


def test_native_llvm_execution_negation_in_condition(compile_stage2):
    """Test that negation operator works in conditional expressions."""
    source = """
fn check_not_ready(ready -> boolean) -> int {
    if !ready {
        return 1;
    }
    return 0;
}

fn main() -> int {
    let result1 = check_not_ready(false);
    let result2 = check_not_ready(true);
    
    // result1 should be 1 (since !false = true)
    // result2 should be 0 (since !true = false)
    // total = 1 + 0 = 1
    return result1 + result2;
}
"""
    lowered = compile_stage2(source)

    # Should not have "call to unknown function" warnings for negation
    unknown_function_warnings = [
        diag for diag in lowered.diagnostics
        if "call to unknown function `!" in diag
    ]
    assert not unknown_function_warnings, f"Negation in conditions should be supported: {unknown_function_warnings}"

    # Compile and verify execution
    import llvmlite.binding as llvm
    llvm.initialize_native_target()
    llvm.initialize_native_asmprinter()
    target = llvm.Target.from_default_triple()
    target_machine = target.create_target_machine()
    backing_module = llvm.parse_assembly("")
    engine = llvm.create_mcjit_compiler(backing_module, target_machine)

    module = llvm.parse_assembly(lowered.ir)
    module.verify()
    engine.add_module(module)
    engine.finalize_object()

    try:
        main_address = engine.get_function_address("main")
        assert main_address != 0, "main function not found"
        main_func = ctypes.CFUNCTYPE(ctypes.c_longlong)(main_address)
        result = main_func()
        assert result == 1, f"Expected 1, got {result}"
    finally:
        engine.run_static_destructors()
        engine.remove_module(module)
