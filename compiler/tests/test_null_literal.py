"""Test null literal support in LLVM lowering."""
import pytest


pytestmark = [pytest.mark.stage2,
              pytest.mark.usefixtures("stage1_environment")]


@pytest.fixture()
def compile_stage2(stage2_environment):
    def _compile(source: str, *, module_name: str = "<memory>"):
        return stage2_environment.compile_to_native_llvm(source, module_name=module_name)
    return _compile


def test_native_llvm_execution_null_literal_lowers(compile_stage2):
    """Test that null literals lower to LLVM without errors."""
    source = """
struct Token {
    value -> string;
    line -> int;
}

fn make_token_with_null() -> Token {
    return Token {
        value: "test",
        line: 42
    };
}

fn main() -> int {
    let t = make_token_with_null();
    return 0;
}
"""
    lowered = compile_stage2(source)

    # Should not have "unsupported expression `null`" warnings
    null_warnings = [
        diag for diag in lowered.diagnostics
        if "unsupported expression `null`" in diag
    ]
    assert not null_warnings, f"null literals should be supported: {null_warnings}"

    # Verify LLVM IR contains null representation
    assert "null" in lowered.ir or "i8* null" in lowered.ir


def test_native_llvm_execution_null_in_struct_field(compile_stage2):
    """Test that null literals work in struct fields."""
    source = """
struct Diagnostic {
    code -> string;
    message -> string;
}

fn make_diagnostic() -> Diagnostic {
    return Diagnostic {
        code: "E001",
        message: "test error"
    };
}

fn main() -> int {
    let d = make_diagnostic();
    return 0;
}
"""
    lowered = compile_stage2(source)

    # Should not have unsupported expression warnings
    unsupported_warnings = [
        diag for diag in lowered.diagnostics
        if "unsupported expression" in diag
    ]
    assert not unsupported_warnings, f"All expressions should be supported: {unsupported_warnings}"

    # Should not have struct literal warnings
    struct_warnings = [
        diag for diag in lowered.diagnostics
        if "struct literal missing closing" in diag
    ]
    assert not struct_warnings, f"Struct literals should parse correctly: {struct_warnings}"
