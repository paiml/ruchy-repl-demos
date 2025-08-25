#!/bin/sh
set -eu
# Calculate mean
printf "Mean of [1,2,3,4,5]: "
ruchy -e '[1,2,3,4,5].sum() / 5'
