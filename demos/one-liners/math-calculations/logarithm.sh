#!/bin/sh
# One-liner: Logarithm calculations
# Usage: ./logarithm.sh
# shellcheck disable=SC2016

echo "Natural logarithm (ln):"
ruchy -e 'println((10.0_f64).ln())'

echo "Base-10 logarithm:"
ruchy -e 'println((100.0_f64).log10())'

echo "Base-2 logarithm:"
ruchy -e 'println((8.0_f64).log2())'

echo "Custom base logarithm:"
ruchy -e 'let val = 81.0; let base = 3.0; println(val.log(base))'
