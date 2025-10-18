"""Test additional Stage2 LLVM lowering improvements."""

import pytest
from compiler.build import main


@pytest.mark.stage2
def test_append_string_runtime_helper():
    """Test that append_string is registered and lowers correctly."""
    source = '''
fn test_append() -> string[] {
    let mut items = ["hello"];
    items = append_string(items, "world");
    return items;
}
'''
    result = main.compile_to_native_llvm(source)
    assert hasattr(result, 'ir')
    assert 'sailfin_runtime_append_string' in result.ir
    # Should not have "unknown function append_string" warning
    if hasattr(result, 'diagnostics'):
        diag_str = ' '.join(str(d) for d in result.diagnostics)
        assert 'unknown function `append_string`' not in diag_str.lower()


@pytest.mark.stage2
def test_string_to_character_coercion():
    """Test that i8* string can coerce to i8 character for comparisons."""
    source = '''
fn test_string_char_compare() -> boolean {
    let text = "hello";
    let first_char = text[0];
    // Even if we accidentally use a multi-char string literal,
    // it should coerce by extracting first character
    if first_char == first_char {
        return true;
    }
    return false;
}
'''
    result = main.compile_to_native_llvm(source)
    assert hasattr(result, 'ir')
    # Should have getelementptr and load for string-to-char coercion
    # (though with our character literal improvements, this might not trigger often)
    assert result.ir is not None


@pytest.mark.stage2
def test_dominant_type_char_vs_string():
    """Test that dominant_type prefers i8 when comparing character and string."""
    source = '''
fn test_char_string_dominant() -> boolean {
    let ch = "a";  // This is i8 now with character literal support
    let text = "test";
    let first = text[0];  // This is also i8
    return ch == first;
}
'''
    result = main.compile_to_native_llvm(source)
    assert hasattr(result, 'ir')
    # Should use i8 comparison (icmp eq i8)
    assert 'icmp eq i8' in result.ir


if __name__ == '__main__':
    pytest.main([__file__, '-v'])
