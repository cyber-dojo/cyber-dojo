// Captures the local home page as if viewed at 80% zoom on a 1512px-wide Retina screen.
// Usage: node shot_home.mjs <out.png>
import { openPage } from './cdp.mjs';

const out = process.argv[2];
const page = await openPage('http://localhost/creator/home', { width: 1890, height: 1040, scale: 1.6 });
await page.sleep(1500);
// The local stack reports hostname 'staging', which adds a red beta banner production never shows.
await page.eval(`document.querySelectorAll('.edged-panel.questions[style*="red"]').forEach(e => e.remove())`);
await page.sleep(300);
await page.shot(out);
await page.close();
console.log('saved', out);
