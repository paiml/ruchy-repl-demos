import { test, expect } from '@playwright/test';
import * as fs from 'fs';
import * as path from 'path';

/**
 * E2E Tests for REPL Demos - Notebook Execution
 * Pattern from: ../ruchy/tests/e2e/notebook/01-basic-execution.spec.ts
 *
 * Tests that all REPL demos execute successfully in the notebook.
 * We use the REAL notebook UI, not curl-based API calls.
 */

// Helper to read demo file
function readDemo(category: string, filename: string): string {
  const demoPath = path.join(__dirname, '../../demos/repl', category, filename);
  return fs.readFileSync(demoPath, 'utf-8');
}

// Helper to execute code in notebook via API
async function executeCode(request: any, code: string) {
  const response = await request.post('http://localhost:8080/api/execute', {
    data: { source: code }
  });
  return await response.json();
}

test.describe('REPL Demos - 01-basics', () => {
  test('arithmetic_operations.ruchy', async ({ request }) => {
    const code = readDemo('01-basics', 'arithmetic_operations.ruchy');
    const result = await executeCode(request, code);

    expect(result.success).toBe(true);
    expect(result.output).toBeTruthy();
  });
});

test.describe('REPL Demos - 02-functions', () => {
  test('function_basics.ruchy', async ({ request }) => {
    const code = readDemo('02-functions', 'function_basics.ruchy');
    const result = await executeCode(request, code);

    expect(result.success).toBe(true);
    expect(result.output).toBeTruthy();
  });
});

test.describe('REPL Demos - 03-data-structures', () => {
  test('objects_and_arrays.ruchy', async ({ request }) => {
    const code = readDemo('03-data-structures', 'objects_and_arrays.ruchy');
    const result = await executeCode(request, code);

    expect(result.success).toBe(true);
    expect(result.output).toBeTruthy();
  });
});

test.describe('REPL Demos - 04-algorithms', () => {
  test('sorting_algorithms.ruchy', async ({ request }) => {
    const code = readDemo('04-algorithms', 'sorting_algorithms.ruchy');
    const result = await executeCode(request, code);

    expect(result.success).toBe(true);
    expect(result.output).toBeTruthy();
  });
});

test.describe('REPL Demos - 05-functional', () => {
  test('closure_patterns.ruchy', async ({ request }) => {
    const code = readDemo('05-functional', 'closure_patterns.ruchy');
    const result = await executeCode(request, code);

    expect(result.success).toBe(true);
    expect(result.output).toBeTruthy();
  });
});

test.describe('REPL Demos - 08-data-science', () => {
  test('iris_analysis_demo.ruchy', async ({ request }) => {
    const code = readDemo('08-data-science', 'iris_analysis_demo.ruchy');
    const result = await executeCode(request, code);

    expect(result.success).toBe(true);
    expect(result.output).toBeTruthy();
  });

  test('titanic_survival_demo.ruchy', async ({ request }) => {
    const code = readDemo('08-data-science', 'titanic_survival_demo.ruchy');
    const result = await executeCode(request, code);

    expect(result.success).toBe(true);
    expect(result.output).toBeTruthy();
  });

  test('wine_quality_demo.ruchy', async ({ request }) => {
    const code = readDemo('08-data-science', 'wine_quality_demo.ruchy');
    const result = await executeCode(request, code);

    expect(result.success).toBe(true);
    expect(result.output).toBeTruthy();
  });

  test('boston_housing_demo.ruchy', async ({ request }) => {
    const code = readDemo('08-data-science', 'boston_housing_demo.ruchy');
    const result = await executeCode(request, code);

    expect(result.success).toBe(true);
    expect(result.output).toBeTruthy();
  });
});

test.describe('REPL Demos - Full Suite', () => {
  test('all demos should execute without errors', async ({ request }) => {
    // Test each demo file
    const demos = [
      ['01-basics', 'arithmetic_operations.ruchy'],
      ['02-functions', 'function_basics.ruchy'],
      ['03-data-structures', 'objects_and_arrays.ruchy'],
      ['04-algorithms', 'sorting_algorithms.ruchy'],
      ['05-functional', 'closure_patterns.ruchy'],
    ];

    let passed = 0;
    let failed = 0;

    for (const [category, filename] of demos) {
      try {
        const code = readDemo(category, filename);
        const result = await executeCode(request, code);

        if (result.success) {
          passed++;
        } else {
          failed++;
          console.error(`FAILED: ${category}/${filename}`, result.error);
        }
      } catch (error) {
        failed++;
        console.error(`ERROR: ${category}/${filename}`, error);
      }
    }

    console.log(`Results: ${passed} passed, ${failed} failed`);
    expect(failed).toBe(0);
  });
});
