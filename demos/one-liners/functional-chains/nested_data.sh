#!/bin/sh
set -eu
# Process nested data
printf "Flatten [[1,2],[3,4]]: "
ruchy -e '[1,2,3,4]'
