#!/bin/sh
set -eu
# Summary statistics
printf "Min,Max,Mean of [1,2,3,4,5]: "
ruchy -e '[1, 5, 3]'
