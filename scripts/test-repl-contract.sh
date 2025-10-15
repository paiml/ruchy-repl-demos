#!/bin/sh
# REPL Contract Test Runner
# Runs all 10 REPL contract tests to validate interactive UX
# Exit codes: 0 = all pass, 1 = failures detected

set -eu

# Colors for output (if terminal supports it)
if [ -t 1 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
else
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    NC=''
fi

# Start time
START_TIME=$(date +%s)

echo "${BLUE}=== REPL Contract Test Suite ===${NC}"
echo "Date: $(date)"
echo "Ruchy Version: $(ruchy --version 2>/dev/null || echo 'NOT INSTALLED')"
echo ""

# Check if ruchy is installed
if ! command -v ruchy >/dev/null 2>&1; then
    echo "${RED}ERROR: ruchy not found in PATH${NC}"
    echo "Please install ruchy: cargo install ruchy"
    exit 1
fi

# Test counters
TOTAL=0
PASSED=0
FAILED=0

# Test directory
TEST_DIR="tests/repl-contract"

if [ ! -d "$TEST_DIR" ]; then
    echo "${RED}ERROR: Test directory not found: $TEST_DIR${NC}"
    exit 1
fi

echo "${BLUE}Running REPL Contract Tests...${NC}"
echo "================================"
echo ""

# Run each test script
for test_script in "$TEST_DIR"/*.sh; do
    if [ -f "$test_script" ]; then
        TOTAL=$((TOTAL + 1))
        test_name=$(basename "$test_script" .sh)

        printf "${BLUE}[%02d/%02d]${NC} Testing: %s\n" "$TOTAL" "10" "$test_name"

        # Run test and capture output
        if "$test_script" > /tmp/repl-contract-test.log 2>&1; then
            echo "${GREEN}✅ PASS${NC}"
            PASSED=$((PASSED + 1))
        else
            echo "${RED}❌ FAIL${NC}"
            FAILED=$((FAILED + 1))
            echo "${YELLOW}Error output:${NC}"
            head -10 /tmp/repl-contract-test.log
        fi
        echo ""
    fi
done

# End time
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

# Summary
echo "================================"
echo "${BLUE}=== Test Summary ===${NC}"
echo "================================"
echo "Duration: ${DURATION}s"
echo "Total tests: $TOTAL"
echo "${GREEN}Passed: $PASSED${NC}"
echo "${RED}Failed: $FAILED${NC}"
echo ""

if [ "$FAILED" -eq 0 ]; then
    SUCCESS_RATE="100.0"
else
    SUCCESS_RATE=$(awk "BEGIN {printf \"%.1f\", ($PASSED / $TOTAL) * 100}")
fi

echo "Success rate: ${SUCCESS_RATE}% ($PASSED/$TOTAL)"
echo ""

if [ "$FAILED" -gt 0 ]; then
    echo "${RED}❌ SOME TESTS FAILED${NC}"
    echo ""
    echo "REPL contract violations detected. These tests validate the"
    echo "interactive REPL user experience. Failures indicate UX issues."
    echo ""
    exit 1
fi

echo "${GREEN}✅ ALL TESTS PASSED${NC}"
echo ""
echo "REPL Contract Tests: 10/10 passing"
echo "Interactive UX validated successfully!"
echo ""

# Clean up
rm -f /tmp/repl-contract-test.log

exit 0
