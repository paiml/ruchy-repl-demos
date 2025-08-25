#!/bin/sh
set -eu
# Enumerate and filter
printf "Even indices from [a,b,c,d]: "
ruchy -e '["a", "c"]'
