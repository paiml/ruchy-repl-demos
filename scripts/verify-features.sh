#!/bin/sh
# Feature Verification Script (Phase 2B - REPL-221)
# Detects vaporware patterns: unimplemented methods/functions used in demos
# Exit codes: 0 = no issues, 1 = vaporware detected

set -eu

# Colors for output
if [ -t 1 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m'
else
    RED=''; GREEN=''; YELLOW=''; BLUE=''; NC=''
fi

echo "${BLUE}=== Feature Verification Protocol ===${NC}"
echo "Scanning for vaporware patterns in demos..."
echo ""

# Define suspicious patterns (from Phase 1A results)
UNIMPLEMENTED_METHODS=".join\(\)|.reverse\(\)|.for_each\(\)|.count\(\)|.sum\(\)|.sorted\(\)"
UNIMPLEMENTED_STDLIB="sqrt\(|log\(|sin\(|cos\(|ceil\(|floor\("
UNSUPPORTED_SYNTAX="\[.*\.\.[0-9]\]|\[[0-9]\.\.\.\]"
DATAFRAME_REFS="DataFrame|\.to_csv\(|\.read_csv\("

# Directories to scan
DEMO_DIRS="demos/repl demos/one-liner book/demos"

# Create temp file for results
TEMP_RESULTS=$(mktemp)

printf "%s\n" "${BLUE}Checking for unimplemented methods...${NC}"

for dir in $DEMO_DIRS; do
    if [ ! -d "$dir" ]; then
        continue
    fi

    # Find all .ruchy files
    # shellcheck disable=SC2044
    for file in $(find "$dir" -type f -name "*.ruchy"); do
        # Check for unimplemented methods
        if grep -E "$UNIMPLEMENTED_METHODS" "$file" > /dev/null 2>&1; then
            printf "${RED}❌ VAPORWARE: %s${NC}\n" "$file"
            printf "   ${YELLOW}Contains unimplemented method: %s${NC}\n" "$(grep -o -E "$UNIMPLEMENTED_METHODS" "$file" | head -1)"
            echo "ISSUE" >> "$TEMP_RESULTS"
        fi

        # Check for unimplemented stdlib functions
        if grep -E "$UNIMPLEMENTED_STDLIB" "$file" > /dev/null 2>&1; then
            printf "${RED}❌ VAPORWARE: %s${NC}\n" "$file"
            printf "   ${YELLOW}Contains unimplemented stdlib: %s${NC}\n" "$(grep -o -E "$UNIMPLEMENTED_STDLIB" "$file" | head -1)"
            echo "ISSUE" >> "$TEMP_RESULTS"
        fi

        # Check for unsupported syntax
        if grep -E "$UNSUPPORTED_SYNTAX" "$file" > /dev/null 2>&1; then
            printf "${RED}❌ VAPORWARE: %s${NC}\n" "$file"
             printf "   %s\n" "${YELLOW}Contains unsupported syntax: string/array range slicing${NC}"
            echo "ISSUE" >> "$TEMP_RESULTS"
        fi

        # Check for DataFrame references
        if grep -E "$DATAFRAME_REFS" "$file" > /dev/null 2>&1; then
            printf "${RED}❌ VAPORWARE: %s${NC}\n" "$file"
            printf "   %s\n" "${YELLOW}Contains DataFrame reference (not implemented)${NC}"
            echo "ISSUE" >> "$TEMP_RESULTS"
        fi
    done
done

# Count issues and files
ISSUES_FOUND=$(wc -l < "$TEMP_RESULTS" 2>/dev/null || echo "0")
# shellcheck disable=SC2086
TOTAL_FILES=$(find $DEMO_DIRS -type f -name "*.ruchy" 2>/dev/null | wc -l)

# Clean up temp file
rm -f "$TEMP_RESULTS"

echo ""
echo "${BLUE}=== Verification Summary ===${NC}"
echo "Files scanned: $TOTAL_FILES"

if [ "$ISSUES_FOUND" -eq 0 ]; then
    echo "${GREEN}✅ NO VAPORWARE DETECTED${NC}"
    echo "All demos use only implemented features."
    exit 0
else
    echo "${RED}❌ VAPORWARE DETECTED: $ISSUES_FOUND issues${NC}"
    echo ""
    echo "${YELLOW}⚠️  QUALITY GATE FAILURE${NC}"
    echo "Demos contain references to unimplemented features."
    echo ""
    echo "${BLUE}Required Actions:${NC}"
    echo "1. Remove demos using unimplemented features"
    echo "2. Add verification comments: // VERIFIED: feature_name works in ruchy v3.86.0"
    echo "3. Test features manually in REPL before adding to demos"
    echo "4. Update roadmap to track implementation status"
    echo ""
    exit 1
fi
