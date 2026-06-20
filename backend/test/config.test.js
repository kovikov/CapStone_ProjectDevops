import assert from 'node:assert';
import http from 'node:http';
import { before, after, test } from 'node:test';
import app from '../src/server.js';

const server = http.createServer(app);

before(async () => {
  await new Promise((resolve) => server.listen(0, resolve));
});

after(async () => {
  await new Promise((resolve) => server.close(resolve));
});

const baseUrl = `http://localhost:${server.address().port}`;

test('GET /api/config uses STORE_NAME env variable when set', async () => {
  const originalStoreName = process.env.STORE_NAME;
  process.env.STORE_NAME = 'Test Store';

  try {
    const res = await fetch(`${baseUrl}/api/config`);
    assert.strictEqual(res.status, 200);
    const body = await res.json();
    assert.strictEqual(body.storeName, 'Test Store');
  } finally {
    if (originalStoreName === undefined) {
      delete process.env.STORE_NAME;
    } else {
      process.env.STORE_NAME = originalStoreName;
    }
  }
});
