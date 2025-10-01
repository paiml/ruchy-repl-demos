#!/bin/sh
# One-liner: Extract substring from string
# Usage: ./substring.sh
# shellcheck disable=SC2016

echo "Extract substring by range:"
ruchy -e 'let text = "hello world"; println(text[0..5])'

echo "Extract from index to end:"
ruchy -e 'let text = "programming"; println(text[3..])'

echo "Extract domain from email:"
ruchy -e 'let email = "user@example.com"; let at = email.find("@").unwrap(); println(email[at+1..])'
