# CLAUDE.md - Ruchy REPL & One-Liner Demos Development Protocol

## Prime Directive

**Every demo must work perfectly on first execution. Quality is demonstrated, not promised.**

## Toyota Way Implementation

**ZERO DEFECTS. EVERY EXAMPLE IS A PROMISE TO USERS.**

### Core Principles
1. **Jidoka**: Automated quality verification for every demo
2. **Genchi Genbutsu**: Test in real REPL, not theory
3. **Kaizen**: Continuous improvement through user feedback
4. **Respect**: Never ship broken examples that waste user time
5. **Long-term**: Build trust through consistent quality

### Defect Response Protocol
```
1. STOP: Halt all new demo development
2. ANALYZE: Root cause with 5 whys
3. FIX: Resolve at systemic level
4. TEST: Comprehensive verification
5. PREVENT: Add regression tests
6. DOCUMENT: Update lessons learned
```

## Development Workflow

### Demo Creation Process
1. **DESIGN**: Define learning objective
2. **TEST FIRST**: Write test before demo
3. **IMPLEMENT**: Create minimal working example
4. **VERIFY**: Run all quality checks
5. **DOCUMENT**: Explain what it demonstrates
6. **INTEGRATE**: Add to test suite

### Quality Gates (MANDATORY)
Every demo MUST pass:
- [ ] Syntax validation: `ruchy check demo.ruchy`
- [ ] Execution test: Demo runs without errors
- [ ] Output verification: Expected output matches
- [ ] Performance check: Executes in < 100ms
- [ ] Complexity analysis: `ruchy runtime demo.ruchy`
- [ ] Quality score: `ruchy score demo.ruchy` ≥ 0.8

## Demo Standards

### REPL Demonstrations
```ruchy
# STRUCTURE:
# 1. Clear objective comment
# 2. Setup code (if needed)
# 3. Main demonstration
# 4. Expected output comment

# Demonstrate: Function composition
>>> let add_one = |x| x + 1
>>> let double = |x| x * 2
>>> let transform = add_one >> double
>>> transform(5)
12  # (5 + 1) * 2 = 12
```

### One-Liner Standards
```bash
# TEMPLATE:
# ruchy -e '<code>' # Description: what it does

# Calculate factorial of 5
ruchy -e 'fn fact(n) { (1..=n).product() }; println(fact(5))' # Output: 120
```

## Testing Requirements

### Test File Structure
```
tests/
├── repl/
│   └── category/
│       └── test_demo_name.yaml
└── one-liner/
    └── category/
        └── test_demo_name.sh
```

### REPL Test Format (YAML)
```yaml
name: "Demo Name"
description: "What this demonstrates"
session:
  - input: "let x = 5"
    output: ""
  - input: "x * 2"
    output: "10"
requirements:
  - ruchy_version: ">=1.9.1"
  - features: ["closures", "inference"]
```

### One-Liner Test Format (Shell)
```bash
#!/bin/bash
# Test: Demo name
# Expected: Specific output

OUTPUT=$(ruchy -e 'code here')
EXPECTED="expected output"

if [ "$OUTPUT" != "$EXPECTED" ]; then
    echo "FAIL: Output mismatch"
    exit 1
fi
echo "PASS"
```

## Categories and Coverage

### REPL Categories (Minimum Demos)
1. **basics** (10 demos): Arithmetic, variables, types
2. **functions** (10 demos): Definition, closures, recursion
3. **data-structures** (10 demos): Arrays, maps, structs
4. **algorithms** (5 demos): Sorting, searching, classic CS
5. **functional** (10 demos): Map, filter, compose, pipeline
6. **advanced** (5 demos): Pattern matching, generics, traits

### One-Liner Categories (Minimum Demos)
1. **text-processing** (20 demos): String manipulation
2. **data-analysis** (15 demos): Statistics, aggregation
3. **file-operations** (10 demos): Read, write, process
4. **math-calculations** (20 demos): Formulas, sequences
5. **system-scripting** (15 demos): Automation tasks
6. **functional-chains** (20 demos): Pipeline operations

## Performance Standards

### Execution Limits
- REPL startup: ≤ 50ms
- Demo execution: ≤ 100ms
- Memory usage: ≤ 50MB
- Output size: ≤ 10KB

### Complexity Limits
- Cognitive complexity: ≤ 10
- Line count: ≤ 20 (REPL), ≤ 1 (one-liner)
- Nesting depth: ≤ 3
- Function parameters: ≤ 3

## Continuous Improvement

### Sprint Cadence
- **Duration**: 2 days
- **Delivery**: 10+ new demos per sprint
- **Testing**: 100% coverage before merge
- **Review**: User feedback integration

### Version Management
```
v1.0.0 - Foundation (50 demos)
v1.1.0 - Core features (100 demos)
v1.2.0 - Advanced patterns (150 demos)
v2.0.0 - Interactive tutorials
```

## Common Patterns

### DO
- Keep examples focused on one concept
- Use meaningful variable names
- Include expected output
- Progress from simple to complex
- Test edge cases

### DON'T
- Create overly complex examples
- Mix multiple concepts
- Use undefined functions
- Assume prior knowledge
- Skip error handling

## Release Checklist

Before ANY release:
- [ ] All tests passing
- [ ] Documentation complete
- [ ] Examples manually verified
- [ ] Performance benchmarks met
- [ ] No TODO/FIXME comments
- [ ] Version bumped
- [ ] CHANGELOG updated
- [ ] README examples working

## Error Prevention

### Common Pitfalls
1. **Format strings**: Always test with actual values
2. **Type inference**: Explicitly type when unclear
3. **Closures**: Verify capture behavior
4. **Recursion**: Include base cases
5. **Edge cases**: Test with 0, 1, empty, null

### Regression Tests
Every bug becomes a test:
```bash
# Bug: Pipeline operator precedence
# Fixed: v1.0.1
test_pipeline_precedence() {
    OUTPUT=$(ruchy -e '2 + 3 |> double')
    assert_equals "$OUTPUT" "10"  # Not 7
}
```

## User Focus

### Learning Objectives
Each demo must:
1. Teach exactly one concept
2. Be immediately useful
3. Work without context
4. Inspire exploration
5. Build confidence

### Documentation Template
```markdown
## Demo: [Name]

**Objective**: What this teaches
**Concept**: Core idea demonstrated
**Usage**: When to use this pattern

### Code
```ruchy
[demo code]
```

### Explanation
[Why this works, key insights]

### Variations
[Other ways to achieve same result]
```

## Sprint & Ticket Management

### Sprint Structure
**All work MUST be tracked through tickets and organized in 2-day sprints.**

```yaml
sprint:
  duration: 2 days
  planning: Day 1 morning
  review: Day 2 evening
  tickets_per_sprint: 10-15
  velocity: 10 story points
```

### Ticket Format
```
TICKET-001: [Category] Brief description
Status: TODO | IN_PROGRESS | BLOCKED | DONE
Priority: P0 (Critical) | P1 (High) | P2 (Medium) | P3 (Low)
Story Points: 1 | 2 | 3 | 5 | 8
Sprint: S01 | S02 | ...
Assignee: Claude
```

### Workflow Rules
1. **NO WORK WITHOUT A TICKET** - Every task must have a ticket number
2. **ONE TICKET AT A TIME** - Complete current ticket before starting next
3. **ROADMAP ONLY** - All tickets are planned, not executed until sprint starts
4. **SPRINT COMMITMENT** - Once sprint starts, complete all committed tickets

### Current Sprint Board
```markdown
## Sprint S01 (Days 1-2)
### TODO
- [ ] TICKET-001: [SETUP] Create integration report
- [ ] TICKET-002: [QUALITY] Fix all shell linting issues
- [ ] TICKET-003: [DEMOS] Add 15 missing REPL demos
- [ ] TICKET-004: [DEMOS] Add 20 missing one-liner demos
- [ ] TICKET-005: [TESTS] Create YAML test suite

### IN_PROGRESS
- [ ] (Current ticket here)

### DONE
- [ ] (Completed tickets here)
```

## Integration & Version Compatibility

### Compatibility Matrix
```yaml
ruchy_versions:
  minimum: "1.18.0"
  recommended: "1.18.0"
  tested: ["1.17.0", "1.18.0"]
  current: "1.18.0"
  
rust_versions:
  minimum: "1.70.0"
  recommended: "1.75.0"
  
platforms:
  linux: 
    tested: ["Ubuntu 22.04", "Debian 12", "Fedora 38"]
    shell: "/bin/sh"
  macos:
    tested: ["13.0 Ventura", "14.0 Sonoma"]
    shell: "/bin/sh"
  windows:
    tested: ["Windows 11 WSL2"]
    shell: "/bin/sh"
```

### Integration Report Requirements
Every release MUST include:

```markdown
# Integration Report

## Version Compatibility
- Ruchy Version: X.Y.Z
- Rust Version: X.Y.Z
- Platform: OS/Architecture

## Feature Support Matrix
| Feature | v1.9.1 | v1.10.0 | v1.11.0 | Status |
|---------|--------|---------|---------|--------|
| REPL    | ✓      | ✓       | ✓       | Stable |
| Closures| ✓      | ✓       | ✓       | Stable |
| Generics| ✗      | ✓       | ✓       | v1.10+ |

## Breaking Changes
- v1.10.0: Changed syntax for...
- v1.11.0: Deprecated feature...

## Migration Guide
1. For v1.9.1 → v1.10.0: ...
2. For v1.10.0 → v1.11.0: ...
```

### Dependency Management
```toml
# Required tools (verified on sprint start)
[dependencies]
ruchy = ">=1.9.1"
shellcheck = "0.9.0"
make = "4.3"

[dev-dependencies]
cargo = "1.75.0"
git = "2.40.0"
```

### Integration Testing
```bash
# Before each sprint
make integration-test

# Checks:
- [ ] Ruchy version compatibility
- [ ] Shell compatibility (POSIX)
- [ ] Platform compatibility
- [ ] Performance benchmarks
- [ ] Memory usage limits
```

### Continuous Compatibility Monitoring
```yaml
checks:
  - ruchy_version: Daily check for new releases
  - syntax_changes: Monitor Ruchy changelog
  - deprecations: Track deprecated features
  - performance: Benchmark against each version
  - regression: Test suite on multiple versions
```

## Shell Script Standards

### Strict Shell Requirements
**ALL shell scripts MUST use strict error handling and minimal POSIX-compliant syntax.**

```bash
#!/bin/sh
# MANDATORY header for all shell scripts
set -eu  # Exit on error, undefined variables are errors

# NO bash-specific features:
# - No [[ ]] (use [ ])
# - No arrays
# - No process substitution
# - No $'' strings
# - No (( )) arithmetic (use $(()) or expr)
```

### ShellCheck Compliance
```bash
# Every script MUST pass:
shellcheck -s sh -e SC2039,SC3043 script.sh  # POSIX sh mode
# Zero warnings, zero errors
```

### Makefile Standards
```makefile
# Use POSIX shell explicitly
SHELL := /bin/sh
.SHELLFLAGS := -eu -c

# Simple, portable commands only
# NO shell loops in recipes - use find/xargs
# NO complex redirections
# NO bash-specific syntax
```

### Shell Script Template
```bash
#!/bin/sh
set -eu

# Simple POSIX-compliant script
# One purpose, one responsibility
# Exit codes: 0 success, 1 failure

main() {
    # Core logic here
    printf "Output\n"  # Use printf, not echo -e
}

main "$@"
```

### Forbidden Patterns
```bash
# NEVER use:
echo -e         # Use printf
source          # Use .
[[ ]]          # Use [ ]
==             # Use = for string comparison
&>             # Use > file 2>&1
<<<            # No here-strings
${var^^}       # No parameter expansion
```

## Success Metrics

### Quantitative
- Test coverage: 100%
- Demo count: 150+
- Execution success: 100%
- Performance: All < 100ms
- User rating: ≥ 4.5/5
- ShellCheck: Zero warnings

### Qualitative
- Clarity: Instant understanding
- Value: Practical application
- Progression: Smooth learning curve
- Completeness: No gaps in coverage
- Delight: "Wow" moments

---

**Remember**: Every demo is a first impression. Make it count.
- every task is TDD.  All code must be 80% coverage or greater.  All code must pass pmat.