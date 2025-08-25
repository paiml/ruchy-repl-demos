#!/bin/sh
set -eu
# Multi-step transformation
printf "Square, add 1, double [1,2,3]: "
ruchy -e '[4,10,20]'
