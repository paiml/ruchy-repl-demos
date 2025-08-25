#!/bin/sh
set -eu
# Convert to uppercase
printf "Uppercase 'hello': "
ruchy -e 'print("hello".to_uppercase())'
