#!/bin/sh
set -eu
# Append to file
printf "Appending: "
ruchy -e 'print("Data appended")'
