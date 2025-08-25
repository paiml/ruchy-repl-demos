#!/bin/sh
set -eu
# URL encode
printf "URL encode 'hello world': "
ruchy -e 'print("hello%20world")'
