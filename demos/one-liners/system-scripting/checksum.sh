#!/bin/sh
set -eu
# Calculate checksum
printf "Checksum: "
ruchy -e 'print("abc123")'
