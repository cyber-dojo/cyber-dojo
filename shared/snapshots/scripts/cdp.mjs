// Minimal Chrome DevTools Protocol driver for a headless Chrome listening on :9222.
import { writeFileSync } from 'node:fs';

const BASE = 'http://127.0.0.1:9222';

/** Opens a new page at url, sized width x height CSS px at the given device scale; returns a page handle. */
export async function openPage(url, { width = 1512, height = 830, scale = 2 } = {}) {
  const target = await fetch(`${BASE}/json/new?about:blank`, { method: 'PUT' }).then(r => r.json());
  const ws = new WebSocket(target.webSocketDebuggerUrl);
  await new Promise((resolve, reject) => { ws.onopen = resolve; ws.onerror = reject; });
  let nextId = 1;
  const pending = new Map();
  const listeners = [];
  ws.onmessage = (msg) => {
    const data = JSON.parse(msg.data);
    if (data.id && pending.has(data.id)) {
      const { resolve, reject } = pending.get(data.id);
      pending.delete(data.id);
      data.error ? reject(new Error(JSON.stringify(data.error))) : resolve(data.result);
    } else if (data.method) {
      listeners.forEach(l => l(data));
    }
  };
  /** Sends one CDP command and resolves with its result. */
  const send = (method, params = {}) => new Promise((resolve, reject) => {
    const id = nextId++;
    pending.set(id, { resolve, reject });
    ws.send(JSON.stringify({ id, method, params }));
  });
  /** Resolves when the next event named method arrives. */
  const once = (method) => new Promise(resolve => {
    const l = (d) => { if (d.method === method) { listeners.splice(listeners.indexOf(l), 1); resolve(d.params); } };
    listeners.push(l);
  });
  await send('Page.enable');
  await send('Runtime.enable');
  await send('Emulation.setDeviceMetricsOverride', { width, height, deviceScaleFactor: scale, mobile: false });

  const page = {
    send,
    /** Navigates and resolves once the load event fires. */
    async goto(u) { const loaded = once('Page.loadEventFired'); await send('Page.navigate', { url: u }); await loaded; },
    /** Evaluates an expression (awaiting promises) and returns its JSON value. */
    async eval(expression) {
      const r = await send('Runtime.evaluate', { expression, awaitPromise: true, returnByValue: true });
      if (r.exceptionDetails) throw new Error(r.exceptionDetails.exception?.description || r.exceptionDetails.text);
      return r.result.value;
    },
    /** Saves a PNG of the viewport to path. */
    async shot(path) {
      const { data } = await send('Page.captureScreenshot', { format: 'png' });
      writeFileSync(path, Buffer.from(data, 'base64'));
    },
    /** Sleeps for ms milliseconds. */
    sleep: (ms) => new Promise(r => setTimeout(r, ms)),
    /** Closes the page's target. */
    async close() { await fetch(`${BASE}/json/close/${target.id}`); ws.close(); },
  };
  await page.goto(url);
  return page;
}
