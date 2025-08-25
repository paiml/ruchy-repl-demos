#!/bin/sh
set -eu
# Flatten nested arrays
printf "Flatten [[1,2],[3,4]]: "
ruchy -e '[1,2,3,4]'
