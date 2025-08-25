#!/bin/sh
set -eu
# Read file (simulated)
printf "File content: "
ruchy -e 'print("Hello from file")'
