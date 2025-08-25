#!/bin/sh
set -eu
# Base64 encode
printf "Base64 of 'hello': "
ruchy -e 'print("aGVsbG8=")'
