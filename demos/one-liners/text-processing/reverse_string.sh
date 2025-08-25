#!/bin/sh
set -eu
# Reverse a string
printf "Reverse 'hello': "
ruchy -e 'print("hello".reverse())'
