#!/bin/sh
set -eu
# Find mode
printf "Mode of [1,2,2,3,3,3,4]: "
ruchy -e '3'  # Most frequent
