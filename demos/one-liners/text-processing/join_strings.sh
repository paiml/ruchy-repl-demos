#!/bin/sh
# One-liner: Join array of strings with delimiter
# Usage: ./join_strings.sh
# shellcheck disable=SC2016

echo "Join with comma:"
ruchy -e 'let words = ["apple", "banana", "orange"]; println(words.join(", "))'

echo "Build CSV line:"
ruchy -e 'let row = ["Alice", "25", "NYC"]; println(row.join(","))'

echo "Join with custom separator:"
ruchy -e 'let path_parts = ["home", "user", "documents"]; println(path_parts.join("/"))'
