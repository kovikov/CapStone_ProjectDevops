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

test('GET / returns backend ready message', async () => {
  const res = await fetch(`${baseUrl}/`);
  assert.strictEqual(res.status, 200);
  const body = await res.json();
  assert.strictEqual(body.message, 'Zuri Market Backend API is running');
});

test('GET /api/products returns products array', async () => {
  const res = await fetch(`${baseUrl}/api/products`);
  assert.strictEqual(res.status, 200);
  const body = await res.json();
  assert.ok(Array.isArray(body));
  assert.ok(body.length > 0);
});

test('GET /api/config returns store name', async () => {
  const res = await fetch(`${baseUrl}/api/config`);
  assert.strictEqual(res.status, 200);
  const body = await res.json();
  assert.strictEqual(body.storeName, 'Zuri Market');
});
