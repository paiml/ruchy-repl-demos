#!/bin/sh
set -eu
# Get user info
printf "User: "
ruchy -e 'print("user")'
