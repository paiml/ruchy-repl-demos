#!/bin/sh
set -eu

# Test a REPL example file
# Usage: test-repl-example.sh <file.repl>

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file.repl>"
    exit 1
fi

REPL_FILE="$1"

if [ ! -f "$REPL_FILE" ]; then
    echo "Error: File $REPL_FILE not found"
    exit 1
fi

# Create a temporary Ruchy file from REPL examples
TEMP_FILE="/tmp/test_repl_$$"
echo "fn main() {" > "$TEMP_FILE"

# Convert REPL session to executable code
# Remove comments and convert REPL format to regular code
grep -v "^//" "$REPL_FILE" | \
grep -v "^#" | \
grep -v "^$" | \
while IFS= read -r line; do
    # Simple conversion - just wrap in println! if it's an expression
    if echo "$line" | grep -q "^[a-zA-Z0-9_].*[^;]$"; then
        echo "    println!(\"{}\", $line);" >> "$TEMP_FILE"
    else
        echo "    $line" >> "$TEMP_FILE"
    fi
done

echo "}" >> "$TEMP_FILE"

# Test compilation
if ruchy check "$TEMP_FILE" >/dev/null 2>&1; then
    rm -f "$TEMP_FILE"
    exit 0
else
    rm -f "$TEMP_FILE" 
    exit 1
fi