#!/bin/sh
# One-liner: Check if string ends with suffix
# Usage: ./ends_with.sh
# shellcheck disable=SC2016

echo "Check if string ends with suffix:"
ruchy -e 'let text = "hello.txt"; println(text.ends_with(".txt"))'

echo "Check multiple files:"
ruchy -e 'let files = ["doc.pdf", "image.png", "data.txt"]; files.iter().filter(|f| f.ends_with(".txt")).for_each(|f| println(f))'
