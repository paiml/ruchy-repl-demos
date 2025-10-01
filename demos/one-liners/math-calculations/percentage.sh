#!/bin/sh
# One-liner: Calculate percentages
# Usage: ./percentage.sh
# shellcheck disable=SC2016

echo "Calculate percentage:"
ruchy -e 'let part = 25.0; let total = 200.0; println(f"{(part / total * 100.0)}%")'

echo "Find percentage of value:"
ruchy -e 'let value = 150.0; let percent = 20.0; println(f"20% of 150 is {value * percent / 100.0}")'

echo "Percentage increase:"
ruchy -e 'let old = 100.0; let new = 125.0; println(f"Increase: {(new - old) / old * 100.0}%")'
