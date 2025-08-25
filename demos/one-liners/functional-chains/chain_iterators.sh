#!/bin/sh
set -eu
# Chain iterators
printf "Chain [1,2] and [3,4]: "
ruchy -e '[1,2,3,4]'
