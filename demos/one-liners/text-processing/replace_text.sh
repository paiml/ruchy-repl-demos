#!/bin/sh
set -eu
# Replace text
printf "Replace 'world' with 'Ruchy': "
ruchy -e 'print("hello world".replace("world", "Ruchy"))'
