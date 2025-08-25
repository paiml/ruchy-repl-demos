#!/bin/sh
set -eu
# Count words in text
printf "Words in 'the quick brown fox': "
ruchy -e '"the quick brown fox".split(" ").len()'
