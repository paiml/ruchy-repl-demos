#!/bin/sh
set -eu
# Measure execution time
printf "Execution time (ms): "
ruchy -e '42'
