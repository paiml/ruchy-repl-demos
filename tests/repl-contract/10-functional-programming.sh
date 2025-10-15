#!/bin/sh
# REPL Contract Test 10: Functional Programming
# Tests that REPL handles functional programming features

set -e

echo "Testing: Functional programming features..."

# Test lambda/closure
OUTPUT=$(printf "let double = |x| x * 2\ndouble(21)\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^42$"; then
    echo "✅ PASS: Lambda/closure (double(21) = 42)"
else
    echo "❌ FAIL: Lambda failed"
    echo "Output: $OUTPUT"
    exit 1
fi

# Test higher-order function
OUTPUT=$(printf "let apply_twice = |f, x| f(f(x))\nlet inc = |x| x + 1\napply_twice(inc, 5)\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^7$"; then
    echo "✅ PASS: Higher-order function (apply_twice(inc, 5) = 7)"
else
    echo "❌ FAIL: Higher-order function failed"
    exit 1
fi

# Test filter operation (use %% to escape % in printf)
OUTPUT=$(printf "let nums = [1, 2, 3, 4, 5, 6]\nnums.filter(|x| x %% 2 == 0)\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "\[2, 4, 6\]"; then
    echo "✅ PASS: Filter operation"
else
    echo "❌ FAIL: Filter failed"
    exit 1
fi

echo "✅ ALL CHECKS PASSED: Functional programming validated"
exit 0
