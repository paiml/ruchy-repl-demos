#!/bin/sh
# TDD Verification Script - Quality Gate for All Examples
# NO EXAMPLE CAN BE SHOWN WITHOUT PASSING THIS VERIFICATION

set -eu

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Ruchy version check
RUCHY_VERSION="1.18.0"
CURRENT_VERSION=$(ruchy --version | cut -d' ' -f2)

if [ "$CURRENT_VERSION" != "$RUCHY_VERSION" ]; then
    printf "${RED}ERROR: Ruchy version mismatch${NC}\n"
    printf "Expected: %s\n" "$RUCHY_VERSION"
    printf "Found: %s\n" "$CURRENT_VERSION"
    exit 1
fi

# Counters
TOTAL=0
PASSED=0
FAILED=0

# Test a REPL example
test_repl_example() {
    local file="$1"
    local name=$(basename "$file" .repl)
    
    printf "Testing REPL: %s... " "$name"
    TOTAL=$((TOTAL + 1))
    
    # Try to execute the REPL file
    if ruchy "$file" > /dev/null 2>&1; then
        printf "${GREEN}✅ PASS${NC}\n"
        PASSED=$((PASSED + 1))
        return 0
    else
        printf "${RED}❌ FAIL${NC}\n"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

# Test a one-liner example
test_oneliner_example() {
    local file="$1"
    local name=$(basename "$file" .sh)
    
    printf "Testing one-liner: %s... " "$name"
    TOTAL=$((TOTAL + 1))
    
    # Execute the shell script
    if sh "$file" > /dev/null 2>&1; then
        printf "${GREEN}✅ PASS${NC}\n"
        PASSED=$((PASSED + 1))
        return 0
    else
        printf "${RED}❌ FAIL${NC}\n"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

# Test README examples
test_readme_examples() {
    printf "\n${YELLOW}=== Testing README Examples ===${NC}\n"
    
    # Extract and test ruchy code blocks from README
    if [ -f "README.md" ]; then
        # Create temp directory for tests
        TEMP_DIR=$(mktemp -d)
        
        # Extract ruchy code blocks
        awk '/```ruchy/,/```/' README.md | grep -v '```' > "$TEMP_DIR/readme_examples.ruchy" 2>/dev/null || true
        
        if [ -s "$TEMP_DIR/readme_examples.ruchy" ]; then
            if ruchy "$TEMP_DIR/readme_examples.ruchy" > /dev/null 2>&1; then
                printf "${GREEN}✅ README examples pass${NC}\n"
            else
                printf "${RED}❌ README examples fail${NC}\n"
                FAILED=$((FAILED + 1))
            fi
            TOTAL=$((TOTAL + 1))
        fi
        
        rm -rf "$TEMP_DIR"
    fi
}

# Main testing logic
main() {
    printf "${YELLOW}=== TDD Quality Gate Verification ===${NC}\n"
    printf "Ruchy Version: %s\n\n" "$RUCHY_VERSION"
    
    # Test REPL examples
    printf "${YELLOW}=== Testing REPL Demos ===${NC}\n"
    if [ -d "demos/repl" ]; then
        find demos/repl -name "*.repl" -type f | while read -r file; do
            test_repl_example "$file" || true
        done
    fi
    
    # Test one-liner examples
    printf "\n${YELLOW}=== Testing One-liner Demos ===${NC}\n"
    if [ -d "demos/one-liners" ]; then
        find demos/one-liners -name "*.sh" -type f | while read -r file; do
            test_oneliner_example "$file" || true
        done
    fi
    
    # Test README examples
    test_readme_examples
    
    # Summary
    printf "\n${YELLOW}=== TDD Verification Summary ===${NC}\n"
    printf "Total tests: %d\n" "$TOTAL"
    printf "${GREEN}Passed: %d${NC}\n" "$PASSED"
    printf "${RED}Failed: %d${NC}\n" "$FAILED"
    
    # Calculate pass rate
    if [ "$TOTAL" -gt 0 ]; then
        PASS_RATE=$((PASSED * 100 / TOTAL))
        printf "Pass rate: %d%%\n" "$PASS_RATE"
        
        if [ "$PASS_RATE" -eq 100 ]; then
            printf "\n${GREEN}✅ ALL TESTS PASSED - Quality Gate APPROVED${NC}\n"
            exit 0
        else
            printf "\n${RED}❌ QUALITY GATE FAILED - Fix failing tests before release${NC}\n"
            printf "${RED}NO EXAMPLES CAN BE SHOWN WITHOUT 100%% PASS RATE${NC}\n"
            exit 1
        fi
    else
        printf "${YELLOW}No tests found${NC}\n"
        exit 1
    fi
}

# Run main
main "$@"