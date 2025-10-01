#!/bin/sh
# One-liner: Split string by delimiter
# Usage: ./split_string.sh
# shellcheck disable=SC2016

echo "Split by comma:"
ruchy -e 'let csv = "apple,banana,orange"; csv.split(",").for_each(|x| println(x))'

echo "Split by space and count:"
ruchy -e 'let text = "the quick brown fox"; println(f"Words: {text.split(\" \").count()}")'

echo "Split and filter:"
ruchy -e 'let data = "1,2,3,4,5"; let nums: Vec<i32> = data.split(",").map(|x| x.parse().unwrap()).filter(|x| x > 2).collect(); println(nums)'
