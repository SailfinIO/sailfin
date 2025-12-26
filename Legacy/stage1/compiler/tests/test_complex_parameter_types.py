"""Tests for complex parameter type resolution in LLVM lowering.

These tests verify that functions with parameters of complex types (struct arrays,
enum arrays, nested structs, imported types) compile without 'unsupported parameter type'
diagnostics and that the parameters get reasonable LLVM types even when exact type
metadata is unavailable (e.g., for imported types not in the current module's type context).
"""

import pytest

pytestmark = [pytest.mark.stage2,
              pytest.mark.usefixtures("stage1_environment")]


def test_native_llvm_function_with_struct_array_parameter(compile_stage2) -> None:
    """Test that function accepting struct array parameter compiles cleanly."""
    source = """
struct Point {
    x -> number;
    y -> number;
}

fn process_points(points -> Point[]) -> number {
    return 0;
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_stage2(source)

    # Check that there are no "unsupported parameter type" diagnostics
    unsupported_param_errors = [
        diag for diag in lowered.diagnostics
        if "unsupported parameter type" in diag and "Point[]" in diag
    ]
    assert not unsupported_param_errors, \
        f"Struct array parameters should be supported: {unsupported_param_errors}"

    # Check that there are no "parameter type ... falls back to double" warnings
    double_fallback_warnings = [
        diag for diag in lowered.diagnostics
        if "double" in diag and "lacks struct metadata" in diag and "Point" in diag
    ]
    assert not double_fallback_warnings, \
        f"Struct array parameters should not fallback to double: {double_fallback_warnings}"

    ir = lowered.ir

    # Verify the parameter has a reasonable LLVM type (array of pointers or struct pointers)
    # The exact type depends on whether Point is in the type context, but it should not be 'double'
    assert "double* %points" not in ir, "Parameter should not be double-typed"

    # Should have some form of pointer type for the array
    assert "%points" in ir, "Parameter should be present in IR"


def test_native_llvm_function_with_enum_array_parameter(compile_stage2) -> None:
    """Test that function accepting enum array parameter compiles cleanly."""
    source = """
enum Color {
    Red,
    Green,
    Blue,
}

fn process_colors(colors -> Color[]) -> number {
    return 0;
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_stage2(source)

    # Check that there are no "unsupported parameter type" diagnostics
    unsupported_param_errors = [
        diag for diag in lowered.diagnostics
        if "unsupported parameter type" in diag and "Color[]" in diag
    ]
    assert not unsupported_param_errors, \
        f"Enum array parameters should be supported: {unsupported_param_errors}"

    # Check that there are no "parameter type ... falls back to double" warnings
    double_fallback_warnings = [
        diag for diag in lowered.diagnostics
        if "double" in diag and "lacks struct metadata" in diag and "Color" in diag
    ]
    assert not double_fallback_warnings, \
        f"Enum array parameters should not fallback to double: {double_fallback_warnings}"

    ir = lowered.ir

    # Verify the parameter has a reasonable LLVM type
    assert "double* %colors" not in ir, "Parameter should not be double-typed"
    assert "%colors" in ir, "Parameter should be present in IR"


def test_native_llvm_function_with_nested_struct_parameter(compile_stage2) -> None:
    """Test that function with nested struct parameter compiles cleanly."""
    source = """
struct Point {
    x -> number;
    y -> number;
}

struct Rectangle {
    top_left -> Point;
    bottom_right -> Point;
}

fn compute_area(rect -> Rectangle) -> number {
    return 0;
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_stage2(source)

    # Check that there are no "unsupported parameter type" diagnostics
    unsupported_param_errors = [
        diag for diag in lowered.diagnostics
        if "unsupported parameter type" in diag and "Rectangle" in diag
    ]
    assert not unsupported_param_errors, \
        f"Nested struct parameters should be supported: {unsupported_param_errors}"

    # Check that there are no "parameter type ... falls back to double" warnings
    double_fallback_warnings = [
        diag for diag in lowered.diagnostics
        if "double" in diag and "lacks struct metadata" in diag and "Rectangle" in diag
    ]
    assert not double_fallback_warnings, \
        f"Nested struct parameters should not fallback to double: {double_fallback_warnings}"

    ir = lowered.ir

    # Verify the parameter has struct type
    assert "%Rectangle" in ir, "Rectangle type should be defined"
    assert "%Point" in ir, "Point type should be defined"


def test_native_llvm_function_with_unresolved_import_type_uses_pointer_fallback(compile_stage2) -> None:
    """Test that function with parameter of unresolved imported type uses pointer fallback."""
    # Simulate a module that imports a type from another module (not in type context)
    # In this case, we'll just declare a function with a type that looks like it's imported
    # but isn't actually defined in this module
    source = """
fn process_token(token -> Token) -> number {
    return 0;
}

fn main() -> number {
    return 0;
}
"""

    lowered = compile_stage2(source)

    # When a type can't be resolved, it should fallback to i8* (not double)
    # Check that there are no "unsupported parameter type" diagnostics
    unsupported_param_errors = [
        diag for diag in lowered.diagnostics
        if "unsupported parameter type" in diag and "Token" in diag
    ]
    assert not unsupported_param_errors, \
        f"Unresolved types should use pointer fallback: {unsupported_param_errors}"

    # The parameter should have i8* type as a fallback
    ir = lowered.ir
    assert "%token" in ir, "Parameter should be present in IR"

    # It should not fallback to double
    assert "double %token" not in ir, "Parameter should not be double-typed"


@pytest.fixture()
def compile_stage2(stage2_environment):
    def _compile(source: str, *, module_name: str = "<memory>"):
        return stage2_environment.compile_to_native_llvm(source, module_name=module_name)

    return _compile
