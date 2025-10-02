# WASM Mode Specification

**Version**: 1.0.0
**Status**: Draft
**Created**: October 2, 2025
**Ruchy Version**: v3.63.0

---

## 📋 Table of Contents

1. [Purpose](#purpose)
2. [Goals](#goals)
3. [WASM vs Native Comparison](#wasm-vs-native-comparison)
4. [Testing Framework](#testing-framework)
5. [Experiment Methodology](#experiment-methodology)
6. [Bug Reporting Protocol](#bug-reporting-protocol)
7. [Reproducibility Requirements](#reproducibility-requirements)
8. [Integration with Quality Gates](#integration-with-quality-gates)

---

## Purpose

This specification defines how to test all ruchy-repl-demos in **WebAssembly (WASM) mode** using the native ruchy notebook environment. The goal is to:

1. **Validate WASM compatibility** of all 200 demos
2. **Identify WASM-specific bugs** for upstream reporting
3. **Document WASM capabilities** and limitations
4. **Create reproducible experiments** for the ruchy project

---

## Goals

### Primary Objectives

1. ✅ **100% WASM Coverage** - Test all 200 demos in WASM mode
2. ✅ **Bug Discovery** - Find and document WASM-specific issues
3. ✅ **Upstream Reporting** - Create reproducible bug reports for ../ruchy
4. ✅ **Capability Documentation** - Document what works/doesn't work in WASM

### Success Criteria

- [ ] All 200 demos tested in WASM mode
- [ ] WASM compatibility matrix created
- [ ] All bugs reported upstream with reproducible examples
- [ ] WASM-specific documentation completed
- [ ] Integration with existing quality gates

---

## WASM vs Native Comparison

### Architecture Differences

| Feature | Native (Rust) | WASM (Browser) | Notes |
|---------|---------------|----------------|-------|
| **Runtime** | Native binary | WebAssembly | Different execution environment |
| **File I/O** | Full filesystem | Virtual FS / API | Limited in browser |
| **Performance** | Direct hardware | Sandboxed | Typically slower |
| **Memory** | OS-managed | Linear memory | WASM-specific limits |
| **Threading** | OS threads | Web Workers | Limited concurrency |
| **FFI** | Full C interop | JavaScript only | Different boundaries |

### Expected Compatibility

**Should Work (100%)**:
- ✅ Basic arithmetic
- ✅ Functions and closures
- ✅ Data structures (arrays, objects)
- ✅ Functional operations (map, filter, reduce)
- ✅ String processing
- ✅ Math calculations
- ✅ Algorithm demonstrations

**May Have Issues**:
- ⚠️ File operations (if WASM lacks virtual FS)
- ⚠️ System calls
- ⚠️ Performance-sensitive code
- ⚠️ Large memory allocations

**Definitely Won't Work**:
- ❌ Native file system access
- ❌ OS-specific operations
- ❌ Direct hardware access

---

## Testing Framework

### Test Structure

```
tests/wasm/
├── wasm_compatibility_test.ruchy     # Main test suite
├── results/
│   ├── compatibility_matrix.md       # WASM vs Native comparison
│   ├── bug_reports/                  # Bugs found in WASM
│   │   ├── issue_001.md
│   │   ├── issue_002.md
│   │   └── ...
│   └── experiments/                  # Reproducible experiments
│       ├── experiment_001.md
│       ├── experiment_002.md
│       └── ...
└── scripts/
    ├── run_wasm_tests.sh            # Execute all WASM tests
    └── compare_native_wasm.sh       # Compare outputs
```

### Test Execution

```bash
# Run all demos in WASM mode
make test-wasm

# Compare WASM vs Native
make compare-wasm-native

# Generate compatibility report
make wasm-report
```

### Test Categories

1. **REPL Demos (85 total)**
   - Test each demo in WASM notebook
   - Compare output with native
   - Record any differences

2. **One-liner Demos (115 total)**
   - Execute in WASM environment
   - Validate results match native
   - Document performance differences

---

## Experiment Methodology

### Experiment Template

Each experiment should follow this structure:

```markdown
# Experiment XXX: [Title]

**Date**: YYYY-MM-DD
**Ruchy Version**: vX.Y.Z
**Environment**: WASM / Native

## Hypothesis
What we expect to happen.

## Setup
```ruchy
// Setup code
```

## Execution
```ruchy
// Test code
```

## Expected Result (Native)
```
Expected output from native ruchy
```

## Actual Result (WASM)
```
Actual output from WASM ruchy
```

## Observations
- What worked
- What didn't work
- Performance differences
- Memory usage

## Conclusion
- ✅ PASS: Works as expected
- ❌ FAIL: Bug found
- ⚠️ PARTIAL: Works with limitations

## Reproducibility
Steps to reproduce:
1. ...
2. ...

## Upstream Report
- [ ] Bug report created: #XXX
- [ ] Discussed with maintainers
- [ ] Fix proposed
- [ ] Fix merged
```

### Example Experiment

```markdown
# Experiment 001: Array Map Performance

**Date**: 2025-10-02
**Ruchy Version**: v3.63.0
**Environment**: WASM vs Native

## Hypothesis
Array map operations should work identically in WASM and Native.

## Setup
```ruchy
let nums = [1, 2, 3, 4, 5];
```

## Execution
```ruchy
let doubled = nums.map(|x| x * 2);
println(doubled);
```

## Expected Result (Native)
```
[2, 4, 6, 8, 10]
```

## Actual Result (WASM)
```
[2, 4, 6, 8, 10]
```

## Observations
- ✅ Functionally identical
- ⚠️ WASM ~20% slower (acceptable)
- ✅ Memory usage similar

## Conclusion
✅ PASS: Full compatibility confirmed

## Reproducibility
1. Open ruchy WASM notebook
2. Execute setup code
3. Run execution code
4. Compare output

## Upstream Report
N/A - No issues found
```

---

## Bug Reporting Protocol

### Bug Report Template

When a bug is found in WASM mode:

```markdown
# Bug Report: [Title]

**Environment**: WASM
**Ruchy Version**: vX.Y.Z
**Severity**: Critical / High / Medium / Low
**Status**: New / Reported / Fixed

## Summary
One-sentence description of the bug.

## Reproducible Example
```ruchy
// Minimal code that reproduces the bug
```

## Expected Behavior
What should happen (from Native).

## Actual Behavior
What actually happens (in WASM).

## Environment Details
- Browser: Chrome / Firefox / Safari
- OS: Linux / macOS / Windows
- Ruchy WASM version: vX.Y.Z

## Steps to Reproduce
1. ...
2. ...
3. ...

## Impact
How this affects demos:
- X demos broken
- Y demos partially working
- Z demos unaffected

## Workaround
Temporary solution (if any).

## Upstream Issue
- Link to ../ruchy issue: https://github.com/paiml/ruchy/issues/XXX

## Additional Context
Any other relevant information.
```

### Reporting Workflow

1. **Discover Bug** - Find issue during WASM testing
2. **Verify** - Confirm it works in Native
3. **Document** - Create bug report with template
4. **Reproduce** - Create minimal reproducible example
5. **Report Upstream** - File issue in ../ruchy repository
6. **Track** - Monitor issue status
7. **Update** - Document resolution

---

## Reproducibility Requirements

### Mandatory Elements

Every experiment and bug report MUST include:

1. **Exact Ruchy Version**
   ```bash
   ruchy --version
   ```

2. **Complete Code**
   - No omitted imports
   - No assumed context
   - Self-contained examples

3. **Expected Output**
   - From Native ruchy
   - With exact formatting

4. **Actual Output**
   - From WASM ruchy
   - With exact error messages

5. **Environment Details**
   - Browser and version
   - OS and version
   - WASM runtime version

### Verification Steps

Before reporting upstream:

```bash
# 1. Test in Native
ruchy test_case.ruchy

# 2. Test in WASM
# (Open WASM notebook and execute)

# 3. Compare outputs
diff native_output.txt wasm_output.txt

# 4. Document differences
cat > bug_report.md << EOF
...
EOF
```

---

## Integration with Quality Gates

### New Quality Gate: WASM Compatibility

Add GATE 11 to quality-gates.sh:

```bash
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "GATE 11: WASM Compatibility"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

WASM_TESTS=$(find tests/wasm -name "*.ruchy" 2>/dev/null | wc -l)
if [ "$WASM_TESTS" -gt 0 ]; then
    echo "✅ PASS: WASM tests present ($WASM_TESTS tests)"
else
    echo "⚠️  WARNING: No WASM tests found"
fi
```

### Makefile Integration

```makefile
# WASM Testing
test-wasm:
	@echo "🌐 Testing WASM Compatibility"
	@./scripts/run_wasm_tests.sh

compare-wasm-native:
	@echo "⚖️  Comparing WASM vs Native"
	@./scripts/compare_native_wasm.sh

wasm-report:
	@echo "📊 Generating WASM Compatibility Report"
	@./scripts/generate_wasm_report.sh
	@cat tests/wasm/results/compatibility_matrix.md

# Integration
quality-gates-wasm: quality-gates test-wasm
	@echo "✅ Quality gates + WASM validation complete"
```

---

## Compatibility Matrix Template

```markdown
# WASM Compatibility Matrix

**Generated**: YYYY-MM-DD
**Ruchy Version**: vX.Y.Z
**Total Demos**: 200

## Summary

| Category | Total | Native Pass | WASM Pass | Compatibility |
|----------|-------|-------------|-----------|---------------|
| REPL: Basics | 10 | 10 | 10 | 100% |
| REPL: Functions | 10 | 10 | 9 | 90% |
| REPL: Data Structures | 15 | 15 | 15 | 100% |
| REPL: Algorithms | 10 | 10 | 10 | 100% |
| REPL: Functional | 20 | 20 | 20 | 100% |
| REPL: Advanced | 20 | 20 | 18 | 90% |
| One-liner: Text | 20 | 20 | 20 | 100% |
| One-liner: Math | 20 | 20 | 20 | 100% |
| One-liner: Data | 15 | 15 | 15 | 100% |
| One-liner: Files | 10 | 10 | 5 | 50% |
| One-liner: System | 20 | 20 | 10 | 50% |
| One-liner: Functional | 25 | 25 | 25 | 100% |
| **TOTAL** | **200** | **200** | **187** | **93.5%** |

## Detailed Results

### Fully Compatible (187 demos)
✅ Works identically in WASM and Native

### Partially Compatible (8 demos)
⚠️ Works with limitations:
- `advanced/file_handling.repl` - Virtual FS only
- `system/directory_ops.sh` - Limited in browser
...

### Not Compatible (5 demos)
❌ Cannot work in WASM:
- `system/native_calls.sh` - OS-specific
- `files/filesystem_write.sh` - No real FS
...

## Bug Reports Filed

1. [Issue #001](bug_reports/issue_001.md) - Array performance degradation
2. [Issue #002](bug_reports/issue_002.md) - String allocation bug
...
```

---

## Implementation Plan

### Phase 1: Setup (Week 1)
- [ ] Create `tests/wasm/` directory structure
- [ ] Write initial test harness
- [ ] Create experiment template
- [ ] Set up bug tracking

### Phase 2: Testing (Week 2-3)
- [ ] Test all 200 demos in WASM
- [ ] Document each result
- [ ] Create compatibility matrix
- [ ] Identify all bugs

### Phase 3: Reporting (Week 4)
- [ ] Create reproducible examples for all bugs
- [ ] File upstream issues in ../ruchy
- [ ] Document workarounds
- [ ] Update quality gates

### Phase 4: Integration (Week 5)
- [ ] Add WASM gate to quality-gates.sh
- [ ] Create Makefile targets
- [ ] Update documentation
- [ ] Sprint retrospective

---

## References

### External Resources
- [Ruchy Repository](https://github.com/paiml/ruchy)
- [WebAssembly Specification](https://webassembly.org/)
- [WASM Performance Best Practices](https://webassembly.org/docs/best-practices/)

### Internal Documentation
- [VALIDATION_FRAMEWORK.md](../../VALIDATION_FRAMEWORK.md)
- [QUICK_REFERENCE.md](../../QUICK_REFERENCE.md)
- [ROADMAP.md](../../ROADMAP.md)

---

## Appendix

### Glossary

- **WASM**: WebAssembly - Binary instruction format for browser execution
- **Native**: Standard ruchy binary running on OS
- **Reproducibility**: Ability to recreate exact same results
- **Upstream**: The main ruchy project repository

### Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2025-10-02 | Initial specification |

---

*This specification ensures systematic WASM compatibility testing with reproducible results for upstream bug reporting.*
