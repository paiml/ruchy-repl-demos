#!/bin/sh
# REPL Contract Test 07: Help Command
# Tests that :help command works

set -e

echo "Testing: :help command..."

# Test :help command
OUTPUT=$(printf ":help\n:quit\n" | ruchy repl 2>&1)

# Should show some help text (we'll check for common keywords)
if echo "$OUTPUT" | grep -qi "help\|command\|quit\|exit"; then
    echo "✅ PASS: :help command shows information"
else
    echo "❌ FAIL: :help command failed"
    echo "Output: $OUTPUT"
    exit 1
fi

# REPL should still be functional after :help
OUTPUT=$(printf ":help\n2 + 2\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^4$"; then
    echo "✅ PASS: REPL functional after :help"
else
    echo "❌ FAIL: REPL not functional after :help"
    exit 1
fi

echo "✅ ALL CHECKS PASSED: Help command validated"
exit 0
