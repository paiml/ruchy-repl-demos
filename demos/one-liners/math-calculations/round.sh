#!/bin/sh
# One-liner: Round numbers to nearest integer
# Usage: ./round.sh
# shellcheck disable=SC2016

echo "Round to nearest integer:"
ruchy -e 'println((3.6_f64).round())'

echo "Round multiple values:"
ruchy -e '[1.4, 2.5, 3.6, 4.5].iter().map(|x| x.round()).for_each(|x| println(x))'

echo "Round to decimal places (multiply, round, divide):"
ruchy -e 'let val = 3.14159; let decimals = 2.0; println((val * 10_f64.powf(decimals)).round() / 10_f64.powf(decimals))'
