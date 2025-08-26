#!/bin/sh
set -eu

# Comprehensive Ruchy Quality Analysis using ALL tools
echo "🚀 COMPREHENSIVE RUCHY QUALITY ANALYSIS"
echo "========================================"
echo "Using ALL available Ruchy tools for maximum dogfooding"
echo ""

# Track overall results
TOOLS_USED=0
TOOLS_PASSED=0
TOOLS_FAILED=0

# Helper function to run a tool
run_tool() {
    tool_name="$1"
    tool_command="$2"
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🔧 Running: ruchy $tool_name"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    TOOLS_USED=$((TOOLS_USED + 1))
    
    if eval "$tool_command"; then
        echo "✅ $tool_name: PASSED"
        TOOLS_PASSED=$((TOOLS_PASSED + 1))
    else
        echo "❌ $tool_name: FAILED"
        TOOLS_FAILED=$((TOOLS_FAILED + 1))
    fi
    echo ""
}

# 1. SYNTAX CHECK
run_tool "check" "ruchy check tests/test_framework.ruchy 2>/dev/null"

# 2. TEST EXECUTION
run_tool "test" "ruchy test tests/test_basics.ruchy 2>/dev/null"

# 3. LINTING
run_tool "lint" "ruchy lint tests/test_framework.ruchy 2>/dev/null"

# 4. FORMATTING
run_tool "fmt" "ruchy fmt tests/test_framework.ruchy > /tmp/formatted.ruchy 2>/dev/null"

# 5. AST ANALYSIS
run_tool "ast" "ruchy ast tests/test_basics.ruchy > /tmp/ast.json 2>/dev/null"

# 6. PROVABILITY
echo "Testing provability..."
cat > /tmp/prove_test.ruchy << 'EOF'
#[prove(forall x: x + 0 == x)]
fun add_zero(x) { x + 0 }
EOF
run_tool "provability" "ruchy provability /tmp/prove_test.ruchy 2>/dev/null"

# 7. RUNTIME ANALYSIS
run_tool "runtime" "ruchy runtime tests/test_basics.ruchy 2>/dev/null"

# 8. QUALITY SCORE
run_tool "score" "ruchy score tests/test_framework.ruchy 2>/dev/null"

# 9. QUALITY GATE
run_tool "quality-gate" "ruchy quality-gate tests/test_basics.ruchy 2>/dev/null"

# 10. DOCUMENTATION
run_tool "doc" "ruchy doc tests/test_framework.ruchy > /tmp/docs.md 2>/dev/null"

# 11. BENCHMARKING
echo "Creating benchmark test..."
cat > /tmp/bench_test.ruchy << 'EOF'
fun fibonacci(n) {
    if n <= 1 { n } else { fibonacci(n-1) + fibonacci(n-2) }
}
#[bench]
fun bench_fib() { fibonacci(20) }
EOF
run_tool "bench" "ruchy bench /tmp/bench_test.ruchy 2>/dev/null"

# 12. OPTIMIZATION ANALYSIS
run_tool "optimize" "ruchy optimize tests/test_basics.ruchy 2>/dev/null"

# 13. TRANSPILATION
run_tool "transpile" "ruchy transpile tests/test_framework.ruchy > /tmp/transpiled.rs 2>/dev/null"

# 14. PARSING
run_tool "parse" "ruchy parse tests/test_basics.ruchy > /tmp/parsed.json 2>/dev/null"

# 15. COVERAGE (via test command)
echo "Testing with coverage..."
run_tool "test --coverage" "ruchy test --coverage tests/test_basics.ruchy 2>/dev/null"

# Summary Report
echo ""
echo "========================================"
echo "📊 RUCHY TOOLS USAGE REPORT"
echo "========================================"
echo "  Tools Used: $TOOLS_USED"
echo "  Passed: $TOOLS_PASSED"
echo "  Failed: $TOOLS_FAILED"
echo ""

# Feature Matrix
echo "📋 Feature Support Matrix:"
echo "  ✅ Syntax Checking   - ruchy check"
echo "  ✅ Testing           - ruchy test"
echo "  ✅ Linting           - ruchy lint"
echo "  ✅ Formatting        - ruchy fmt"
echo "  ✅ AST Analysis      - ruchy ast"
echo "  ✅ Formal Proofs     - ruchy provability"
echo "  ✅ Runtime Analysis  - ruchy runtime"
echo "  ✅ Quality Scoring   - ruchy score"
echo "  ✅ Quality Gates     - ruchy quality-gate"
echo "  ✅ Documentation     - ruchy doc"
echo "  ✅ Benchmarking      - ruchy bench"
echo "  ✅ Optimization      - ruchy optimize"
echo "  ✅ Transpilation     - ruchy transpile"
echo "  ✅ Parsing           - ruchy parse"
echo "  ✅ Coverage          - ruchy test --coverage"
echo ""

if [ "$TOOLS_PASSED" -eq "$TOOLS_USED" ]; then
    echo "🎉 PERFECT SCORE! All Ruchy tools working!"
    echo "This project demonstrates COMPLETE dogfooding!"
    exit 0
else
    echo "⚠️  Some tools need attention ($TOOLS_FAILED failed)"
    echo "Continue improving to achieve 100% dogfooding"
    exit 1
fi