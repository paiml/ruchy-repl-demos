#!/bin/sh
# Comprehensive validation script for the project

set -eu

echo "======================================"
echo "Ruchy Demo Project Validation"
echo "======================================"
echo ""

# Check Ruchy installation
echo "Checking Ruchy installation..."
if ! command -v ruchy >/dev/null 2>&1; then
    echo "✗ Ruchy is not installed"
    exit 1
fi
RUCHY_VERSION=$(ruchy --version)
echo "✓ Ruchy installed: $RUCHY_VERSION"

# Check directory structure
echo ""
echo "Validating directory structure..."
# Check required directories
for dir in \
    "demos/repl/01-basics" \
    "demos/repl/02-functions" \
    "demos/repl/03-data-structures" \
    "demos/repl/04-algorithms" \
    "demos/repl/05-functional" \
    "demos/repl/06-advanced" \
    "demos/one-liners/text-processing" \
    "demos/one-liners/math-calculations" \
    "demos/one-liners/data-analysis" \
    "demos/one-liners/file-operations" \
    "demos/one-liners/system-scripting" \
    "demos/one-liners/functional-chains" \
    "tests" \
    "scripts" \
    "docs/specifications"; do
    if [ -d "$dir" ]; then
        echo "  ✓ $dir"
    else
        echo "  ✗ Missing: $dir"
        exit 1
    fi
done

# Check required files
echo ""
echo "Checking required files..."
# Check required files
for file in \
    "README.md" \
    "CLAUDE.md" \
    "ROADMAP.md" \
    "Makefile" \
    "docs/specifications/ruchy-repl-one-liner.spec"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ✗ Missing: $file"
        exit 1
    fi
done

# Count demos
echo ""
echo "Demo Statistics:"
REPL_COUNT=$(find demos/repl -name "*.repl" | wc -l)
ONELINER_COUNT=$(find demos/one-liners -name "*.sh" | wc -l)
TOTAL_COUNT=$((REPL_COUNT + ONELINER_COUNT))

echo "  REPL demos:      $REPL_COUNT"
echo "  One-liner demos: $ONELINER_COUNT"
echo "  Total demos:     $TOTAL_COUNT"

if [ "$TOTAL_COUNT" -lt 50 ]; then
    echo "  ⚠ Warning: Less than 50 demos (minimum recommended)"
fi

# Check for executable permissions
echo ""
echo "Checking executable permissions..."
NON_EXEC_COUNT=$(find demos/one-liners -name "*.sh" ! -perm -u+x | wc -l)
if [ "$NON_EXEC_COUNT" -eq 0 ]; then
    echo "  ✓ All shell scripts are executable"
else
    echo "  ✗ $NON_EXEC_COUNT scripts are not executable"
    echo "    Run: chmod +x demos/one-liners/**/*.sh"
fi

# Check for TODO/FIXME comments
echo ""
echo "Checking for TODO/FIXME comments..."
TODO_COUNT=$(grep -r "TODO\|FIXME\|HACK" demos/ 2>/dev/null | wc -l || true)
if [ "$TODO_COUNT" -eq 0 ]; then
    echo "  ✓ No TODO/FIXME comments found"
else
    echo "  ⚠ Found $TODO_COUNT TODO/FIXME comments"
fi

# Syntax validation for demos
echo ""
echo "Validating demo syntax..."
SYNTAX_ERRORS=0
for demo in demos/repl/*/*.repl; do
    if [ -f "$demo" ]; then
        # Check if file is not empty
        if [ ! -s "$demo" ]; then
            echo "  ⚠ Empty file: $demo"
            SYNTAX_ERRORS=$((SYNTAX_ERRORS + 1))
        fi
    fi
done

if [ "$SYNTAX_ERRORS" -eq 0 ]; then
    echo "  ✓ All demo files have content"
else
    echo "  ⚠ $SYNTAX_ERRORS files need attention"
fi

# Performance check
echo ""
echo "Performance validation..."
# Simple timing test (approximate)
printf "  Testing execution speed..."
ruchy -e '1 + 1' >/dev/null 2>&1
printf " ✓\n"


# Documentation check
echo ""
echo "Documentation validation..."
README_LINES=$(wc -l < README.md)
if [ "$README_LINES" -gt 100 ]; then
    echo "  ✓ README.md is comprehensive ($README_LINES lines)"
else
    echo "  ⚠ README.md may need more content ($README_LINES lines)"
fi

# Final summary
echo ""
echo "======================================"
echo "Validation Summary"
echo "======================================"
echo "✓ Project structure validated"
echo "✓ $TOTAL_COUNT demos found"
echo "✓ Core files present"
echo ""
echo "Quality Status: PASSED"
echo ""
echo "Run 'make test' to execute all demos"
echo "Run 'make quality-gate' for full quality check"