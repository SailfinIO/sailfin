"""Test Stage2 LLVM lowering improvements for string operations and character literals."""

import pytest
from compiler.build import main


@pytest.mark.stage2
def test_character_literal_lowering():
    """Test that single-character string literals lower to i8 type."""
    source = '''
fn test_char() -> number {
    let ch = "a";
    return 97;
}
'''
    result = main.compile_to_native_llvm(source)
    assert hasattr(result, 'ir')
    assert 'i8 97' in result.ir, "Character literal should lower to i8 with ASCII value"


@pytest.mark.stage2
def test_substring_runtime_helper_registered():
    """Test that substring function is registered as a runtime helper."""
    source = '''
fn test_substring() -> string {
    let text = "hello";
    let result = substring(text, 0, 3);
    return result;
}
'''
    result = main.compile_to_native_llvm(source)
    assert hasattr(result, 'ir')
    # Should have the runtime helper declaration
    assert 'sailfin_runtime_substring' in result.ir
    # Should not have "unknown function substring" warning
    if hasattr(result, 'diagnostics'):
        diag_str = ' '.join(str(d) for d in result.diagnostics)
        assert 'unknown function `substring`' not in diag_str.lower()


@pytest.mark.stage2
def test_string_length_property_lowering():
    """Ensure string.length lowers to the runtime helper call."""
    source = '''
fn string_length(text -> string) -> int {
    return text.length;
}
'''
    result = main.compile_to_native_llvm(source)
    assert hasattr(result, 'ir')
    ir = result.ir
    assert 'declare i64 @sailfin_runtime_string_length' in ir
    assert '@sailfin_runtime_string_length' in ir
    assert 'call i64 @sailfin_runtime_string_length' in ir


@pytest.mark.stage2
def test_character_classification_helpers_registered():
    """Test that is_whitespace_char, is_decimal_digit, is_alpha_char are registered."""
    source = '''
fn test_char_helpers() -> boolean {
    let ch = "a";
    let is_ws = is_whitespace_char(" ");
    let is_digit = is_decimal_digit("5");
    let is_alpha = is_alpha_char("z");
    return true;
}
'''
    result = main.compile_to_native_llvm(source)
    assert hasattr(result, 'ir')
    # Should have runtime helper declarations
    assert 'sailfin_runtime_is_whitespace_char' in result.ir
    assert 'sailfin_runtime_is_decimal_digit' in result.ir
    assert 'sailfin_runtime_is_alpha_char' in result.ir


@pytest.mark.stage2
def test_character_comparison():
    """Test that character comparisons work (i8 == i8)."""
    source = '''
fn test_char_cmp() -> boolean {
    let text = "test";
    let first = text[0];
    if first == "t" {
        return true;
    }
    return false;
}
'''
    result = main.compile_to_native_llvm(source)
    assert hasattr(result, 'ir')
    # Should have i8 comparison (icmp eq i8)
    assert 'icmp eq i8' in result.ir
    # Should not have type mismatch errors between i8 and i8*
    if hasattr(result, 'diagnostics'):
        diag_str = ' '.join(str(d) for d in result.diagnostics)
        assert 'unable to convert right operand from `i8*` to `i8`' not in diag_str


@pytest.mark.stage2
def test_escape_sequence_character_literals():
    """Test that escape sequences in character literals work."""
    source = '''
fn test_escape_chars() -> boolean {
    let newline = "\\n";
    let tab = "\\t";
    return true;
}
'''
    result = main.compile_to_native_llvm(source)
    assert hasattr(result, 'ir')
    # Should lower escape sequences to their ASCII values
    # \n = 10, \t = 9
    assert 'i8 10' in result.ir or 'i8 9' in result.ir


@pytest.mark.stage2
def test_string_addition_lowering():
    """Ensure string addition lowers to the runtime concat helper instead of pointer math."""
    source = '''
fn join(first -> string, second -> string) -> string {
    return first + second;
}
'''
    result = main.compile_to_native_llvm(source)
    assert hasattr(result, 'ir')
    ir = result.ir
    assert '@sailfin_runtime_string_concat' in ir
    assert 'call i8* @sailfin_runtime_string_concat' in ir
    assert ' = add i8*' not in ir


if __name__ == '__main__':
    pytest.main([__file__, '-v'])
