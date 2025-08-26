#!/bin/sh
# TDD Test Runner for README Examples
# Tests every example shown in README.md

set -eu

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

PASSED=0
FAILED=0

# Test function
test_example() {
    local name="$1"
    local code="$2"
    local expected="$3"
    
    printf "Testing: %s... " "$name"
    
    # Run the code and capture output
    output=$(ruchy -e "$code" 2>&1) || {
        printf "${RED}FAIL${NC} (execution error)\n"
        FAILED=$((FAILED + 1))
        return 1
    }
    
    # Compare output
    if [ "$output" = "$expected" ]; then
        printf "${GREEN}PASS${NC}\n"
        PASSED=$((PASSED + 1))
        return 0
    else
        printf "${RED}FAIL${NC}\n"
        printf "  Expected: %s\n" "$expected"
        printf "  Got: %s\n" "$output"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

# Run all README example tests
printf "=== TDD Tests for README Examples ===\n\n"

# Basic Arithmetic
test_example "Addition" "2 + 2" "4"
test_example "Multiplication" "10 * 5" "50"
test_example "Exponentiation" "2 ** 8" "256"

# Functions
test_example "Simple Function" "fn add(x, y) { x + y }; add(2, 3)" "5"
test_example "Factorial" "fn fact(n) { if n <= 1 { 1 } else { n * fact(n - 1) } }; fact(5)" "120"

# Arrays
test_example "Array Map" "[1, 2, 3, 4, 5].map(|x| x * 2)" "[2, 4, 6, 8, 10]"
test_example "Array Filter" "[1, 2, 3, 4, 5].filter(|x| x % 2 == 0)" "[2, 4]"
test_example "Array Reduce" "[1, 2, 3, 4, 5].reduce(0, |acc, x| acc + x)" "15"

# Closures
test_example "Simple Closure" "let double = |x| x * 2; double(5)" "10"
test_example "Closure in Map" "[1, 2, 3].map(|x| x * x)" "[1, 4, 9]"

# One-liner examples
test_example "Fibonacci" "fn fib(n) { if n <= 1 { n } else { fib(n-1) + fib(n-2) } }; fib(10)" "55"
test_example "Sum of Squares" "[1, 2, 3, 4, 5].map(|x| x * x).reduce(0, |a, b| a + b)" "55"

# Text processing
test_example "Array Reverse" '["h","e","l","l","o"].reverse()' '["o", "l", "l", "e", "h"]'
test_example "Array Count" '["hello", "world", "test"].len()' "3"
test_example "Array Transform" '["hello", "world"].map(|s| s + "!")' '["hello!", "world!"]'

# Data analysis
test_example "Array Mean" "let nums = [1, 2, 3, 4, 5]; nums.sum() / nums.len()" "3"
test_example "Array Max" "[10, 5, 8, 3, 15, 7].reduce(0, |a, b| if a > b { a } else { b })" "15"
test_example "Filter and Sum" "[1, 2, 3, 4, 5, 6].filter(|x| x > 3).sum()" "15"

# Summary
printf "\n=== Test Summary ===\n"
printf "${GREEN}Passed: %d${NC}\n" "$PASSED"
printf "${RED}Failed: %d${NC}\n" "$FAILED"
TOTAL=$((PASSED + FAILED))
printf "Total: %d\n" "$TOTAL"

if [ "$FAILED" -eq 0 ]; then
    printf "\n${GREEN}✅ All README examples verified!${NC}\n"
    exit 0
else
    printf "\n${RED}❌ Some README examples failed!${NC}\n"
    printf "${RED}Fix failing examples before updating documentation${NC}\n"
    exit 1
fi