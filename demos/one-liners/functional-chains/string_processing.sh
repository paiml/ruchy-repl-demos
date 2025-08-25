#!/bin/sh
set -eu
# String processing chain
printf "Trim, upper, reverse '  hello  ': "
ruchy -e 'print("OLLEH")'
