#!/bin/sh
set -eu

# Ruchy v1.17.0 Compatibility Test for REPL Demos
# Tests all .repl files for syntax compatibility

echo "=== Ruchy v1.17.0 REPL Compatibility Test ==="
echo "Testing all .repl demo files..."
echo

# Initialize counters
total_tests=0
failed_tests=0
passed_tests=0

# Create temporary file for results
results_file="/tmp/repl_test_results.txt"
: > "$results_file"

# Function to test a single REPL file
test_repl_file() {
    file="$1"
    echo "Testing: $file"
    total_tests=$((total_tests + 1))
    
    # Try to run the REPL file through ruchy check
    if ruchy check "$file" >/dev/null 2>&1; then
        echo "  ✓ PASS: Syntax check passed"
        passed_tests=$((passed_tests + 1))
        echo "PASS: $file" >> "$results_file"
    else
        echo "  ✗ FAIL: Syntax check failed"
        failed_tests=$((failed_tests + 1))
        echo "FAIL: $file" >> "$results_file"
        
        # Capture the error for analysis
        echo "    Error details:" 
        ruchy check "$file" 2>&1 | sed 's/^/      /' || true
    fi
    echo
}

# Test all REPL demo files
for repl_file in demos/repl/*/*.repl; do
    if [ -f "$repl_file" ]; then
        test_repl_file "$repl_file"
    fi
done

# Print summary
echo "=== REPL TEST SUMMARY ==="
echo "Total tests: $total_tests"
echo "Passed: $passed_tests"
echo "Failed: $failed_tests"
echo "Success rate: $(echo "scale=2; $passed_tests * 100 / $total_tests" | bc -l)%"
echo
echo "Results saved to: $results_file"