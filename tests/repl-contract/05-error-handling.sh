#!/bin/sh
# REPL Contract Test 05: Error Handling
# Tests that REPL gracefully handles errors

set -e

echo "Testing: Error handling and recovery..."

# Test syntax error (should not crash REPL)
OUTPUT=$(printf "let x = \n2 + 2\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^4$"; then
    echo "✅ PASS: REPL recovers from syntax error"
else
    echo "❌ FAIL: REPL did not recover from error"
    echo "Output: $OUTPUT"
    exit 1
fi

# Test undefined variable (should show error but continue)
OUTPUT=$(printf "undefined_var\n5 + 5\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^10$"; then
    echo "✅ PASS: REPL continues after undefined variable"
else
    echo "❌ FAIL: REPL did not continue after error"
    exit 1
fi

# Test division (should handle gracefully)
OUTPUT=$(printf "10 / 2\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^5$"; then
    echo "✅ PASS: Division works correctly"
else
    echo "❌ FAIL: Division failed"
    exit 1
fi

echo "✅ ALL CHECKS PASSED: Error handling validated"
exit 0
