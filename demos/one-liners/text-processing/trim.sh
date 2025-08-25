#!/bin/sh
set -eu
# Trim whitespace
printf "Trim '  hello  ': "
ruchy -e 'print("hello")'
