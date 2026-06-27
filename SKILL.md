---
name: ai-citation-foundations
description: This skill should be used when the user asks to "make my website AI-friendly", "set up llms.txt", "fix my robots.txt for AI", "help AI cite my site", "get my site into ChatGPT or Perplexity", "AI SEO foundations", or "AI crawler setup". Interviews the user, detects their site's stack, teaches them about AI crawlers, then plans and (on approval) implements the foundational layer — llms.txt, a robots.txt AI-crawler policy, sitemap wiring, canonical and meta tags, and Schema.org JSON-LD. Not for general SEO audits, paid AI content-mirror layers, or backend application code.
metadata:
  version: 0.1.0
---

# AI Citation Foundations

Help the user make their website discoverable and citable by AI systems (ChatGPT, Claude, Perplexity, Gemini, AI Overviews) at a foundational level. Run a guided, gated workflow: orient, educate, interview, audit, plan, implement on approval, verify.

This skill covers the **free, universal foundations** that every site should have. It does not build paid "AI mirror" layers that serve alternate content to bots — that is out of scope.

## How You Work

- **Honest, never hype.** AI discoverability is an immature, shifting field. State plainly what is proven (a correct robots.txt AI policy), what is a cheap-but-unproven signal (llms.txt), and what is experimental (`noai`, `ai.json`). Never promise citations.
- **Stack-adaptive.** Derive every decision from the user's actual repo. Never assume a framework or a file location — detect it.
- **Educate, then let the user choose.** Do not impose a bot policy. Teach the difference between bots, then ask for the user's comfort level.
- **Gated.** Each phase has a gate. Do not advance until it is met. Stop for explicit approval before writing files.
- **Truthful content only.** Build llms.txt and schema from the user's real pages and real facts. Never invent statistics, page titles, or links.

## Workflow

### Phase 0 — Orient and detect the stack

1. Confirm the current working directory is the user's website repository. If unclear, ask for the path.
2. Detect the static-site generator or framework. Read `package.json`, framework config files, and the directory layout.
3. Load `references/stack-detection.md` and map, for this stack: where `robots.txt` and `llms.txt` belong (e.g. `public/`, `static/`, or repo root), how the sitemap is produced (integration/plugin vs manual), and where `<head>` tags and JSON-LD are injected.

> **Gate:** The stack is identified, or explicitly classified as "unknown → treat as a static site served from root."

### Phase 1 — Educate and interview

1. Give a brief, plain-English explanation of AI crawlers using `references/ai-bots-reference.md`: the difference between **retrieval/answer bots** (OAI-SearchBot, ChatGPT-User, PerplexityBot, Claude-User — these fetch pages to build cited answers; blocking them removes the site from that engine's citations) and **training bots** (GPTBot, ClaudeBot, CCBot, Google-Extended, Bytespider — these gather content to train models; allowing or blocking them is a values/business call, not a citation call).
2. Ask a single batched set of questions (do not drip one at a time):
   - Public site URL and organisation/brand name.
   - Primary content type (blog, docs, product, SaaS, portfolio…).
   - The 5–10 pages most worth citing.
   - **Bot comfort level:** welcome all good bots / welcome retrieval but not training / block all AI — present the trade-off of each honestly.
   - Host and CDN (e.g. Netlify, Vercel, Cloudflare) — needed to flag the CDN-override risk later.

> **Gate:** Bot comfort level chosen and site facts captured.

### Phase 2 — Audit the current state

1. Read any existing `robots.txt`, `llms.txt`/`llms-full.txt`, sitemap config, `<head>`/meta, and JSON-LD.
2. Produce a concrete gap list tied to citation impact. Examples: "No `llms.txt`." "`robots.txt` has `Disallow: /` under `User-agent: *` with no AI exceptions — this blocks PerplexityBot and OAI-SearchBot and removes you from their cited answers." "No canonical tags — AI may credit a duplicate URL." "No Article/Organization schema."
3. Compute and present the **AI Foundations Score** — a 0–100% coverage meter — per `references/scoring.md`: render the 10-cell progress bar, the percentage and band label, and a one-line reason. **Record the baseline** for Phase 5. If the baseline is already **100%**, congratulate the user (their foundations are complete), offer only an optional re-verify, and skip the plan/implement phases.

> **Gate:** A specific, prioritised gap list and a baseline AI Foundations Score the user can see.

### Phase 3 — Plan

Present a stack-specific plan covering only the gaps. For each item, state the exact file to add or change and mark it **Proven**, **Low-cost signal**, or **Experimental** (per `references/` guidance). Include: the chosen `robots.txt` pattern, an `llms.txt` drafted from the user's real pages, sitemap wiring for this stack, and applicable supporting signals (canonical, meta description, JSON-LD). Optionally note the score the plan is expected to reach as a motivator (e.g. "this takes you from 40% to ~100%").

> **Gate:** The user explicitly approves before any file is written.

### Phase 4 — Implement (only after approval)

1. Adapt each artifact to the stack: a static file in the right directory, a framework integration/route, or manual instructions for plain HTML.
2. Fill `assets/` templates from the interview answers, replacing every `{{PLACEHOLDER}}`. Use `references/robots-patterns.md` to select the robots template matching the chosen comfort level. Use the correct modern user-agent tokens (e.g. `ClaudeBot`, not the deprecated `anthropic-ai`/`Claude-Web`).
3. Add the `Sitemap:` directive (and optionally `llms-txt:`) to `robots.txt`.
4. Keep `llms.txt` to the spec in `references/llms-txt-spec.md` (single H1, blockquote summary, H2 sections, one-line link descriptions, no images/tables/code, ~3–4KB).

> **Gate:** All approved artifacts written, each containing only true, user-supplied content.

### Phase 5 — Verify and hand off

1. Run the verify script against a local build/preview or the static files to confirm `robots.txt`, `llms.txt`, and the sitemap resolve and parse. It accepts either a directory or a URL, e.g. `bash scripts/verify-foundations.sh ./dist` or `bash scripts/verify-foundations.sh https://example.com` (run it with a `bash` prefix and the skill-relative path; URL mode needs `curl`).
2. Give a short post-deploy checklist:
   - **Confirm the CDN/host is not overriding `robots.txt`** (Cloudflare, CloudFront and others can serve their own).
   - Changes take roughly 24 hours for major crawlers to pick up.
   - robots.txt is advisory — well-behaved crawlers honour it; others may not.
   - Re-run the verify script against the live URL after deploy.
3. Recompute the **AI Foundations Score** and show the movement from the Phase 2 baseline as `before → after` (e.g. `40% → 100%`) with the new band line, per `references/scoring.md`. If it is now 100%, use the celebration copy.

> **Gate:** Verification run, the score movement shown, and the checklist delivered.

## Honesty principle

Hold this line throughout: the **robots.txt AI policy is the load-bearing piece** for citations; **llms.txt is a cheap signal**, useful mainly for IDE agents and human-pasted URLs and not yet auto-fetched by major crawlers; **schema, canonical, and sitemap help discovery and attribution** but are not guaranteed citation levers; **`noai`, `ai.json`, and `.well-known` files are experimental** and not yet honoured at scale. If the user expects a guaranteed ranking or citation bump, correct that expectation.

## Resources

| File | Load when |
|------|-----------|
| `references/stack-detection.md` | Phase 0 — to locate artifacts for the detected stack |
| `references/ai-bots-reference.md` | Phase 1 — the bot education + user-agent reference table |
| `references/robots-patterns.md` | Phase 3–4 — choose and assemble the robots.txt policy |
| `references/llms-txt-spec.md` | Phase 3–4 — exact llms.txt format and caveats |
| `references/schema-and-meta.md` | Phase 3–4 — JSON-LD, canonical, meta, semantic HTML |
| `references/scoring.md` | Phase 2 & 5 — the AI Foundations Score rubric, bands, and bar |
| `assets/` | Phase 4 — templates to fill (`{{PLACEHOLDER}}` markers) |
| `scripts/verify-foundations.sh` | Phase 5 — confirm artifacts resolve and parse |

## Error handling

- **Not a website repo** (no front-end, only backend/app code): say so and stop — this skill is for websites.
- **Stack not recognised:** fall back to the static-site path — files at repo root or the obvious public directory, manual sitemap guidance.
- **robots.txt is generated, not static** (some frameworks build it): edit the generator/source, not the build output, and note that.
- **CDN may override:** if the host is Cloudflare/Vercel/Netlify, flag the override risk explicitly in Phase 5.
- **User wants the paid AI-mirror layer / serving alternate content to bots:** out of scope; point them to standard practices and stop short of building it.

## Examples

### Example 1 — Astro blog, "help AI cite my site"

Phase 0 detects Astro from `package.json` and routes static artifacts to `public/`. Phase 1 explains retrieval vs training bots; the user picks "welcome retrieval, decide on training" and chooses to allow training too. Phase 2 finds an existing `public/robots.txt` with `User-agent: *` / `Allow: /` but no named AI bots and no sitemap directive, and no `llms.txt`. Phase 3 proposes: a named-bot `robots.txt` (retrieval allowed, training allowed) with `Sitemap:` and `llms-txt:` directives, an `llms.txt` built from the user's 8 best posts, and confirmation that `@astrojs/sitemap` already covers the sitemap. After approval, Phase 4 writes `public/robots.txt` and `public/llms.txt`. Phase 5 runs the verify script and warns to confirm Netlify isn't overriding `robots.txt`.

### Example 2 — Plain static HTML site, "set up llms.txt and fix robots for AI"

Phase 0 finds no framework and treats the repo as a static site served from root. Phase 1 user picks "welcome retrieval, block training." Phase 2 finds no `robots.txt`, no `llms.txt`, no sitemap, and pages missing canonical tags. Phase 3 proposes root-level `robots.txt` (retrieval bots allowed, training bots disallowed), a hand-built `llms.txt`, a manual `sitemap.xml` with `lastmod`, and `<link rel="canonical">` plus a meta description per page. After approval Phase 4 writes the files and shows the per-page `<head>` snippet to paste. Phase 5 verifies the files resolve locally and reminds the user that robots.txt is advisory.

### Example 3 — Wrong request, should defer

User asks "build me an AI mirror that serves different content to bots." Recognise this as the out-of-scope paid mirror pattern: explain the skill covers only standard, transparent foundations (no cloaking), deliver those if wanted, and stop short of building a bot-specific content layer.
