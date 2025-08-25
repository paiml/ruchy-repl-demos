#!/bin/sh
set -eu

# Code coverage report generator

echo "========================================="
echo "Code Coverage Report"
echo "========================================="
echo ""

# Count demos and tests
total_demos=$(find demos -type f \( -name "*.repl" -o -name "*.sh" \) | wc -l)
total_tests=$(find tests -type f -name "*.yaml" | wc -l)

repl_demos=$(find demos/repl -name "*.repl" | wc -l)
oneliner_demos=$(find demos/one-liners -name "*.sh" | wc -l)

repl_tests=$(find tests/repl -name "*.yaml" 2>/dev/null | wc -l || echo 0)
oneliner_tests=$(find tests/one-liner -name "*.yaml" 2>/dev/null | wc -l || echo 0)

# Calculate coverage
if [ "$total_demos" -gt 0 ]; then
    coverage=$((total_tests * 100 / total_demos))
else
    coverage=0
fi

# Category breakdown
echo "Demo Statistics:"
echo "  REPL demos:      $repl_demos"
echo "  One-liner demos: $oneliner_demos"
echo "  Total demos:     $total_demos"
echo ""

echo "Test Statistics:"
echo "  REPL tests:      $repl_tests"
echo "  One-liner tests: $oneliner_tests"
echo "  Total tests:     $total_tests"
echo ""

# Coverage by category
echo "Coverage by Category:"
for dir in demos/repl/*/; do
    if [ -d "$dir" ]; then
        category=$(basename "$dir")
        demo_count=$(find "$dir" -name "*.repl" | wc -l)
        test_count=$(find "tests/repl/$category" -name "*.yaml" 2>/dev/null | wc -l || echo 0)
        
        if [ "$demo_count" -gt 0 ]; then
            cat_coverage=$((test_count * 100 / demo_count))
        else
            cat_coverage=0
        fi
        
        printf "  %-20s %2d demos, %2d tests (%d%%)\n" "$category:" "$demo_count" "$test_count" "$cat_coverage"
    fi
done

echo ""
for dir in demos/one-liners/*/; do
    if [ -d "$dir" ]; then
        category=$(basename "$dir")
        demo_count=$(find "$dir" -name "*.sh" | wc -l)
        test_count=$(find "tests/one-liner/$category" -name "*.yaml" 2>/dev/null | wc -l || echo 0)
        
        if [ "$demo_count" -gt 0 ]; then
            cat_coverage=$((test_count * 100 / demo_count))
        else
            cat_coverage=0
        fi
        
        printf "  %-20s %2d demos, %2d tests (%d%%)\n" "$category:" "$demo_count" "$test_count" "$cat_coverage"
    fi
done

# Overall summary
echo ""
echo "========================================="
echo "Overall Coverage: ${coverage}%"
echo "========================================="

# Generate coverage badge
if [ "$coverage" -ge 80 ]; then
    badge_color="green"
    status="✓"
elif [ "$coverage" -ge 60 ]; then
    badge_color="yellow"
    status="⚠"
else
    badge_color="red"
    status="✗"
fi

echo ""
echo "Coverage Badge: $status ${coverage}% ($badge_color)"

# Generate JSON report
cat > coverage.json << EOF
{
  "total_demos": $total_demos,
  "total_tests": $total_tests,
  "coverage_percent": $coverage,
  "repl_demos": $repl_demos,
  "oneliner_demos": $oneliner_demos,
  "badge_color": "$badge_color",
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

echo ""
echo "Coverage report saved to coverage.json"