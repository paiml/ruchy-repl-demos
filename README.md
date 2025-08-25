# Ruchy REPL & One-Liner Demonstration Suite 🚀

[![Tests](https://img.shields.io/badge/tests-150%2B%20demos-brightgreen.svg)](./tests)
[![Ruchy](https://img.shields.io/badge/ruchy-v1.9.1%2B-blue.svg)](https://github.com/paiml/ruchy)
[![Quality](https://img.shields.io/badge/quality-Toyota%20Way-gold.svg)](./CLAUDE.md)
[![Coverage](https://img.shields.io/badge/coverage-100%25-success.svg)](./tests)

**Production-ready demonstrations of Ruchy's interactive REPL and powerful one-liner capabilities**

## 🎯 What This Is

A comprehensive suite of tested, verified demonstrations showcasing:
- **Interactive REPL**: 50+ examples from basics to advanced patterns
- **One-Liners**: 100+ practical command-line solutions
- **Real-World Applications**: Text processing, data analysis, system automation
- **Quality Guaranteed**: Every demo tested and verified with formal analysis

## ⚡ Quick Start

```bash
# Install Ruchy (v1.9.1+)
cargo install ruchy

# Clone demos
git clone https://github.com/paiml/ruchy-repl-demos.git
cd ruchy-repl-demos

# Run tests to verify everything works
make test

# Try a REPL demo
ruchy repl < demos/repl/01-basics/demo_01_arithmetic.repl

# Execute a one-liner
./demos/one-liners/text-processing/reverse_string.sh
```

## 📚 Demo Categories

### REPL Demonstrations

| Category | Demos | Description |
|----------|-------|-------------|
| **Basics** | 10 | Arithmetic, variables, basic expressions |
| **Functions** | 10 | Definition, closures, recursion, composition |
| **Data Structures** | 10 | Arrays, maps, structs, collections |
| **Algorithms** | 5 | Sorting, searching, classic CS problems |
| **Functional** | 10 | Map, filter, reduce, pipeline operations |
| **Advanced** | 5 | Pattern matching, generics, type inference |

### One-Liner Examples

| Category | Demos | Use Cases |
|----------|-------|-----------|
| **Text Processing** | 20 | String manipulation, parsing, formatting |
| **Data Analysis** | 15 | Statistics, aggregation, calculations |
| **File Operations** | 10 | Read, write, transform files |
| **Math Calculations** | 20 | Formulas, sequences, numerical methods |
| **System Scripting** | 15 | Automation, environment, timestamps |
| **Functional Chains** | 20 | Pipeline operations, composition |

## 🔬 Quality Assurance

Every demonstration includes:

```bash
# Syntax validation
ruchy check demo.ruchy          # ✓ Valid syntax

# Runtime complexity
ruchy runtime demo.ruchy        # O(n) complexity

# Formal verification
ruchy provability demo.ruchy    # 100% provable

# Quality scoring
ruchy score demo.ruchy          # Score: A+ (0.95/1.0)
```

## 💡 Featured Examples

### REPL: Functional Composition
```ruchy
>>> let add_one = |x| x + 1
>>> let double = |x| x * 2
>>> let transform = add_one >> double
>>> transform(5)
12
```

### One-Liner: Prime Numbers
```bash
ruchy -e 'fn is_prime(n) { n > 1 && !(2..n).any(|i| n % i == 0) }; 
         println((2..50).filter(is_prime).join(", "))'
# Output: 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47
```

### REPL: Pattern Matching
```ruchy
>>> fn classify(n: i32) -> String {
...     match n {
...         n if n < 0 => "negative",
...         0 => "zero",
...         1..=10 => "small",
...         _ => "large"
...     }
... }
>>> [classify(-5), classify(0), classify(7), classify(100)]
["negative", "zero", "small", "large"]
```

### One-Liner: Data Pipeline
```bash
ruchy -e '(1..=100) 
         |> filter(|x| x % 2 == 0) 
         |> map(|x| x * x) 
         |> take(5) 
         |> sum() 
         |> println'
# Output: 220 (4 + 16 + 36 + 64 + 100)
```

## 📊 Learning Path

### Beginner
1. Start with `demos/repl/01-basics/`
2. Try simple one-liners in `text-processing/`
3. Experiment with `math-calculations/`

### Intermediate
1. Explore `demos/repl/02-functions/`
2. Work through `data-analysis/` one-liners
3. Study `demos/repl/03-data-structures/`

### Advanced
1. Master `demos/repl/05-functional/`
2. Build complex `functional-chains/`
3. Tackle `demos/repl/06-advanced/`

## 🛠️ Development

### Running Tests
```bash
# All tests
make test

# Specific category
make test-repl-basics
make test-oneliner-text

# With coverage
make coverage
```

### Adding New Demos
1. Create demo file in appropriate category
2. Write test in `tests/` directory
3. Run `make validate` to verify
4. Update documentation
5. Submit PR with test results

### Quality Gates
```bash
make quality-gate  # Must pass before merge
```

Checks:
- ✅ All demos execute successfully
- ✅ Performance < 100ms per demo
- ✅ Test coverage 100%
- ✅ No TODO/FIXME comments
- ✅ Documentation complete

## 📈 Project Status

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Demo Count | 150+ | 150 | ✅ |
| Test Coverage | 100% | 100% | ✅ |
| Performance | <100ms | ✓ All pass | ✅ |
| Quality Score | A+ | A+ (0.95) | ✅ |
| Documentation | Complete | Complete | ✅ |

## 🎓 Educational Value

Each demonstration teaches:
- **Core Concept**: One specific Ruchy feature
- **Best Practice**: Idiomatic usage pattern
- **Real Application**: Practical use case
- **Performance**: Complexity characteristics
- **Verification**: Formal correctness proof

## 🔄 Continuous Updates

This project follows continuous delivery:
- **Sprint Releases**: Every 2 days
- **User Feedback**: Integrated within 24 hours
- **Version Updates**: Tracks latest Ruchy features
- **Quality Maintained**: Zero regression policy

## 📝 Documentation

- [Specification](docs/specifications/ruchy-repl-one-liner.spec) - Complete project specification
- [Development Guide](CLAUDE.md) - Toyota Way quality standards
- [Roadmap](ROADMAP.md) - Development timeline and milestones
- [Tutorials](docs/tutorials/) - Step-by-step learning guides

## 🤝 Contributing

We welcome contributions that:
1. Add new demonstration categories
2. Improve existing examples
3. Enhance test coverage
4. Fix bugs (though we aim for zero)
5. Improve documentation

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📜 License

MIT License - See [LICENSE](LICENSE) for details.

## 🏆 Acknowledgments

- Ruchy language team for the amazing REPL
- Toyota Production System for quality methodology
- Community contributors for feedback and ideas

---

**Ready to explore Ruchy's interactive power? Start with `make test` to verify everything works!**
