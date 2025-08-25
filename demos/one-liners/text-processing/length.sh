#!/bin/sh
set -eu
# String length
printf "Length of 'hello world': "
ruchy -e '"hello world".len()'
