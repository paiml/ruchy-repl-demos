#!/bin/sh
# Install Git Hooks for Ruchy REPL Demos
# Toyota Way: Automate quality gates to prevent defects

set -eu

echo "🪝 Installing Git Hooks"
echo "======================="
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a git repository"
    echo "   Run this script from the project root"
    exit 1
fi

# Create hooks directory if it doesn't exist
mkdir -p .git/hooks

# Install pre-commit hook
echo "Installing pre-commit hook..."
if [ -f "scripts/pre-commit-hook.sh" ]; then
    cp scripts/pre-commit-hook.sh .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
    echo "✅ Pre-commit hook installed"
else
    echo "❌ Error: scripts/pre-commit-hook.sh not found"
    exit 1
fi

# Test the hook
echo ""
echo "Testing pre-commit hook..."
if .git/hooks/pre-commit >/dev/null 2>&1; then
    echo "✅ Pre-commit hook works correctly"
else
    echo "⚠️  Warning: Pre-commit hook test failed"
    echo "   Hook is installed but may fail on commit"
    echo "   Run: .git/hooks/pre-commit"
    echo "   To see detailed error messages"
fi

echo ""
echo "Git hooks installed successfully!"
echo ""
echo "The following quality gates will run on every commit:"
echo "  ✓ Ruchy version check"
echo "  ✓ SATD check (ZERO tolerance)"
echo "  ✓ Ruchy test file validation"
echo "  ✓ Syntax validation"
echo "  ✓ ShellCheck validation"
echo "  ✓ Comment syntax validation"
echo "  ✓ Documentation completeness"
echo "  ✓ Script permissions"
echo "  ✓ Empty file detection"
echo "  ✓ Project structure validation"
echo ""
echo "Toyota Way: Quality built-in, not bolted-on"
echo ""

exit 0
