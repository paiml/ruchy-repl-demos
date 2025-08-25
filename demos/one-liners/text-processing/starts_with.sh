#!/bin/sh
set -eu
# Check string starts with
printf "Does 'hello' start with 'he'? "
ruchy -e '"hello".starts_with("he")'
