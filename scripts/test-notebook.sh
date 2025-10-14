#!/bin/sh
# Test all demos in Ruchy notebook environment
# Following ruchy-book pattern for notebook validation

set -eu

echo "🧪 Testing Demos in Ruchy Notebook Environment"
echo "=============================================="
echo ""

# Configuration
NOTEBOOK_PORT=8765
NOTEBOOK_HOST="127.0.0.1"
NOTEBOOK_URL="http://${NOTEBOOK_HOST}:${NOTEBOOK_PORT}"
RESULTS_FILE="notebook-results.json"
NOTEBOOK_PID=""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Cleanup function
cleanup() {
    if [ -n "$NOTEBOOK_PID" ] && kill -0 "$NOTEBOOK_PID" 2>/dev/null; then
        echo ""
        echo "🛑 Stopping notebook server (PID: $NOTEBOOK_PID)..."
        kill "$NOTEBOOK_PID" 2>/dev/null || true
        wait "$NOTEBOOK_PID" 2>/dev/null || true
    fi
}

trap cleanup EXIT INT TERM

# Start notebook server
start_notebook_server() {
    echo "🚀 Starting Ruchy notebook server on port ${NOTEBOOK_PORT}..."

    # Start server in background
    ruchy notebook --port "$NOTEBOOK_PORT" --host "$NOTEBOOK_HOST" > /dev/null 2>&1 &
    NOTEBOOK_PID=$!

    # Wait for server to be ready
    echo "⏳ Waiting for server to be ready..."
    for i in 1 2 3 4 5 6 7 8 9 10; do
        if curl -s "${NOTEBOOK_URL}" > /dev/null 2>&1; then
            echo "✅ Notebook server ready (PID: ${NOTEBOOK_PID})"
            return 0
        fi
        sleep 1
    done

    echo "❌ Notebook server failed to start"
    return 1
}

# Test a single demo in notebook
test_demo_in_notebook() {
    demo_file="$1"
    demo_name=$(basename "$demo_file")

    printf "  Testing %s... " "$demo_name"

    # Read demo content
    if [ ! -f "$demo_file" ]; then
        echo "${RED}SKIP${NC} (file not found)"
        return 1
    fi

    demo_code=$(cat "$demo_file")

    # Execute in notebook via API
    response=$(curl -s -X POST "${NOTEBOOK_URL}/api/execute" \
        -H "Content-Type: application/json" \
        -d "{\"code\": $(printf '%s' "$demo_code" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')}" \
        2>/dev/null || echo '{"success":false,"error":"Failed to connect"}')

    # Check if execution succeeded
    if echo "$response" | grep -q '"success":true'; then
        echo "${GREEN}✓ PASS${NC}"
        return 0
    else
        error_msg=$(echo "$response" | sed -n 's/.*"error":"\([^"]*\)".*/\1/p')
        echo "${RED}✗ FAIL${NC} ($error_msg)"
        return 1
    fi
}

# Test REPL demos
test_repl_demos() {
    echo "📖 Testing REPL Demos"
    echo "--------------------"

    total=0
    passed=0

    # Find all REPL demo files
    for category_dir in demos/repl/*/; do
        if [ -d "$category_dir" ]; then
            category_name=$(basename "$category_dir")
            echo ""
            echo "Category: $category_name"

            for demo in "${category_dir}"*.ruchy; do
                if [ -f "$demo" ]; then
                    total=$((total + 1))
                    if test_demo_in_notebook "$demo"; then
                        passed=$((passed + 1))
                    fi
                fi
            done
        fi
    done

    echo ""
    echo "REPL Results: $passed/$total passed"

    return 0
}

# Test one-liner demos
test_oneliner_demos() {
    echo ""
    echo "🔗 Testing One-Liner Demos"
    echo "-------------------------"

    total=0
    passed=0

    # One-liners are tested via shell execution, not notebook
    # Count them for reporting purposes
    for category_dir in demos/one-liners/*/; do
        if [ -d "$category_dir" ]; then
            for demo in "${category_dir}"*.sh; do
                if [ -f "$demo" ]; then
                    total=$((total + 1))
                    # Execute shell script
                    if sh "$demo" > /dev/null 2>&1; then
                        passed=$((passed + 1))
                    fi
                fi
            done
        fi
    done

    echo "One-liner Results: $passed/$total passed (via shell execution)"

    return 0
}

# Generate results JSON
generate_results_json() {
    repl_passed=$1
    repl_total=$2
    oneliner_passed=$3
    oneliner_total=$4

    cat > "$RESULTS_FILE" <<EOF
{
  "notebook_validation": {
    "timestamp": "$(date -u +"%Y-%m-%d %H:%M:%S UTC")",
    "ruchy_version": "$(ruchy --version 2>/dev/null | cut -d' ' -f2 || echo 'unknown')",
    "repl_demos": {
      "total": $repl_total,
      "passed": $repl_passed,
      "failed": $((repl_total - repl_passed)),
      "success_rate": $(awk "BEGIN {printf \"%.4f\", $repl_passed / $repl_total}")
    },
    "oneliner_demos": {
      "total": $oneliner_total,
      "passed": $oneliner_passed,
      "failed": $((oneliner_total - oneliner_passed)),
      "success_rate": $(awk "BEGIN {printf \"%.4f\", $oneliner_passed / $oneliner_total}")
    },
    "overall": {
      "total": $((repl_total + oneliner_total)),
      "passed": $((repl_passed + oneliner_passed)),
      "failed": $((repl_total + oneliner_total - repl_passed - oneliner_passed)),
      "success_rate": $(awk "BEGIN {printf \"%.4f\", ($repl_passed + $oneliner_passed) / ($repl_total + $oneliner_total)}")
    }
  }
}
EOF

    echo ""
    echo "📊 Results saved to: $RESULTS_FILE"
}

# Main execution
main() {
    # Start notebook server
    if ! start_notebook_server; then
        echo "❌ Failed to start notebook server"
        exit 1
    fi

    echo ""

    # Test REPL demos
    test_repl_demos
    repl_passed=$passed
    repl_total=$total

    # Test one-liner demos
    test_oneliner_demos
    oneliner_passed=$passed
    oneliner_total=$total

    # Generate results
    generate_results_json "$repl_passed" "$repl_total" "$oneliner_passed" "$oneliner_total"

    echo ""
    echo "=============================================="
    echo "📊 Notebook Validation Complete"
    echo "=============================================="
    echo ""
    echo "REPL Demos:      $repl_passed/$repl_total passed"
    echo "One-liners:      $oneliner_passed/$oneliner_total passed"
    echo "Overall:         $((repl_passed + oneliner_passed))/$((repl_total + oneliner_total)) passed"
    echo ""

    # Calculate overall success rate
    overall_rate=$(awk "BEGIN {printf \"%.1f\", (($repl_passed + $oneliner_passed) * 100.0) / ($repl_total + $oneliner_total)}")
    echo "Success Rate: ${overall_rate}%"
    echo ""

    # Quality gate: 100% success required
    if [ "$repl_passed" -eq "$repl_total" ] && [ "$oneliner_passed" -eq "$oneliner_total" ]; then
        echo "${GREEN}✅ QUALITY GATE: PASSED${NC}"
        echo "All demos work in notebook environment!"
        return 0
    else
        echo "${RED}❌ QUALITY GATE: FAILED${NC}"
        echo "Some demos failed notebook validation"
        return 1
    fi
}

# Run main
main "$@"
