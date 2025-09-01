#!/bin/bash
# One-liner: Calculate factorial using ruchy
# Usage: ./factorial.sh

echo "Calculating factorial with Ruchy one-liner..."
echo

echo "Factorial of 5:"
ruchy -e 'fun factorial(n) { if n <= 1 { 1 } else { n * factorial(n - 1) } }; println(factorial(5))'

echo "Factorial of 10:"  
ruchy -e 'fun factorial(n) { if n <= 1 { 1 } else { n * factorial(n - 1) } }; println(factorial(10))'

echo "Factorial of 6:"
ruchy -e 'fun factorial(n) { if n <= 1 { 1 } else { n * factorial(n - 1) } }; println(factorial(6))'