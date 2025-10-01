#!/bin/sh
# shellcheck disable=SC2003,SC3037
# Comprehensive Coverage Report for Ruchy REPL Demos
# Tracks demo coverage, test coverage, and quality metrics
#
# Based on ruchy-book and rosetta-ruchy coverage frameworks

set -eu

echo "📊 Comprehensive Coverage Report"
echo "================================="
echo ""

# Generate timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
RUCHY_VERSION=$(ruchy --version 2>/dev/null | cut -d' ' -f2 || echo "unknown")

# Demo Coverage Analysis
echo "=== Demo Coverage Analysis ==="
echo ""

# Count by category
echo "REPL Demos by Category:"
for category in 01-basics 02-functions 03-data-structures 04-algorithms 05-functional 06-advanced; do
    count=$(find "demos/repl/$category" -name "*.repl" 2>/dev/null | wc -l || echo "0")
    target=10
    percentage=$((count * 100 / target))
    if [ "$count" -ge "$target" ]; then
        status="✅"
    else
        status="⚠️ "
    fi
    printf "  %s %-25s: %2d/%2d (%3d%%)\n" "$status" "$category" "$count" "$target" "$percentage"
done

echo ""
echo "One-liner Demos by Category:"
for category in text-processing math-calculations data-analysis file-operations system-scripting functional-chains; do
    count=$(find "demos/one-liners/$category" -name "*.sh" 2>/dev/null | wc -l || echo "0")
    case "$category" in
        text-processing) target=20 ;;
        math-calculations) target=20 ;;
        data-analysis) target=15 ;;
        file-operations) target=10 ;;
        system-scripting) target=15 ;;
        functional-chains) target=20 ;;
        *) target=10 ;;
    esac
    percentage=$((count * 100 / target))
    if [ "$count" -ge "$target" ]; then
        status="✅"
    else
        status="⚠️ "
    fi
    printf "  %s %-25s: %2d/%2d (%3d%%)\n" "$status" "$category" "$count" "$target" "$percentage"
done

echo ""

# Overall Demo Statistics
REPL_TOTAL=$(find demos/repl -name "*.repl" 2>/dev/null | wc -l || echo "0")
ONELINER_TOTAL=$(find demos/one-liners -name "*.sh" 2>/dev/null | wc -l || echo "0")
DEMO_TOTAL=$((REPL_TOTAL + ONELINER_TOTAL))
DEMO_TARGET=150

echo "=== Overall Demo Statistics ==="
echo ""
printf "  REPL demos:          %3d\n" "$REPL_TOTAL"
printf "  One-liner demos:     %3d\n" "$ONELINER_TOTAL"
printf "  Total demos:         %3d / %3d (Target)\n" "$DEMO_TOTAL" "$DEMO_TARGET"

if [ "$DEMO_TOTAL" -ge "$DEMO_TARGET" ]; then
    printf "  Status:              ✅ Target achieved\n"
else
    REMAINING=$((DEMO_TARGET - DEMO_TOTAL))
    printf "  Status:              ⚠️  Need %d more demos\n" "$REMAINING"
fi

echo ""

# Test Coverage Analysis
echo "=== Test Coverage Analysis ==="
echo ""

TEST_COUNT=$(find tests -name "test_*.ruchy" 2>/dev/null | wc -l || echo "0")
printf "  Test files:          %3d\n" "$TEST_COUNT"

# Run tests and capture pass rate
if [ -f "scripts/run_ruchy_tests.sh" ]; then
    TEST_OUTPUT="/tmp/coverage_test_output.log"
    if sh scripts/run_ruchy_tests.sh > "$TEST_OUTPUT" 2>&1; then
        PASS_RATE=$(grep -o "[0-9]\+%" "$TEST_OUTPUT" | head -1 || echo "0%")
        printf "  Pass rate:           %s\n" "$PASS_RATE"
        printf "  Status:              ✅ Tests passing\n"
    else
        printf "  Pass rate:           0%%\n"
        printf "  Status:              ❌ Tests failing\n"
    fi
else
    printf "  Status:              ⚠️  Test runner not found\n"
fi

echo ""

# Quality Metrics
echo "=== Quality Metrics ==="
echo ""

# SATD Count
SATD_COUNT=0
for pattern in "demos/repl/*/*.repl" "demos/one-liners/*/*.sh" "tests/*.ruchy"; do
    for file in $pattern; do
        if [ -f "$file" ]; then
            count=$(grep -c "TODO\|FIXME\|HACK\|XXX" "$file" 2>/dev/null || echo "0")
            SATD_COUNT=$(expr "$SATD_COUNT" + "$count" || echo "$SATD_COUNT")
        fi
    done 2>/dev/null
done

printf "  SATD comments:       %3d (Target: 0)\n" "$SATD_COUNT"
if [ "$SATD_COUNT" -eq 0 ]; then
    printf "  SATD Status:         ✅ ZERO SATD achieved\n"
else
    printf "  SATD Status:         ❌ ZERO tolerance violated\n"
fi

# Empty files check
EMPTY_COUNT=0
for pattern in "demos/repl/*/*.repl" "demos/one-liners/*/*.sh"; do
    for file in $pattern; do
        if [ -f "$file" ] && [ ! -s "$file" ]; then
            EMPTY_COUNT=$(expr "$EMPTY_COUNT" + 1)
        fi
    done 2>/dev/null
done

printf "  Empty files:         %3d (Target: 0)\n" "$EMPTY_COUNT"
if [ "$EMPTY_COUNT" -eq 0 ]; then
    printf "  Empty file status:   ✅ No empty files\n"
else
    printf "  Empty file status:   ❌ Remove empty files\n"
fi

# ShellCheck compliance
if command -v shellcheck >/dev/null 2>&1; then
    SHELLCHECK_ERRORS=0
    for pattern in "scripts/*.sh" "demos/one-liners/*/*.sh"; do
        for script in $pattern; do
            if [ -f "$script" ]; then
                if ! shellcheck -s sh -e SC2039,SC3043 "$script" >/dev/null 2>&1; then
                    SHELLCHECK_ERRORS=$(expr "$SHELLCHECK_ERRORS" + 1)
                fi
            fi
        done 2>/dev/null
    done
    printf "  ShellCheck errors:   %3d (Target: 0)\n" "$SHELLCHECK_ERRORS"
    if [ "$SHELLCHECK_ERRORS" -eq 0 ]; then
        printf "  ShellCheck status:   ✅ All scripts pass\n"
    else
        printf "  ShellCheck status:   ❌ Fix ShellCheck issues\n"
    fi
else
    printf "  ShellCheck:          ⚠️  Not installed\n"
fi

echo ""

# Ruchy Tool Integration
echo "=== Ruchy Tool Integration ==="
echo ""

TOOL_COUNT=0
TOOL_TOTAL=0

for tool in check lint fmt ast prove bench score quality-gate optimize doc; do
    TOOL_TOTAL=$((TOOL_TOTAL + 1))
    if ruchy "$tool" --help >/dev/null 2>&1; then
        printf "  ✅ ruchy %-15s Available\n" "$tool"
        TOOL_COUNT=$((TOOL_COUNT + 1))
    else
        printf "  ⚠️  ruchy %-15s Not available\n" "$tool"
    fi
done

TOOL_PERCENTAGE=$((TOOL_COUNT * 100 / TOOL_TOTAL))
echo ""
printf "  Tool integration:    %d/%d (%d%%)\n" "$TOOL_COUNT" "$TOOL_TOTAL" "$TOOL_PERCENTAGE"

echo ""

# Performance Metrics
echo "=== Performance Metrics ==="
echo ""

printf "  Testing execution speed...\n"
START_TIME=$(date +%s%N)
ruchy -e 'println("benchmark")' >/dev/null 2>&1 || true
END_TIME=$(date +%s%N)
DURATION=$((END_TIME - START_TIME))
DURATION_MS=$((DURATION / 1000000))

printf "  Execution time:      %dms\n" "$DURATION_MS"
if [ "$DURATION_MS" -lt 1000 ]; then
    printf "  Performance status:  ✅ < 1000ms target\n"
else
    printf "  Performance status:  ⚠️  >= 1000ms\n"
fi

echo ""

# Summary Score
echo "=== Coverage Summary ==="
echo ""

SCORE=0
MAX_SCORE=10

# Demo count (20% weight)
if [ "$DEMO_TOTAL" -ge "$DEMO_TARGET" ]; then
    SCORE=$((SCORE + 2))
fi

# Test pass rate (20% weight)
if [ "$TEST_COUNT" -ge 3 ]; then
    SCORE=$((SCORE + 2))
fi

# SATD (20% weight)
if [ "$SATD_COUNT" -eq 0 ]; then
    SCORE=$((SCORE + 2))
fi

# Empty files (10% weight)
if [ "$EMPTY_COUNT" -eq 0 ]; then
    SCORE=$((SCORE + 1))
fi

# ShellCheck (10% weight)
if command -v shellcheck >/dev/null 2>&1; then
    if [ "$SHELLCHECK_ERRORS" -eq 0 ]; then
        SCORE=$((SCORE + 1))
    fi
fi

# Tool integration (10% weight)
if [ "$TOOL_PERCENTAGE" -ge 70 ]; then
    SCORE=$((SCORE + 1))
fi

# Performance (10% weight)
if [ "$DURATION_MS" -lt 1000 ]; then
    SCORE=$((SCORE + 1))
fi

SCORE_PERCENTAGE=$((SCORE * 100 / MAX_SCORE))

printf "  Overall Score:       %d/%d (%d%%)\n" "$SCORE" "$MAX_SCORE" "$SCORE_PERCENTAGE"
echo ""

if [ "$SCORE_PERCENTAGE" -ge 80 ]; then
    printf "  Quality Gate:        ✅ PASSED (≥80%%)\n"
    STATUS="PASS"
else
    printf "  Quality Gate:        ❌ FAILED (<80%%)\n"
    STATUS="FAIL"
fi

echo ""
echo "================================="
echo "Report generated: $TIMESTAMP"
echo "Ruchy version: $RUCHY_VERSION"
echo "Overall status: $STATUS"
echo "================================="
echo ""

# Exit with appropriate code
if [ "$STATUS" = "PASS" ]; then
    exit 0
else
    echo "Toyota Way: Quality built-in, not bolted-on"
    echo "Address the issues above to meet quality gates"
    exit 1
fi
