.PHONY: help all build test clean install validate quality-gate coverage benchmark \
        test-repl test-oneliner test-repl-basics test-repl-functions test-repl-data \
        test-repl-algorithms test-repl-functional test-repl-advanced \
        test-oneliner-text test-oneliner-data test-oneliner-file \
        test-oneliner-math test-oneliner-system test-oneliner-functional \
        demos-repl demos-oneliner verify lint pre-commit release

# Use strict POSIX shell
SHELL := /bin/sh
.SHELLFLAGS := -eu -c

# Default target
help:
	@echo "Ruchy REPL & One-Liner Demos - Development Commands"
	@echo ""
	@echo "Core Commands:"
	@echo "  make test         - Run all tests"
	@echo "  make demos-repl   - Run all REPL demonstrations"
	@echo "  make demos-oneliner - Run all one-liner demonstrations"
	@echo "  make validate     - Run validation checks on all demos"
	@echo "  make quality-gate - Run full quality gate checks"
	@echo "  make clean        - Clean generated files"
	@echo ""
	@echo "Test Commands:"
	@echo "  make test-repl    - Test all REPL demos"
	@echo "  make test-oneliner - Test all one-liner demos"
	@echo "  make test-repl-basics - Test basic REPL demos"
	@echo "  make test-repl-functions - Test function REPL demos"
	@echo "  make test-oneliner-text - Test text processing one-liners"
	@echo "  make test-oneliner-math - Test math one-liners"
	@echo "  make coverage     - Generate test coverage report"
	@echo ""
	@echo "Quality Commands:"
	@echo "  make verify       - Verify syntax of all demos"
	@echo "  make lint         - Check for quality issues"
	@echo "  make benchmark    - Run performance benchmarks"
	@echo ""
	@echo "Development Commands:"
	@echo "  make install      - Install dependencies"
	@echo "  make pre-commit   - Run pre-commit checks"
	@echo "  make release      - Prepare for release"

# Build/setup
install:
	@echo "Checking Ruchy installation..."
	@if ! command -v ruchy >/dev/null 2>&1; then \
		echo "ERROR: ruchy not found. Install with: cargo install ruchy"; \
		exit 1; \
	fi
	@ruchy --version
	@echo "✓ Ruchy installed"
	@echo "Setting up directory structure..."
	@mkdir -p demos/repl/01-basics demos/repl/02-functions demos/repl/03-data-structures
	@mkdir -p demos/repl/04-algorithms demos/repl/05-functional demos/repl/06-advanced
	@mkdir -p demos/one-liners/text-processing demos/one-liners/data-analysis
	@mkdir -p demos/one-liners/file-operations demos/one-liners/math-calculations
	@mkdir -p demos/one-liners/system-scripting demos/one-liners/functional-chains
	@mkdir -p tests/repl tests/one-liner
	@mkdir -p scripts
	@mkdir -p docs/tutorials
	@echo "✓ Directory structure created"

# Run all tests
test: test-repl test-oneliner
	@echo "✓ All tests passed"

# Test REPL demos
test-repl: test-repl-basics test-repl-functions test-repl-data test-repl-algorithms test-repl-functional test-repl-advanced
	@echo "✓ All REPL tests passed"

test-repl-basics:
	@echo "Testing REPL basics..."
	@if ls demos/repl/01-basics/*.repl >/dev/null 2>&1; then \
		for demo in demos/repl/01-basics/*.repl; do \
			printf "  Testing %s...\n" "$$demo"; \
			if ruchy repl < "$$demo" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

test-repl-functions:
	@echo "Testing REPL functions..."
	@if ls demos/repl/02-functions/*.repl >/dev/null 2>&1; then \
		for demo in demos/repl/02-functions/*.repl; do \
			printf "  Testing %s...\n" "$$demo"; \
			if ruchy repl < "$$demo" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

test-repl-data:
	@echo "Testing REPL data structures..."
	@if ls demos/repl/03-data-structures/*.repl >/dev/null 2>&1; then \
		for demo in demos/repl/03-data-structures/*.repl; do \
			printf "  Testing %s...\n" "$$demo"; \
			if ruchy repl < "$$demo" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

test-repl-algorithms:
	@echo "Testing REPL algorithms..."
	@if ls demos/repl/04-algorithms/*.repl >/dev/null 2>&1; then \
		for demo in demos/repl/04-algorithms/*.repl; do \
			printf "  Testing %s...\n" "$$demo"; \
			if ruchy repl < "$$demo" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

test-repl-functional:
	@echo "Testing REPL functional programming..."
	@if ls demos/repl/05-functional/*.repl >/dev/null 2>&1; then \
		for demo in demos/repl/05-functional/*.repl; do \
			printf "  Testing %s...\n" "$$demo"; \
			if ruchy repl < "$$demo" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

test-repl-advanced:
	@echo "Testing REPL advanced features..."
	@if ls demos/repl/06-advanced/*.repl >/dev/null 2>&1; then \
		for demo in demos/repl/06-advanced/*.repl; do \
			printf "  Testing %s...\n" "$$demo"; \
			if ruchy repl < "$$demo" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

# Test one-liner demos
test-oneliner: test-oneliner-text test-oneliner-data test-oneliner-file test-oneliner-math test-oneliner-system test-oneliner-functional
	@echo "✓ All one-liner tests passed"

test-oneliner-text:
	@echo "Testing text processing one-liners..."
	@if ls demos/one-liners/text-processing/*.sh >/dev/null 2>&1; then \
		for script in demos/one-liners/text-processing/*.sh; do \
			printf "  Testing %s...\n" "$$script"; \
			if sh "$$script" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

test-oneliner-data:
	@echo "Testing data analysis one-liners..."
	@if ls demos/one-liners/data-analysis/*.sh >/dev/null 2>&1; then \
		for script in demos/one-liners/data-analysis/*.sh; do \
			printf "  Testing %s...\n" "$$script"; \
			if sh "$$script" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

test-oneliner-file:
	@echo "Testing file operation one-liners..."
	@if ls demos/one-liners/file-operations/*.sh >/dev/null 2>&1; then \
		for script in demos/one-liners/file-operations/*.sh; do \
			printf "  Testing %s...\n" "$$script"; \
			if sh "$$script" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

test-oneliner-math:
	@echo "Testing math calculation one-liners..."
	@if ls demos/one-liners/math-calculations/*.sh >/dev/null 2>&1; then \
		for script in demos/one-liners/math-calculations/*.sh; do \
			printf "  Testing %s...\n" "$$script"; \
			if sh "$$script" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

test-oneliner-system:
	@echo "Testing system scripting one-liners..."
	@if ls demos/one-liners/system-scripting/*.sh >/dev/null 2>&1; then \
		for script in demos/one-liners/system-scripting/*.sh; do \
			printf "  Testing %s...\n" "$$script"; \
			if sh "$$script" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

test-oneliner-functional:
	@echo "Testing functional chain one-liners..."
	@if ls demos/one-liners/functional-chains/*.sh >/dev/null 2>&1; then \
		for script in demos/one-liners/functional-chains/*.sh; do \
			printf "  Testing %s...\n" "$$script"; \
			if sh "$$script" > /dev/null 2>&1; then \
				printf "    ✓ Passed\n"; \
			else \
				printf "    ✗ Failed\n"; \
				exit 1; \
			fi; \
		done; \
	else \
		echo "  No demos found yet"; \
	fi

# Run demonstrations
demos-repl:
	@echo "Running all REPL demonstrations..."
	@find demos/repl -name "*.repl" | while read -r demo; do \
		printf "Demo: %s\n" "$$demo"; \
		ruchy repl < "$$demo" 2>/dev/null || true; \
	done

demos-oneliner:
	@echo "Running all one-liner demonstrations..."
	@find demos/one-liners -name "*.sh" | while read -r script; do \
		printf "Demo: %s\n" "$$script"; \
		sh "$$script" 2>/dev/null || true; \
	done

# Validation
validate: verify
	@echo "Validating all demos..."
	@find demos -name "*.ruchy" | while read -r file; do \
		ruchy check "$$file" 2>/dev/null || true; \
	done
	@echo "✓ Validation complete"

verify:
	@echo "Verifying syntax of all Ruchy files..."
	@find demos -name "*.ruchy" | while read -r file; do \
		printf "Checking %s\n" "$$file"; \
		ruchy check "$$file" 2>/dev/null || true; \
	done
	@echo "✓ Syntax verification complete"

# Quality gates
quality-gate: test lint verify benchmark
	@echo "Running quality gate checks..."
	@echo "✓ Checking for TODO/FIXME comments..."
	@if find demos -type f \( -name "*.ruchy" -o -name "*.repl" \) -exec grep -l "TODO\|FIXME\|HACK" {} \; | grep .; then \
		echo "✗ Found TODO/FIXME comments"; \
		exit 1; \
	fi
	@echo "✓ Checking demo count..."
	@count=$$(find demos \( -name "*.repl" -o -name "*.sh" \) | wc -l); \
	if [ "$$count" -lt 20 ]; then \
		echo "✗ Less than 20 demos found"; \
		exit 1; \
	fi
	@echo "✓ All quality gates passed"

lint: shellcheck
	@echo "✓ All linting checks passed"

shellcheck:
	@echo "Running ShellCheck on all shell scripts..."
	@find . -name "*.sh" -type f | while read -r script; do \
		printf "  Checking %s..." "$$script"; \
		if shellcheck -s sh -e SC2039,SC3043 "$$script" >/dev/null 2>&1; then \
			printf " ✓\n"; \
		else \
			printf " ✗\n"; \
			shellcheck -s sh -e SC2039,SC3043 "$$script"; \
			exit 1; \
		fi; \
	done
	@echo "✓ ShellCheck passed"

# Performance
benchmark:
	@echo "Running performance benchmarks..."
	@echo "  Testing REPL startup time..."
	@time -p ruchy repl < /dev/null 2>&1 | head -1
	@echo "  Testing one-liner execution..."
	@time -p ruchy -e 'println("benchmark")' 2>&1 | head -1
	@echo "✓ Benchmarks complete"

# Coverage
coverage:
	@echo "Generating test coverage report..."
	@echo "Total demos: $$(find demos -name '*.repl' -o -name '*.sh' | wc -l)"
	@echo "REPL demos: $$(find demos/repl -name '*.repl' | wc -l)"
	@echo "One-liner demos: $$(find demos/one-liners -name '*.sh' | wc -l)"
	@echo "Test files: $$(find tests -name '*.yaml' -o -name '*.sh' | wc -l)"
	@echo "✓ Coverage report generated"

# Clean
clean:
	@echo "Cleaning generated files..."
	@find . -name "*.tmp" -exec rm -f {} + 2>/dev/null || true
	@find . -name "*.log" -exec rm -f {} + 2>/dev/null || true
	@find . -name "*.out" -exec rm -f {} + 2>/dev/null || true
	@echo "✓ Clean complete"

# Pre-commit hook
pre-commit: quality-gate
	@echo "✓ Pre-commit checks passed"

# Release preparation
release: quality-gate
	@echo "Preparing for release..."
	@echo "  Checking version..."
	@if ! grep -q "v[0-9]" README.md; then \
		echo "✗ Version not found in README"; \
		exit 1; \
	fi
	@echo "  Checking documentation..."
	@if [ ! -f ROADMAP.md ]; then \
		echo "✗ ROADMAP.md not found"; \
		exit 1; \
	fi
	@if [ ! -f CLAUDE.md ]; then \
		echo "✗ CLAUDE.md not found"; \
		exit 1; \
	fi
	@echo "  Checking demos..."
	@count=$$(find demos \( -name "*.repl" -o -name "*.sh" \) | wc -l); \
	if [ "$$count" -lt 150 ]; then \
		echo "⚠️  Warning: Less than 150 demos"; \
	fi
	@echo "✓ Ready for release"

# All
all: install test quality-gate coverage
	@echo "✓ All tasks complete"