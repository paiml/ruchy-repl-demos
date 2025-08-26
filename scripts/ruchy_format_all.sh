#!/bin/sh
set -eu

# Ruchy Format Runner - Format all code with ruchy fmt
echo "🎨 Running Ruchy Format on all demos"
echo "===================================="

FORMATTED=0
FAILED=0

# Format all test files
echo "Formatting test files..."
for file in tests/*.ruchy; do
    if [ -f "$file" ]; then
        printf "  Formatting %s... " "$(basename "$file")"
        
        if ruchy fmt "$file" > /tmp/formatted.ruchy 2>/dev/null; then
            if ! diff -q "$file" /tmp/formatted.ruchy > /dev/null 2>&1; then
                cp /tmp/formatted.ruchy "$file"
                printf "✅ (modified)\n"
                FORMATTED=$((FORMATTED + 1))
            else
                printf "✅ (no changes)\n"
            fi
        else
            printf "❌ (failed)\n"
            FAILED=$((FAILED + 1))
        fi
    fi
done

# Format REPL demos
echo ""
echo "Formatting REPL demos..."
find demos/repl -name "*.repl" | while read -r file; do
    printf "  Formatting %s... " "$(basename "$file")"
    
    # Convert to .ruchy for formatting
    tmp_file="/tmp/$(basename "$file" .repl).ruchy"
    cp "$file" "$tmp_file"
    
    if ruchy fmt "$tmp_file" > /tmp/formatted.ruchy 2>/dev/null; then
        if ! diff -q "$tmp_file" /tmp/formatted.ruchy > /dev/null 2>&1; then
            # Convert back to .repl format
            cp /tmp/formatted.ruchy "$file"
            printf "✅ (modified)\n"
            FORMATTED=$((FORMATTED + 1))
        else
            printf "✅ (no changes)\n"
        fi
    else
        printf "❌ (failed)\n"
        FAILED=$((FAILED + 1))
    fi
    
    rm -f "$tmp_file"
done

echo ""
echo "===================================="
echo "Format Summary"
echo "  Files formatted: $FORMATTED"
echo "  Failed: $FAILED"

if [ "$FAILED" -eq 0 ]; then
    echo "✅ All files formatted successfully!"
    exit 0
else
    echo "⚠️  Some files could not be formatted"
    exit 1
fi