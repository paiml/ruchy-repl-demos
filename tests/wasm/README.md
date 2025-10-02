# WASM Compatibility Testing

This directory contains the WASM compatibility testing framework for ruchy-repl-demos.

## Purpose

Test all 200 demos in WebAssembly mode to:
1. Validate WASM compatibility
2. Identify WASM-specific bugs
3. Report issues upstream to ../ruchy
4. Document WASM capabilities

## Quick Start

```bash
# Run WASM compatibility tests
make test-wasm

# Compare WASM vs Native
make compare-wasm-native

# View WASM report
make wasm-report

# Run full quality gates + WASM
make quality-gates-wasm
```

## Directory Structure

```
tests/wasm/
├── README.md                          # This file
├── wasm_compatibility_test.ruchy      # Main test suite
├── results/
│   ├── bug_reports/                   # Bugs found in WASM
│   │   ├── bug_report_template.md
│   │   └── issue_XXX.md
│   └── experiments/                   # Reproducible experiments
│       ├── experiment_template.md
│       └── experiment_XXX.md
└── scripts/
    ├── run_wasm_tests.sh             # Execute WASM tests
    └── compare_native_wasm.sh        # Compare outputs
```

## Documentation

See [WASM Mode Specification](../../docs/specifications/wasm-mode.md) for:
- Complete testing methodology
- Bug reporting protocol
- Experiment guidelines
- Reproducibility requirements

## Workflow

1. **Test in Native**: Verify demo works in native ruchy
2. **Test in WASM**: Execute in WASM notebook
3. **Compare**: Check for differences
4. **Document**: Record results
5. **Report**: File upstream bugs if needed

## Current Status

- [ ] WASM test suite created
- [ ] All 200 demos tested in WASM
- [ ] Compatibility matrix generated
- [ ] Bugs reported upstream
- [ ] Documentation complete

## Contributing

When adding WASM tests:
1. Use experiment template
2. Include reproducible example
3. Document Native vs WASM differences
4. Follow bug report template for issues
5. File upstream issues with links

---

*For detailed specifications, see: docs/specifications/wasm-mode.md*
