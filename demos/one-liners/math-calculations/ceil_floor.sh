#!/bin/sh
# One-liner: Ceiling and floor operations
# Usage: ./ceil_floor.sh
# shellcheck disable=SC2016

echo "Ceiling (round up):"
ruchy -e 'println((3.2_f64).ceil())'

echo "Floor (round down):"
ruchy -e 'println((3.8_f64).floor())'

echo "Process array:"
ruchy -e '[1.1, 2.5, 3.9].iter().for_each(|x| println(f"{x} -> ceil: {x.ceil()}, floor: {x.floor()}"))'
