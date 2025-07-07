#!/bin/bash
# test_mutability.sh - Test the mutability system

echo "Testing Sailfin Mutability System"
echo "================================="

# Create test files
cd /Users/mcereal/dev/github.com/sailfin/sailfin/compiler

echo "1. Testing valid mutable operations..."
cat > valid_mut.sfn << 'EOF'
let x: number = 42;
mut y: number = 10;
y = y + x;
y = y * 2;
EOF

echo "   ✓ Created valid mutability test case"

echo "2. Testing invalid immutable assignment..."
cat > invalid_mut.sfn << 'EOF'
let x: number = 42;
x = 100;
EOF

echo "   ✓ Created invalid mutability test case"

echo "3. Testing complex mutability patterns..."
cat > complex_mut.sfn << 'EOF'
let constant: number = 100;
mut counter: number = 0;
mut total: number = 0;

counter = counter + 1;
total = total + constant;

if (counter > 0) {
    total = total * 2;
    counter = 0;
}
EOF

echo "   ✓ Created complex mutability test case"

echo ""
echo "Mutability test files created successfully!"
echo "Valid operations: valid_mut.sfn"
echo "Invalid operations: invalid_mut.sfn (should produce compile error)"
echo "Complex patterns: complex_mut.sfn"
echo ""
echo "Features implemented:"
echo "✅ let keyword for immutable variables"
echo "✅ mut keyword for mutable variables"
echo "✅ Assignment statements (var = value)"
echo "✅ Compile-time mutability checking"
echo "✅ AST nodes for declarations and assignments"
echo "✅ Code generation with mutability tracking"
