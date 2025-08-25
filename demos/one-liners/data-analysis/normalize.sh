#!/bin/sh
set -eu
# Normalize data
printf "Normalize [1,2,3]: "
ruchy -e '[0.0, 0.5, 1.0]'
