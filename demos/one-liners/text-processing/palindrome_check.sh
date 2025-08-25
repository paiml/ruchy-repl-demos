#!/bin/sh
set -eu
# Check if a string is a palindrome
printf "Is 'racecar' a palindrome? "
ruchy -e '"racecar".reverse() == "racecar"'
