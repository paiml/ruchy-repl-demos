#!/bin/sh
# One-liner: Calculate combinations (nCr)
# Usage: ./combinations.sh
# shellcheck disable=SC2016

echo "Combinations formula: nCr = n! / (r! * (n-r)!)"
ruchy -e 'fn fact(n: u64) -> u64 { (1..=n).product() } fn comb(n: u64, r: u64) -> u64 { fact(n) / (fact(r) * fact(n - r)) } println(f"C(5,2) = {comb(5, 2)}")'

echo "Choose 3 from 10:"
ruchy -e 'fn fact(n: u64) -> u64 { (1..=n).product() } fn comb(n: u64, r: u64) -> u64 { fact(n) / (fact(r) * fact(n - r)) } println(f"C(10,3) = {comb(10, 3)}")'
