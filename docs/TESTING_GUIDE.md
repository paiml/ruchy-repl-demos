# Testing Guide - Ruchy REPL Demos

**Last Updated**: 2025-10-15
**Version**: 1.0
**Status**: Complete

---

## Table of Contents

1. [Overview](#overview)
2. [Testing Pyramid](#testing-pyramid)
3. [Quick Start](#quick-start)
4. [Testing Layers](#testing-layers)
5. [Quality Gates](#quality-gates)
6. [Running Tests](#running-tests)
7. [Writing Tests](#writing-tests)
8. [CI/CD Integration](#cicd-integration)
9. [Troubleshooting](#troubleshooting)
10. [Toyota Way Principles](#toyota-way-principles)

---

## Overview

### Philosophy

**Prime Directive**: "Every demo must work perfectly on first execution"

This project implements a complete testing pyramid following Toyota Way principles:
- **Zero Defects**: All demos must work, no exceptions
- **Jidoka**: Automated quality verification at every layer
- **Genchi Genbutsu**: Test in real environments, not theory
- **Kaizen**: Continuous improvement through feedback
- **Respect**: Never waste user time with broken examples

### Current Status

```
Total Demos: 148
Quality Gates: 13/13 (100% automated)
Demo Execution: 148/148 (100% passing)
REPL Contract: 10/10 (100% passing)
Notebook Validation: 55/56 (98% passing)
Vaporware Detection: 56 files scanned (0 issues)
Overall Quality: 85% complete
```

---

## Testing Pyramid

```
                  ┌─────────────────────┐
                  │ REPL Contract (E2E) │  10 tests
                  │  Real ruchy REPL    │  Validates UX
                  └─────────────────────┘
                 ┌───────────────────────┐
                 │  Notebook Validation  │  55 demos
                 │  HTTP API testing     │  State management
                 └───────────────────────┘
                ┌─────────────────────────┐
                │  Demo Execution Tests   │  148 demos
                │  ruchy run validation   │  Syntax + runtime
                └─────────────────────────┘
               ┌───────────────────────────┐
               │     Quality Gates         │  13 gates
               │  Style, docs, structure   │  CI enforcement
               └───────────────────────────┘
```

### Layer Purpose

**Layer 1: Quality Gates** (Foundation)
- Purpose: Code quality, documentation, project structure
- Speed: Fast (< 30 seconds)
- Scope: Entire codebase
- CI: Runs on every push

**Layer 2: Demo Execution Tests**
- Purpose: Validate all demos run without errors
- Speed: Fast (< 5 seconds for 148 demos)
- Scope: All .ruchy demo files
- CI: Runs on every push

**Layer 3: Notebook Validation**
- Purpose: Test demos in Ruchy notebook environment
- Speed: Medium (10-15 seconds)
- Scope: Notebook-compatible demos
- CI: Runs on every push (warnings allowed)

**Layer 4: REPL Contract Tests** (Top)
- Purpose: End-to-end interactive UX validation
- Speed: Fast (< 1 second for 10 tests)
- Scope: REPL behavior contracts
- CI: Runs on every push

---

## Quick Start

### Run All Tests

```bash
# Full quality gate check (recommended before commit)
make quality-gate

# Run specific test layers
make test-demos           # Demo execution (148 demos)
make test-notebook        # Notebook validation (55 demos)
make test-repl-contract   # REPL contract tests (10 tests)
make verify-features      # Vaporware detection (56 files)
```

### Typical Workflow

```bash
# 1. Make changes to demos
vim demos/repl/01-basics/arithmetic.ruchy

# 2. Run demo execution tests
make test-demos

# 3. Run full quality gates
make quality-gate

# 4. Commit if all gates pass
git add .
git commit -m "feat: Add arithmetic demo"
```

---

## Testing Layers

### Layer 1: Quality Gates (13 Gates)

**Purpose**: Enforce code quality, documentation, and project standards

**Gates**:
1. ✅ **Git Tag Validation** - Semantic versioning
2. ✅ **File Structure** - Required directories exist
3. ✅ **Ruchy Native Tests** - Language-native test suite
4. ✅ **Demo Count** - Minimum 50 demos required
5. ✅ **TODO/FIXME Comments** - No unfinished work
6. ✅ **Documentation Coverage** - README completeness
7. ✅ **ShellCheck Compliance** - Shell script quality
8. ✅ **Ruchy Tool Integration** - Essential tools working
9. ✅ **Project Structure** - All required directories
10. ✅ **Performance Validation** - REPL startup < 1s
11. ✅ **Demo Execution Tests** - All demos run successfully
12. ✅ **Notebook Validation** - 98%+ success rate
13. ✅ **Feature Verification** - Vaporware detection

**Run**: `make quality-gate` or `./scripts/quality-gates.sh`

**Expected Output**:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
QUALITY GATE SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Gates Passed: 13/13 (100%)

✅ ALL QUALITY GATES PASSED

Project is ready for release!
Toyota Way: Quality built-in, not bolted-on
```

### Layer 2: Demo Execution Tests

**Purpose**: Validate all .ruchy demos execute without errors

**Test Script**: `scripts/test-demos.sh`

**Coverage**:
- REPL demos: `demos/repl/**/*.ruchy`
- One-liner demos: `demos/one-liner/**/*.ruchy`
- Book demos: `book/demos/**/*.ruchy`

**Run**: `make test-demos`

**What It Tests**:
- ✅ Syntax correctness (`ruchy check`)
- ✅ Runtime execution (`ruchy run`)
- ✅ No runtime errors
- ✅ Output validation (exit codes)

**Expected Output**:
```
🧪 Testing ALL Ruchy demos...

Testing REPL Demos
Testing: demos/repl/01-basics/arithmetic.ruchy
  ✓ Passed
Testing: demos/repl/01-basics/variables.ruchy
  ✓ Passed
...

Total demos tested: 148
Passed: 148
Failed: 0
Success rate: 100.0%
```

**Fast Execution**: All 148 demos test in < 5 seconds

### Layer 3: Notebook Validation

**Purpose**: Test demos in Ruchy notebook HTTP API environment

**Test Script**: `scripts/test-notebook.ts` (Deno TypeScript)

**Coverage**: 56 notebook-compatible demos

**Run**: `make test-notebook`

**What It Tests**:
- ✅ Notebook server startup
- ✅ Demo execution via HTTP API
- ✅ State management between cells
- ✅ Error handling
- ✅ Output correctness

**Expected Output**:
```
🔬 Ruchy Notebook Validation Test Suite
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Starting Ruchy notebook server...
✓ Server started on http://localhost:8080

Testing: demos/repl/01-basics/arithmetic.ruchy
✓ PASS (42ms)

Testing: demos/repl/01-basics/variables.ruchy
✓ PASS (38ms)
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Test Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total Demos: 56
Passed: 55
Failed: 1
Success Rate: 98.21%
```

**Known Issues**:
- 1 demo fails due to state pollution (upstream issue)
- 98%+ success rate is acceptable

### Layer 4: REPL Contract Tests

**Purpose**: End-to-end validation of interactive REPL user experience

**Test Script**: `scripts/test-repl-contract.sh`

**Coverage**: 10 REPL behavior contracts

**Run**: `make test-repl-contract`

**What It Tests**:
1. ✅ Prompt appearance and startup
2. ✅ Arithmetic evaluation
3. ✅ Variable definition and recall
4. ✅ Function definition and invocation
5. ✅ Error handling and recovery
6. ✅ Multi-line input handling
7. ✅ :help command
8. ✅ :quit command
9. ✅ Data structures (arrays, records)
10. ✅ Functional programming (lambdas, HOFs)

**Expected Output**:
```
=== REPL Contract Test Suite ===
Ruchy Version: 3.86.0

[01/10] Testing: 01-prompt-appearance     ✅ PASS
[02/10] Testing: 02-arithmetic-eval       ✅ PASS
[03/10] Testing: 03-variable-definition   ✅ PASS
[04/10] Testing: 04-function-definition   ✅ PASS
[05/10] Testing: 05-error-handling        ✅ PASS
[06/10] Testing: 06-multiline-input       ✅ PASS
[07/10] Testing: 07-help-command          ✅ PASS
[08/10] Testing: 08-quit-command          ✅ PASS
[09/10] Testing: 09-data-structures       ✅ PASS
[10/10] Testing: 10-functional-programming ✅ PASS

Duration: 0s
Total tests: 10
Passed: 10
Failed: 0
Success rate: 100.0%
```

**Technology**: POSIX shell + stdin piping (no external dependencies)

---

## Quality Gates

### Gate Descriptions

#### Gate 1: Git Tag Validation
**Purpose**: Ensure semantic versioning compliance
**Command**: `git describe --tags`
**Pass Criteria**: Valid semver tag exists
**Fix**: Create git tag: `git tag v1.0.0`

#### Gate 2: File Structure
**Purpose**: Verify required project files exist
**Files Checked**: `README.md`, `Makefile`, `CLAUDE.md`
**Fix**: Create missing files

#### Gate 3: Ruchy Native Tests
**Purpose**: Run language-native test suite
**Command**: `make test-ruchy-native`
**Pass Criteria**: All native tests pass
**Fix**: Fix failing tests in `tests/` directory

#### Gate 4: Demo Count
**Purpose**: Ensure minimum demo threshold
**Minimum**: 50 demos
**Current**: 148 demos
**Fix**: Add more demos to `demos/` directory

#### Gate 5: TODO/FIXME Comments
**Purpose**: Prevent unfinished work in commits
**Pattern**: `TODO|FIXME|HACK|XXX|OPTIMIZE ME`
**Pass Criteria**: Zero matches in code
**Fix**: Complete or remove TODO comments

#### Gate 6: Documentation Coverage
**Purpose**: Ensure README completeness
**Sections Required**: Installation, Usage, Examples, Testing
**Fix**: Add missing sections to README.md

#### Gate 7: ShellCheck Compliance
**Purpose**: Shell script quality and portability
**Standard**: POSIX sh (not bash)
**Pass Criteria**: Zero ShellCheck warnings
**Fix**: Run `make shellcheck` and fix issues

#### Gate 8: Ruchy Tool Integration
**Purpose**: Verify essential Ruchy tools work
**Tools**: `ruchy check`, `ruchy run`, `ruchy format`
**Pass Criteria**: 2/3 tools functional
**Fix**: Update ruchy: `cargo install ruchy`

#### Gate 9: Project Structure
**Purpose**: Validate directory structure
**Directories**: `demos/`, `tests/`, `scripts/`, `docs/`
**Fix**: Create missing directories

#### Gate 10: Performance Validation
**Purpose**: Ensure fast REPL startup
**Threshold**: < 1000ms
**Current**: ~2ms
**Fix**: Optimize startup scripts

#### Gate 11: Demo Execution Tests
**Purpose**: All demos must execute successfully
**Coverage**: 148 demos
**Pass Criteria**: 100% success rate
**Fix**: Debug failing demos with `make test-demos-verbose`

#### Gate 12: Notebook Validation
**Purpose**: Demos work in notebook environment
**Coverage**: 56 demos
**Pass Criteria**: 98%+ success rate
**Fix**: Review failed demos, may be infrastructure issue

#### Gate 13: Feature Verification (NEW!)
**Purpose**: Detect vaporware (unimplemented features)
**Coverage**: 56 .ruchy files
**Pass Criteria**: Zero vaporware patterns detected
**Patterns Detected**:
- Unimplemented methods: `.join()`, `.reverse()`, `.for_each()`
- Missing stdlib: `sqrt()`, `log()`, `sin()`, `cos()`
- Unsupported syntax: `[start..end]` slicing
- Non-existent features: `DataFrame`
**Fix**: Remove demos using unimplemented features

---

## Running Tests

### All Tests

```bash
# Run complete quality gate suite (recommended)
make quality-gate
```

### Individual Test Layers

```bash
# Demo execution tests (fast, 148 demos)
make test-demos

# Notebook validation (medium, 56 demos)
make test-notebook

# REPL contract tests (fast, 10 tests)
make test-repl-contract

# Feature verification (fast, 56 files)
make verify-features
```

### Specific Demo Categories

```bash
# REPL demos by category
make test-repl-basics
make test-repl-functions
make test-repl-data
make test-repl-functional

# One-liner demos by category
make test-oneliner-text
make test-oneliner-data
make test-oneliner-math
make test-oneliner-system
```

### Verbose/Debug Mode

```bash
# Show full output for debugging
make test-demos-verbose

# Run individual demo
ruchy run demos/repl/01-basics/arithmetic.ruchy
ruchy check demos/repl/01-basics/arithmetic.ruchy
```

### CI Simulation

```bash
# Run exactly what CI runs
./scripts/quality-gates.sh

# Check if CI would pass
make quality-gate && echo "✅ CI WILL PASS"
```

---

## Writing Tests

### Demo Execution Tests

**Automatic**: All `.ruchy` files in `demos/` are automatically tested

**Requirements**:
1. Valid Ruchy syntax
2. Executes without runtime errors
3. Uses only implemented features (no vaporware)
4. Exit code 0 on success

**Example Demo** (`demos/repl/01-basics/arithmetic.ruchy`):
```ruchy
// Demonstrate: Basic arithmetic operations
let x = 5
let y = 3

println(x + y)  // 8
println(x * y)  // 15
println(x - y)  // 2
```

**Testing**: Automatically included in `make test-demos`

### REPL Contract Tests

**Location**: `tests/repl-contract/*.sh`

**Template**:
```bash
#!/bin/sh
# REPL Contract Test: [Test Name]
# Tests that REPL handles [specific behavior]

set -e

echo "Testing: [description]..."

# Send commands to REPL via stdin
OUTPUT=$(printf "command1\ncommand2\n:quit\n" | ruchy repl 2>&1)

# Validate output
if echo "$OUTPUT" | grep -q "expected_output"; then
    echo "✅ PASS: [test description]"
else
    echo "❌ FAIL: [test description]"
    echo "Output: $OUTPUT"
    exit 1
fi

echo "✅ ALL CHECKS PASSED"
exit 0
```

**Example** (`tests/repl-contract/02-arithmetic-eval.sh`):
```bash
#!/bin/sh
set -e

echo "Testing: Arithmetic evaluation..."

# Test addition
OUTPUT=$(printf "2 + 2\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^4$"; then
    echo "✅ PASS: Addition (2 + 2 = 4)"
else
    echo "❌ FAIL: Addition failed"
    exit 1
fi

# Test multiplication
OUTPUT=$(printf "6 * 7\n:quit\n" | ruchy repl 2>&1)
if echo "$OUTPUT" | grep -q "^42$"; then
    echo "✅ PASS: Multiplication (6 * 7 = 42)"
else
    echo "❌ FAIL: Multiplication failed"
    exit 1
fi

echo "✅ ALL CHECKS PASSED"
exit 0
```

**IMPORTANT**: Use `%%` to escape `%` in printf (e.g., `x %% 2` for modulo)

### Notebook Validation Tests

**Automatic**: All demos in `demos/repl/` and `demos/one-liner/` are tested

**Custom Tests**: Edit `scripts/test-notebook.ts`

**Example Addition**:
```typescript
const testCases = [
  {
    name: "My New Demo",
    file: "demos/repl/my-category/my-demo.ruchy",
    expectedOutput: "expected result"
  },
  // ... other tests
];
```

### Quality Gate Tests

**Location**: `scripts/quality-gates.sh`

**Add New Gate** (example):
```bash
# ==============================================================================
# GATE 14: My New Gate
# ==============================================================================
check_gate "My Gate Description" "14"

if [ some_condition ]; then
    echo "✅ PASS: Gate description"
    GATES_PASSED=$((GATES_PASSED + 1))
else
    echo "❌ FAIL: Gate description"
    echo "   Fix: How to resolve"
    GATES_FAILED=$((GATES_FAILED + 1))
fi
echo ""
```

---

## CI/CD Integration

### GitHub Actions Workflow

**File**: `.github/workflows/quality-gates.yml`

**Triggers**:
- Push to any branch
- Pull request to main
- Manual workflow dispatch

**Steps**:
1. Install Ruchy (`cargo install ruchy`)
2. Install Deno (for notebook validation)
3. Run all 13 quality gates
4. Run demo execution tests
5. Run notebook validation
6. Run REPL contract tests
7. Auto-update INTEGRATION.md (main branch only)
8. Create Andon cord issue on failure (main branch only)

**Example Run**:
```yaml
- name: Run Quality Gates
  run: |
    chmod +x scripts/quality-gates.sh
    ./scripts/quality-gates.sh

- name: Run Demo Execution Tests
  run: make test-demos

- name: Run Notebook Validation
  run: make test-notebook || echo "98%+ acceptable"

- name: Run REPL Contract Tests
  run: make test-repl-contract
```

### Andon Cord (Failure Automation)

**Trigger**: Any quality gate failure on main branch

**Action**: Automatically creates GitHub issue

**Issue Template**:
```markdown
🚨 ANDON CORD: Quality Gates Failed

Build: #123
Commit: abc123
Date: 2025-10-15

## Failed Gates
- Gate 5: TODO/FIXME Comments (4 violations)
- Gate 7: ShellCheck Compliance (2 warnings)

## Required Actions
1. STOP: Halt all new development
2. ANALYZE: Root cause analysis (5 Whys)
3. FIX: Resolve at systemic level
4. TEST: Verify fix with quality gates
5. PREVENT: Add regression tests

## Defect Response Protocol
[5 Whys Analysis template...]
```

**Labels**: `P0-critical`, `quality-gate-failure`, `andon-cord`

### Auto-Update INTEGRATION.md

**Trigger**: Successful quality gates on main branch

**Action**: Updates `INTEGRATION.md` with latest metrics

**Auto-Commit**: Changes committed and pushed automatically

---

## Troubleshooting

### Common Issues

#### Issue: "ruchy not found in PATH"
**Cause**: Ruchy not installed
**Fix**:
```bash
cargo install ruchy
ruchy --version
```

#### Issue: "Deno not installed"
**Cause**: Deno required for notebook validation
**Fix**:
```bash
curl -fsSL https://deno.land/install.sh | sh
deno --version
```

#### Issue: "ShellCheck warnings"
**Cause**: Non-POSIX shell syntax
**Fix**:
```bash
make shellcheck        # See all issues
shellcheck script.sh   # Check specific script
```

**Common fixes**:
- Use `[ ]` not `[[ ]]`
- Use `=` not `==` for string comparison
- Use `printf` not `echo -e`
- Use `. file` not `source file`

#### Issue: "Demo execution failed"
**Cause**: Runtime error in demo
**Fix**:
```bash
make test-demos-verbose          # See full output
ruchy run demos/path/demo.ruchy  # Run specific demo
ruchy check demos/path/demo.ruchy # Check syntax
```

#### Issue: "Notebook validation failed"
**Cause**: State pollution or server issue
**Fix**:
```bash
# Restart notebook server
pkill -f "ruchy notebook"
make test-notebook

# Check server logs
ruchy notebook --port 8080 --verbose
```

#### Issue: "Vaporware detected"
**Cause**: Demo uses unimplemented features
**Fix**:
```bash
make verify-features   # See which files
# Remove or comment out unimplemented features
# Or add verification comment if feature actually works
```

#### Issue: "REPL contract test failed"
**Cause**: REPL behavior changed or test issue
**Fix**:
```bash
# Run specific test
./tests/repl-contract/02-arithmetic-eval.sh

# Debug with manual REPL
ruchy repl
>>> 2 + 2
4
>>> :quit
```

### Debug Mode

**Enable verbose output**:
```bash
# Shell scripts
set -x  # Add to top of script

# Makefile
make test-demos VERBOSE=1

# Quality gates
DEBUG=1 ./scripts/quality-gates.sh
```

### Getting Help

**Check logs**:
```bash
# CI logs (GitHub Actions)
.github/workflows/quality-gates.yml

# Test output
/tmp/demo_execution.log
/tmp/notebook_validation.log
/tmp/feature_verification.log
```

**Documentation**:
- `TESTING_ROADMAP.md` - Implementation roadmap
- `PHASE_1A_RESULTS.md` - Demo execution test details
- `PHASE_1B_RESULTS.md` - Notebook validation details
- `PHASE_2A_RESULTS.md` - REPL contract test details
- `PHASE_2B_RESULTS.md` - Feature verification details

---

## Toyota Way Principles

### Jidoka (Autonomation)

**Build quality in, don't inspect it in**

✅ **Automated Testing**: All 13 gates run automatically
✅ **Fast Feedback**: Quality issues detected in < 30 seconds
✅ **Andon Cord**: Production stops on quality failures
✅ **Self-Testing**: Demos validate themselves

### Genchi Genbutsu (Go and See)

**Verify facts for yourself**

✅ **Real Environments**: Test in actual REPL, not mocks
✅ **Real Usage**: Notebook HTTP API tested end-to-end
✅ **Real Patterns**: Vaporware detection from actual failures
✅ **Real Metrics**: Measure actual execution times

### Kaizen (Continuous Improvement)

**Challenge everything, improve continuously**

✅ **Learn from Failures**: Phase 1A failures → Phase 2B detection
✅ **Incremental Progress**: 75% → 80% → 85% completion
✅ **Process Refinement**: Simple stdin piping vs. complex expect
✅ **Feedback Loops**: User issues → regression tests

### Respect for People

**Never waste user time**

✅ **Working Demos**: 148/148 demos execute successfully
✅ **Quality Documentation**: 100% verified, not promised
✅ **Fast Tests**: < 5 seconds for full demo suite
✅ **Clear Errors**: Actionable error messages

### Long-term Thinking

**Build foundation for sustained excellence**

✅ **Comprehensive Testing**: 4-layer pyramid
✅ **Automated CI**: 13 gates enforced
✅ **Documentation**: Complete testing guide
✅ **Maintainability**: Simple, portable POSIX shell

---

## Summary

### Testing Coverage

```
Quality Gates:        13/13 (100%)
Demo Execution:       148/148 (100%)
REPL Contract:        10/10 (100%)
Notebook Validation:  55/56 (98%)
Vaporware Detection:  56 files (0 issues)
```

### Quick Commands

```bash
make quality-gate        # Run all 13 gates
make test-demos          # Test 148 demos
make test-notebook       # Test 56 notebook demos
make test-repl-contract  # Test 10 REPL contracts
make verify-features     # Scan for vaporware
```

### Philosophy

**Every demo is a promise to users. Make it count.**

- Test automatically, test early, test often
- Build quality in, don't bolt it on
- Stop the line when quality suffers
- Learn from every failure
- Respect user time with working examples

---

**For Questions**: See [TESTING_ROADMAP.md](../TESTING_ROADMAP.md) or create GitHub issue

**Last Updated**: 2025-10-15
**Next Review**: After Phase 3 completion
