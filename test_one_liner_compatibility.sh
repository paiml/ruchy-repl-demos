#!/bin/sh
set -eu

# Ruchy v1.17.0 Compatibility Test for One-liner Demos
# Tests all .sh files that contain ruchy one-liners

echo "=== Ruchy v1.17.0 One-liner Compatibility Test ==="
echo "Testing all one-liner demo files..."
echo

# Initialize counters
total_tests=0
failed_tests=0
passed_tests=0

# Create temporary file for results
results_file="/tmp/one_liner_test_results.txt"
: > "$results_file"

# Function to test a single one-liner script
test_one_liner_file() {
    file="$1"
    echo "Testing: $file"
    total_tests=$((total_tests + 1))
    
    # Make sure the script is executable and run it
    if [ -f "$file" ] && [ -r "$file" ]; then
        chmod +x "$file" 2>/dev/null || true
        
        # Try to execute the script
        if "$file" >/dev/null 2>&1; then
            echo "  ✓ PASS: Script executed successfully"
            passed_tests=$((passed_tests + 1))
            echo "PASS: $file" >> "$results_file"
        else
            echo "  ✗ FAIL: Script execution failed"
            failed_tests=$((failed_tests + 1))
            echo "FAIL: $file" >> "$results_file"
            
            # Capture the error for analysis
            echo "    Error details:"
            "$file" 2>&1 | head -5 | sed 's/^/      /' || true
        fi
    else
        echo "  ✗ FAIL: File not readable"
        failed_tests=$((failed_tests + 1))
        echo "FAIL: $file (not readable)" >> "$results_file"
    fi
    echo
}

# Test all one-liner demo files
for script_file in demos/one-liners/*/*.sh; do
    if [ -f "$script_file" ]; then
        test_one_liner_file "$script_file"
    fi
done

# Print summary
echo "=== ONE-LINER TEST SUMMARY ==="
echo "Total tests: $total_tests"
echo "Passed: $passed_tests"
echo "Failed: $failed_tests"
echo "Success rate: $(echo "scale=2; $passed_tests * 100 / $total_tests" | bc -l)%"
echo
echo "Results saved to: $results_file"