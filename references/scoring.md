# AI Foundations Score

A light, honest 0–100% coverage score, shown once during the audit (Phase 2) as a
baseline and again at hand-off (Phase 5) so the user sees how far the work moved them.

Keep it minimal and never gamify at the expense of honesty. The weights mirror the
rest of the skill: the `robots.txt` AI policy is load-bearing; `llms.txt` is a low-cost
signal. The score measures whether the foundations **exist and are correct** — it is a
coverage meter, **not** a promise of rankings or citations. Say so if the user reads it
that way.

## Rubric (weights sum to 100)

Score by what is actually present and correct in the repo or live site. Partial credit is
fine (e.g. canonical tags on some pages → half). Round the final total to the nearest 5%.

| Foundation | Points | Counts as done when… |
|---|---:|---|
| `robots.txt` AI-crawler policy | 30 | `robots.txt` exists and makes an intentional choice about AI **retrieval** bots — names them, or a deliberate allow-all — rather than a default that silently blocks them |
| `sitemap.xml` + `Sitemap:` directive | 20 | a sitemap exists with `lastmod`, and `robots.txt` declares it |
| Canonical URLs | 15 | pages carry a self-referential `rel="canonical"` link |
| Meta descriptions | 10 | content pages have unique meta descriptions |
| Schema.org JSON-LD | 15 | Organization sitewide **and** Article on content pages |
| `llms.txt` | 10 | a spec-valid `llms.txt` at the web root |

## Bands, labels and copy

Pick the band for the score; use its label and line.

| Score | Label | Line |
|---|---|---|
| 100% | Fully optimised 🎉 | "Well done — your site's AI foundations are fully in place. You don't need to do anything." |
| 80–99% | Strong ✨ | "Strong foundations. Just a couple of quick wins left." |
| 50–79% | Solid start 🧭 | "A solid start, with a few meaningful gaps worth closing." |
| 20–49% | Early days 🌱 | "Early days — there's real opportunity here, and it's quick to capture." |
| 1–19% | Almost blank ⬜ | "Almost a blank canvas. A few foundational files will go a long way." |
| 0% | Blank canvas ⬜ | "Nothing in place yet — the perfect time to set the foundations right." |

## Progress bar

Render a simple 10-cell bar, one filled cell per 10% (round the score to the nearest 10%
for the bar), then show the exact nearest-5% number:

```
[██████░░░░] 60%
```

## How to present it

- **Phase 2 (baseline):** show the bar, the % and band label, then a one-line reason
  naming what's already done and what's missing (e.g. "robots.txt and sitemap are solid;
  no llms.txt or schema yet"). **Record the baseline number** for Phase 5.
- **If the baseline is already 100%:** use the celebration line, confirm there's nothing
  to implement, and offer only an optional re-verify. Do **not** invent work to do.
- **Phase 3 (optional motivator):** the plan may note the score it's expected to reach,
  e.g. "this plan takes you from 40% to ~100%."
- **Phase 5 (after the work):** recompute and show the movement from the baseline as
  `before → after` (e.g. `40% → 100%`) with the new band line. If it's now 100%, use the
  celebration copy.

## Honesty guardrail

If the user treats the percentage as a guarantee, correct it: it reflects how much of the
foundational layer is in place, not whether any AI engine will cite them.
