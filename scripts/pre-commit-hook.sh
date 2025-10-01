#!/bin/sh
# Ruchy REPL Demos Pre-commit Hook - RIGID QUALITY ENFORCEMENT
# Toyota Way: Zero tolerance for defects
#
# Based on best practices from ruchy-book and rosetta-ruchy
# Enforces quality gates before allowing commits
# shellcheck disable=SC2003

set -e

echo "🔍 Ruchy REPL Demos Pre-commit Quality Gates"
echo "=============================================="
echo "ZERO TOLERANCE MODE ACTIVE"
echo ""

# Configuration (STRICT THRESHOLDS)
MIN_TEST_FILES=3

# Function to print colored output
print_status() {
    status="$1"
    message="$2"

    if [ "$status" = "PASS" ]; then
        echo "  ✅ $message"
    elif [ "$status" = "FAIL" ]; then
        echo "  ❌ $message"
    elif [ "$status" = "WARN" ]; then
        echo "  ⚠️  $message"
    else
        echo "  $message"
    fi
}

# Check 1: Ruchy version
printf "  Ruchy version check... "
if ! command -v ruchy >/dev/null 2>&1; then
    echo "❌"
    print_status "FAIL" "Ruchy not installed"
    print_status "INFO" "Install with: cargo install ruchy"
    exit 1
fi

CURRENT_VERSION=$(ruchy --version 2>/dev/null | cut -d' ' -f2 || echo "unknown")
if [ "$CURRENT_VERSION" != "unknown" ]; then
    echo "✅ (v$CURRENT_VERSION)"
else
    echo "⚠️"
    print_status "WARN" "Unable to detect Ruchy version"
fi

# Check 2: SATD (ZERO tolerance)
printf "  SATD check (ZERO tolerance)... "
SATD_COUNT=0

for pattern in "demos/repl/*/*.repl" "demos/one-liners/*/*.sh" "tests/*.ruchy"; do
    for file in $pattern; do
        if [ -f "$file" ]; then
            count=$(grep -c "TODO\|FIXME\|HACK\|XXX" "$file" 2>/dev/null || echo "0")
            SATD_COUNT=$(expr "$SATD_COUNT" + "$count" || echo "$SATD_COUNT")
        fi
    done 2>/dev/null
done

if [ "$SATD_COUNT" = "0" ] || [ -z "$SATD_COUNT" ]; then
    echo "✅"
else
    echo "❌"
    print_status "FAIL" "Found $SATD_COUNT SATD comments - ZERO tolerance violated!"
    echo ""
    echo "   Violations:"
    grep -n "TODO\|FIXME\|HACK\|XXX" demos/repl/*/*.repl demos/one-liners/*/*.sh tests/*.ruchy 2>/dev/null | head -5
    echo ""
    print_status "FAIL" "❌ COMMIT BLOCKED: Remove all TODO/FIXME/HACK comments"
    exit 1
fi

# Check 3: Ruchy test files exist
printf "  Ruchy test files... "
TEST_FILE_COUNT=$(find tests -name "test_*.ruchy" 2>/dev/null | wc -l || echo "0")

if [ "$TEST_FILE_COUNT" -ge "$MIN_TEST_FILES" ]; then
    echo "✅ ($TEST_FILE_COUNT files)"
else
    echo "❌"
    print_status "FAIL" "Only $TEST_FILE_COUNT test files (Required: ≥$MIN_TEST_FILES)"
    print_status "FAIL" "❌ COMMIT BLOCKED: Add more test files"
    exit 1
fi

# Check 4: Ruchy syntax validation
printf "  Ruchy syntax validation... "
SYNTAX_ERRORS=0

for file in tests/test_*.ruchy; do
    if [ -f "$file" ]; then
        if ! ruchy check "$file" >/dev/null 2>&1; then
            SYNTAX_ERRORS=$(expr "$SYNTAX_ERRORS" + 1)
        fi
    fi
done 2>/dev/null

if [ "$SYNTAX_ERRORS" -eq 0 ]; then
    echo "✅"
else
    echo "❌"
    print_status "FAIL" "$SYNTAX_ERRORS files have syntax errors"
    print_status "FAIL" "❌ COMMIT BLOCKED: Fix Ruchy syntax errors"
    exit 1
fi

# Check 5: ShellCheck validation
if command -v shellcheck >/dev/null 2>&1; then
    printf "  ShellCheck validation... "
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

    if [ "$SHELLCHECK_ERRORS" -eq 0 ]; then
        echo "✅"
    else
        echo "❌"
        print_status "FAIL" "$SHELLCHECK_ERRORS scripts have ShellCheck issues"
        print_status "FAIL" "❌ COMMIT BLOCKED: Fix ShellCheck warnings"
        exit 1
    fi
else
    print_status "WARN" "ShellCheck not installed (recommended)"
fi

# Check 6: Comment syntax validation
printf "  Comment syntax validation... "
if [ -f "scripts/validate_comment_syntax.sh" ]; then
    if sh scripts/validate_comment_syntax.sh >/dev/null 2>&1; then
        echo "✅"
    else
        echo "❌"
        print_status "FAIL" "Comment syntax violations found"
        print_status "FAIL" "Use // for Ruchy code comments, not #"
        print_status "FAIL" "❌ COMMIT BLOCKED: Fix comment syntax"
        exit 1
    fi
else
    echo "⚠️"
fi

# Check 7: Required documentation files
printf "  Required documentation... "
MISSING_DOCS=""

if [ ! -f "README.md" ]; then
    MISSING_DOCS="$MISSING_DOCS README.md"
fi

if [ ! -f "CLAUDE.md" ]; then
    MISSING_DOCS="$MISSING_DOCS CLAUDE.md"
fi

if [ ! -f "ROADMAP.md" ]; then
    MISSING_DOCS="$MISSING_DOCS ROADMAP.md"
fi

if [ -z "$MISSING_DOCS" ]; then
    echo "✅"
else
    echo "❌"
    print_status "FAIL" "Missing documentation: $MISSING_DOCS"
    print_status "FAIL" "❌ COMMIT BLOCKED: Add required documentation"
    exit 1
fi

# Check 8: Executable permissions on shell scripts
printf "  Shell script permissions... "
NON_EXEC_COUNT=$(find scripts demos/one-liners -name "*.sh" ! -perm -u+x 2>/dev/null | wc -l || echo "0")

if [ "$NON_EXEC_COUNT" -eq 0 ]; then
    echo "✅"
else
    echo "❌"
    print_status "FAIL" "$NON_EXEC_COUNT scripts not executable"
    print_status "INFO" "Run: find . -name '*.sh' -exec chmod +x {} +"
    print_status "FAIL" "❌ COMMIT BLOCKED: Fix script permissions"
    exit 1
fi

# Check 9: No empty demo files
printf "  Empty file check... "
EMPTY_FILES=0

for pattern in "demos/repl/*/*.repl" "demos/one-liners/*/*.sh"; do
    for file in $pattern; do
        if [ -f "$file" ] && [ ! -s "$file" ]; then
            EMPTY_FILES=$(expr "$EMPTY_FILES" + 1)
        fi
    done 2>/dev/null
done

if [ "$EMPTY_FILES" -eq 0 ]; then
    echo "✅"
else
    echo "❌"
    print_status "FAIL" "$EMPTY_FILES empty demo files found"
    print_status "FAIL" "❌ COMMIT BLOCKED: Remove or complete empty files"
    exit 1
fi

# Check 10: Project structure
printf "  Project structure... "
MISSING_DIRS=""

for dir in demos/repl demos/one-liners tests scripts docs; do
    if [ ! -d "$dir" ]; then
        MISSING_DIRS="$MISSING_DIRS $dir"
    fi
done

if [ -z "$MISSING_DIRS" ]; then
    echo "✅"
else
    echo "❌"
    print_status "FAIL" "Missing directories:$MISSING_DIRS"
    print_status "FAIL" "❌ COMMIT BLOCKED: Fix project structure"
    exit 1
fi

# All checks passed
echo ""
echo "✅ All pre-commit quality gates passed!"
echo ""
echo "Toyota Way: Quality built-in, not bolted-on"
echo "Commit may proceed."
echo ""

exit 0
