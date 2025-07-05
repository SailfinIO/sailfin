# Sailfin Compiler Tests

This directory contains the test suite for the Sailfin self-hosting compiler.

## Directory Structure

```
tests/
├── run_tests.sh              # Master test runner (✅ Working)
├── scripts/                  # Test automation scripts
│   ├── test_self_hosting.sh  # Self-hosting verification
│   ├── test_mutability.sh    # Mutability system tests
│   ├── test_arrays.sh        # Array functionality tests
│   ├── test_strings.sh       # String handling tests
│   └── test_modules.sh       # Module system tests
├── cases/                    # Test case files (.sfn)
│   ├── demo.sfn              # Basic language features demo
│   ├── mutability_test.sfn   # Mutability and assignment tests
│   ├── comprehensive_test.sfn # Complex language constructs
│   ├── test_import.sfn       # Module import/export functionality test
│   ├── test_module.sfn       # Sample module for import testing
│   └── *.sfn                 # 40+ additional feature-specific tests
```

## Recent Cleanup (July 5, 2025)

- ✅ **Organized Test Structure**: Moved all `.sfn` test files to `cases/` directory
- ✅ **Updated Master Test Runner**: `run_tests.sh` now runs comprehensive test suite
- ✅ **Fixed Test Cases**: Updated incompatible tests (e.g., C-style for loops → while loops)
- ✅ **Added Module Tests**: `test_import.sfn` and `test_module.sfn` for import functionality
- ✅ **Clean Output**: Colored output with clear PASS/FAIL indicators

## Current Test Results
```
🧪 Sailfin Compiler Test Suite
===============================
📊 Test Results Summary
Total Tests:  14
Passed:       14
Failed:       0
🎉 All tests passed!
```

## Running Tests

### Run All Tests
```bash
cd compiler/tests
./run_tests.sh
```

### Run Individual Test Scripts
```bash
# Test mutability system
./scripts/test_mutability.sh

# Test self-hosting capabilities  
./scripts/test_self_hosting.sh
```

## Test Categories

### 1. Syntax Tests (`cases/`)
- Verify parser can handle all language constructs
- Test complex expressions and statements
- Validate mutability rules

### 2. Compiler Tests (`scripts/`)
- Test entire compilation pipeline
- Verify code generation
- Check error handling

### 3. Feature Tests
- **Lexical Analysis**: Token recognition, operators, literals
- **Parsing**: AST construction, precedence, error recovery  
- **Code Generation**: ARM64 assembly, register allocation
- **Mutability**: Compile-time checking, assignment validation

## Adding New Tests

### Test Cases
1. Create a new `.sfn` file in `cases/`
2. Add the test to `run_tests.sh`
3. Document expected behavior

### Test Scripts
1. Create a new script in `scripts/`
2. Make it executable (`chmod +x`)
3. Follow naming convention: `test_<feature>.sh`

## Test Status

- ✅ **Lexer**: Complete token recognition
- ✅ **Parser**: All major constructs supported
- ✅ **AST**: Complete node definitions
- ✅ **CodeGen**: ARM64 assembly generation
- ✅ **Mutability**: Compile-time enforcement
- 🚧 **Functions**: In development
- 🚧 **Loops**: Planned
- 🚧 **Structs**: Planned
