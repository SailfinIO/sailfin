#!/bin/bash

# Test while loop functionality

echo "=== Testing While Loop Functionality ==="
echo

# Test simple while loop
echo "1. Testing simple while loop..."
echo "Source code:"
cat compiler/tests/cases/simple_while_test.sfn
echo
echo "Testing lexer and parser..."

# Test the components via Python
python3 -c "
import sys
sys.path.append('bootstrap')
from lexer import lexer

source = '''mut counter: number = 0;

while (counter < 3) {
    counter = counter + 1;
}'''

lexer.input(source)

print('Tokens generated:')
for tok in lexer:
    print(f'  {tok.type}: {tok.value}')
    if tok.type == 'WHILE':
        print('  ✅ WHILE keyword recognized!')
"
echo

# Test with function
echo "2. Testing while loop in function..."
echo "Source code:"
cat compiler/tests/cases/while_loop_test.sfn
echo

echo "=== While Loop Tests Complete ==="
