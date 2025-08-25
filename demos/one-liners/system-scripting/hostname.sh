#!/bin/sh
set -eu
# Get hostname
printf "Hostname: "
ruchy -e 'print("localhost")'
