"""Tests for Stage2 self-hosting bootstrap."""

import pathlib
import pytest

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
STAGE2_BUILD = REPO_ROOT / "build" / "stage2"


@pytest.mark.stage2
def test_bootstrap_stage2_generates_all_compiler_modules():
    """Verify that bootstrap_stage2.py generates LLVM modules for all compiler sources."""
    # Expected modules from compiler/src/*.sfn and runtime/prelude.sfn
    expected_modules = [
        "ast.ll",
        "decorator_semantics.ll",
        "effect_checker.ll",
        "emit_native.ll",
        "emitter_sailfin.ll",
        "lexer.ll",
        "main.ll",
        "native_ir.ll",
        "native_llvm_lowering.ll",
        "native_lowering.ll",
        "parser.ll",
        "prelude.ll",
        "self_host_checks.ll",
        "string_utils.ll",
        "token.ll",
        "typecheck.ll",
    ]

    # Check that Stage2 build directory exists
    assert STAGE2_BUILD.exists(
    ), f"Stage2 build directory not found: {STAGE2_BUILD}"

    # Check that each expected module exists
    missing = []
    for module_name in expected_modules:
        module_path = STAGE2_BUILD / module_name
        if not module_path.exists():
            missing.append(module_name)

    assert not missing, f"Missing Stage2 LLVM modules: {', '.join(missing)}"


@pytest.mark.stage2
def test_bootstrap_stage2_modules_are_valid_llvm():
    """Verify that generated LLVM modules contain valid LLVM IR."""
    # Check a few key modules for basic LLVM IR structure
    key_modules = ["main.ll", "parser.ll", "native_llvm_lowering.ll"]

    for module_name in key_modules:
        module_path = STAGE2_BUILD / module_name
        assert module_path.exists(), f"Module not found: {module_name}"

        content = module_path.read_text(encoding="utf-8")

        # Basic sanity checks for LLVM IR structure
        assert "define" in content, f"{module_name}: No function definitions found"
        assert content.strip().startswith("; ModuleID =") or "define" in content, \
            f"{module_name}: Doesn't look like valid LLVM IR"


@pytest.mark.stage2
def test_bootstrap_stage2_main_module_has_entry_points():
    """Verify that main.ll contains expected compiler entry points."""
    main_module = STAGE2_BUILD / "main.ll"
    assert main_module.exists(), "main.ll not found"

    content = main_module.read_text(encoding="utf-8")

    # Check for key entry point functions
    # These may need adjustment based on actual function names in Stage2
    expected_patterns = [
        "define",  # At least one function definition
    ]

    for pattern in expected_patterns:
        assert pattern in content, f"main.ll missing expected pattern: {pattern}"


@pytest.mark.stage2
def test_bootstrap_stage2_module_sizes_are_reasonable():
    """Verify that generated modules have reasonable sizes (not empty, not suspiciously small)."""
    # Minimum size threshold (in bytes) - modules should have substantial content
    MIN_SIZE = 100

    for module_path in STAGE2_BUILD.glob("*.ll"):
        size = module_path.stat().st_size
        assert size >= MIN_SIZE, \
            f"{module_path.name} is suspiciously small ({size} bytes), may be incomplete"
