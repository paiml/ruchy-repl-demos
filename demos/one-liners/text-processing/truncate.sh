#!/bin/sh
# One-liner: Truncate string to maximum length
# Usage: ./truncate.sh
# shellcheck disable=SC2016

echo "Truncate to length:"
ruchy -e 'let text = "this is a very long string"; let max_len = 10; println(if text.len() > max_len { &text[0..max_len] } else { text })'

echo "Truncate with ellipsis:"
ruchy -e 'let text = "this is a very long string"; let max = 15; println(if text.len() > max { text[0..max].to_string() + "..." } else { text.to_string() })'

echo "Truncate array of strings:"
ruchy -e 'let texts = ["short", "this is much longer", "ok"]; texts.iter().map(|s| if s.len() > 10 { &s[0..10] } else { s }).for_each(|s| println(s))'
