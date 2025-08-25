#!/bin/sh
set -eu
# Check string contains
printf "Does 'hello' contain 'ell'? "
ruchy -e '"hello".contains("ell")'
