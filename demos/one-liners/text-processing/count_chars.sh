#!/bin/sh
# One-liner: Count specific characters in string
# Usage: ./count_chars.sh
# shellcheck disable=SC2016

echo "Count specific character:"
ruchy -e 'let text = "hello world"; println(f"Letter o appears: {text.chars().filter(|c| c == &'\''o'\'').count()} times")'

echo "Count vowels:"
ruchy -e 'let text = "programming"; let vowels = "aeiou"; println(f"Vowels: {text.chars().filter(|c| vowels.contains(*c)).count()}")'

echo "Count digits:"
ruchy -e 'let text = "abc123def456"; println(f"Digits: {text.chars().filter(|c| c.is_numeric()).count()}")'
