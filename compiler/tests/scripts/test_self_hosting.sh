#!/bin/bash
# Sailfin Compiler Test Suite
# This script runs comprehensive tests for the Sailfin compiler

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOTSTRAP_DIR="$SCRIPT_DIR/../../bootstrap"
CASES_DIR="$SCRIPT_DIR/cases"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"

echo "🧪 Sailfin Compiler Test Suite"
echo "==============================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to run a single test case
run_test_case() {
    local test_name="$1"
    local test_file="$2"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    printf "%-50s" "Testing: $test_name"
    
    if [[ ! -f "$test_file" ]]; then
        echo -e "${RED}MISSING${NC} - Test file not found"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 0  # Continue with other tests
    fi
    
    # Try to compile with bootstrap
    cd "$BOOTSTRAP_DIR"
    if python bootstrap.py "$test_file" > /dev/null 2>&1; then
        echo -e "${GREEN}PASS${NC}"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        echo -e "${RED}FAIL${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 0  # Don't exit, continue with other tests
    fi
}

# Function to run a test script
run_test_script() {
    local script_name="$1"
    local script_file="$SCRIPTS_DIR/$script_name"
    
    echo ""
    echo -e "${BLUE}📋 Running $script_name${NC}"
    echo "────────────────────────────────────────────────────"
    
    if [[ -f "$script_file" ]] && [[ -x "$script_file" ]]; then
        cd "$SCRIPT_DIR"
        if bash "$script_file"; then
            echo -e "${GREEN}✅ $script_name completed successfully${NC}"
        else
            echo -e "${RED}❌ $script_name failed${NC}"
        fi
    else
        echo -e "${YELLOW}⚠️  $script_name not found or not executable${NC}"
    fi
}

echo -e "${BLUE}🔍 Phase 1: Basic Compilation Tests${NC}"
echo "Testing individual .sfn files for compilation errors..."
echo ""

# Test basic language features
run_test_case "Hello World" "$CASES_DIR/hello_world_test.sfn"
run_test_case "Simple Number" "$CASES_DIR/simple_number.sfn"
run_test_case "Simple String" "$CASES_DIR/simple_string_test.sfn"
run_test_case "Simple Arithmetic" "$CASES_DIR/simple_arithmetic.sfn"
run_test_case "Simple Function" "$CASES_DIR/simple_function.sfn"

# Test mutability system
run_test_case "Valid Mutability" "$CASES_DIR/valid_mutability_test.sfn"
run_test_case "Complex Mutability" "$CASES_DIR/complex_mutability_test.sfn"

# Test control flow
run_test_case "Simple If-Return" "$CASES_DIR/simple_if_return.sfn"
run_test_case "Simple While" "$CASES_DIR/simple_while_test.sfn"
run_test_case "Simple For" "$CASES_DIR/simple_for_test.sfn"

# Test data structures
run_test_case "Array Access" "$CASES_DIR/array_access_test.sfn"
run_test_case "Struct Access" "$CASES_DIR/struct_access_test.sfn"

# Test advanced features
run_test_case "Module Import" "$CASES_DIR/test_import.sfn"
run_test_case "Complex Expressions" "$CASES_DIR/comprehensive_test.sfn"

echo ""
echo -e "${BLUE}🔍 Phase 2: Specialized Test Scripts${NC}"
echo "Running comprehensive test suites..."

# Run specialized test scripts
run_test_script "test_mutability.sh"
run_test_script "test_self_hosting.sh"
run_test_script "test_arrays.sh"
run_test_script "test_strings.sh"
run_test_script "test_modules.sh"

echo ""
echo -e "${BLUE}📊 Test Results Summary${NC}"
echo "==============================="
echo -e "Total Tests:  ${TOTAL_TESTS}"
echo -e "Passed:       ${GREEN}${PASSED_TESTS}${NC}"
echo -e "Failed:       ${RED}${FAILED_TESTS}${NC}"

if [[ $FAILED_TESTS -eq 0 ]]; then
    echo -e "${GREEN}🎉 All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}❌ Some tests failed.${NC}"
    exit 1
fi
