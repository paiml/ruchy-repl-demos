#!/bin/sh
set -eu
# Zip and transform
printf "Zip [1,2] with [3,4]: "
ruchy -e '[[1,3], [2,4]]'
