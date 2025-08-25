#!/bin/sh
set -eu
# Error handling in chain
printf "Safe divide: "
ruchy -e '10 / 2'
