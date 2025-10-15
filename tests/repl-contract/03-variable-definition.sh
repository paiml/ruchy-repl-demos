#!/bin/sh
# REPL Contract Test 03: Variable Definition
# Tests that REPL correctly defines and recalls variables

set -e

echo "Testing: Variable definition and recall..."

# Test variable definition and use
OUTPUT=$(printf "let x = 42\nx\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^42$"; then
    echo "✅ PASS: Variable definition and recall (let x = 42; x)"
else
    echo "❌ FAIL: Variable definition failed"
    echo "Output: $OUTPUT"
    exit 1
fi

# Test variable in expression
OUTPUT=$(printf "let y = 10\ny * 5\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^50$"; then
    echo "✅ PASS: Variable in expression (y * 5 = 50)"
else
    echo "❌ FAIL: Variable expression failed"
    exit 1
fi

# Test multiple variables
OUTPUT=$(printf "let a = 3\nlet b = 4\na + b\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^7$"; then
    echo "✅ PASS: Multiple variables (a + b = 7)"
else
    echo "❌ FAIL: Multiple variables failed"
    exit 1
fi

echo "✅ ALL CHECKS PASSED: Variable definition validated"
exit 0
