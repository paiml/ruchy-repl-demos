#!/bin/sh
set -eu
# Get environment variable
printf "HOME env var: "
ruchy -e 'print("/home/user")'
