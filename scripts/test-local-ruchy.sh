#!/bin/sh
set -eu

# Test demos against currently installed Ruchy version

echo "========================================="
echo "Local Ruchy Version Compatibility Test"
echo "========================================="
echo ""

# Check if ruchy is installed
if ! command -v ruchy >/dev/null 2>&1; then
    echo "Error: Ruchy is not installed or not in PATH"
    exit 1
fi

# Get current version
VERSION=$(ruchy --version | sed 's/ruchy //')
echo "Testing against installed Ruchy version: $VERSION"

echo ""
echo "========================================="
echo "Testing Basic Functionality"
echo "========================================="
echo ""

# Test basic functionality
echo "Basic arithmetic test (1 + 1):"
if ruchy -e '1 + 1' >/dev/null 2>&1; then
    echo "  ✓ Basic arithmetic works"
else
    echo "  ✗ Basic arithmetic failed"
    exit 1
fi

# Test string operations
echo ""
echo "String operations test:"
if ruchy -e 'print("hello")' >/dev/null 2>&1; then
    echo "  ✓ String operations work"
else
    echo "  ✗ String operations failed"
fi

# Test array operations
echo ""
echo "Array operations test:"
if ruchy -e '[1,2,3].len()' >/dev/null 2>&1; then
    echo "  ✓ Array operations work"
else
    echo "  ✗ Array operations failed"
fi

echo ""
echo "========================================="
echo "Testing REPL Demos"
echo "========================================="
echo ""

REPL_TOTAL=0
REPL_PASS=0
REPL_FAIL=0

for category in demos/repl/*/; do
    if [ -d "$category" ]; then
        category_name=$(basename "$category")
        echo "Testing category: $category_name"
        
        for demo in "$category"*.repl; do
            if [ -f "$demo" ]; then
                REPL_TOTAL=$((REPL_TOTAL + 1))
                demo_name=$(basename "$demo")
                
                if ruchy repl < "$demo" >/dev/null 2>&1; then
                    REPL_PASS=$((REPL_PASS + 1))
                    printf "  ✓ %s\n" "$demo_name"
                else
                    REPL_FAIL=$((REPL_FAIL + 1))
                    printf "  ✗ %s\n" "$demo_name"
                fi
            fi
        done
        echo ""
    fi
done

echo "========================================="
echo "Testing One-Liner Demos"
echo "========================================="
echo ""

ONELINER_TOTAL=0
ONELINER_PASS=0
ONELINER_FAIL=0

for category in demos/one-liners/*/; do
    if [ -d "$category" ]; then
        category_name=$(basename "$category")
        echo "Testing category: $category_name"
        
        for script in "$category"*.sh; do
            if [ -f "$script" ]; then
                ONELINER_TOTAL=$((ONELINER_TOTAL + 1))
                script_name=$(basename "$script")
                
                if sh "$script" >/dev/null 2>&1; then
                    ONELINER_PASS=$((ONELINER_PASS + 1))
                    printf "  ✓ %s\n" "$script_name"
                else
                    ONELINER_FAIL=$((ONELINER_FAIL + 1))
                    printf "  ✗ %s\n" "$script_name"
                fi
            fi
        done
        echo ""
    fi
done

# Calculate percentages
if [ "$REPL_TOTAL" -gt 0 ]; then
    REPL_PCT=$((REPL_PASS * 100 / REPL_TOTAL))
else
    REPL_PCT=0
fi

if [ "$ONELINER_TOTAL" -gt 0 ]; then
    ONELINER_PCT=$((ONELINER_PASS * 100 / ONELINER_TOTAL))
else
    ONELINER_PCT=0
fi

# Final Summary
echo "========================================="
echo "Final Compatibility Report"
echo "========================================="
echo ""
printf "Ruchy Version: %s\n" "$VERSION"
printf "Test Date: %s\n" "$(date -u +"%Y-%m-%d %H:%M:%S UTC")"
echo ""
echo "REPL Demos:"
printf "  Total:  %d\n" "$REPL_TOTAL"
printf "  Passed: %d (%d%%)\n" "$REPL_PASS" "$REPL_PCT"
printf "  Failed: %d\n" "$REPL_FAIL"
echo ""
echo "One-Liner Demos:"
printf "  Total:  %d\n" "$ONELINER_TOTAL"
printf "  Passed: %d (%d%%)\n" "$ONELINER_PASS" "$ONELINER_PCT"
printf "  Failed: %d\n" "$ONELINER_FAIL"
echo ""
printf "Overall Demos: %d/%d passed (%d%%)\n" \
    $((REPL_PASS + ONELINER_PASS)) \
    $((REPL_TOTAL + ONELINER_TOTAL)) \
    $(((REPL_PASS + ONELINER_PASS) * 100 / (REPL_TOTAL + ONELINER_TOTAL)))

# Overall assessment
echo ""
if [ "$REPL_PCT" -ge 90 ] && [ "$ONELINER_PCT" -ge 90 ]; then
    echo "Status: ✅ FULLY COMPATIBLE with Ruchy $VERSION"
elif [ "$REPL_PCT" -ge 70 ] || [ "$ONELINER_PCT" -ge 70 ]; then
    echo "Status: ⚠️  PARTIALLY COMPATIBLE with Ruchy $VERSION"
else
    echo "Status: ❌ COMPATIBILITY ISSUES with Ruchy $VERSION"
fi

echo ""
echo "========================================="