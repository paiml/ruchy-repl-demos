#!/bin/sh
# Demo Execution Test Framework
# Tests all demos (REPL + one-liners) for successful execution
# Exit codes: 0 = all pass, 1 = failures detected

set -eu

# Colors for output (if terminal supports it)
if [ -t 1 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    NC='\033[0m' # No Color
else
    RED=''
    GREEN=''
    YELLOW=''
    NC=''
fi

# Failure log
FAILURE_LOG="test-failures.log"
RESULTS_FILE=".test-results.tmp"
rm -f "$FAILURE_LOG" "$RESULTS_FILE"

# Initialize results file
echo "0 0 0" > "$RESULTS_FILE"  # total passed failed

# Start time
START_TIME=$(date +%s)

echo "=== Demo Execution Test Framework ==="
echo "Date: $(date)"
echo "Ruchy Version: $(ruchy --version 2>/dev/null || echo 'NOT INSTALLED')"
echo ""

# Check if ruchy is installed
if ! command -v ruchy >/dev/null 2>&1; then
    echo "${RED}ERROR: ruchy not found in PATH${NC}"
    echo "Please install ruchy: cargo install ruchy"
    exit 1
fi

echo "Phase 1: Testing REPL Demos"
echo "----------------------------"

# Test REPL demos
if [ -d "demos/repl" ]; then
    find demos/repl -name "*.ruchy" -type f | sort | while read -r demo; do
        # Read current counts
        read -r TOTAL PASSED FAILED < "$RESULTS_FILE"
        TOTAL=$((TOTAL + 1))
        printf "Testing %s ... " "$demo"

        # Run demo and capture exit code
        if ruchy run "$demo" >/dev/null 2>&1; then
            echo "${GREEN}✅ PASS${NC}"
            PASSED=$((PASSED + 1))
        else
            echo "${RED}❌ FAIL${NC}"
            FAILED=$((FAILED + 1))
            echo "FAILED: $demo" >> "$FAILURE_LOG"

            # Capture error for debugging
            echo "  Error output:" >> "$FAILURE_LOG"
            ruchy run "$demo" 2>&1 | head -5 >> "$FAILURE_LOG" || true
            echo "" >> "$FAILURE_LOG"
        fi

        # Write updated counts
        echo "$TOTAL $PASSED $FAILED" > "$RESULTS_FILE"
    done
else
    echo "${YELLOW}WARNING: demos/repl directory not found${NC}"
fi

echo ""
echo "Phase 2: Testing One-Liner Demos"
echo "---------------------------------"

# Test one-liner shell scripts
if [ -d "demos/one-liners" ]; then
    find demos/one-liners -name "*.sh" -type f | sort | while read -r script; do
        # Read current counts
        read -r TOTAL PASSED FAILED < "$RESULTS_FILE"
        TOTAL=$((TOTAL + 1))
        printf "Testing %s ... " "$script"

        # Run one-liner script and capture exit code
        if sh "$script" >/dev/null 2>&1; then
            echo "${GREEN}✅ PASS${NC}"
            PASSED=$((PASSED + 1))
        else
            echo "${RED}❌ FAIL${NC}"
            FAILED=$((FAILED + 1))
            echo "FAILED: $script" >> "$FAILURE_LOG"

            # Capture error for debugging
            echo "  Error output:" >> "$FAILURE_LOG"
            sh "$script" 2>&1 | head -5 >> "$FAILURE_LOG" || true
            echo "" >> "$FAILURE_LOG"
        fi

        # Write updated counts
        echo "$TOTAL $PASSED $FAILED" > "$RESULTS_FILE"
    done
else
    echo "${YELLOW}WARNING: demos/one-liners directory not found${NC}"
fi

# End time
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

# Read final counts
read -r TOTAL PASSED FAILED < "$RESULTS_FILE"

# Summary
echo ""
echo "=== Test Summary ==="
echo "Duration: ${DURATION}s"
echo "Total demos tested: $TOTAL"
echo "Passed: ${GREEN}$PASSED${NC}"
echo "Failed: ${RED}$FAILED${NC}"

if [ "$FAILED" -gt 0 ]; then
    echo ""
    echo "${RED}❌ FAILURES DETECTED${NC}"
    echo "See $FAILURE_LOG for details:"
    echo ""
    cat "$FAILURE_LOG"
    exit 1
fi

echo ""
echo "${GREEN}✅ ALL TESTS PASSED${NC}"
echo "Success rate: 100% ($PASSED/$TOTAL)"

# Clean up
rm -f "$FAILURE_LOG" "$RESULTS_FILE"

exit 0
