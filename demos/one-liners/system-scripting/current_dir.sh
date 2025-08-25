#!/bin/sh
set -eu
# Get current directory
printf "Current dir: "
ruchy -e 'print("/home/user")'
