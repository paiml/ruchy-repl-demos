#!/bin/sh
# REPL Contract Test 09: Data Structures
# Tests that REPL handles arrays and records

set -e

echo "Testing: Data structures (arrays and records)..."

# Test array creation and indexing
OUTPUT=$(printf "let arr = [1, 2, 3, 4, 5]\narr[2]\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^3$"; then
    echo "✅ PASS: Array creation and indexing"
else
    echo "❌ FAIL: Array indexing failed"
    echo "Output: $OUTPUT"
    exit 1
fi

# Test array with map
OUTPUT=$(printf "let nums = [1, 2, 3]\nnums.map(|x| x * 2)\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "\[2, 4, 6\]"; then
    echo "✅ PASS: Array map operation"
else
    echo "❌ FAIL: Array map failed"
    exit 1
fi

# Test record creation and field access
OUTPUT=$(printf "let person = {name: \"Alice\", age: 30}\nperson.age\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^30$"; then
    echo "✅ PASS: Record creation and field access"
else
    echo "❌ FAIL: Record access failed"
    exit 1
fi

echo "✅ ALL CHECKS PASSED: Data structures validated"
exit 0
