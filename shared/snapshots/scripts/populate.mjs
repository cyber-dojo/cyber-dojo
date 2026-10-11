// Gives avatars in a C++ GoogleTest group a run of Print Diamond traffic-lights.
// Each arg is a pattern of G/R/A/E letters (joins a new avatar) or <kata_id>=<pattern> (reuses a kata).
// G is green, R is red (a wrong E-size assert), A is amber (that assert missing its ");"),
// E is green with a whole TEST(Diamond, E) added, which gives the review page a good diff.
// Usage: node populate.mjs <group_id> GRRG RAGE <kata_id>=RAG ...
import { openPage } from './cdp.mjs';

const [groupId, ...specs] = process.argv.slice(2);

const HPP = `#ifndef HIKER_INCLUDED
#define HIKER_INCLUDED

#include <string>
#include <vector>

std::vector<std::string> diamond(char widest);

#endif
`;

const CPP = `#include "hiker.hpp"
#include <cstdlib>

std::vector<std::string> diamond(char widest)
{
    const int size = widest - 'A';
    std::vector<std::string> lines;
    for (int row = 0; row <= 2 * size; ++row)
    {
        const int indent = std::abs(size - row);
        const char letter = static_cast<char>('A' + size - indent);
        std::string line(2 * size + 1, ' ');
        line[indent] = letter;
        line[2 * size - indent] = letter;
        lines.push_back(line);
    }
    return lines;
}
`;

const TESTS = `#include "hiker.hpp"
#include <gtest/gtest.h>

using namespace ::testing;

TEST(Diamond, A)
{
    std::vector<std::string> expected{
        "A"
    };
    ASSERT_EQ(expected, diamond('A'));
}

TEST(Diamond, C)
{
    std::vector<std::string> expected{
        "  A  ",
        " B B ",
        "C   C",
        " B B ",
        "  A  "
    };
    ASSERT_EQ(expected, diamond('C'));
}

TEST(Diamond, D)
{
    std::vector<std::string> expected{
        "   A   ",
        "  B B  ",
        " C   C ",
        "D     D",
        " C   C ",
        "  B B  ",
        "   A   "
    };
    ASSERT_EQ(expected, diamond('D'));
}
`;

const E_TEST = `
TEST(Diamond, E)
{
    std::vector<std::string> expected{
        "    A    ",
        "   B B   ",
        "  C   C  ",
        " D     D ",
        "E       E",
        " D     D ",
        "  C   C  ",
        "   B B   ",
        "    A    "
    };
    ASSERT_EQ(expected, diamond('E'));
}
`;

/** Joins the group as a new avatar and returns the new kata id. */
async function join() {
  let r, text;
  // nginx limits /creator/enter to 1r/m, so a 429 means wait for the next token.
  for (let attempt = 0; attempt < 6; attempt++) {
    r = await fetch('http://localhost/creator/enter.json', {
      method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ id: groupId }),
    });
    text = await r.text();
    if (r.status !== 429) break;
    await new Promise(res => setTimeout(res, 65000));
  }
  if (r.status !== 200) throw new Error(`join failed: HTTP ${r.status} ${text.slice(0, 200)}`);
  const body = JSON.parse(text);
  if (!body.id) throw new Error('join failed: ' + text);
  return body.id;
}

// Runs inside the edit page: writes the diamond files once, then defines window.__run(c)
// which sets the tests file to a G/R/A/E variant, presses [test], and resolves
// once a new light lands.
const SETUP = `(() => {
  const cm = n => document.getElementById('file_content_for_' + n).nextElementSibling.CodeMirror;
  cm('hiker.hpp').setValue(${JSON.stringify(HPP)});
  cm('hiker.cpp').setValue(${JSON.stringify(CPP)});
  const tests = ${JSON.stringify(TESTS)};
  const unfinished = '\\nTEST(Diamond, E)\\n{\\n    ASSERT_EQ(5u, diamond(\\'E\\').size()';
  const eTest = ${JSON.stringify(E_TEST)};
  const v = { G: tests, R: tests + unfinished + ');\\n}\\n', A: tests + unfinished + '\\n}\\n', E: tests + eTest };
  const total = () => Array.from(document.querySelectorAll('div.count')).slice(5, 8)
    .reduce((a, e) => a + (+e.textContent.trim() || 0), 0);
  window.__run = async (c) => {
    const before = total();
    cm('hiker.tests.cpp').setValue(v[c]);
    document.getElementById('test-button').click();
    for (let i = 0; i < 300; i++) {
      await new Promise(r => setTimeout(r, 200));
      if (total() > before) return 'ok';
    }
    return 'timeout';
  };
  return 'ready';
})()`;

const RAG = `Array.from(document.querySelectorAll('div.count')).slice(5, 8).map(e => e.textContent.trim()).join('/')`;

for (const spec of specs) {
  const [kataId, pattern] = spec.includes('=') ? spec.split('=') : [await join(), spec];
  const page = await openPage(`http://localhost/kata/edit/${kataId}`);
  await page.sleep(1000);
  await page.eval(SETUP);
  let log = '';
  for (const c of pattern) {
    let res = await page.eval(`window.__run('${c}')`);
    if (res !== 'ok') {
      // A run on a not-yet-pulled image hits 'still preparing'; close dialogs and retry once.
      await page.eval(`document.querySelectorAll('button').forEach(b => { if (/^close$/i.test(b.textContent.trim())) b.click(); })`);
      await page.sleep(30000);
      res = await page.eval(`window.__run('${c}')`);
    }
    log += res === 'ok' ? c : '!';
    if (res !== 'ok') break;
    await page.sleep(300);
  }
  console.log(kataId, pattern, '->', log, 'rag', await page.eval(RAG));
  await page.close();
}
