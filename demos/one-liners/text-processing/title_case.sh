#!/bin/sh
# One-liner: Convert string to title case
# Usage: ./title_case.sh
# shellcheck disable=SC2016

echo "Convert to title case:"
ruchy -e 'let text = "hello world"; let title = text.split(" ").map(|w| { let mut chars = w.chars(); match chars.next() { Some(c) => c.to_uppercase().collect::<String>() + chars.as_str(), None => String::new() } }).collect::<Vec<_>>().join(" "); println(title)'

echo "Title case for names:"
ruchy -e 'let name = "john doe smith"; println(name.split_whitespace().map(|w| { let (first, rest) = w.split_at(1); first.to_uppercase() + rest }).collect::<Vec<_>>().join(" "))'
