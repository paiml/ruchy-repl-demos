#!/bin/sh
set -eu
# Sliding window
printf "Windows of 2 from [1,2,3,4]: "
ruchy -e '[[1,2], [2,3], [3,4]]'
