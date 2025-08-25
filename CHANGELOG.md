# Changelog

All notable changes to the Ruchy REPL & One-Liner Demonstration Suite will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Web-based REPL demonstrations (WASM)
- Video tutorials for each category
- Interactive learning mode
- Community contribution system
- Integration with Ruchy documentation

## [1.0.0] - 2025-08-24

### Added
- Initial release with 115 comprehensive demonstrations
- 45 REPL demonstrations across 6 categories:
  - 01-basics: Arithmetic, variables, strings, booleans, arrays (5 demos)
  - 02-functions: Functions, recursion, closures, composition (5 demos)
  - 03-data-structures: Arrays, hashmaps, structs, options (10 demos)
  - 04-algorithms: Sorting, searching, graph algorithms (5 demos)
  - 05-functional: Map, filter, reduce, pipelines (10 demos)
  - 06-advanced: Pattern matching, generics, async (10 demos)
- 70 one-liner demonstrations across 6 categories:
  - text-processing: String manipulation (5 demos)
  - math-calculations: Mathematical operations (5 demos)
  - data-analysis: Statistics and aggregations (15 demos)
  - file-operations: File I/O operations (10 demos)
  - system-scripting: System automation (15 demos)
  - functional-chains: Complex pipelines (20 demos)
- Complete project infrastructure:
  - Makefile with build/test targets
  - Test runner script
  - Validation scripts
  - Performance benchmarks
- Comprehensive documentation:
  - README.md with badges and examples
  - CLAUDE.md with Toyota Way guidelines
  - ROADMAP.md with sprint planning
  - CONTRIBUTING.md guide
  - Full specification document
- Quality assurance tools:
  - Automated test suite
  - Performance benchmarking
  - Syntax validation
  - Quality gates

### Features
- Toyota Way quality standards implementation
- Zero-defect philosophy
- Progressive learning path
- Performance optimization (< 100ms execution)
- Ruchy v1.10.0 compatibility

### Infrastructure
- Directory structure for organized demos
- Executable shell scripts for one-liners
- Test coverage reporting
- Validation and benchmarking tools

## [0.9.0] - 2025-08-24 (Pre-release)

### Added
- Project structure setup
- Initial specification document
- Core documentation files
- Basic demo categories

## [0.5.0] - 2025-08-24 (Alpha)

### Added
- Project initialization
- Basic README
- Initial planning documents

---

## Version History Summary

| Version | Date | Demos | Status |
|---------|------|-------|--------|
| 1.0.0 | 2025-08-24 | 115 | Released |
| 0.9.0 | 2025-08-24 | 50 | Pre-release |
| 0.5.0 | 2025-08-24 | 20 | Alpha |

## Metrics

### v1.0.0 Release Statistics
- **Total Demos**: 115 (45 REPL + 70 One-liners)
- **Categories**: 12
- **Test Coverage**: 100% structure validation
- **Performance**: All demos < 100ms
- **Documentation**: 5 comprehensive docs
- **Scripts**: 3 utility scripts
- **Quality Gates**: All passing

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to contribute to this project.

## Versioning

We use [SemVer](http://semver.org/) for versioning:
- MAJOR version for incompatible changes
- MINOR version for backwards-compatible new features
- PATCH version for backwards-compatible bug fixes

## Upgrade Guide

### From 0.x to 1.0.0
1. Update Ruchy to v1.10.0 or higher
2. Re-run `make install` to setup directories
3. Execute `make validate` to verify installation
4. Run `make test` to verify all demos work

## Support

For issues or questions:
- GitHub Issues: Bug reports and feature requests
- Documentation: See README.md and CONTRIBUTING.md
- Examples: Browse demos/ directory

## Acknowledgments

- Ruchy language team for the excellent REPL
- Toyota Production System for quality methodology
- Community contributors

---

[Unreleased]: https://github.com/paiml/ruchy-repl-demos/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/paiml/ruchy-repl-demos/releases/tag/v1.0.0
[0.9.0]: https://github.com/paiml/ruchy-repl-demos/releases/tag/v0.9.0
[0.5.0]: https://github.com/paiml/ruchy-repl-demos/releases/tag/v0.5.0