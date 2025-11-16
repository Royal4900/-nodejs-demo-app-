const assert = require('assert');
const http = require('http');

// Import the app
const app = require('./app');

// Test suite
function runTests() {
  console.log('Running tests...\n');
  
  let passed = 0;
  let failed = 0;
  let server;

  // Start test server and wait for it to be ready
  server = app.listen(0, () => {
    // Server is now ready, start running tests
    runTest1();
  });

  // Helper function to make HTTP requests
  function makeRequest(path, callback) {
    const port = server.address().port;
    const options = {
      hostname: 'localhost',
      port: port,
      path: path,
      method: 'GET'
    };

    const req = http.request(options, (res) => {
      let data = '';
      res.on('data', (chunk) => {
        data += chunk;
      });
      res.on('end', () => {
        try {
          const json = JSON.parse(data);
          callback(null, res.statusCode, json);
        } catch (e) {
          callback(null, res.statusCode, data);
        }
      });
    });

    req.on('error', (error) => {
      callback(error, null, null);
    });

    req.setTimeout(5000, () => {
      req.destroy();
      callback(new Error('Request timeout'), null, null);
    });

    req.end();
  }

  // Test 1: Root endpoint
  function runTest1() {
    makeRequest('/', (error, statusCode, data) => {
      if (error) {
        console.error('✗ Test 1 failed:', error.message);
        failed++;
        runTest2();
        return;
      }
      try {
        assert.strictEqual(statusCode, 200, 'Root endpoint should return 200');
        assert.strictEqual(data.message, 'Welcome to Node.js Demo App', 'Should have correct message');
        assert.strictEqual(data.version, '1.0.0', 'Should have correct version');
        assert.strictEqual(data.status, 'running', 'Should have running status');
        console.log('✓ Test 1 passed: Root endpoint');
        passed++;
      } catch (err) {
        console.error('✗ Test 1 failed:', err.message);
        failed++;
      }
      runTest2();
    });
  }

  // Test 2: Health endpoint
  function runTest2() {
    makeRequest('/health', (error, statusCode, data) => {
      if (error) {
        console.error('✗ Test 2 failed:', error.message);
        failed++;
        runTest3();
        return;
      }
      try {
        assert.strictEqual(statusCode, 200, 'Health endpoint should return 200');
        assert.strictEqual(data.status, 'healthy', 'Should have healthy status');
        assert(typeof data.uptime === 'number', 'Uptime should be a number');
        console.log('✓ Test 2 passed: Health endpoint');
        passed++;
      } catch (err) {
        console.error('✗ Test 2 failed:', err.message);
        failed++;
      }
      runTest3();
    });
  }

  // Test 3: API info endpoint
  function runTest3() {
    makeRequest('/api/info', (error, statusCode, data) => {
      if (error) {
        console.error('✗ Test 3 failed:', error.message);
        failed++;
        runTest4();
        return;
      }
      try {
        assert.strictEqual(statusCode, 200, 'API info endpoint should return 200');
        assert.strictEqual(data.app, 'nodejs-demo-app', 'Should have correct app name');
        assert(typeof data.environment === 'string', 'Environment should be a string');
        assert(typeof data.nodeVersion === 'string', 'Node version should be a string');
        console.log('✓ Test 3 passed: API info endpoint');
        passed++;
      } catch (err) {
        console.error('✗ Test 3 failed:', err.message);
        failed++;
      }
      runTest4();
    });
  }

  // Test 4: 404 endpoint
  function runTest4() {
    makeRequest('/nonexistent', (error, statusCode, data) => {
      if (error) {
        console.error('✗ Test 4 failed:', error.message);
        failed++;
        finishTests();
        return;
      }
      try {
        assert.strictEqual(statusCode, 404, 'Nonexistent endpoint should return 404');
        console.log('✓ Test 4 passed: 404 handling');
        passed++;
      } catch (err) {
        console.error('✗ Test 4 failed:', err.message);
        failed++;
      }
      finishTests();
    });
  }

  // Finish tests and close server
  function finishTests() {
    server.close(() => {
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
    });
  }
}

// Run tests
runTests();

