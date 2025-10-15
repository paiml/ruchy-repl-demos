#!/bin/sh
# REPL Contract Test 02: Basic Arithmetic Evaluation
# Tests that REPL correctly evaluates arithmetic expressions

set -e

echo "Testing: Basic arithmetic evaluation..."

# Test basic addition
OUTPUT=$(printf "2 + 2\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^4$"; then
    echo "✅ PASS: Addition (2 + 2 = 4)"
else
    echo "❌ FAIL: Addition failed"
    echo "Output: $OUTPUT"
    exit 1
fi

# Test multiplication
OUTPUT=$(printf "5 * 7\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^35$"; then
    echo "✅ PASS: Multiplication (5 * 7 = 35)"
else
    echo "❌ FAIL: Multiplication failed"
    exit 1
fi

# Test complex expression
OUTPUT=$(printf "(10 + 5) * 2\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^30$"; then
    echo "✅ PASS: Complex expression ((10 + 5) * 2 = 30)"
else
    echo "❌ FAIL: Complex expression failed"
    exit 1
fi

echo "✅ ALL CHECKS PASSED: Arithmetic evaluation validated"
exit 0
