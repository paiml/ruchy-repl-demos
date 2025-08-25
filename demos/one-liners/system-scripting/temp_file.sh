#!/bin/sh
set -eu
# Create temp file name
printf "Temp file: "
ruchy -e 'print("/tmp/temp_12345")'
