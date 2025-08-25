#!/bin/sh
set -eu
# Get system info
printf "OS: "
ruchy -e 'print("Linux")'
