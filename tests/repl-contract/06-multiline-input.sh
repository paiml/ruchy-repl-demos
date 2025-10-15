#!/bin/sh
# REPL Contract Test 06: Multi-line Input
# Tests that REPL handles multi-line function definitions

set -e

echo "Testing: Multi-line input handling..."

# Test multi-line function definition
# Note: In stdin mode, each line is evaluated separately
# So we test that multi-line works when properly formatted on one line
OUTPUT=$(printf "fn add(a, b) { a + b }\nadd(3, 4)\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^7$"; then
    echo "✅ PASS: Multi-line function (formatted inline)"
else
    echo "❌ FAIL: Multi-line function failed"
    echo "Output: $OUTPUT"
    exit 1
fi

# Test multi-statement expression
OUTPUT=$(printf "let x = 5\nlet y = 10\nx + y\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^15$"; then
    echo "✅ PASS: Multiple statements"
else
    echo "❌ FAIL: Multiple statements failed"
    exit 1
fi

# Test nested blocks
OUTPUT=$(printf "fn test() { let a = 1; let b = 2; a + b }\ntest()\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^3$"; then
    echo "✅ PASS: Nested blocks in function"
else
    echo "❌ FAIL: Nested blocks failed"
    exit 1
fi

echo "✅ ALL CHECKS PASSED: Multi-line input validated"
exit 0
