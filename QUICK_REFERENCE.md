# Validation Framework - Quick Reference

**For**: Ruchy REPL & One-Liner Demos
**Philosophy**: Toyota Way - ZERO tolerance for defects

## 🚀 Quick Start (First Time)

```bash
# 1. Install git hooks (one-time)
make install-hooks

# 2. Check current quality
make coverage-report

# 3. Run quality gates
make quality-gates
```

## 📋 Daily Commands

### Before You Start
```bash
# Check project status
make coverage-report

# View help
make help
```

### During Development
```bash
# Run all tests
make test

# Test specific category
make test-repl-basics
make test-oneliner-math
```

### Before Commit
```bash
# Run quality gates (MANDATORY)
make quality-gates

# Or strict mode (ZERO tolerance)
make quality-gate-strict

# Then commit (pre-commit hook auto-runs)
git commit -m "your message"
```

### Weekly/Sprint
```bash
# Run Kaizen cycle
make kaizen

# Update integration report
make update-integration

# Check for regressions
make test-regression
```

## 🎯 Quality Gates (10 Gates)

| # | Gate | Command | Target |
|---|------|---------|--------|
| 1 | Ruchy Version | `ruchy --version` | Latest |
| 2 | Test Suite | `make test` | 100% pass |
| 3 | Demo Count | `find demos` | ≥50 |
| 4 | SATD | `grep TODO` | 0 |
| 5 | ShellCheck | `shellcheck` | 0 errors |
| 6 | Comments | `//` not `#` | Valid |
| 7 | Docs | README/CLAUDE/ROADMAP | Present |
| 8 | Ruchy Tools | `ruchy lint` | Working |
| 9 | Structure | `demos/tests/scripts` | Valid |
| 10 | Performance | `< 1000ms` | Fast |

## 🔍 Quick Diagnostics

### Check Quality Score
```bash
make coverage-report | grep "Overall Score"
# Goal: ≥80% (9/10 or better)
```

### Find SATD Comments
```bash
make analyze-satd
# Goal: 0 TODO/FIXME/HACK
```

### Check Demo Coverage
```bash
make coverage-report | head -30
# See per-category status
```

### Test Pass Rate
```bash
make test | grep "Pass rate"
# Goal: 100%
```

## ❌ Common Issues & Fixes

### Issue: ShellCheck Errors
```bash
# Find errors
make shellcheck

# Fix common issues:
# - Use [ ] not [[ ]]
# - Use /bin/sh not /bin/bash
# - Quote variables: "$var" not $var
```

### Issue: SATD Comments
```bash
# Find them
make analyze-satd

# Remove all TODO/FIXME/HACK
# Replace with proper implementation or tickets
```

### Issue: Empty Demo Files
```bash
# Find them
find demos -empty

# Remove or complete them
```

### Issue: Test Failures
```bash
# Run tests with details
./scripts/run_ruchy_tests.sh

# Fix failing tests
# Re-run: make test
```

### Issue: Missing Documentation
```bash
# Check what's missing
ls -l README.md CLAUDE.md ROADMAP.md

# Create missing files
```

## 🌸 Toyota Way Commands

### Kaizen (Continuous Improvement)
```bash
make kaizen
# Runs full improvement cycle:
# 1. Genchi Genbutsu (Go and See)
# 2. Jidoka (Quality Check)
# 3. Hansei (Reflect)
```

### Learn the Philosophy
```bash
make help-toyota-way
# Shows principles and policies
```

### Enforce ZERO Tolerance
```bash
make quality-gate-strict
# Fails on ANY violation
```

## 🔧 Troubleshooting

### Pre-commit Hook Not Running
```bash
# Verify hook is installed
ls -la .git/hooks/pre-commit

# Reinstall if missing
make install-hooks
```

### Quality Gates Failing
```bash
# Check which gate failed
make quality-gates

# Run specific checks
make shellcheck           # Check shell scripts
make test-ruchy-native   # Run tests
make analyze-satd        # Check for SATD comments
```

### ShellCheck Issues
```bash
# Check all scripts
make shellcheck

# Fix common issues:
# - Use printf instead of echo -n
# - Use expr for arithmetic in POSIX sh
# - Add shellcheck disable directives for valid exceptions
```

## 📊 Reporting

### Update INTEGRATION.md
```bash
make update-integration
# Single source of truth
# View: cat INTEGRATION.md
```

### Generate Coverage Report
```bash
make coverage-report > report.txt
# Full quality analysis
```

### Check Regressions
```bash
make test-regression
# Detects demo count drops
```

## 🔧 Scripts Reference

| Script | Purpose | Usage |
|--------|---------|-------|
| `quality-gates.sh` | MANDATORY validation | `make quality-gates` |
| `pre-commit-hook.sh` | Git commit blocker | Auto-runs |
| `coverage-report.sh` | Quality analysis | `make coverage-report` |
| `update-integration.sh` | Status report | `make update-integration` |
| `install-hooks.sh` | Hook setup | `make install-hooks` |

## 🎓 Score Breakdown

### Coverage Report Score (0-100%)

- **20%**: Demo count (≥150)
- **20%**: Test pass rate (100%)
- **20%**: SATD count (0)
- **10%**: Empty files (0)
- **10%**: ShellCheck (0 errors)
- **10%**: Tool integration (≥70%)
- **10%**: Performance (< 1000ms)

**Passing**: ≥80% (8/10 points)

## 🚨 Pre-commit Hook

**Automatically checks**:
1. Ruchy version
2. SATD (blocks if found)
3. Test files (≥3)
4. Syntax (all valid)
5. ShellCheck
6. Comments (// not #)
7. Documentation
8. Permissions
9. Empty files
10. Structure

**Bypassing** (NOT RECOMMENDED):
```bash
git commit --no-verify
# Only use in emergencies!
```

## 📈 Integration Workflow

### Local Development
```bash
1. make coverage-report   # Check status
2. Work on demos
3. make test              # Test frequently
4. make quality-gates     # Before commit
5. git commit             # Hook validates
```

### CI/CD Pipeline
```bash
1. make install
2. make install-hooks
3. make quality-gate-strict
4. make test-all-examples
5. make coverage-report
6. make update-integration
```

## 🎯 Goals & Targets

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| Demos | 180 | 150 | ✅ 120% |
| Pass Rate | 100% | 100% | ✅ |
| SATD | 0 | 0 | ✅ |
| ShellCheck | 12 | 0 | ⚠️ 92% |
| Score | 90% | 80% | ✅ |
| Tools | 100% | 70% | ✅ |

## 🔗 Key Files

- `VALIDATION_FRAMEWORK.md` - Complete framework docs
- `INTEGRATION.md` - Current status report
- `CLAUDE.md` - Development protocol
- `ROADMAP.md` - Sprint planning

## 💡 Pro Tips

1. **Run `make kaizen` weekly** - Continuous improvement
2. **Check `make coverage-report` daily** - Track progress
3. **Never skip quality gates** - Quality first
4. **Fix SATD immediately** - No technical debt
5. **Keep tests at 100%** - Every demo works

## 🆘 Need Help?

```bash
# Show all commands
make help

# Show Toyota Way philosophy
make help-toyota-way

# Show validation framework
cat VALIDATION_FRAMEWORK.md

# Check current status
make coverage-report
```

---

**Remember**: Quality is built-in, not bolted-on!

**ZERO Tolerance**: No TODO, No FIXME, No HACK
**100% Pass Rate**: Every demo must work
**80% Score**: Minimum quality gate

*Quick Reference v1.0 - October 2025*
