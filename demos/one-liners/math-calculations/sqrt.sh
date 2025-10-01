#!/bin/sh
# One-liner: Calculate square root
# Usage: ./sqrt.sh
# shellcheck disable=SC2016

echo "Square root:"
ruchy -e 'println((16.0_f64).sqrt())'

echo "Multiple square roots:"
ruchy -e '[4.0, 9.0, 16.0, 25.0].iter().map(|x| x.sqrt()).for_each(|x| println(x))'
