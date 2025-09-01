#!/bin/bash
# One-liner: Functional pipeline operations
# Usage: ./pipeline_operations.sh

echo "Functional pipeline operations with Ruchy..."
echo

echo "Array mapping:"
ruchy -e 'let nums = [1, 2, 3, 4]; let doubled = nums.map(|x| x * 2); println(f"{nums} doubled: {doubled}")'

echo "Array filtering concept:"
ruchy -e 'let all_nums = [1, 2, 3, 4, 5, 6]; println(f"Processing {all_nums} (filter even: coming in future versions)")'

echo "Chained transformations:"
ruchy -e 'let data = [1, 2, 3]; let result = data.map(|x| x * 2).map(|x| x + 1); println(f"{data} -> double -> add1: {result}")'

echo "Closure composition:"
ruchy -e 'let add_one = |x| x + 1; let double = |x| x * 2; let value = 5; println(f"Compose: double(add_one({value})) = {double(add_one(value))}")'

echo "Function application:"
ruchy -e 'let apply = |f, x| f(x); let square = |n| n * n; println(f"apply(square, 7) = {apply(square, 7)}")'