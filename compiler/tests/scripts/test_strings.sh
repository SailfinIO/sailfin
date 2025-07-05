#!/bin/bash

# Test the codegen component with string literals using the bootstrap compiler

echo "=== Testing String Codegen Implementation ==="
echo

# First test: Simple string with print
echo "1. Testing lexer with string literals..."
echo 'Test source: print("Hello, World!");'

# Let's test the lexer directly via Python
python3 -c "
import sys
sys.path.append('bootstrap')
from lexer import lexer

source = 'print(\"Hello, World!\");'
lexer.input(source)

print('Tokens generated:')
for tok in lexer:
    print(f'  {tok.type}: {tok.value}')
"
echo

# Second test: Test the parser
echo "2. Testing parser with string literals..."
python3 -c "
import sys
sys.path.append('bootstrap')
from lexer import lexer
from parser import parser

source = 'print(\"Hello, World!\");'
lexer.input(source)
tokens = list(lexer)
lexer.input(source)  # Reset lexer

result = parser.parse(source, lexer=lexer)
print(f'Parse result: {result}')
print(f'Type: {type(result)}')
"
echo

echo "=== String Tests Complete ==="
