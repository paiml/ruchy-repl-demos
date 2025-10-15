#!/bin/sh
# REPL Contract Test 01: Prompt Appearance
# Tests that REPL starts and displays welcome message

set -e

echo "Testing: REPL prompt appearance and startup..."

# Run REPL with :quit command
OUTPUT=$(printf ":quit\n" | ruchy repl 2>&1)

# Check for welcome message
if echo "$OUTPUT" | grep -q "Welcome to Ruchy REPL"; then
    echo "✅ PASS: Welcome message displayed"
else
    echo "❌ FAIL: Welcome message not found"
    echo "Output: $OUTPUT"
    exit 1
fi

# Check for version
if echo "$OUTPUT" | grep -q "v[0-9]\+\.[0-9]\+\.[0-9]\+"; then
    echo "✅ PASS: Version displayed"
else
    echo "❌ FAIL: Version not found"
    exit 1
fi

# Check for help hint
if echo "$OUTPUT" | grep -q ":help\|:quit"; then
    echo "✅ PASS: Help hint displayed"
else
    echo "❌ FAIL: Help hint not found"
    exit 1
fi

echo "✅ ALL CHECKS PASSED: REPL prompt appearance validated"
exit 0
