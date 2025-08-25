#!/bin/sh
set -eu

# Monitor for new Ruchy releases and test automatically
# Can be run as a cron job: */30 * * * * /path/to/monitor-ruchy-releases.sh

LAST_VERSION_FILE=".last_ruchy_version"
REPORTS_DIR="compatibility-reports"

echo "========================================="
echo "Ruchy Release Monitor"
echo "========================================="
echo ""

# Create reports directory if it doesn't exist
mkdir -p "$REPORTS_DIR"

# Get current latest version
echo "Checking for new Ruchy releases..."
LATEST_VERSION=$(curl -s https://crates.io/api/v1/crates/ruchy | grep -o '"max_version":"[^"]*"' | cut -d'"' -f4)

if [ -z "$LATEST_VERSION" ]; then
    echo "Error: Could not fetch latest version"
    exit 1
fi

echo "Latest Ruchy version: $LATEST_VERSION"

# Check if we've seen this version before
if [ -f "$LAST_VERSION_FILE" ]; then
    LAST_VERSION=$(cat "$LAST_VERSION_FILE")
    echo "Last tested version: $LAST_VERSION"
    
    if [ "$LATEST_VERSION" = "$LAST_VERSION" ]; then
        echo "No new version detected"
        exit 0
    fi
else
    echo "First run - no previous version recorded"
    LAST_VERSION="unknown"
fi

echo ""
echo "NEW VERSION DETECTED: $LATEST_VERSION"
echo "========================================="
echo ""

# Test the new version
echo "Testing compatibility with new version..."
./scripts/test-ruchy-version.sh "$LATEST_VERSION"

# Move report to reports directory
if [ -f "compat-report-${LATEST_VERSION}.json" ]; then
    mv "compat-report-${LATEST_VERSION}.json" "$REPORTS_DIR/"
fi

# Update last version file
echo "$LATEST_VERSION" > "$LAST_VERSION_FILE"

# Check if there were compatibility issues
REPORT_FILE="$REPORTS_DIR/compat-report-${LATEST_VERSION}.json"
if [ -f "$REPORT_FILE" ]; then
    REPL_RATE=$(grep -o '"repl_demos".*"pass_rate": [0-9]*' "$REPORT_FILE" | grep -o '[0-9]*$')
    ONELINER_RATE=$(grep -o '"oneliner_demos".*"pass_rate": [0-9]*' "$REPORT_FILE" | grep -o '[0-9]*$')
    
    if [ "$REPL_RATE" -lt 90 ] || [ "$ONELINER_RATE" -lt 90 ]; then
        echo ""
        echo "⚠️  WARNING: Compatibility issues detected!"
        echo "REPL pass rate: ${REPL_RATE}%"
        echo "One-liner pass rate: ${ONELINER_RATE}%"
        echo ""
        echo "Creating compatibility issue report..."
        
        # Create an issue file that can be used by CI
        cat > "$REPORTS_DIR/compatibility-issue-${LATEST_VERSION}.txt" << EOF
Ruchy $LATEST_VERSION Compatibility Issue

A new version of Ruchy ($LATEST_VERSION) has been released with compatibility issues:
- REPL demos pass rate: ${REPL_RATE}%
- One-liner demos pass rate: ${ONELINER_RATE}%

Previous version: $LAST_VERSION

Please review the failing demos and update as needed.
EOF
        
        echo "Issue report created: $REPORTS_DIR/compatibility-issue-${LATEST_VERSION}.txt"
    else
        echo ""
        echo "✅ Version $LATEST_VERSION is fully compatible!"
    fi
fi

echo ""
echo "Monitoring complete"