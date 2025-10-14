import { test, expect } from '@playwright/test';

/**
 * Smoke Test - Verify notebook server and basic execution
 * Pattern from: ../ruchy/tests/e2e/notebook/00-smoke-test.spec.ts
 *
 * This is the REALITY CHECK test - validates the actual notebook works.
 */

test.describe('Notebook Smoke Test - Reality Check', () => {
  test.beforeEach(async ({ page }) => {
    // Navigate to ACTUAL notebook URL
    await page.goto('http://localhost:8080');

    // Wait for notebook to load
    await page.waitForSelector('#notebook-cells', { timeout: 10000 });
  });

  test('should load actual notebook interface', async ({ page }) => {
    // Verify REAL UI elements exist
    await expect(page.locator('#notebook-cells')).toBeVisible();
    await expect(page.locator('#cell-type-selector')).toBeVisible();
    await expect(page.locator('#btn-add-cell')).toBeVisible();

    // Check for CodeMirror (actual editor)
    await expect(page.locator('.CodeMirror')).toBeVisible();
  });

  test('should execute simple arithmetic', async ({ page }) => {
    // Find the first CodeMirror instance
    const codeMirror = page.locator('.CodeMirror').first();
    await codeMirror.click();

    // Clear existing code and type new code
    await page.keyboard.press('Control+A');
    await page.keyboard.type('2 + 2');

    // Execute with Shift+Enter
    await page.keyboard.press('Shift+Enter');

    // Wait for output to appear
    await page.waitForSelector('.cell-output:visible', { timeout: 5000 });

    // Verify output contains result
    const output = await page.locator('.cell-output').first().textContent();
    expect(output).toContain('4');
  });

  test('should execute via API (backend verification)', async ({ request }) => {
    // Direct API test to prove backend works
    const response = await request.post('http://localhost:8080/api/execute', {
      data: {
        source: '10 * 5'
      }
    });

    const result = await response.json();
    expect(result.success).toBe(true);
    expect(result.output).toBe('50');
  });
});
