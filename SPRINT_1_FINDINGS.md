# Sprint 1 Findings: Notebook Testing Architecture

**Date**: 2025-10-14
**Sprint**: Sprint 1 (90% → Paused for Architecture Decision)
**Status**: Needs Decision on Testing Approach

## 🔍 Discovery: Ruchy Notebooks Have Two Modes

After implementing Playwright E2E tests and attempting to run them, we discovered that **Ruchy notebooks can run in two different architectures**:

### 1. **Server-Based** (ruchy-book pattern)
- Command: `ruchy notebook --port 8080`
- Architecture: Rust server serving HTTP API
- API Endpoint: `POST /api/execute` with `{source: "code"}`
- UI: Served at root `/` or `/notebook.html`
- Pattern: ruchy-book uses Deno script hitting API

### 2. **WASM-Based** (wasm-labs pattern)
- Command: `python3 -m http.server 8000` (static serving)
- Architecture: Pure WASM in browser, no server
- Loading: `<script type="module">` loads WASM
- Pattern: wasm-labs uses Playwright with static HTML

## 🧪 What We Built (Paused)

Created Playwright E2E infrastructure following ../ruchy patterns:
- ✅ `playwright.config.ts` - Configuration
- ✅ `tests/e2e/00-smoke-test.spec.ts` - Smoke tests
- ✅ `tests/e2e/01-repl-demos.spec.ts` - Demo tests
- ✅ `package.json` - Playwright dependencies
- ⚠️  **Issue**: Tried to test server mode, but unclear which mode ruchy-repl-demos should use

## ❓ Architecture Decision Needed

**Question**: Which notebook architecture should ruchy-repl-demos use?

### Option A: Server-Based (`ruchy notebook`)
**Pattern**: Follow ruchy-book

**Pros**:
- ✅ Full Ruchy runtime (no WASM limitations)
- ✅ Real server execution (what users will use)
- ✅ Can test `/api/execute` endpoint
- ✅ Already have infrastructure (ruchy notebook command)

**Cons**:
- ❌ Requires Rust server running during tests
- ❌ More complex CI/CD (need to start server)
- ❌ Slower (server startup time)

**Implementation**:
```bash
# Start server (manual or in CI)
ruchy notebook --port 8080 &
NOTEBOOK_PID=$!

# Run tests via API
curl -X POST http://localhost:8080/api/execute \
  -H "Content-Type: application/json" \
  -d '{"source": "2 + 2"}'

# Or use Deno script like ruchy-book
deno run --allow-net scripts/test-notebook.ts
```

### Option B: WASM-Based (static files)
**Pattern**: Follow wasm-labs

**Pros**:
- ✅ Pure browser testing (no server needed)
- ✅ Simpler CI/CD (just `python3 -m http.server`)
- ✅ Faster (no server startup)
- ✅ Tests what users see in browser

**Cons**:
- ❌ Need to build WASM first (`wasm-pack build`)
- ❌ WASM may have limitations vs full runtime
- ❌ More complex setup (WASM build process)

**Implementation**:
```bash
# Build WASM (in ruchy repo)
cd ../ruchy
wasm-pack build --target web --out-dir pkg

# Copy to ruchy-repl-demos
cp pkg/*.wasm ../ruchy-repl-demos/static/

# Serve static files
python3 -m http.server 8000

# Test with Playwright
npx playwright test
```

### Option C: Hybrid (Both)
**Pattern**: Test both modes

**Pros**:
- ✅ Complete coverage
- ✅ Validates both deployment modes

**Cons**:
- ❌ Double the work
- ❌ More complex maintenance

## 📊 Pattern Analysis from Related Projects

| Project | Pattern | Server | WASM | Notes |
|---------|---------|--------|------|-------|
| **ruchy** | Both | ✅ | ✅ | Uses `wasm-pack` + E2E tests |
| **ruchy-book** | Server | ✅ | ❌ | Deno script → `/api/execute` |
| **wasm-labs** | WASM | ❌ | ✅ | Pure WASM, static serving |
| **rosetta-ruchy** | Server | ✅ | ❌ | MCP server mode |

## 💡 Recommendation

**For ruchy-repl-demos**: Follow **Option A (Server-Based)** like ruchy-book

**Reasoning**:
1. ✅ This project is about **REPL demos** - server mode is more authentic
2. ✅ ruchy-book already solved this problem with Deno script
3. ✅ Simpler to implement (no WASM build process)
4. ✅ Tests actual `ruchy notebook` command users will use
5. ✅ Can add WASM mode later if needed

## 🎯 Recommended Implementation

### Step 1: Create Deno Test Script (Like ruchy-book)
```typescript
// scripts/test-notebook.ts
const NOTEBOOK_URL = "http://localhost:8080/api/execute";

async function testDemo(code: string) {
  const response = await fetch(NOTEBOOK_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ source: code }),
  });

  const result = await response.json();
  return result.success;
}

// Test each demo file
for (const demo of demos) {
  const code = await Deno.readTextFile(demo);
  const passed = await testDemo(code);
  console.log(`${demo}: ${passed ? '✅' : '❌'}`);
}
```

### Step 2: Update Makefile
```makefile
test-notebook:
	@echo "📓 Testing demos in Ruchy notebook..."
	@echo "Starting notebook server..."
	@ruchy notebook --port 8080 & echo $$! > .notebook.pid
	@sleep 2
	@deno run --allow-all scripts/test-notebook.ts
	@kill $$(cat .notebook.pid)
	@rm .notebook.pid
```

### Step 3: Deprecate Playwright (For Now)
- Keep `playwright.config.ts` for future WASM testing
- Document it as "Future: WASM Mode Testing"
- Focus on Deno script for Sprint 1 completion

## 📝 Sprint 1 Status After This Discovery

**Current**: 90% complete (REPL-103 paused)

**With Server-Based Approach**:
- REPL-103: Create `scripts/test-notebook.ts` (Deno script)
- REPL-103: Update Makefile with server management
- REPL-103: Test all demos via API
- REPL-105: Auto-update INTEGRATION.md with results

**Estimated Time**: 3-4 hours to complete Sprint 1

## 🚫 What We Learned (Toyota Way - Hansei)

**Good**:
- ✅ Followed ../ruchy patterns for Playwright
- ✅ Created proper test infrastructure
- ✅ Documented architecture discovery

**Could Improve**:
- ⚠️  Should have checked ruchy-book's actual implementation first
- ⚠️  Assumed WASM mode when ruchy has both modes
- ⚠️  Could have asked about architecture before implementing

**Root Cause (5 Whys)**:
1. Why did we implement wrong pattern? → Assumed WASM-only
2. Why assume WASM-only? → Saw ../ruchy has WASM tests
3. Why not check ruchy-book? → Focused on ../ruchy primarily
4. Why focus on ../ruchy? → It's the compiler, seemed most authoritative
5. Why not ask first? → Wanted to show initiative by implementing

**Countermeasure**: Always check ALL related projects before implementing

## 🎓 Next Steps

**Immediate** (to complete Sprint 1):
1. Create `scripts/test-notebook.ts` following ruchy-book pattern
2. Update Makefile with server management
3. Test all REPL demos via `/api/execute`
4. Complete REPL-105 (INTEGRATION.md automation)
5. Mark Sprint 1 as 100% complete

**Future** (Sprint 2+):
1. Add WASM mode testing using Playwright infrastructure
2. Test both server and WASM modes
3. Document deployment for both modes

---

**Status**: Paused at 90%, awaiting decision on server vs WASM approach
**Recommendation**: Server-based (Option A) following ruchy-book pattern
**Estimated Time to Complete**: 3-4 hours
