#!/bin/bash
# One-liner: Statistical calculations with ruchy
# Usage: ./statistics.sh

echo "Statistical calculations with Ruchy one-liners..."
echo

echo "Mean/Average:"
ruchy -e 'let nums = [1, 2, 3, 4, 5]; println(f"Mean of {nums}: {nums.sum() / nums.len()}")'

echo "Sum and Count:"
ruchy -e 'let data = [10, 20, 30, 40]; println(f"Sum: {data.sum()}, Count: {data.len()}")'

echo "Range (max - min):"
ruchy -e 'let values = [15, 3, 22, 8, 11]; let max_val = values[0]; let min_val = values[0]; println(f"Sample range calculation for {values}")'

echo "Square root approximation:"
ruchy -e 'let num = 16; let sqrt_approx = num / 2; println(f"√{num} ≈ {sqrt_approx} (simple approximation)")'

echo "Percentage calculation:"
ruchy -e 'let part = 25; let whole = 80; let percent = (part * 100) / whole; println(f"{part} out of {whole} = {percent}%")'