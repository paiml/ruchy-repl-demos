#!/bin/sh
# REPL Contract Test 04: Function Definition
# Tests that REPL correctly defines and calls functions

set -e

echo "Testing: Function definition and invocation..."

# Test simple function
OUTPUT=$(printf "fn double(x) { x * 2 }\ndouble(5)\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^10$"; then
    echo "✅ PASS: Function definition (double(5) = 10)"
else
    echo "❌ FAIL: Function definition failed"
    echo "Output: $OUTPUT"
    exit 1
fi

# Test closure
OUTPUT=$(printf "let add_n = |x| |y| x + y\nlet add_5 = add_n(5)\nadd_5(3)\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^8$"; then
    echo "✅ PASS: Closure function (add_5(3) = 8)"
else
    echo "❌ FAIL: Closure failed"
    exit 1
fi

# Test recursive function
OUTPUT=$(printf "fn fact(n) { if n <= 1 { 1 } else { n * fact(n - 1) } }\nfact(5)\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^120$"; then
    echo "✅ PASS: Recursive function (fact(5) = 120)"
else
    echo "❌ FAIL: Recursive function failed"
    exit 1
fi

echo "✅ ALL CHECKS PASSED: Function definition validated"
exit 0
