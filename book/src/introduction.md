# Introduction

Welcome to the **Ruchy REPL & One-Liner Demos** - a comprehensive, test-driven collection of practical Ruchy examples.

## Why This Book Exists

Learning a programming language effectively requires **working examples**. This book provides exactly that - a curated collection of Ruchy code that:

- **Works immediately** - Every example is tested before documentation
- **Teaches progressively** - From basic concepts to advanced patterns
- **Solves real problems** - Practical examples you can use today

## Test-Driven Approach

Unlike traditional programming books, every example in this collection follows strict quality standards:

### Quality Guarantees

```
✅ Syntax validated with: ruchy check
✅ Execution tested with: ruchy run  
✅ Performance verified with: ruchy runtime
✅ Quality scored with: ruchy score ≥ 0.8
```

### No Broken Examples

We follow the **Toyota Way** manufacturing principles:
- **Jidoka**: Stop and fix problems immediately
- **Genchi Genbutsu**: Go see for yourself (test in real environment)
- **Kaizen**: Continuous improvement through feedback

## Book Structure

### Part I: REPL Mastery
Interactive development using Ruchy's REPL environment. Learn to:
- Explore APIs interactively
- Prototype solutions quickly
- Debug code effectively
- Build complex programs incrementally

### Part II: One-Liner Mastery  
Powerful single-line solutions for common tasks:
- Text processing and analysis
- Data manipulation and analysis
- File operations and batch processing
- System administration and automation

### Part III: Advanced Techniques
Professional development practices:
- Testing strategies
- Performance optimization
- Best practices and patterns

## How to Use This Book

### For Beginners
Start with [Chapter 1: Basics](ch01-00-basics-tdd.md) and work through sequentially. Each chapter builds on the previous ones.

### For Experienced Developers
Jump to specific topics using the detailed table of contents. Each section is self-contained with working examples.

### For Reference
Use the appendices for quick lookup of patterns, syntax, and troubleshooting guides.

## Code Conventions

### REPL Sessions
REPL examples are shown with clear input/output:

```ruchy
>>> let x = 5
>>> let y = 10  
>>> x + y
15
```

### One-Liners
Command-line examples include descriptions:

```bash
# Calculate factorial of 5
ruchy -e 'fn fact(n) { (1..=n).product() }; println(fact(5))'
# Output: 120
```

### Test Validation
Each example includes its test status:

```ruchy
// ✅ Tested: ruchy check ✓, ruchy run ✓, score: 0.92
>>> let numbers = [1, 2, 3, 4, 5]
>>> numbers.map(|x| x * 2)
[2, 4, 6, 8, 10]
```

## Contributing

Found an issue or have a suggestion? This book is continuously improved based on user feedback:

1. All examples are automatically tested
2. Issues are tracked and resolved systematically  
3. New examples are added based on community needs

## Version Compatibility

This book is compatible with:
- **Ruchy v1.14.0** (current)
- **Rust 1.75.0** (minimum)
- **All major platforms** (Linux, macOS, Windows)

## Getting Help

If you encounter issues:

1. Check [Appendix D: Troubleshooting](appendix-d-troubleshooting.md)
2. Verify your Ruchy version: `ruchy --version`
3. Test individual examples with: `ruchy check example.ruchy`

---

Let's begin your test-driven Ruchy journey!