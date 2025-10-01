#!/bin/sh
# One-liner: Repeat string N times
# Usage: ./repeat_string.sh
# shellcheck disable=SC2016

echo "Repeat string:"
ruchy -e 'let s = "ha"; println(s.repeat(5))'

echo "Create separator line:"
ruchy -e 'println("=".repeat(50))'

echo "Build pattern:"
ruchy -e 'let pattern = "* "; println(pattern.repeat(10))'
