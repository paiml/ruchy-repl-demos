# Chapter 1: WASM Basics - Test-Driven WebAssembly Learning

**Building Production-Ready WebAssembly with Ruchy**

WebAssembly (WASM) represents the future of high-performance computing across platforms. With Ruchy v2.1.0's native WASM compilation, you can write once and deploy everywhere - from browsers to edge computing platforms.

This chapter establishes WASM-first development patterns using Test-Driven Development (TDD) principles. Every example compiles to WebAssembly first, then validates in the REPL.

## What You'll Learn

- Native WASM compilation with `ruchy wasm`
- Cross-platform deployment patterns
- Browser, Node.js, and serverless integration
- Performance optimization for WASM modules
- Security validation and quality metrics

## WASM-First Development Workflow

### The New Standard Pattern

```ruchy
// 1. Write Ruchy function
fun add(a: i32, b: i32) -> i32 {
    a + b
}

// 2. Compile to WASM
// ruchy wasm add.ruchy -o add.wasm --target browser

// 3. Deploy to platform  
// ruchy wasm add.ruchy --deploy --deploy-target cloudflare

// 4. Validate in REPL
// >>> add(5, 3)
// 8
```

### Supported Deployment Targets

Ruchy v2.1.0 supports immediate deployment to:

- **Browser**: Interactive web applications
- **Node.js**: High-performance server modules
- **Cloudflare Workers**: Edge computing functions  
- **AWS Lambda**: Serverless microservices
- **Vercel**: JAMstack deployment
- **Deno**: Modern runtime integration

## Quality Gates for WASM

Every WASM module must pass:

```bash
# Compile with validation
ruchy wasm source.ruchy -o output.wasm --verbose

# Check module quality
ruchy score output.wasm  # Must score ≥ 0.8

# Validate security
ruchy wasm output.wasm --security-check

# Performance analysis
ruchy runtime output.wasm
```

## Next Steps

Begin with [WASM Arithmetic & Compilation](ch01-01-wasm-arithmetic.md) to master the fundamentals.

---

**Every WASM module in this book is production-tested across all deployment targets. Quality demonstrated, not promised.**