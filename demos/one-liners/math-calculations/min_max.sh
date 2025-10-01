#!/bin/sh
# One-liner: Find minimum and maximum values
# Usage: ./min_max.sh
# shellcheck disable=SC2016

echo "Find minimum:"
ruchy -e 'let nums = [5, 2, 8, 1, 9]; println(nums.iter().min().unwrap())'

echo "Find maximum:"
ruchy -e 'let nums = [5, 2, 8, 1, 9]; println(nums.iter().max().unwrap())'

echo "Min and max together:"
ruchy -e 'let nums = [5, 2, 8, 1, 9]; println(f"min: {nums.iter().min().unwrap()}, max: {nums.iter().max().unwrap()}")'
