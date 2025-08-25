#!/bin/sh
set -eu
# Conditional chaining
printf "Process if > 0: "
ruchy -e 'print("processed")'
