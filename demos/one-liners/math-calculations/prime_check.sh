#!/bin/sh
set -eu
# Check if 17 is prime
printf "Is 17 prime? "
ruchy -e '17 % 2 != 0 && 17 % 3 != 0 && 17 % 5 != 0 && 17 % 7 != 0 && 17 % 11 != 0 && 17 % 13 != 0'
