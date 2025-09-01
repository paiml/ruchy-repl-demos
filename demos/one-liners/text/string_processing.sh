#!/bin/bash
# One-liner: String processing with ruchy
# Usage: ./string_processing.sh

echo "String processing with Ruchy one-liners..."
echo

echo "Convert to uppercase:"
ruchy -e 'println("hello world".to_uppercase())'

echo "Convert to lowercase:"
ruchy -e 'println("HELLO WORLD".to_lowercase())'

echo "Trim whitespace:"
ruchy -e 'println("  hello world  ".trim())'

echo "String interpolation:"
ruchy -e 'let name = "Ruchy"; println(f"Welcome to {name} v1.27.10!")'

echo "String length:"
ruchy -e 'let text = "Hello, Ruchy!"; println(f"Length: {text.len()}")'