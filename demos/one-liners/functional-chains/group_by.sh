#!/bin/sh
set -eu
# Group by property
printf "Group by first letter: "
ruchy -e '[["apple", "ant"], ["bat", "bee"]]'
