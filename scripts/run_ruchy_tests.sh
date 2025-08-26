#!/bin/sh
set -eu

# Ruchy Test Runner Script
# Uses native Ruchy test command for all testing

echo "🧪 Running Ruchy Test Suite"
echo "============================"
echo ""

# Track overall results
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to run a test file
run_test() {
    test_file="$1"
    test_name="$(basename "$test_file" .ruchy)"
    
    echo "📦 Running: $test_name"
    
    if ruchy test "$test_file" > /tmp/test_output.txt 2>&1; then
        printf "  ✅ PASSED\n"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        
        # Extract test counts from output if available
        if grep -q "Total tests:" /tmp/test_output.txt; then
            cat /tmp/test_output.txt | grep -E "Total tests:|Passed:|Failed:" | sed 's/^/    /'
        fi
    else
        printf "  ❌ FAILED\n"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        
        # Show error output
        printf "    Error output:\n"
        cat /tmp/test_output.txt | head -20 | sed 's/^/      /'
    fi
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    echo ""
}

# Test Framework Tests
echo "Testing Framework Components"
echo "----------------------------"

if [ -f "tests/test_framework.ruchy" ]; then
    # Create a test for the test framework itself
    cat > tests/test_framework_self.ruchy << 'EOF'
import { assert, assert_equals, assert_not_equals, assert_gt, assert_lt, describe, it, test_report } from "./test_framework.ruchy"

describe("Test Framework Self-Test", || {
    it("should assert true conditions", || {
        assert(true, "True should pass")
        assert(1 == 1, "Equality should pass")
    })
    
    it("should assert_equals correctly", || {
        assert_equals(5, 5, "5 equals 5")
        assert_equals("hello", "hello", "String equality")
    })
    
    it("should assert_not_equals correctly", || {
        assert_not_equals(5, 10, "5 not equals 10")
        assert_not_equals("hello", "world", "String inequality")
    })
    
    it("should assert_gt correctly", || {
        assert_gt(10, 5, "10 > 5")
        assert_gt(100, 99, "100 > 99")
    })
    
    it("should assert_lt correctly", || {
        assert_lt(5, 10, "5 < 10")
        assert_lt(99, 100, "99 < 100")
    })
})

test_report()
EOF
    
    run_test "tests/test_framework_self.ruchy"
fi

# Basic Tests
echo "Testing Basic Demos"
echo "-------------------"

if [ -f "tests/test_basics.ruchy" ]; then
    run_test "tests/test_basics.ruchy"
fi

# Function Tests
echo "Testing Function Demos"
echo "----------------------"

if [ -f "tests/test_functions.ruchy" ]; then
    run_test "tests/test_functions.ruchy"
fi

# Data Structure Tests
echo "Testing Data Structure Demos"
echo "----------------------------"

if [ -f "tests/test_data_structures.ruchy" ]; then
    run_test "tests/test_data_structures.ruchy"
fi

# Algorithm Tests
echo "Testing Algorithm Demos"
echo "-----------------------"

if [ -f "tests/test_algorithms.ruchy" ]; then
    run_test "tests/test_algorithms.ruchy"
fi

# Functional Programming Tests
echo "Testing Functional Demos"
echo "------------------------"

if [ -f "tests/test_functional.ruchy" ]; then
    run_test "tests/test_functional.ruchy"
fi

# One-Liner Tests
echo "Testing One-Liner Demos"
echo "-----------------------"

if [ -f "tests/test_oneliners.ruchy" ]; then
    run_test "tests/test_oneliners.ruchy"
fi

# Coverage Calculation
echo ""
echo "📊 Test Coverage Report"
echo "======================="

# Count demo files
REPL_DEMOS=$(find demos/repl -name "*.repl" 2>/dev/null | wc -l)
ONELINER_DEMOS=$(find demos/one-liners -name "*.sh" 2>/dev/null | wc -l)
TOTAL_DEMOS=$((REPL_DEMOS + ONELINER_DEMOS))

# Count test files
TEST_FILES=$(find tests -name "test_*.ruchy" 2>/dev/null | wc -l)

echo "Demo files: $TOTAL_DEMOS"
echo "Test files: $TEST_FILES"
echo "Tests run: $TOTAL_TESTS"
echo "Tests passed: $PASSED_TESTS"
echo "Tests failed: $FAILED_TESTS"

if [ "$TOTAL_TESTS" -gt 0 ]; then
    PASS_RATE=$((PASSED_TESTS * 100 / TOTAL_TESTS))
    echo "Pass rate: ${PASS_RATE}%"
    
    if [ "$PASS_RATE" -ge 80 ]; then
        echo "✅ Quality gate: PASSED (≥80%)"
    else
        echo "❌ Quality gate: FAILED (<80%)"
        exit 1
    fi
else
    echo "⚠️  No tests were run"
    exit 1
fi

# Calculate coverage (simplified)
if [ "$TOTAL_DEMOS" -gt 0 ]; then
    # Assume each test file covers roughly 10-15 demos
    ESTIMATED_COVERED=$((TEST_FILES * 12))
    if [ "$ESTIMATED_COVERED" -gt "$TOTAL_DEMOS" ]; then
        COVERAGE=100
    else
        COVERAGE=$((ESTIMATED_COVERED * 100 / TOTAL_DEMOS))
    fi
    
    echo "Estimated coverage: ${COVERAGE}%"
    
    if [ "$COVERAGE" -ge 80 ]; then
        echo "✅ Coverage goal: MET (≥80%)"
    else
        echo "⚠️  Coverage goal: NOT MET (<80%)"
        echo "   Need more test files to cover all demos"
    fi
fi

echo ""
echo "============================"
echo "🧪 Test Suite Complete"
echo "============================"

# Exit with error if any tests failed
if [ "$FAILED_TESTS" -gt 0 ]; then
    exit 1
fi

exit 0