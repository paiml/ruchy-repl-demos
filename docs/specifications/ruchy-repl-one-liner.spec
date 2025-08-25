# Ruchy REPL & One-Liner Demonstration Suite Specification

**Version**: 1.0.0  
**Last Updated**: August 24, 2025  
**Status**: Ready for Implementation

## Executive Summary

The Ruchy REPL & One-Liner Demonstration Suite showcases the language's interactive capabilities and rapid prototyping power through comprehensive examples demonstrating both REPL and one-liner execution modes. This project follows Toyota Way quality principles with 100% test coverage and formal verification.

## Core Objectives

1. **Interactive Excellence**: Demonstrate Ruchy's REPL as a production-ready interactive environment
2. **One-Liner Power**: Showcase complex operations achievable in single command lines
3. **Progressive Complexity**: From simple expressions to advanced functional programming
4. **Quality Demonstration**: Every example includes formal verification and BigO analysis
5. **Real-World Applicability**: Practical examples developers can immediately use

## Architecture

```
ruchy-repl-demos/
├── demos/
│   ├── repl/                    # REPL interactive sessions
│   │   ├── 01-basics/           # Basic expressions and evaluation
│   │   ├── 02-functions/        # Function definition and execution
│   │   ├── 03-data-structures/  # Working with collections
│   │   ├── 04-algorithms/       # Algorithm implementation
│   │   ├── 05-functional/       # Functional programming patterns
│   │   └── 06-advanced/         # Advanced REPL features
│   └── one-liners/              # One-liner examples
│       ├── text-processing/     # String and text manipulation
│       ├── data-analysis/       # Quick data operations
│       ├── file-operations/     # File I/O one-liners
│       ├── math-calculations/   # Mathematical computations
│       ├── system-scripting/    # System automation
│       └── functional-chains/   # Pipeline operations
├── tests/
│   ├── repl/                    # REPL test suites
│   └── one-liner/               # One-liner test suites
├── scripts/
│   ├── validate.sh              # Validation script
│   └── benchmark.sh             # Performance benchmarks
└── docs/
    ├── specifications/          # This specification
    └── tutorials/               # User tutorials

```

## REPL Demonstrations

### Category 1: Basic Expressions (01-basics/)
```ruchy
# demo_01_arithmetic.repl
>>> 2 + 2
4
>>> 10 * 5.5
55.0
>>> 2 ** 8
256
>>> 17 % 5
2
```

### Category 2: Function Definitions (02-functions/)
```ruchy
# demo_01_simple_functions.repl
>>> fn greet(name: String) -> String {
...     "Hello, " + name + "!"
... }
>>> greet("Ruchy")
"Hello, Ruchy!"

>>> fn factorial(n: i32) -> i32 {
...     if n <= 1 { 1 } else { n * factorial(n - 1) }
... }
>>> factorial(5)
120
```

### Category 3: Data Structures (03-data-structures/)
```ruchy
# demo_01_collections.repl
>>> let numbers = [1, 2, 3, 4, 5]
>>> numbers.map(|x| x * 2)
[2, 4, 6, 8, 10]

>>> let data = {"name": "Alice", "age": 30}
>>> data["name"]
"Alice"
```

### Category 4: Algorithms (04-algorithms/)
```ruchy
# demo_01_sorting.repl
>>> fn quicksort(arr: [i32]) -> [i32] {
...     if arr.len() <= 1 { return arr }
...     let pivot = arr[0]
...     let less = arr[1..].filter(|x| x < pivot)
...     let greater = arr[1..].filter(|x| x >= pivot)
...     quicksort(less) + [pivot] + quicksort(greater)
... }
>>> quicksort([3, 1, 4, 1, 5, 9, 2, 6])
[1, 1, 2, 3, 4, 5, 6, 9]
```

### Category 5: Functional Programming (05-functional/)
```ruchy
# demo_01_pipelines.repl
>>> [1, 2, 3, 4, 5]
...   |> filter(|x| x % 2 == 0)
...   |> map(|x| x * x)
...   |> sum()
20

>>> fn compose<A, B, C>(f: A -> B, g: B -> C) -> (A -> C) {
...     |x| g(f(x))
... }
>>> let add_one = |x| x + 1
>>> let double = |x| x * 2
>>> let transform = compose(add_one, double)
>>> transform(5)
12
```

### Category 6: Advanced Features (06-advanced/)
```ruchy
# demo_01_pattern_matching.repl
>>> fn describe(x: Option<i32>) -> String {
...     match x {
...         Some(n) if n > 0 => "Positive: " + n.to_string(),
...         Some(0) => "Zero",
...         Some(n) => "Negative: " + n.to_string(),
...         None => "No value"
...     }
... }
>>> describe(Some(42))
"Positive: 42"
>>> describe(None)
"No value"
```

## One-Liner Demonstrations

### Text Processing
```bash
# Count words in a string
ruchy -e 'println("hello world from ruchy".split(" ").len())'

# Reverse a string
ruchy -e 'println("ruchy".chars().rev().collect::<String>())'

# Extract unique words
ruchy -e 'let text = "the quick brown fox jumps over the lazy fox"; println(text.split(" ").unique().join(", "))'
```

### Data Analysis
```bash
# Calculate mean of numbers
ruchy -e 'let nums = [1, 2, 3, 4, 5]; println(nums.sum() / nums.len())'

# Find max and min
ruchy -e 'let data = [8, 3, 9, 1, 5]; println("Max: {}, Min: {}", data.max(), data.min())'

# Standard deviation
ruchy -e 'let vals = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0]; let mean = vals.sum() / vals.len(); let variance = vals.map(|x| (x - mean).pow(2)).sum() / vals.len(); println(variance.sqrt())'
```

### File Operations
```bash
# Read and count lines
ruchy -e 'println(read_file("data.txt").lines().count())'

# Process CSV data
ruchy -e 'read_file("data.csv").lines().skip(1).map(|line| line.split(",")[2]).sum()'

# Write processed data
ruchy -e 'let result = (1..=10).map(|x| x * x).join("\n"); write_file("squares.txt", result)'
```

### Math Calculations
```bash
# Fibonacci sequence
ruchy -e 'fn fib(n) { if n <= 1 { n } else { fib(n-1) + fib(n-2) } }; println((0..10).map(fib).join(", "))'

# Prime checker
ruchy -e 'fn is_prime(n) { n > 1 && !(2..n).any(|i| n % i == 0) }; println((2..20).filter(is_prime).join(", "))'

# Factorial
ruchy -e 'fn fact(n) { (1..=n).product() }; println(fact(10))'
```

### System Scripting
```bash
# Generate timestamp
ruchy -e 'println(std::time::now().format("%Y-%m-%d %H:%M:%S"))'

# Process environment variables
ruchy -e 'println(env::var("PATH").split(":").filter(|p| p.contains("bin")).join("\n"))'

# Quick JSON processing
ruchy -e 'let json = r#"{"name": "Alice", "age": 30}"#; let data = json::parse(json); println("Name: {}", data["name"])'
```

### Functional Chains
```bash
# Complex pipeline
ruchy -e '(1..=100) |> filter(|x| x % 2 == 0) |> map(|x| x * x) |> take(10) |> sum() |> println'

# Compose transformations
ruchy -e 'let double = |x| x * 2; let add_ten = |x| x + 10; [1,2,3,4,5].map(double >> add_ten).println()'

# Lazy evaluation
ruchy -e '(1..).filter(|x| x % 7 == 0).take(5).collect::<Vec<_>>().println()'
```

## Quality Standards

### Toyota Way Compliance
- **Zero Defects**: Every example must work on first execution
- **Systematic Testing**: 100% test coverage for all demonstrations
- **Continuous Improvement**: Regular updates based on user feedback
- **Root Cause Analysis**: Any failure triggers 5-whys investigation

### Testing Requirements
1. **Unit Tests**: Each demo has corresponding test file
2. **Integration Tests**: Full REPL session replay tests
3. **Property Tests**: Invariants verified across input ranges
4. **Performance Tests**: Execution time benchmarks
5. **Regression Tests**: Historical issues prevented

### Formal Verification
Each demonstration includes:
```bash
# Syntax validation
ruchy check demo.ruchy

# Complexity analysis
ruchy runtime demo.ruchy

# Provability analysis
ruchy provability demo.ruchy

# Quality scoring
ruchy score demo.ruchy
```

## Implementation Phases

### Phase 1: Foundation (Week 1)
- [ ] Basic REPL demonstrations (01-basics)
- [ ] Simple one-liners (text-processing, math)
- [ ] Test infrastructure setup
- [ ] Initial documentation

### Phase 2: Core Features (Week 2)
- [ ] Function demonstrations (02-functions)
- [ ] Data structure examples (03-data-structures)
- [ ] File operation one-liners
- [ ] Integration test suite

### Phase 3: Advanced (Week 3)
- [ ] Algorithm implementations (04-algorithms)
- [ ] Functional programming (05-functional)
- [ ] System scripting one-liners
- [ ] Performance benchmarks

### Phase 4: Polish (Week 4)
- [ ] Advanced REPL features (06-advanced)
- [ ] Functional chain one-liners
- [ ] Tutorial documentation
- [ ] Release preparation

## Success Metrics

### Quantitative
- **Test Coverage**: ≥95%
- **Example Count**: ≥50 REPL demos, ≥100 one-liners
- **Execution Time**: All demos < 100ms
- **Zero Failures**: 100% success rate
- **Documentation**: Every demo documented

### Qualitative
- **Clarity**: Examples immediately understandable
- **Practicality**: Real-world applicable
- **Progressive**: Learning curve supported
- **Impressive**: Showcases Ruchy's power
- **Reusable**: Copy-paste ready

## Delivery Commitment

This specification represents a binding contract for delivery. The implementation will:

1. **Follow Toyota Way**: Zero-defect quality built-in
2. **Be Test-Driven**: Tests written before demos
3. **Use Ruchy v1.9.1+**: Latest language features
4. **Provide Value**: Every example teaches something
5. **Ship Complete**: No partial implementations

## Technical Requirements

### Dependencies
- Ruchy v1.9.1 or higher
- Rust 1.75+ (for test harness)
- Make (for build automation)
- Git (for version control)

### Performance Targets
- REPL startup: < 50ms
- One-liner execution: < 100ms
- Test suite completion: < 30s
- Memory usage: < 50MB per demo

### Compatibility
- Linux: Full support
- macOS: Full support
- Windows: WSL2 supported
- Web: WASM REPL planned

## Continuous Delivery

The project will follow continuous delivery principles:

1. **Sprint-based delivery**: 2-day sprints
2. **Incremental value**: Each sprint adds usable demos
3. **Feedback integration**: User feedback within 24 hours
4. **Version releases**: Semantic versioning
5. **Zero downtime**: Always functional main branch

---

*This specification is the single source of truth for the Ruchy REPL & One-Liner Demonstration Suite.*