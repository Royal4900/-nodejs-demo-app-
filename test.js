const assert = require('assert');

// Simple test suite
function runTests() {
  console.log('Running tests...');
  
  let passed = 0;
  let failed = 0;

  // Test 1: Basic assertion
  try {
    assert.strictEqual(1 + 1, 2, 'Basic math should work');
    console.log('✓ Test 1 passed: Basic math');
    passed++;
  } catch (error) {
    console.error('✗ Test 1 failed:', error.message);
    failed++;
  }

  // Test 2: String assertion
  try {
    const message = 'Hello, World!';
    assert.strictEqual(typeof message, 'string', 'Message should be a string');
    console.log('✓ Test 2 passed: String type check');
    passed++;
  } catch (error) {
    console.error('✗ Test 2 failed:', error.message);
    failed++;
  }

  // Test 3: Array assertion
  try {
    const arr = [1, 2, 3];
    assert.strictEqual(arr.length, 3, 'Array should have 3 elements');
    console.log('✓ Test 3 passed: Array length check');
    passed++;
  } catch (error) {
    console.error('✗ Test 3 failed:', error.message);
    failed++;
  }

  // Test 4: Object assertion
  try {
    const obj = { name: 'Demo App', version: '1.0.0' };
    assert.strictEqual(obj.name, 'Demo App', 'Object should have correct name');
    console.log('✓ Test 4 passed: Object property check');
    passed++;
  } catch (error) {
    console.error('✗ Test 4 failed:', error.message);
    failed++;
  }

  // Summary
  console.log('\n=== Test Summary ===');
  console.log(`Passed: ${passed}`);
  console.log(`Failed: ${failed}`);
  console.log(`Total: ${passed + failed}`);

  if (failed > 0) {
    process.exit(1);
  } else {
    console.log('\n✅ All tests passed!');
    process.exit(0);
  }
}

runTests();

