#!/bin/sh
set -eu

# Convert Rust syntax to Ruchy syntax in REPL demo files
# Ruchy v1.18.1 requires:
# - fn -> fun
# - Remove type annotations
# - Remove generics syntax
# - Simplify closures

echo "Converting Rust syntax to Ruchy syntax in REPL demos..."

# Find all .repl files
find demos/repl -name "*.repl" -type f | while read -r file; do
    echo "Processing: $file"
    
    # Create temporary file
    tmp_file="${file}.tmp"
    
    # Convert syntax
    sed \
        -e 's/^fn /fun /g' \
        -e 's/\sfn\s/ fun /g' \
        -e 's/: i32//g' \
        -e 's/: i64//g' \
        -e 's/: f32//g' \
        -e 's/: f64//g' \
        -e 's/: usize//g' \
        -e 's/: bool//g' \
        -e 's/: str//g' \
        -e 's/: String//g' \
        -e 's/: &str//g' \
        -e 's/: Vec<[^>]*>//g' \
        -e 's/: Option<[^>]*>//g' \
        -e 's/: Result<[^>]*>//g' \
        -e 's/: fn([^)]*) -> [^ ]* //g' \
        -e 's/: fn([^)]*)//g' \
        -e 's/ -> i32//g' \
        -e 's/ -> i64//g' \
        -e 's/ -> f32//g' \
        -e 's/ -> f64//g' \
        -e 's/ -> usize//g' \
        -e 's/ -> bool//g' \
        -e 's/ -> str//g' \
        -e 's/ -> String//g' \
        -e 's/ -> Vec<[^>]*>//g' \
        -e 's/ -> Option<[^>]*>//g' \
        -e 's/ -> Result<[^>]*>//g' \
        -e 's/<[A-Z], [A-Z], [A-Z]>//g' \
        -e 's/<[A-Z], [A-Z]>//g' \
        -e 's/<[A-Z]>//g' \
        -e 's/\[i32\]/[]/g' \
        -e 's/\[i64\]/[]/g' \
        -e 's/\[f32\]/[]/g' \
        -e 's/\[f64\]/[]/g' \
        -e 's/Vec:://g' \
        -e 's/HashMap:://g' \
        -e 's/Option:://g' \
        -e 's/Result:://g' \
        "$file" > "$tmp_file"
    
    # Replace original file
    mv "$tmp_file" "$file"
done

echo "Conversion complete!"
echo ""
echo "Summary of changes:"
echo "- fn -> fun"
echo "- Removed type annotations (: i32, : String, etc.)"
echo "- Removed return type annotations (-> i32, -> String, etc.)"
echo "- Removed generic type parameters (<T>, <A, B>, etc.)"
echo "- Removed namespace prefixes (Vec::, HashMap::, etc.)"