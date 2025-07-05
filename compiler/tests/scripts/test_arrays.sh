#!/bin/bash

# Test array functionality

echo "=== Testing Array Functionality ==="

# Test simple array creation and access
echo "1. Testing simple array creation and access..."
echo "Source code:"
cat compiler/tests/cases/simple_array_test.sfn
echo
echo "Testing lexer and parser..."

# Test the components via Python
python3 -c "
import sys
sys.path.append('bootstrap')
from lexer import lexer
from parser import parser
source = '''mut arr: array<number> = [1, 2, 3];
print(arr[0]);  // Should print 1
print(arr[1]);  // Should print 2
print(arr[2]);  // Should print 3
'''
lexer.input(source)
tokens = list(lexer)
lexer.input(source)  # Reset lexer
result = parser.parse(source, lexer=lexer)
print(f'Parse result: {result}')
print(f'Type: {type(result)}')
"
echo
# Test array manipulation in a function
echo "2. Testing array manipulation in a function..."
echo "Source code:"
cat compiler/tests/cases/array_function_test.sfn
echo
echo "Testing lexer and parser..."
python3 -c "
import sys
sys.path.append('bootstrap')
from lexer import lexer
from parser import parser
source = '''mut arr: array<number> = [1, 2, 3];
fn printArray(arr: array<number>) {
    for i in 0..arr.length {
        print(arr[i]);
    }
}
printArray(arr);  // Should print 1, 2, 3
'''
lexer.input(source)
tokens = list(lexer)
lexer.input(source)  # Reset lexer
result = parser.parse(source, lexer=lexer)
print(f'Parse result: {result}')
print(f'Type: {type(result)}')
"
echo
echo "=== Array Tests Complete ==="
echo
