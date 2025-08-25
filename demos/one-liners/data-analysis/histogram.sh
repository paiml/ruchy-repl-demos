#!/bin/sh
set -eu
# Histogram bins
printf "Histogram bins: "
ruchy -e '[[1,2], [3,4], [5]]'
