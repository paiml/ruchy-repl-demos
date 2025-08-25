#!/bin/sh
set -eu
# Moving average
printf "Moving avg of [1,2,3,4,5]: "
ruchy -e '[1.5, 2.5, 3.5, 4.5]'
