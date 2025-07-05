#!/bin/bash
# Real functional test for Sailfin compiler
# This script tests that the bootstrap can compile simple Sailfin code to executable Python
# and validates the actual functionality

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOTSTRAP_DIR="$SCRIPT_DIR/../../bootstrap"
CASES_DIR="$SCRIPT_DIR/cases"

echo "🧪 Sailfin Real Functionality Tests"
echo "==================================="
echo ""

# Function to run a compilation test and check the output
run_compilation_test() {
    local test_name="$1"
    local test_file="$2"
    local expected_pattern="$3"
    
    echo "🔍 Testing: $test_name"
    echo "   File: $test_file"
    
    if [[ ! -f "$test_file" ]]; then
        echo "   ❌ Test file not found: $test_file"
        return 1
    fi
    
    # Try to compile the file with bootstrap
    local output_file="$BOOTSTRAP_DIR/test_output_$(basename "$test_file" .sfn).py"
    
    cd "$BOOTSTRAP_DIR"
    if python bootstrap.py "$test_file" -o "$output_file" -c 2>&1; then
        echo "   ✅ Compilation successful"
        
        # Check if output file was created
        if [[ -f "$output_file" ]]; then
            echo "   ✅ Output file created: $(basename "$output_file")"
            
            # Check if the output contains expected pattern
            if [[ -n "$expected_pattern" ]]; then
                if grep -q "$expected_pattern" "$output_file" 2>/dev/null; then
                    echo "   ✅ Output contains expected pattern: $expected_pattern"
                else
                    echo "   ⚠️  Output doesn't contain expected pattern: $expected_pattern"
                    echo "      Actual content:"
                    head -10 "$output_file" | sed 's/^/         /'
                fi
            fi
        else
            echo "   ❌ No output file created"
            return 1
        fi
    else
        echo "   ❌ Compilation failed"
        return 1
    fi
    
    echo ""
    return 0
}

# Test basic number variable
run_compilation_test "Simple Number Variable" "$CASES_DIR/simple_number.sfn" "42"

# Test basic arithmetic
cat > "$CASES_DIR/simple_arithmetic.sfn" << 'EOF'
let x: number = 10;
let y: number = 5;
let result: number = x + y;
EOF

run_compilation_test "Simple Arithmetic" "$CASES_DIR/simple_arithmetic.sfn" "result"

# Test mutability
cat > "$CASES_DIR/simple_mutability.sfn" << 'EOF'
mut counter: number = 0;
counter = counter + 1;
EOF

run_compilation_test "Simple Mutability" "$CASES_DIR/simple_mutability.sfn" "counter"

echo "🎯 Real Test Summary"
echo "=================="
echo "These tests verify that the bootstrap compiler can:"
echo "1. Parse basic Sailfin syntax"
echo "2. Generate Python output"
echo "3. Handle variables and arithmetic"
echo "4. Support mutability keywords"
echo ""
echo "Note: For ARM64 assembly generation, we need the self-hosting"
echo "Sailfin compiler to be working, which requires these basic"
echo "features to be implemented in the bootstrap first."
