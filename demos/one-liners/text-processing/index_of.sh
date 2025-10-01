#!/bin/sh
# One-liner: Find index of substring in string
# Usage: ./index_of.sh
# shellcheck disable=SC2016

echo "Find index of substring:"
ruchy -e 'let text = "hello world"; match text.find("world") { Some(i) => println(f"Found at index: {i}"), None => println("Not found") }'

echo "Find last occurrence:"
ruchy -e 'let text = "the quick brown fox jumps over the lazy dog"; match text.rfind("the") { Some(i) => println(f"Last occurrence at: {i}"), None => println("Not found") }'

echo "Check if substring exists:"
ruchy -e 'let email = "user@example.com"; println(f"Has @: {email.contains(\"@\")}")'
