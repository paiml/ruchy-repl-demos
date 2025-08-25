#!/bin/sh
set -eu
# Partition data
printf "Partition by even/odd [1,2,3,4]: "
ruchy -e '[[2,4], [1,3]]'
