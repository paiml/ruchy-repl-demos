#!/bin/sh
# One-liner: Exponential (e^x) calculations
# Usage: ./exponential.sh
# shellcheck disable=SC2016

echo "Calculate e^x:"
ruchy -e 'use std::f64::consts::E; println(E.powf(2.0))'

echo "Exponential of multiple values:"
ruchy -e 'use std::f64::consts::E; [1.0, 2.0, 3.0].iter().map(|x| E.powf(*x)).for_each(|x| println(f"{x:.4}"))'

echo "Natural exponential:"
ruchy -e 'println((1.0_f64).exp())'
