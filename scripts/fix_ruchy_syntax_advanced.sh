#!/bin/sh
set -eu

# Fix any remaining syntax issues in REPL demos
echo "Fixing advanced Ruchy syntax issues..."

# Find all .repl files and fix common patterns
find demos/repl -name "*.repl" -type f | while read -r file; do
    # Check if file has problematic patterns
    if grep -q 'fun.*:.*->' "$file" 2>/dev/null || \
       grep -q 'fun.*: \[' "$file" 2>/dev/null || \
       grep -q '-> fn' "$file" 2>/dev/null; then
        echo "Fixing: $file"
        
        # Create temporary file
        tmp_file="${file}.tmp"
        
        # Fix complex patterns
        sed \
            -e 's/: \[\]//g' \
            -e 's/-> \[\]//g' \
            -e 's/-> fn([^)]*)//g' \
            -e 's/(fx)/(f, x)/g' \
            -e 's/(fg)/(f, g)/g' \
            -e 's/(xy)/(x, y)/g' \
            -e 's/(ab)/(a, b)/g' \
            -e 's/(arr: , f->/arr, f/g' \
            "$file" > "$tmp_file"
        
        # Replace original file
        mv "$tmp_file" "$file"
    fi
done

echo "Advanced syntax fixes complete!"