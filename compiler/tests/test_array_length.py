"""
Test array .length member access in Stage2 LLVM lowering.

Arrays in LLVM are represented as { element_type*, i64 }* where field 1 is the length.
This test suite validates that .length access on array parameters and locals compiles
correctly and can be used in conditions, comparisons, and return expressions.
"""

import pytest

pytestmark = [pytest.mark.stage2,
              pytest.mark.usefixtures("stage1_environment")]


@pytest.fixture()
def compile_stage2(stage2_environment):
    def _compile(source: str, *, module_name: str = "<memory>"):
        return stage2_environment.compile_to_native_llvm(source, module_name=module_name)
    return _compile


@pytest.mark.unit
def test_native_llvm_array_length_in_condition(compile_stage2):
    """Verify array.length access works in if conditions."""
    source = """
fn has_items(items -> number[]) -> boolean {
    if items.length > 0 {
        return true;
    }
    return false;
}
"""
    result = compile_stage2(source)

    # Check that LLVM lowering completed
    assert result is not None
    assert hasattr(result, 'ir')

    # Verify the IR contains load and extractvalue for .length
    ir_content = result.ir
    assert 'load {' in ir_content  # Loading the array struct
    assert 'extractvalue' in ir_content  # Extracting the length field
    assert ', 1' in ir_content  # Field index 1 is the length
    assert 'icmp' in ir_content  # Comparison operation


@pytest.mark.unit
def test_native_llvm_array_length_return(compile_stage2):
    """Verify array.length can be returned from a function."""
    source = """
fn count_items(items -> string[]) -> int {
    return items.length;
}
"""
    result = compile_stage2(source)

    assert result is not None
    assert hasattr(result, 'ir')

    ir_content = result.ir
    # Should load the array struct and extract length field
    assert 'extractvalue' in ir_content
    assert 'i64' in ir_content  # Length is i64 type
    assert 'ret i64' in ir_content  # Return the length


@pytest.mark.unit
def test_native_llvm_array_length_comparison(compile_stage2):
    """Verify array.length can be used in comparisons between two arrays."""
    source = """
fn arrays_same_size(first -> number[], second -> number[]) -> boolean {
    if first.length == second.length {
        return true;
    }
    return false;
}
"""
    result = compile_stage2(source)

    assert result is not None
    assert hasattr(result, 'ir')

    ir_content = result.ir
    # Should extract length from both arrays and compare
    assert ir_content.count('extractvalue') >= 2  # Two arrays, two extracts
    assert 'icmp eq i64' in ir_content  # Compare the lengths


@pytest.mark.unit
def test_native_llvm_array_length_in_loop(compile_stage2):
    """Verify array.length works in loop conditions."""
    source = """
fn sum_array(numbers -> number[]) -> number {
    let mut total -> number = 0.0;
    let mut index -> int = 0;
    loop {
        if index >= numbers.length {
            break;
        }
        total += numbers[index];
        index += 1;
    }
    return total;
}
"""
    result = compile_stage2(source)

    assert result is not None
    assert hasattr(result, 'ir')

    ir_content = result.ir
    # Should extract length for the loop condition
    assert 'extractvalue' in ir_content
    assert 'icmp' in ir_content  # Comparison for loop exit


@pytest.mark.unit
def test_native_llvm_empty_array_length(compile_stage2):
    """Verify .length works on empty array literals."""
    source = """
fn check_empty() -> int {
    let empty -> number[] = [];
    return empty.length;
}
"""
    result = compile_stage2(source)

    assert result is not None
    assert hasattr(result, 'ir')

    # Should compile without errors (even if runtime behavior varies)
    ir_content = result.ir
    assert 'define' in ir_content  # Function was generated


@pytest.mark.unit
def test_native_llvm_struct_array_length(compile_stage2):
    """Verify .length works on arrays of structs."""
    source = """
struct Point {
    x -> number;
    y -> number;
}

fn count_points(points -> Point[]) -> int {
    return points.length;
}
"""
    result = compile_stage2(source)

    assert result is not None
    assert hasattr(result, 'ir')

    ir_content = result.ir
    # Should extract length from struct array
    assert 'extractvalue' in ir_content
    assert 'i64' in ir_content


@pytest.mark.unit
def test_native_llvm_array_concat_method(compile_stage2):
    """Array.concat should keep the receiver as the first runtime argument."""
    source = """
fn push(items -> number[]) -> number[] {
    return items.concat([1.0]);
}
"""
    result = compile_stage2(source)

    assert result is not None
    assert hasattr(result, 'ir')

    ir_content = result.ir
    assert '@sailfin_runtime_concat(' in ir_content
    assert '@sailfin_runtime_concat({ i8**, i64 }*' in ir_content
    assert ', { i8**, i64 }*' in ir_content


@pytest.mark.unit
def test_native_llvm_struct_array_literal_annotation(compile_stage2):
    """Empty struct array literals should respect their annotated element type."""
    source = """
struct Pair {
    left -> number;
    right -> number;
}

fn make_pairs() -> Pair[] {
    let pairs -> Pair[] = [];
    return pairs;
}
"""
    result = compile_stage2(source)

    assert result is not None
    assert hasattr(result, 'ir')

    ir_content = result.ir
    # The emitted IR should allocate the Pair array shape rather than falling back to double
    assert '{ %Pair*, i64 }' in ir_content
