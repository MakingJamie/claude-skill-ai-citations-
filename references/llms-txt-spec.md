# llms.txt — exact format and an honest read on what it's worth

Use in **Phase 3–4** to draft the file. Use the caveats below in Phase 1/3 so the user has accurate expectations.

## What it is

`llms.txt` is a community convention (proposed by Jeremy Howard / Answer.AI, Sept 2024; informal spec at llmstxt.org). It is a single Markdown file at the **site root** (`{{SITE_URL}}/llms.txt`) giving an AI a curated map of the site's most useful pages, each with a one-line description. It is **not** an IETF/W3C standard.

## Exact format

```markdown
# {{SITE_NAME}}

> One to three sentences: what this site is, who it serves, and what an AI can
> accomplish by reading these resources.

## Section name

- [Page title]({{SITE_URL}}/path): one sentence on what this page answers.
- [Another page]({{SITE_URL}}/path-2): one sentence on what it covers.

## Another section

- [Page title]({{SITE_URL}}/path-3): one sentence description.
```

Rules:
- Exactly **one H1** at the top — the site/brand name.
- An optional **blockquote** summary directly under it (2–3 sentences max).
- **H2** sections group related links by topic.
- Each link is a Markdown link **plus a one-sentence description** after a colon.
- **No** images, HTML, tables, code blocks, nested headings, or multiple H1s.
- Keep it lean — aim **~3–4 KB**. It is a map, not the territory.
- Use **absolute URLs** and only **real pages** supplied by the user. Never invent links or descriptions.

## `llms.txt` vs `llms-full.txt`

- **`llms.txt`** — the navigation map above. Default deliverable.
- **`llms-full.txt`** — the full Markdown-ified text of key pages concatenated into one file, so an agent needs no further fetches. Useful for **documentation** sites; heavier to produce and keep fresh. Treat as an **optional** Phase-4 extra: offer it, do not default to it, and only build it if the stack makes generation cheap and the user wants it.

## Honest adoption reality (say this plainly)

- Adoption is niche: studies put `llms.txt` on roughly **10% of sites**, and a large majority of existing files **get essentially zero reads**.
- **Major training/retrieval crawlers do not routinely auto-fetch `/llms.txt`** unprompted. There is **no demonstrated citation lift** from merely having one.
- Where it **does** help today: **IDE/coding agents** (Cursor, Continue, Copilot, Aider) pointed at docs; **developer doc platforms** (Mintlify, GitBook) that consume it; and **human-pasted URLs**, where a model may fetch it for cleaner context.

**Bottom line for the user:** `llms.txt` is a near-zero-cost, tidy signal of AI-awareness and a genuine help for agent/doc use cases. Add it — but do not present it as a citation guarantee. The load-bearing foundation for citations is the `robots.txt` retrieval policy plus good, crawlable content.

## Templates

- `assets/llms.txt.template` — the skeleton with `{{PLACEHOLDER}}` markers to fill.
- `assets/llms.txt.example` — a complete, realistic example (a fictional pottery studio) to match for tone, length, and the one-sentence-description style. Use it as the quality bar; do not copy its content.

## Drafting checklist

- [ ] H1 is the brand/site name.
- [ ] Blockquote summary present, ≤3 sentences, accurate.
- [ ] 2–6 H2 sections grouping the user's 5–10 best pages.
- [ ] Every link is a real URL with a true one-line description.
- [ ] No images/tables/code/HTML; file ≈3–4 KB.
- [ ] Saved at the stack's web root (see `references/stack-detection.md`).
- [ ] `llms-txt:` directive added to `robots.txt` (see `references/robots-patterns.md`).
