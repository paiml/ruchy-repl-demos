#!/bin/sh
set -eu
# Skip and take
printf "Skip 2, take 3 from [1,2,3,4,5]: "
ruchy -e '[3,4,5]'
