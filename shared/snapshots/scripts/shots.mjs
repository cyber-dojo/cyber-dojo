// Captures one README screenshot from the local stack at Retina resolution.
// Usage: node shots.mjs edit|review <kata_id> <out.png>
//        node shots.mjs dashboard <group_id> <out.png>
//        node shots.mjs creator - <out.png>
// Zoom z on a 1512px-wide 2x screen is emulated as width 1512/z at device scale 2z.
import { openPage } from './cdp.mjs';

const [which, id, out] = process.argv.slice(2);

/** Opens url as seen at zoom z on a 1512x830 Retina viewport. */
const open = (url, z) => openPage(url, { width: Math.round(1512 / z), height: Math.round(830 / z), scale: 2 * z });

let page;
if (which === 'creator') {
  page = await open('http://localhost/creator/setup?type=group', 0.8);
  await page.sleep(1500);
  // Choose the dashboard shot's cluster; the exercise goes last so the preview shows its instructions.
  const click = (list, name) => page.eval(`$('.${list} .display-name').filter((_, e) => $(e).text().trim() === '${name}').click()`);
  for (const [language, framework] of [['C++ (g++)', 'GoogleTest'], ['Python', 'pytest'], ['JavaScript', 'Jasmine']]) {
    await click('languages', language);
    await page.sleep(300);
    await click('frameworks', framework);
    await page.sleep(300);
  }
  await click('exercises', 'Print Diamond');
} else if (which === 'edit') {
  page = await open(`http://localhost/kata/edit/${id}`, 1.0);
  await page.sleep(1500);
  // predict is a saved kata option, so only tick it when it is not already on.
  await page.eval(`$('#predict-checkbox').is(':checked') || $('#predict-checkbox-title').click()`);
  await page.eval(`cd.kata.filenames.select('hiker.cpp')`);
  await page.sleep(2500);
} else if (which === 'review') {
  page = await open(`http://localhost/review/show/${id}`, 0.9);
  await page.sleep(2500);
} else if (which === 'dashboard') {
  page = await open(`http://localhost/dashboard/show/${id}`, 1.0);
  await page.sleep(2500);
  await page.eval(`$('#auto-refresh-checkbox').is(':checked') && $('#auto-refresh-checkbox').click()`);
  // The grid opens scrolled to its latest minute; scroll back to the session's start.
  await page.eval(`document.querySelectorAll('*').forEach(e => { if (e.scrollWidth > e.clientWidth) e.scrollLeft = 0; }); window.scrollTo(0, 0)`);
}
await page.sleep(800);
await page.shot(out);
await page.close();
console.log('saved', out);
