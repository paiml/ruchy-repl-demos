#!/bin/sh
set -eu

# Validate comment syntax in documentation
# P0 REQUIREMENT: All Ruchy code blocks must use // comments, never #

echo "=== Comment Syntax Validation ==="
echo "Checking for incorrect # comments in Ruchy code blocks..."

# Extract all Ruchy code blocks and check for # comments
temp_file=$(mktemp)
in_ruchy_block=false
line_num=0
errors=0

while IFS= read -r line; do
    line_num=$((line_num + 1))
    
    # Detect start of Ruchy code block
    if echo "$line" | grep -q '```ruchy'; then
        in_ruchy_block=true
        continue
    fi
    
    # Detect end of code block
    if echo "$line" | grep -q '^```$'; then
        in_ruchy_block=false
        continue
    fi
    
    # Check for # comments inside Ruchy blocks
    if [ "$in_ruchy_block" = true ]; then
        # Skip empty lines and lines that are just comments
        if echo "$line" | grep -q '#' && ! echo "$line" | grep -qE '^\s*$'; then
            # Check if this is actually a # comment (not a URL fragment like #L32)
            if echo "$line" | grep -qE '^\s*#|[[:space:]]#[[:space:]]'; then
                echo "❌ ERROR: Line $line_num: Invalid # comment in Ruchy code block"
                echo "   Line: $line"
                echo "   Fix: Change # to // for Ruchy syntax compliance"
                echo
                errors=$((errors + 1))
            fi
        fi
    fi
done < README.md

# Also check test files for consistency
echo "Checking test files for comment syntax..."
for test_file in tests/*.ruchy; do
    if [ -f "$test_file" ]; then
        # Check if any # comments exist (should only be // comments)  
        if grep -n '^[[:space:]]*#' "$test_file" >/dev/null 2>&1; then
            echo "❌ ERROR: File $test_file contains # comments"
            echo "   Ruchy test files should only use // comments"
            grep -n '^[[:space:]]*#' "$test_file" | head -3
            echo
            errors=$((errors + 1))
        fi
    fi
done

rm -f "$temp_file"

if [ $errors -eq 0 ]; then
    echo "✅ Comment syntax validation PASSED"
    echo "   All Ruchy code blocks use correct // comment syntax"
    exit 0
else
    echo "❌ Comment syntax validation FAILED"
    echo "   Found $errors syntax violations"
    echo "   Fix all # comments in Ruchy code to use // syntax"
    exit 1
fi