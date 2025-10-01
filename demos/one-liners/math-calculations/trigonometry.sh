#!/bin/sh
# One-liner: Trigonometric functions
# Usage: ./trigonometry.sh
# shellcheck disable=SC2016

echo "Sine, cosine, tangent:"
ruchy -e 'use std::f64::consts::PI; let angle = PI / 4.0; println(f"sin: {angle.sin():.4}, cos: {angle.cos():.4}, tan: {angle.tan():.4}")'

echo "Convert degrees to radians:"
ruchy -e 'use std::f64::consts::PI; let degrees = 45.0; let radians = degrees * PI / 180.0; println(f"{degrees}° = {radians} radians")'

echo "Arc functions:"
ruchy -e 'println(f"arcsin(0.5) = {(0.5_f64).asin():.4} radians")'
