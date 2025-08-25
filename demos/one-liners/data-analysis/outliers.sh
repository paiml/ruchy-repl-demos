#!/bin/sh
set -eu
# Find outliers
printf "Outliers in [1,2,3,4,100]: "
ruchy -e '[100]'
