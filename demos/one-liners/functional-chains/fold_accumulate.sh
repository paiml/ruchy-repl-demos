#!/bin/sh
set -eu
# Fold accumulate
printf "Running sum of [1,2,3,4]: "
ruchy -e '[1,3,6,10]'
