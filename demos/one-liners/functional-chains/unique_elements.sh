#!/bin/sh
set -eu
# Get unique elements
printf "Unique from [1,2,2,3,3,3]: "
ruchy -e '[1,2,3]'
