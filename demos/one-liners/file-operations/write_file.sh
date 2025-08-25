#!/bin/sh
set -eu
# Write to file (simulated)
printf "Writing to file: "
ruchy -e 'print("Data written")'
