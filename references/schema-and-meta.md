# Supporting signals — schema, canonical, meta, semantic HTML

Use in **Phase 3–4** for the page-level foundations beyond robots.txt and llms.txt. These help **discovery and correct attribution**. Label them honestly: useful, widely-recommended, but **not** a guaranteed citation lever — OpenAI/Anthropic don't publicly rank on them, though Google and several RAG pipelines do read them.

## 1. Schema.org JSON-LD (Proven-useful for attribution)

Machine-readable entity markup in a `<script type="application/ld+json">` block in `<head>`. Helps AI and search extract author, publisher, dates, and entity relationships — reducing wrong attribution and hallucinated metadata.

Minimum worth adding:
- **Organization** — once, site-wide (name, url, logo, social `sameAs`). Establishes the publisher entity.
- **Article / BlogPosting** — on each content page (headline, author, datePublished, dateModified, publisher, description).

Bundle related entities with `@graph`. Templates: `assets/schema/organization.jsonld`, `assets/schema/article.jsonld`. Fill placeholders from real page data; never fabricate authors or dates.

Other types to add only where they genuinely apply: `FAQPage` (real Q&A on the page), `HowTo` (real step lists), `BreadcrumbList` (real nav hierarchy), `Product`, `Event`. Do not add schema for content that isn't actually on the page — that's structured-data spam and can be penalised.

## 2. Canonical URLs (Proven, do this)

Add `<link rel="canonical" href="{{ABSOLUTE_URL}}">` to every page's `<head>`. It tells crawlers which URL is authoritative when duplicates exist (trailing slash, query params, syndication), so AI and search credit **one** source instead of splitting signals. Use the absolute, preferred form and be consistent with trailing-slash policy.

## 3. Meta description (Proven, do this)

`<meta name="description" content="...">` — a concise, accurate ~150–160-char summary per page. Used as a snippet hint by search and surfaced in some AI results. One per page, unique, no keyword stuffing.

## 4. Semantic HTML (Proven, low effort)

Use real structural elements — `<main>`, `<article>`, `<header>`, `<nav>`, `<footer>`, one `<h1>` then ordered `<h2>`/`<h3>`. Clean structure makes content easier for crawlers and extractors to parse into clean, quotable text. Avoid burying body text in `<div>` soup or rendering it only via client-side JS that crawlers may not execute.

## 5. Emerging / experimental signals (Label clearly, don't oversell)

Mention these as optional and **unproven**; only add if the user specifically wants them:
- **`<meta name="robots" content="noai, noimageai">`** — a voluntary opt-out-of-training signal (origin: DeviantArt). Honoured by some, not a standard, not enforceable.
- **`/ai.txt` and `/ai.json`** — proposed machine-readable AI-usage/licensing policy files. Not yet consumed at scale.
- **C2PA / content provenance, TDM reservations** — emerging, relevant to copyright/EU-AI-Act opt-outs; mostly for media and legal posture, not citations.

Do **not** present any item in section 5 as having a measurable effect today.

## Where these go (per stack)

`<head>` injection point and canonical handling differ by framework — see `references/stack-detection.md`. For component-based stacks (Astro/Next/Nuxt/SvelteKit), add JSON-LD and meta in the shared head/layout component. For plain HTML, provide a copy-paste `<head>` snippet per page. Many frameworks emit canonical/meta via existing SEO plugins — detect and reuse rather than duplicating.

## Priority order (state in Phase 3)

1. **robots.txt retrieval policy** — the load-bearing item (covered in `references/robots-patterns.md`).
2. **sitemap.xml with `lastmod`** + the `Sitemap:` directive.
3. **canonical + meta description + semantic HTML** — cheap, proven hygiene.
4. **Organization + Article JSON-LD** — proven for attribution.
5. **llms.txt** — cheap signal, unproven for citations.
6. **Experimental signals** — only on request.
