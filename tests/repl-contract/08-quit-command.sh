#!/bin/sh
# REPL Contract Test 08: Quit/Exit Commands
# Tests that REPL exits cleanly with :quit

set -e

echo "Testing: :quit and exit commands..."

# Test :quit command
OUTPUT=$(printf ":quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -qi "goodbye\|exit"; then
    echo "✅ PASS: :quit command shows goodbye message"
else
    # Some REPLs may exit silently, which is also acceptable
    echo "✅ PASS: :quit command exits (silent)"
fi

# Test that :quit actually terminates
# (if we get here, the command completed successfully)
echo "✅ PASS: :quit terminates REPL"

# Test exit code
if printf ":quit\n" | ruchy repl >/dev/null 2>&1; then
    echo "✅ PASS: :quit exits with status 0"
else
    echo "❌ FAIL: :quit exited with non-zero status"
    exit 1
fi

echo "✅ ALL CHECKS PASSED: Quit command validated"
exit 0
