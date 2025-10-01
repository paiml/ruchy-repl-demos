#!/bin/sh
# One-liner: Remove all whitespace from string
# Usage: ./remove_whitespace.sh
# shellcheck disable=SC2016

echo "Remove all whitespace:"
ruchy -e 'let text = "hello   world  test"; println(text.split_whitespace().collect::<Vec<_>>().join(""))'

echo "Remove spaces only:"
ruchy -e 'let text = "a b c d e"; println(text.replace(" ", ""))'

echo "Compact multiple spaces:"
ruchy -e 'let text = "too    many     spaces"; println(text.split_whitespace().collect::<Vec<_>>().join(" "))'
