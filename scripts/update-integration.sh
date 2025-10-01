#!/bin/sh
# shellcheck disable=SC2003,SC3037
# Update INTEGRATION.md with latest test results
# Single source of truth for project integration status
#
# Based on ruchy-book and rosetta-ruchy best practices

set -eu

echo "📝 Updating INTEGRATION.md"
echo "==========================="
echo ""

# Gather system information
RUCHY_VERSION=$(ruchy --version 2>/dev/null | cut -d' ' -f2 || echo "unknown")
TIMESTAMP=$(date "+%B %d, %Y at %H:%M:%S")
HOSTNAME=$(hostname 2>/dev/null || echo "unknown")

# Count demos
REPL_COUNT=$(find demos/repl -name "*.repl" 2>/dev/null | wc -l || echo "0")
ONELINER_COUNT=$(find demos/one-liners -name "*.sh" 2>/dev/null | wc -l || echo "0")
TOTAL_DEMOS=$((REPL_COUNT + ONELINER_COUNT))

# Count test files
TEST_COUNT=$(find tests -name "test_*.ruchy" 2>/dev/null | wc -l || echo "0")

# Run tests and capture results
echo "Running comprehensive tests..."
TEST_OUTPUT="/tmp/test_integration_output.log"
if sh scripts/run_ruchy_tests.sh > "$TEST_OUTPUT" 2>&1; then
    TEST_STATUS="PASS"
    PASS_RATE=$(grep -o "[0-9]\+%" "$TEST_OUTPUT" | head -1 || echo "0%")
else
    TEST_STATUS="FAIL"
    PASS_RATE="0%"
fi

# Check for SATD
SATD_COUNT=0
for pattern in "demos/repl/*/*.repl" "demos/one-liners/*/*.sh" "tests/*.ruchy"; do
    for file in $pattern; do
        if [ -f "$file" ]; then
            count=$(grep -c "TODO\|FIXME\|HACK\|XXX" "$file" 2>/dev/null || echo "0")
            SATD_COUNT=$(expr "$SATD_COUNT" + "$count" || echo "$SATD_COUNT")
        fi
    done 2>/dev/null
done

# Generate INTEGRATION.md
cat > INTEGRATION.md << EOF
# Ruchy REPL Demos - Integration Report

**Generated**: $TIMESTAMP
**System**: $HOSTNAME
**Ruchy Version**: $RUCHY_VERSION

## 📊 Current Status

### Test Results
- **Status**: $TEST_STATUS
- **Pass Rate**: $PASS_RATE
- **Test Files**: $TEST_COUNT

### Demo Coverage
- **REPL Demos**: $REPL_COUNT
- **One-liner Demos**: $ONELINER_COUNT
- **Total Demos**: $TOTAL_DEMOS

### Quality Metrics
- **SATD Comments**: $SATD_COUNT (Target: 0)
- **ShellCheck**: $(command -v shellcheck >/dev/null 2>&1 && echo "✅ Available" || echo "⚠️  Not installed")
- **Ruchy Lint**: $(ruchy lint --help >/dev/null 2>&1 && echo "✅ Available" || echo "⚠️  Not available")

## 🎯 Quality Gates Status

### MANDATORY Gates
EOF

# Run quality gates and capture status
if sh scripts/quality-gates.sh > /tmp/quality_gates.log 2>&1; then
    echo "- ✅ All quality gates PASSED" >> INTEGRATION.md
else
    echo "- ❌ Quality gates FAILED" >> INTEGRATION.md
fi

cat >> INTEGRATION.md << EOF

### Toyota Way Compliance
- **Kaizen (改善)**: Continuous improvement cycle
- **Genchi Genbutsu (現地現物)**: All demos verified
- **Jidoka (自働化)**: Quality built-in
- **Hansei (反省)**: Root cause analysis

## 📈 Coverage by Category

### REPL Demos
EOF

# Count demos by category
for category in basics functions data-structures algorithms functional advanced; do
    count=$(find "demos/repl" -path "*/$category/*" -name "*.repl" 2>/dev/null | wc -l || echo "0")
    printf -- "- **%s**: %d demos\n" "$category" "$count" >> INTEGRATION.md
done

cat >> INTEGRATION.md << EOF

### One-liner Demos
EOF

for category in text-processing math-calculations data-analysis file-operations system-scripting functional-chains; do
    count=$(find "demos/one-liners/$category" -name "*.sh" 2>/dev/null | wc -l || echo "0")
    printf -- "- **%s**: %d demos\n" "$category" "$count" >> INTEGRATION.md
done

cat >> INTEGRATION.md << EOF

## 🔧 Ruchy Tool Integration

### Available Tools
EOF

# Check which Ruchy tools are available
for tool in check lint fmt ast prove bench score quality-gate optimize doc; do
    if ruchy "$tool" --help >/dev/null 2>&1; then
        echo "- ✅ \`ruchy $tool\`" >> INTEGRATION.md
    else
        echo "- ⚠️  \`ruchy $tool\` (not available)" >> INTEGRATION.md
    fi
done

cat >> INTEGRATION.md << EOF

## 📋 Recent Test Output

\`\`\`
EOF

tail -30 "$TEST_OUTPUT" >> INTEGRATION.md 2>/dev/null || echo "No test output available" >> INTEGRATION.MD

cat >> INTEGRATION.md << EOF
\`\`\`

## 🚀 Next Steps

### Immediate Priorities
EOF

if [ "$SATD_COUNT" -gt 0 ]; then
    echo "1. ❌ **CRITICAL**: Remove $SATD_COUNT SATD comments (ZERO tolerance)" >> INTEGRATION.md
fi

if [ "$TOTAL_DEMOS" -lt 50 ]; then
    echo "1. ⚠️  Add more demos (Current: $TOTAL_DEMOS, Target: 50+)" >> INTEGRATION.md
fi

if [ "$TEST_STATUS" = "FAIL" ]; then
    echo "1. ❌ **CRITICAL**: Fix failing tests" >> INTEGRATION.md
fi

cat >> INTEGRATION.md << EOF

### Continuous Improvement
- [ ] Run \`make kaizen\` for continuous improvement cycle
- [ ] Run \`make quality-gate-strict\` for ZERO tolerance validation
- [ ] Review and update ROADMAP.md with sprint progress
- [ ] Add missing demo categories as needed

## 📚 References

- **Development Protocol**: See CLAUDE.md
- **Roadmap**: See ROADMAP.md
- **Quality Gates**: Run \`make help-toyota-way\`

---

*This report is automatically generated. Do not edit manually.*
*Last updated*: $TIMESTAMP
*Ruchy version*: $RUCHY_VERSION
EOF

echo "✅ INTEGRATION.md updated successfully"
echo ""
echo "Summary:"
echo "  Demos: $TOTAL_DEMOS"
echo "  Tests: $TEST_STATUS ($PASS_RATE)"
echo "  SATD: $SATD_COUNT"
echo ""
echo "Review the file: cat INTEGRATION.md"
echo ""

exit 0
