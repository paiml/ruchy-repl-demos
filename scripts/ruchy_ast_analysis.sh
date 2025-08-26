#!/bin/sh
set -eu

# Ruchy AST Analysis - Analyze complexity with ruchy ast
echo "🌳 Running Ruchy AST Analysis"
echo "===================================="

TOTAL=0
COMPLEX=0
MAX_COMPLEXITY=10

# Analyze test files
echo "Analyzing test files..."
for file in tests/*.ruchy; do
    if [ -f "$file" ]; then
        printf "  Analyzing %s...\n" "$(basename "$file")"
        TOTAL=$((TOTAL + 1))
        
        # Get AST and analyze
        if ruchy ast "$file" > /tmp/ast_output.json 2>/dev/null; then
            # Count nodes, depth, etc.
            NODE_COUNT=$(grep -c '"node"' /tmp/ast_output.json 2>/dev/null || echo "0")
            
            printf "    Nodes: %s\n" "$NODE_COUNT"
            
            if [ "$NODE_COUNT" -gt 100 ]; then
                printf "    ⚠️  High complexity (>100 nodes)\n"
                COMPLEX=$((COMPLEX + 1))
            else
                printf "    ✅ Acceptable complexity\n"
            fi
        else
            printf "    ❌ AST generation failed\n"
        fi
    fi
done

# Analyze key demo files
echo ""
echo "Analyzing demo complexity..."
for category in 01-basics 02-functions 03-data-structures 04-algorithms; do
    demo=$(find "demos/repl/$category" -name "*.repl" | head -1)
    if [ -f "$demo" ]; then
        printf "  %s: " "$category"
        
        # Convert to .ruchy
        tmp_file="/tmp/$(basename "$demo" .repl).ruchy"
        cp "$demo" "$tmp_file"
        
        if ruchy ast "$tmp_file" > /tmp/ast_output.json 2>/dev/null; then
            NODE_COUNT=$(grep -c '"node"' /tmp/ast_output.json 2>/dev/null || echo "0")
            printf "%s nodes " "$NODE_COUNT"
            
            if [ "$NODE_COUNT" -gt 50 ]; then
                printf "⚠️\n"
            else
                printf "✅\n"
            fi
        else
            printf "❌\n"
        fi
        
        rm -f "$tmp_file"
    fi
done

echo ""
echo "===================================="
echo "AST Analysis Summary"
echo "  Files analyzed: $TOTAL"
echo "  Complex files: $COMPLEX"

if [ "$COMPLEX" -eq 0 ]; then
    echo "✅ All files within complexity limits!"
else
    echo "⚠️  Some files exceed complexity thresholds"
fi