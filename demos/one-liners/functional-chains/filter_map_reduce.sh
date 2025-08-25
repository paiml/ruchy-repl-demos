#!/bin/sh
set -eu
# Filter, map, reduce pipeline
printf "Filter evens, double, sum [1,2,3,4]: "
ruchy -e '(2*2) + (4*2)'
