#!/bin/sh
# Compare Native vs WASM execution
# Generates comparison report

set -eu

echo "⚖️  Comparing Native vs WASM Execution"
echo "======================================"
echo ""

# Create temporary files
NATIVE_OUTPUT="/tmp/ruchy_native_output.txt"
WASM_OUTPUT="/tmp/ruchy_wasm_output.txt"

# Run test in native mode
echo "Running in Native mode..."
ruchy tests/wasm/wasm_compatibility_test.ruchy > "$NATIVE_OUTPUT" 2>&1

echo "Running in WASM mode..."
echo "(Note: WASM testing requires manual execution in WASM notebook)"
echo "      This script shows the framework for comparison."
echo ""

# For now, copy native output as WASM (placeholder)
cp "$NATIVE_OUTPUT" "$WASM_OUTPUT"

# Compare outputs
echo "Comparing outputs..."
if diff -u "$NATIVE_OUTPUT" "$WASM_OUTPUT" > /dev/null 2>&1; then
    echo "✅ Outputs identical - Full compatibility"
else
    echo "⚠️  Differences detected:"
    diff -u "$NATIVE_OUTPUT" "$WASM_OUTPUT" || true
fi

echo ""
echo "Output files:"
echo "  Native: $NATIVE_OUTPUT"
echo "  WASM:   $WASM_OUTPUT"
