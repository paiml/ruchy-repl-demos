#!/usr/bin/env -S deno run --allow-net --allow-read --allow-run --allow-write

/**
 * Test Ruchy REPL Demos in Notebook
 *
 * Following ruchy-book pattern: Uses `ruchy notebook` server API
 * Pattern source: ../ruchy-book/scripts/test-in-notebook.ts
 *
 * This tests REAL notebook execution via /api/execute endpoint.
 */

const NOTEBOOK_URL = "http://localhost:8080/api/execute";
const NOTEBOOK_HEALTH = "http://localhost:8080/api/health";
const NOTEBOOK_TIMEOUT = 10000; // 10 seconds

interface NotebookResponse {
  success: boolean;
  output?: string;
  error?: string;
  stdout?: string;
  stderr?: string;
}

interface TestResult {
  file: string;
  passed: boolean;
  error?: string;
  output?: string;
}

/**
 * Check if notebook server is running
 */
async function checkNotebookServer(): Promise<boolean> {
  try {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 3000);

    // Try a simple execution to check if server is running
    // (ruchy notebook doesn't have /api/health endpoint)
    const response = await fetch(NOTEBOOK_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ source: "1 + 1" }),
      signal: controller.signal,
    });

    clearTimeout(timeout);
    return response.ok;
  } catch {
    return false;
  }
}

/**
 * Execute code in notebook via API
 */
async function executeInNotebook(code: string): Promise<NotebookResponse> {
  try {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), NOTEBOOK_TIMEOUT);

    const response = await fetch(NOTEBOOK_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ source: code }),
      signal: controller.signal,
    });

    clearTimeout(timeout);

    if (!response.ok) {
      return {
        success: false,
        error: `HTTP ${response.status}: ${response.statusText}`,
      };
    }

    return await response.json();
  } catch (error) {
    return {
      success: false,
      error: `Failed to execute: ${error}`,
    };
  }
}

/**
 * Find all REPL demo files recursively
 */
async function findDemoFiles(): Promise<string[]> {
  const demos: string[] = [];

  async function walkDirectory(dir: string) {
    try {
      for await (const dirEntry of Deno.readDir(dir)) {
        const path = `${dir}/${dirEntry.name}`;
        if (dirEntry.isDirectory) {
          // Recursively walk subdirectories
          await walkDirectory(path);
        } else if (dirEntry.isFile && dirEntry.name.endsWith(".ruchy")) {
          demos.push(path);
        }
      }
    } catch (error) {
      console.error(`Error reading directory ${dir}: ${error}`);
    }
  }

  await walkDirectory("demos/repl");
  return demos.sort();
}

/**
 * Test a single demo file
 */
async function testDemo(filePath: string): Promise<TestResult> {
  try {
    const code = await Deno.readTextFile(filePath);
    const result = await executeInNotebook(code);

    return {
      file: filePath,
      passed: result.success,
      error: result.error,
      output: result.output || result.stdout,
    };
  } catch (error) {
    return {
      file: filePath,
      passed: false,
      error: `Failed to read file: ${error}`,
    };
  }
}

/**
 * Main test runner
 */
async function main() {
  console.log("📓 Ruchy REPL Demos - Notebook Validation");
  console.log("==========================================");
  console.log("");

  // Check if notebook server is running
  console.log("🔍 Checking notebook server...");
  const serverRunning = await checkNotebookServer();

  if (!serverRunning) {
    console.error("❌ Notebook server not running!");
    console.error("");
    console.error("Start the server with:");
    console.error("  ruchy notebook --port 8080");
    console.error("");
    Deno.exit(1);
  }

  console.log("✅ Notebook server is running");
  console.log("");

  // Find all demo files
  const demoFiles = await findDemoFiles();
  console.log(`📂 Found ${demoFiles.length} demo files`);
  console.log("");

  // Test each demo
  const results: TestResult[] = [];
  let passed = 0;
  let failed = 0;

  for (const demoFile of demoFiles) {
    const fileName = demoFile.split("/").pop() || demoFile;
    process.stdout.write(`  Testing ${fileName}... `);

    const result = await testDemo(demoFile);
    results.push(result);

    if (result.passed) {
      console.log("✅ PASS");
      passed++;
    } else {
      console.log("❌ FAIL");
      if (result.error) {
        console.log(`    Error: ${result.error}`);
      }
      failed++;
    }
  }

  // Summary
  console.log("");
  console.log("==========================================");
  console.log("📊 Test Summary");
  console.log("==========================================");
  console.log(`Total:  ${demoFiles.length} demos`);
  console.log(`Passed: ${passed} ✅`);
  console.log(`Failed: ${failed} ❌`);
  console.log("");
  console.log(`Success Rate: ${((passed / demoFiles.length) * 100).toFixed(1)}%`);
  console.log("");

  // Save results to JSON
  const resultsFile = "notebook-test-results.json";
  await Deno.writeTextFile(
    resultsFile,
    JSON.stringify(
      {
        timestamp: new Date().toISOString(),
        total: demoFiles.length,
        passed,
        failed,
        success_rate: passed / demoFiles.length,
        results,
      },
      null,
      2
    )
  );
  console.log(`📄 Results saved to: ${resultsFile}`);
  console.log("");

  // Exit with error if any tests failed
  if (failed > 0) {
    console.error("❌ Some tests failed");
    Deno.exit(1);
  }

  console.log("✅ All tests passed!");
  Deno.exit(0);
}

// Run main
if (import.meta.main) {
  main();
}
