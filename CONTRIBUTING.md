# Contributing to Ruchy REPL & One-Liner Demos

Thank you for your interest in contributing to the Ruchy demonstration suite! This guide will help you contribute high-quality demos that help others learn Ruchy.

## 🎯 Contribution Philosophy

We follow the **Toyota Way** quality principles:
- **Zero Defects**: Every demo must work perfectly
- **Continuous Improvement**: Always looking for better examples
- **Respect for People**: Clear, helpful demonstrations that respect learners' time

## 📋 Types of Contributions

### 1. New Demonstrations
- REPL interactive examples
- One-liner scripts
- Advanced pattern demonstrations

### 2. Improvements
- Bug fixes in existing demos
- Performance optimizations
- Documentation clarifications

### 3. Documentation
- Tutorials for specific concepts
- Translation to other languages
- Video demonstrations

## 🚀 Getting Started

### Prerequisites
1. Install Ruchy v1.9.1 or higher:
   ```bash
   cargo install ruchy
   ```

2. Clone the repository:
   ```bash
   git clone https://github.com/paiml/ruchy-repl-demos.git
   cd ruchy-repl-demos
   ```

3. Run validation:
   ```bash
   make validate
   ```

## 📝 Demo Guidelines

### REPL Demo Structure
```ruchy
// demos/repl/category/demo_name.repl
// Description: What this demo teaches
// Concept: Core concept being demonstrated

// Setup code
let x = 10

// Main demonstration
fn example() {
    // Core logic here
}

// Expected output shown as comments
example()  // Output: result
```

### One-Liner Structure
```bash
#!/bin/bash
# demos/one-liners/category/demo_name.sh
# Description: What this one-liner does

echo "Description of what we're doing:"
ruchy -e 'actual_code_here'
```

## 🔍 Quality Standards

### Before Submitting
Every demo MUST:
- [ ] Work with current Ruchy version
- [ ] Focus on ONE concept
- [ ] Include clear comments
- [ ] Execute in < 100ms
- [ ] Pass syntax validation
- [ ] Have meaningful variable names

### Testing Your Demo
```bash
# Test a REPL demo
ruchy repl < your_demo.repl

# Test a one-liner
bash your_demo.sh

# Run full test suite
make test

# Check quality gates
make quality-gate
```

## 📊 Performance Requirements

| Demo Type | Max Execution Time | Memory Limit |
|-----------|-------------------|--------------|
| Basic REPL | 50ms | 10MB |
| Complex REPL | 100ms | 50MB |
| One-liner | 100ms | 25MB |
| Algorithm Demo | 500ms | 100MB |

## 🎨 Code Style

### DO ✅
```ruchy
// Clear, descriptive names
let user_age = 25
let is_valid = true

// Explain complex logic
// Calculate factorial recursively
fn factorial(n: i32) -> i32 {
    if n <= 1 { 1 } else { n * factorial(n - 1) }
}
```

### DON'T ❌
```ruchy
// Avoid unclear names
let x = 25
let flag = true

// Don't skip explanations
fn f(n: i32) -> i32 {
    if n <= 1 { 1 } else { n * f(n - 1) }
}
```

## 📁 Directory Structure

Place your demos in the appropriate category:

```
demos/
├── repl/
│   ├── 01-basics/        # Variables, types, expressions
│   ├── 02-functions/     # Function definitions, closures
│   ├── 03-data-structures/ # Arrays, maps, structs
│   ├── 04-algorithms/    # Sorting, searching
│   ├── 05-functional/    # FP patterns
│   └── 06-advanced/      # Complex features
└── one-liners/
    ├── text-processing/  # String manipulation
    ├── math-calculations/ # Mathematical operations
    ├── data-analysis/    # Statistics, aggregations
    ├── file-operations/  # File I/O
    ├── system-scripting/ # System tasks
    └── functional-chains/ # Pipeline operations
```

## 🔄 Submission Process

### 1. Create Your Demo
```bash
# Create new demo file
touch demos/repl/01-basics/demo_new_concept.repl

# Edit and test
ruchy repl < demos/repl/01-basics/demo_new_concept.repl
```

### 2. Test Thoroughly
```bash
# Run your specific demo
make test-repl-basics

# Run all tests
make test

# Check quality
make quality-gate
```

### 3. Submit Pull Request
```bash
# Create feature branch
git checkout -b add-new-demo

# Add your files
git add demos/your-new-demo

# Commit with clear message
git commit -m "Add demo: [category] Description of what it demonstrates"

# Push and create PR
git push origin add-new-demo
```

## 📋 Pull Request Template

```markdown
## Demo Description
Brief description of what this demo teaches

## Category
- [ ] REPL Demo
- [ ] One-liner
- [ ] Tutorial

## Testing
- [ ] Demo executes without errors
- [ ] Performance < 100ms
- [ ] Comments are clear
- [ ] Follows style guide

## Checklist
- [ ] Read CONTRIBUTING.md
- [ ] Tested with latest Ruchy
- [ ] Added to appropriate category
- [ ] No TODO/FIXME comments
```

## 🐛 Reporting Issues

### Bug Report Template
```markdown
**Demo**: Path to demo file
**Issue**: What's wrong
**Expected**: What should happen
**Actual**: What actually happens
**Ruchy Version**: Output of `ruchy --version`
**Steps to Reproduce**:
1. Step one
2. Step two
```

## 💡 Demo Ideas

Looking for inspiration? Here are needed demos:

### High Priority
- WebAssembly compilation examples
- Async/await patterns
- Error handling best practices
- Generic type demonstrations

### Medium Priority
- Database operations
- Network programming
- Parallel processing
- Machine learning basics

### Always Welcome
- Real-world problem solutions
- Performance optimization techniques
- Design pattern implementations
- Integration with other tools

## 🎓 Learning Resources

- [Ruchy Documentation](https://github.com/paiml/ruchy)
- [The Ruchy Book](https://github.com/paiml/ruchy-book)
- [Rosetta Ruchy](https://github.com/paiml/rosetta-ruchy)

## 📜 Code of Conduct

- Be respectful and inclusive
- Focus on education and clarity
- Help beginners learn
- Give constructive feedback
- Celebrate contributions

## 🏆 Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Given credit in demo comments

## 📧 Contact

- GitHub Issues: Bug reports and feature requests
- Discussions: General questions and ideas
- Email: [project-email]

## 🙏 Thank You!

Every contribution helps someone learn Ruchy better. Whether it's a simple one-liner or a complex algorithm demonstration, your contribution matters!

---

**Remember**: The best demo is one that makes someone say "Ah, now I understand!"