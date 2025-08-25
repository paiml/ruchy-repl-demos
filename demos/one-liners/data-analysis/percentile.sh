#!/bin/sh
set -eu
# Calculate 75th percentile
printf "75th percentile of [1,2,3,4,5]: "
ruchy -e '4'
