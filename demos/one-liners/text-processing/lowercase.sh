#!/bin/sh
set -eu
# Convert to lowercase
printf "Lowercase 'HELLO': "
ruchy -e 'print("HELLO".to_lowercase())'
