# Chapter 6: REPL Replays - Interactive Testing and Assessment

## Overview

REPL replay is one of Ruchy's most innovative features, providing a sophisticated system for recording, replaying, and testing interactive REPL sessions. This capability serves dual purposes: ensuring implementation correctness through regression testing and enabling automated educational assessment with deterministic execution.

## What Are REPL Replays?

REPL replays allow you to:

1. **Record complete REPL sessions** - Capture every input, output, and state change
2. **Replay sessions deterministically** - Reproduce exact results for testing
3. **Generate comprehensive tests** - Convert interactive sessions into regression tests
4. **Enable educational assessment** - Support automated grading and plagiarism detection

## Getting Started with REPL Replays

### Recording Your First Session

To record a REPL session, use the `--record` flag:

```bash
# Start recording a session
ruchy repl --record demos/my-first-session.replay
```

This starts an interactive REPL that records everything:

```ruchy
>>> 2 + 2
4
>>> let name = "Alice"
>>> f"Hello, {name}!"
"Hello, Alice!"
>>> let numbers = [1, 2, 3, 4, 5]
>>> numbers.sum()
15
>>> :quit
```

When you exit, the complete session is saved to `my-first-session.replay`.

### Understanding Replay Files

Replay files are structured JSON documents containing:

```json
{
  "version": { "major": 1, "minor": 0, "patch": 0 },
  "metadata": {
    "session_id": "ruchy-session-demo-1",
    "created_at": "2025-09-01T12:00:00Z",
    "ruchy_version": "1.29.1",
    "tags": ["demo", "basic-math"]
  },
  "environment": {
    "seed": 12345,
    "resource_limits": {
      "heap_mb": 100,
      "stack_kb": 8192,
      "cpu_ms": 5000
    }
  },
  "timeline": [
    {
      "id": 1,
      "timestamp_ns": 1000000,
      "event": {
        "Input": {
          "text": "2 + 2",
          "mode": "Interactive"
        }
      }
    },
    {
      "id": 2,
      "timestamp_ns": 1100000,
      "event": {
        "Output": {
          "result": {
            "Success": {
              "value": "4"
            }
          }
        }
      }
    }
  ]
}
```

### Replaying Sessions

To replay a recorded session:

```bash
# Replay a session (for verification)
ruchy replay demos/my-first-session.replay

# Replay with detailed output
ruchy replay demos/my-first-session.replay --verbose

# Replay and validate determinism
ruchy replay demos/my-first-session.replay --validate
```

## Converting Replays to Tests

The most powerful feature is converting replay sessions into comprehensive test suites:

### Basic Conversion

```bash
# Convert a single replay to tests
ruchy replay-to-tests demos/my-first-session.replay --output tests/session_tests.rs

# Convert all replays in a directory
ruchy replay-to-tests demos/ --output tests/all_replays.rs
```

### Advanced Test Generation

```bash
# Include property-based tests for determinism
ruchy replay-to-tests demos/math-session.replay \
  --property-tests \
  --benchmarks \
  --timeout 5000 \
  --output tests/comprehensive_tests.rs
```

This generates:
- **Regression tests** - Verify exact output matches
- **Property tests** - Check deterministic behavior
- **Performance benchmarks** - Monitor execution speed
- **Resource tests** - Validate memory/CPU usage

## Practical Examples

### Example 1: Mathematical Operations

Record a session exploring mathematical operations:

```bash
ruchy repl --record demos/math-operations.replay
```

```ruchy
>>> let a = 10
>>> let b = 5
>>> a + b
15
>>> a * b  
50
>>> a ** b
100000
>>> let factorial = |n| (1..=n).product()
>>> factorial(5)
120
>>> factorial(6)
720
>>> :quit
```

Convert to tests:

```bash
ruchy replay-to-tests demos/math-operations.replay \
  --output tests/math_regression.rs \
  --property-tests
```

### Example 2: Data Structure Exploration

Record working with complex data structures:

```bash
ruchy repl --record demos/data-structures.replay
```

```ruchy
>>> let person = { name: "Bob", age: 30, city: "Seattle" }
>>> person.name
"Bob"
>>> let team = [
...     { name: "Alice", role: "Lead" },
...     { name: "Bob", role: "Developer" },
...     { name: "Carol", role: "Designer" }
... ]
>>> team[0].name
"Alice"
>>> team.map(|member| member.role)
["Lead", "Developer", "Designer"]
>>> :quit
```

### Example 3: Function Development

Record the iterative development of a function:

```bash
ruchy repl --record demos/function-development.replay
```

```ruchy
>>> fun fibonacci(n) { if n <= 1 { n } else { fibonacci(n-1) + fibonacci(n-2) } }
>>> fibonacci(5)
5
>>> fibonacci(10)
55
>>> // Let's optimize with memoization
>>> let memo = {}
>>> fun fib_memo(n) {
...     if n <= 1 { 
...         n 
...     } else if memo.has(n) { 
...         memo[n] 
...     } else { 
...         memo[n] = fib_memo(n-1) + fib_memo(n-2);
...         memo[n]
...     }
... }
>>> fib_memo(20)
6765
>>> :quit
```

## Educational Applications

### Automated Assessment

REPL replays enable sophisticated educational assessment:

```bash
# Record student solution
ruchy repl --record student-solution.replay --metadata student_id=12345

# Validate against expected behavior
ruchy replay-validate student-solution.replay --reference reference-solution.replay

# Generate comprehensive grade report
ruchy grade student-solution.replay --rubric assignment-rubric.json
```

### Features for Educators

1. **Plagiarism Detection**
   - AST structural comparison
   - Behavioral pattern analysis
   - Session timing analysis

2. **Automated Grading**
   - Test case verification
   - Performance assessment
   - Code quality metrics

3. **Learning Analytics**
   - Student progress tracking
   - Common error patterns
   - Difficulty assessment

## Advanced Features

### Deterministic Execution

Replays ensure deterministic behavior through:

- **Fixed random seeds** for reproducible randomness
- **Controlled timing** for consistent execution
- **Resource bounds** to prevent runaway processes
- **State isolation** between test runs

### Property-Based Testing

Generated tests verify essential properties:

```rust
#[test]
fn test_session_determinism() {
    // Verify replaying produces identical results
    let replay1 = run_replay("session.replay");
    let replay2 = run_replay("session.replay");
    assert_eq!(replay1, replay2);
}

#[test]
fn test_resource_bounds() {
    // Verify resource usage stays within limits
    let stats = run_replay_with_monitoring("session.replay");
    assert!(stats.heap_usage_mb < 100);
    assert!(stats.execution_time_ms < 5000);
}
```

### Chaos Engineering

Test resilience with fault injection:

```bash
# Test with memory pressure
ruchy replay demos/session.replay --chaos memory-pressure=0.8

# Test with slow compilation  
ruchy replay demos/session.replay --chaos compile-delay=500ms

# Test with cache invalidation
ruchy replay demos/session.replay --chaos cache-miss-rate=0.5
```

## Best Practices

### Recording Effective Sessions

1. **Focus on specific concepts** - One topic per session
2. **Include exploration** - Show the thought process
3. **Test edge cases** - Demonstrate error handling
4. **Add comments** - Explain reasoning during recording
5. **Keep sessions concise** - Aim for 10-20 interactions

### Organizing Replay Files

```
demos/
├── basics/
│   ├── arithmetic.replay
│   ├── variables.replay
│   └── types.replay
├── functions/
│   ├── simple-functions.replay
│   ├── closures.replay
│   └── recursion.replay
└── data-structures/
    ├── arrays.replay
    ├── objects.replay
    └── nested-data.replay
```

### Test Generation Strategy

```bash
# Generate focused regression tests
ruchy replay-to-tests demos/basics/ --output tests/basics_regression.rs

# Generate property tests for critical features
ruchy replay-to-tests demos/functions/ --property-tests --output tests/function_properties.rs

# Generate performance benchmarks
ruchy replay-to-tests demos/algorithms/ --benchmarks --output benchmarks/algorithm_perf.rs
```

## Integration with CI/CD

### Continuous Testing

Add replay validation to your CI pipeline:

```yaml
# .github/workflows/replay-tests.yml
name: Replay Tests
on: [push, pull_request]

jobs:
  replay-validation:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install Ruchy
        run: cargo install ruchy
      - name: Run replay tests
        run: |
          ruchy replay-to-tests demos/ --output tests/generated.rs
          cargo test --test generated
      - name: Validate determinism
        run: |
          for replay in demos/*.replay; do
            ruchy replay "$replay" --validate
          done
```

### Regression Detection

Automatically detect when changes break existing functionality:

```bash
# Before making changes
ruchy replay-to-tests demos/ --output tests/baseline.rs

# After changes
ruchy replay-to-tests demos/ --output tests/current.rs

# Compare test results
diff tests/baseline.rs tests/current.rs
```

## Troubleshooting

### Common Issues

1. **Non-deterministic behavior**
   - Check for uncontrolled randomness
   - Verify system time dependencies
   - Review resource allocation patterns

2. **Replay validation failures**
   - Ensure consistent Ruchy version
   - Check for environment differences
   - Validate resource limit settings

3. **Test generation errors**
   - Verify replay file format
   - Check for corrupted sessions
   - Validate metadata completeness

### Debug Mode

Run replays with detailed debugging:

```bash
ruchy replay session.replay --debug --trace-execution --dump-state
```

## Future Enhancements

The REPL replay system continues to evolve with planned features:

- **Interactive replay editing** - Modify recorded sessions
- **Session merging** - Combine multiple replays
- **Distributed replays** - Record across multiple REPL instances
- **Real-time collaboration** - Share live recording sessions
- **Advanced analytics** - Deeper learning insights

## Conclusion

REPL replays represent a paradigm shift in interactive language testing and education. By providing deterministic recording and replay capabilities, Ruchy enables:

- **Comprehensive regression testing** for language implementations
- **Sophisticated educational assessment** with automated grading
- **Interactive documentation** that stays current with the language
- **Reproducible debugging** for complex interactive scenarios

Whether you're developing language features, creating educational content, or building automated assessment systems, REPL replays provide the foundation for reliable, testable interactive experiences.

Start recording your next REPL session and discover how replays can transform your development workflow!