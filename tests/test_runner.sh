#!/bin/bash
# Comprehensive test runner for all demos

set -e

TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0
FAILED_FILES=()

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "========================================="
echo "Ruchy REPL & One-Liner Demo Test Suite"
echo "========================================="
echo ""

# Test REPL demos
echo "Testing REPL Demos..."
echo "---------------------"

for category in demos/repl/*/; do
    if [ -d "$category" ]; then
        category_name=$(basename "$category")
        echo "Testing category: $category_name"
        
        for demo in "$category"*.repl; do
            if [ -f "$demo" ]; then
                TOTAL_TESTS=$((TOTAL_TESTS + 1))
                demo_name=$(basename "$demo")
                
                # Try to run the demo through REPL
                if timeout 2s ruchy repl < "$demo" > /dev/null 2>&1; then
                    echo -e "  ${GREEN}✓${NC} $demo_name"
                    PASSED_TESTS=$((PASSED_TESTS + 1))
                else
                    echo -e "  ${RED}✗${NC} $demo_name"
                    FAILED_TESTS=$((FAILED_TESTS + 1))
                    FAILED_FILES+=("$demo")
                fi
            fi
        done
    fi
done

echo ""
echo "Testing One-Liner Demos..."
echo "-------------------------"

for category in demos/one-liners/*/; do
    if [ -d "$category" ]; then
        category_name=$(basename "$category")
        echo "Testing category: $category_name"
        
        for script in "$category"*.sh; do
            if [ -f "$script" ]; then
                TOTAL_TESTS=$((TOTAL_TESTS + 1))
                script_name=$(basename "$script")
                
                # Try to run the script
                if timeout 2s bash "$script" > /dev/null 2>&1; then
                    echo -e "  ${GREEN}✓${NC} $script_name"
                    PASSED_TESTS=$((PASSED_TESTS + 1))
                else
                    echo -e "  ${RED}✗${NC} $script_name"
                    FAILED_TESTS=$((FAILED_TESTS + 1))
                    FAILED_FILES+=("$script")
                fi
            fi
        done
    fi
done

echo ""
echo "========================================="
echo "Test Results Summary"
echo "========================================="
echo -e "Total Tests:  $TOTAL_TESTS"
echo -e "Passed:       ${GREEN}$PASSED_TESTS${NC}"
echo -e "Failed:       ${RED}$FAILED_TESTS${NC}"

if [ $FAILED_TESTS -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}Failed Files:${NC}"
    for file in "${FAILED_FILES[@]}"; do
        echo "  - $file"
    done
fi

SUCCESS_RATE=$((PASSED_TESTS * 100 / TOTAL_TESTS))
echo ""
echo -e "Success Rate: ${SUCCESS_RATE}%"

if [ $SUCCESS_RATE -ge 95 ]; then
    echo -e "${GREEN}✓ Quality Gate: PASSED${NC}"
    exit 0
elif [ $SUCCESS_RATE -ge 80 ]; then
    echo -e "${YELLOW}⚠ Quality Gate: WARNING${NC}"
    exit 0
else
    echo -e "${RED}✗ Quality Gate: FAILED${NC}"
    exit 1
fi