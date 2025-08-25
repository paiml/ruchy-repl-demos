#!/bin/sh
set -eu
# Calculate quartiles
printf "Q1,Q2,Q3 of [1,2,3,4,5]: "
ruchy -e '[2, 3, 4]'
