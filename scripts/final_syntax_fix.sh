#!/bin/sh
set -eu

echo "Final syntax fixes for all REPL demos..."

# Find and fix any remaining type annotations
find demos/repl -name "*.repl" -type f | while read -r file; do
    # Check if file needs fixing
    needs_fix=0
    
    # Check for remaining Rust-specific syntax
    if grep -qE ': &[a-zA-Z]|: \[[a-zA-Z]|\bfn\b|impl\s|struct\s|enum\s|trait\s' "$file" 2>/dev/null; then
        needs_fix=1
    fi
    
    if [ "$needs_fix" = "1" ]; then
        echo "Fixing: $file"
        tmp_file="${file}.tmp"
        
        # Comprehensive fixes
        sed \
            -e 's/: &[a-zA-Z][a-zA-Z0-9_]*//g' \
            -e 's/: \[[a-zA-Z][a-zA-Z0-9_]*\]//g' \
            -e 's/: [a-zA-Z][a-zA-Z0-9_]*//g' \
            -e 's/\bfn\b/fun/g' \
            -e 's/impl //' \
            -e 's/struct //' \
            -e 's/enum //' \
            -e 's/trait //' \
            -e 's/&mut //g' \
            -e 's/mut //g' \
            -e 's/pub //g' \
            -e 's/async //g' \
            -e 's/await//g' \
            -e 's/unsafe //g' \
            -e 's/<[a-z]>//g' \
            "$file" > "$tmp_file"
        
        mv "$tmp_file" "$file"
    fi
done

# Check for any files still using println with format specifiers
echo "Checking for println format issues..."
find demos/repl -name "*.repl" -type f | while read -r file; do
    if grep -q 'println(".*{:?}' "$file" 2>/dev/null; then
        echo "Note: $file uses println with format specifiers - may need manual review"
    fi
done

echo "Final syntax fixes complete!"