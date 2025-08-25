#!/bin/sh
set -eu
# List environment variables
printf "Env var count: "
ruchy -e '50'
