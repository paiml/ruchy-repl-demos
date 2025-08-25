#!/bin/sh
set -eu

# Test demos against a specific Ruchy version
# Usage: ./test-ruchy-version.sh [version]
# If no version specified, tests against latest

echo "========================================="
echo "Ruchy Version Compatibility Tester"
echo "========================================="
echo ""

# Get requested version or latest
if [ $# -eq 0 ]; then
    echo "Fetching latest Ruchy version..."
    VERSION=$(curl -s https://crates.io/api/v1/crates/ruchy | grep -o '"max_version":"[^"]*"' | cut -d'"' -f4)
    if [ -z "$VERSION" ]; then
        echo "Error: Could not fetch latest version"
        exit 1
    fi
    echo "Latest version: $VERSION"
else
    VERSION="$1"
    echo "Testing against version: $VERSION"
fi

echo ""
echo "Current Ruchy version:"
ruchy --version || echo "Ruchy not installed"

echo ""
echo "Installing Ruchy $VERSION..."
cargo install ruchy --version "$VERSION" --force

echo ""
echo "Installed version:"
ruchy --version

echo ""
echo "========================================="
echo "Testing Compatibility"
echo "========================================="
echo ""

# Test basic functionality
echo "Basic test (1 + 1):"
if ruchy -e '1 + 1' >/dev/null 2>&1; then
    echo "  ✓ Basic arithmetic works"
else
    echo "  ✗ Basic arithmetic failed"
fi

# Test string operations
echo ""
echo "String test:"
if ruchy -e 'print("hello")' >/dev/null 2>&1; then
    echo "  ✓ String operations work"
else
    echo "  ✗ String operations failed"
fi

# Test REPL demos
echo ""
echo "Testing REPL demos..."
REPL_TOTAL=0
REPL_PASS=0
REPL_FAIL=0

for category in demos/repl/*/; do
    if [ -d "$category" ]; then
        category_name=$(basename "$category")
        echo "  Category: $category_name"
        
        for demo in "$category"*.repl; do
            if [ -f "$demo" ]; then
                REPL_TOTAL=$((REPL_TOTAL + 1))
                demo_name=$(basename "$demo")
                
                if ruchy repl < "$demo" >/dev/null 2>&1; then
                    REPL_PASS=$((REPL_PASS + 1))
                    printf "    ✓ %s\n" "$demo_name"
                else
                    REPL_FAIL=$((REPL_FAIL + 1))
                    printf "    ✗ %s\n" "$demo_name"
                fi
            fi
        done
    fi
done

# Test one-liner demos
echo ""
echo "Testing one-liner demos..."
ONELINER_TOTAL=0
ONELINER_PASS=0
ONELINER_FAIL=0

for category in demos/one-liners/*/; do
    if [ -d "$category" ]; then
        category_name=$(basename "$category")
        echo "  Category: $category_name"
        
        for script in "$category"*.sh; do
            if [ -f "$script" ]; then
                ONELINER_TOTAL=$((ONELINER_TOTAL + 1))
                script_name=$(basename "$script")
                
                if sh "$script" >/dev/null 2>&1; then
                    ONELINER_PASS=$((ONELINER_PASS + 1))
                    printf "    ✓ %s\n" "$script_name"
                else
                    ONELINER_FAIL=$((ONELINER_FAIL + 1))
                    printf "    ✗ %s\n" "$script_name"
                fi
            fi
        done
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

# Summary
echo ""
echo "========================================="
echo "Compatibility Report for Ruchy $VERSION"
echo "========================================="
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

# Overall assessment
if [ "$REPL_PCT" -ge 90 ] && [ "$ONELINER_PCT" -ge 90 ]; then
    echo "Status: ✅ FULLY COMPATIBLE"
elif [ "$REPL_PCT" -ge 70 ] || [ "$ONELINER_PCT" -ge 70 ]; then
    echo "Status: ⚠️  PARTIALLY COMPATIBLE"
else
    echo "Status: ❌ COMPATIBILITY ISSUES"
fi

# Save report
REPORT_FILE="compat-report-${VERSION}.json"
cat > "$REPORT_FILE" << EOF
{
  "ruchy_version": "$VERSION",
  "test_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "repl_demos": {
    "total": $REPL_TOTAL,
    "passed": $REPL_PASS,
    "failed": $REPL_FAIL,
    "pass_rate": $REPL_PCT
  },
  "oneliner_demos": {
    "total": $ONELINER_TOTAL,
    "passed": $ONELINER_PASS,
    "failed": $ONELINER_FAIL,
    "pass_rate": $ONELINER_PCT
  }
}
EOF

echo ""
echo "Report saved to: $REPORT_FILE"