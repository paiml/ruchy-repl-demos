#!/bin/sh
set -eu

# Ruchy Lint Runner - Use ruchy lint for quality checks
echo "🔍 Running Ruchy Lint on all demos"
echo "===================================="

TOTAL=0
PASSED=0
FAILED=0

# Lint all .ruchy test files
echo "Linting test files..."
for file in tests/*.ruchy; do
    if [ -f "$file" ]; then
        printf "  Linting %s... " "$(basename "$file")"
        TOTAL=$((TOTAL + 1))
        
        if ruchy lint "$file" > /tmp/lint_output.txt 2>&1; then
            printf "✅\n"
            PASSED=$((PASSED + 1))
        else
            printf "❌\n"
            FAILED=$((FAILED + 1))
            printf "    Issues found:\n"
            head -10 /tmp/lint_output.txt | sed 's/^/      /'
        fi
    fi
done

# Lint all REPL demos
echo ""
echo "Linting REPL demos..."
find demos/repl -name "*.repl" | while read -r file; do
    printf "  Linting %s... " "$(basename "$file")"
    TOTAL=$((TOTAL + 1))
    
    # Convert to temporary .ruchy file for linting
    tmp_file="/tmp/$(basename "$file" .repl).ruchy"
    cp "$file" "$tmp_file"
    
    if ruchy lint "$tmp_file" > /tmp/lint_output.txt 2>&1; then
        printf "✅\n"
        PASSED=$((PASSED + 1))
    else
        printf "❌\n"
        FAILED=$((FAILED + 1))
        printf "    Issues found:\n"
        head -5 /tmp/lint_output.txt | sed 's/^/      /'
    fi
    
    rm -f "$tmp_file"
done

echo ""
echo "===================================="
echo "Lint Summary"
echo "  Total files: $TOTAL"
echo "  Passed: $PASSED"
echo "  Failed: $FAILED"

if [ "$FAILED" -eq 0 ]; then
    echo "✅ All files pass linting!"
    exit 0
else
    echo "❌ Some files have lint issues"
    exit 1
fi