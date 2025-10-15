#!/bin/sh
# Demo Execution Test Framework (Verbose Mode)
# Shows full output from each demo execution
# Useful for debugging and seeing what demos actually do

set -eu

# Colors for output
if [ -t 1 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m'
else
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    NC=''
fi

# Counters
TOTAL=0
PASSED=0
FAILED=0

echo "=== Demo Execution Test Framework (VERBOSE) ==="
echo "Date: $(date)"
echo "Ruchy Version: $(ruchy --version 2>/dev/null || echo 'NOT INSTALLED')"
echo ""

# Check if ruchy is installed
if ! command -v ruchy >/dev/null 2>&1; then
    echo "${RED}ERROR: ruchy not found in PATH${NC}"
    exit 1
fi

echo "Phase 1: Testing REPL Demos (Verbose)"
echo "======================================"
echo ""

# Test REPL demos with full output
if [ -d "demos/repl" ]; then
    find demos/repl -name "*.ruchy" -type f | sort | while read -r demo; do
        TOTAL=$((TOTAL + 1))

        echo "${BLUE}----------------------------------------${NC}"
        echo "${BLUE}Running: $demo${NC}"
        echo "${BLUE}----------------------------------------${NC}"

        # Run demo with full output
        if ruchy run "$demo"; then
            echo "${GREEN}✅ PASS${NC}"
            PASSED=$((PASSED + 1))
        else
            echo "${RED}❌ FAIL${NC}"
            FAILED=$((FAILED + 1))
        fi
        echo ""
    done
else
    echo "${YELLOW}WARNING: demos/repl directory not found${NC}"
fi

echo ""
echo "Phase 2: Testing One-Liner Demos (Verbose)"
echo "==========================================="
echo ""

# Test one-liner scripts with full output
if [ -d "demos/one-liners" ]; then
    find demos/one-liners -name "*.sh" -type f | sort | while read -r script; do
        TOTAL=$((TOTAL + 1))

        echo "${BLUE}----------------------------------------${NC}"
        echo "${BLUE}Running: $script${NC}"
        echo "${BLUE}----------------------------------------${NC}"

        # Run script with full output
        if sh "$script"; then
            echo "${GREEN}✅ PASS${NC}"
            PASSED=$((PASSED + 1))
        else
            echo "${RED}❌ FAIL${NC}"
            FAILED=$((FAILED + 1))
        fi
        echo ""
    done
else
    echo "${YELLOW}WARNING: demos/one-liners directory not found${NC}"
fi

# Summary
echo ""
echo "=== Test Summary ==="
echo "Total demos tested: $TOTAL"
echo "Passed: ${GREEN}$PASSED${NC}"
echo "Failed: ${RED}$FAILED${NC}"

if [ "$FAILED" -gt 0 ]; then
    echo ""
    echo "${RED}❌ SOME TESTS FAILED${NC}"
    exit 1
fi

echo ""
echo "${GREEN}✅ ALL TESTS PASSED${NC}"
exit 0
