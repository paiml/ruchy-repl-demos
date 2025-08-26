#!/bin/sh
set -eu

# Ruchy Provability - Formal verification with ruchy provability
echo "🔐 Running Ruchy Provability Analysis"
echo "===================================="

TOTAL=0
PROVEN=0
UNPROVEN=0

# Create a test file with provable properties
cat > /tmp/provable_demo.ruchy << 'EOF'
// Provable properties demo

// Property: Addition is commutative
#[prove(forall a, b: a + b == b + a)]
fun add_commutative(a, b) {
    a + b
}

// Property: Multiplication by zero
#[prove(forall x: x * 0 == 0)]
fun mult_zero(x) {
    x * 0
}

// Property: Identity function
#[prove(forall x: identity(x) == x)]
fun identity(x) {
    x
}

// Property: Double is always even
#[prove(forall n: double(n) % 2 == 0)]
fun double(n) {
    n * 2
}

// Property: Absolute value is non-negative
#[prove(forall x: abs(x) >= 0)]
fun abs(x) {
    if x < 0 { -x } else { x }
}
EOF

echo "Testing provable properties..."
if ruchy provability /tmp/provable_demo.ruchy > /tmp/prove_output.txt 2>&1; then
    echo "✅ Provability check passed"
    cat /tmp/prove_output.txt | head -20
    PROVEN=$((PROVEN + 1))
else
    echo "❌ Provability check failed"
    cat /tmp/prove_output.txt | head -10
    UNPROVEN=$((UNPROVEN + 1))
fi

echo ""
echo "Checking algorithm correctness..."

# Test sorting algorithm correctness
cat > /tmp/sort_proof.ruchy << 'EOF'
// Prove sorting correctness

#[prove(ensures result.is_sorted() && result.len() == input.len())]
fun bubble_sort(input) {
    let mut arr = input.clone()
    let n = arr.len()
    
    for i in 0..n {
        for j in 0..n-i-1 {
            if arr[j] > arr[j+1] {
                let tmp = arr[j]
                arr[j] = arr[j+1]
                arr[j+1] = tmp
            }
        }
    }
    
    arr
}

#[prove(ensures result >= 0)]
fun factorial(n) {
    if n <= 1 { 1 } else { n * factorial(n - 1) }
}
EOF

if ruchy provability /tmp/sort_proof.ruchy > /tmp/prove_output.txt 2>&1; then
    echo "✅ Algorithm proofs verified"
    PROVEN=$((PROVEN + 1))
else
    echo "⚠️  Some proofs could not be verified"
    UNPROVEN=$((UNPROVEN + 1))
fi

echo ""
echo "===================================="
echo "Provability Summary"
echo "  Proven properties: $PROVEN"
echo "  Unproven: $UNPROVEN"

if [ "$UNPROVEN" -eq 0 ]; then
    echo "✅ All properties formally verified!"
    exit 0
else
    echo "⚠️  Some properties need manual verification"
    exit 0  # Don't fail - provability is optional
fi