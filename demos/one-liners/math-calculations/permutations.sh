#!/bin/sh
# One-liner: Calculate permutations (nPr)
# Usage: ./permutations.sh
# shellcheck disable=SC2016

echo "Permutations formula: nPr = n! / (n-r)!"
ruchy -e 'fn fact(n: u64) -> u64 { (1..=n).product() } fn perm(n: u64, r: u64) -> u64 { fact(n) / fact(n - r) } println(f"P(5,2) = {perm(5, 2)}")'

echo "Arrange 3 from 10:"
ruchy -e 'fn fact(n: u64) -> u64 { (1..=n).product() } fn perm(n: u64, r: u64) -> u64 { fact(n) / fact(n - r) } println(f"P(10,3) = {perm(10, 3)}")'

echo "Full permutations (n!):"
ruchy -e 'fn fact(n: u64) -> u64 { (1..=n).product() } println(f"P(5,5) = {fact(5)}")'
