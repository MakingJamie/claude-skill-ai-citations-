# robots.txt patterns for AI crawlers

Use in **Phase 3–4** to assemble the policy. Pick the template that matches the comfort level chosen in Phase 1, fill placeholders, and place it per `references/stack-detection.md`.

## How robots.txt matching actually works (get this right)

A crawler obeys **only the single most specific `User-agent` group that matches its token** — groups do **not** stack. So to control `GPTBot` you must give it its **own** `User-agent: GPTBot` block; a rule under `User-agent: *` is ignored by any bot that has its own named block. Practical consequences:

- To **block** a bot: give it a named block with `Disallow: /`.
- To **allow** a bot explicitly: give it a named block with `Allow: /` (or no `Disallow`).
- `User-agent: *` is the catch-all for every bot **without** its own named block (regular search engines, humans-via-tools, unknown bots).
- Within a bot's block, more specific paths can be allowed/disallowed: `Disallow: /admin/`, `Allow: /blog/`.
- Tokens are matched case-insensitively by most crawlers, but match the documented casing to be safe.

## Always include these site-level directives

Independent of any user-agent, add (once, conventionally at top or bottom):

```
Sitemap: {{SITE_URL}}/sitemap.xml
llms-txt: {{SITE_URL}}/llms.txt
```

`Sitemap:` is a long-standing, widely-honoured directive. `llms-txt:` is a community convention (low cost, not universally consumed) — include it as a discovery hint, not a guarantee.

## The three templates

- `assets/robots-welcome-all.txt` — allow retrieval **and** training bots.
- `assets/robots-retrieval-only.txt` — allow retrieval bots, disallow training bots.
- `assets/robots-block-all-ai.txt` — disallow all AI bots, keep normal search.

Each lists bots by name (so the per-bot matching rule above works) and ends with a permissive `User-agent: *` block for normal search and human tools. Replace `{{SITE_URL}}` with the production origin (e.g. `https://example.com`, no trailing slash).

## Common mistakes to catch

- **Blocking the citation channel by accident.** A blanket `User-agent: *` `Disallow: /` (or a CMS default) silently blocks `OAI-SearchBot`, `PerplexityBot`, `Claude-User` and removes the site from those engines' answers. Always check the existing file in Phase 2.
- **Blocking `Googlebot` to "block AI."** That destroys normal search. Use `Google-Extended` for AI/Gemini control instead.
- **Using deprecated tokens.** `anthropic-ai` / `Claude-Web` are legacy — prefer `ClaudeBot` and the `Claude-SearchBot` / `Claude-User` pair.
- **Editing build output instead of source.** If the stack *generates* `robots.txt` (some Next/Astro setups), edit the generator, not the built file — see `references/stack-detection.md`.
- **Trusting robots.txt as security.** It is advisory. Do not "Disallow" a path expecting it to be hidden — sensitive paths need auth, not robots.txt.

## CDN / host override warning (state in Phase 5)

A CDN or host can serve its **own** `robots.txt` ahead of the repo's file:

- **Cloudflare** can inject managed `robots.txt` rules and offers AI Crawl Control / managed robots — verify the dashboard matches the file.
- **Vercel / Netlify** edge rules or redirects can shadow `/robots.txt`.
- After deploy, fetch the live file (`curl https://{{SITE_URL}}/robots.txt`) and confirm it matches what was committed.

Changes take roughly **24 hours** for major crawlers to re-read.

## Stronger enforcement (mention only if the user wants real blocking)

robots.txt states a preference. To actually *enforce* a block, suggest (do not implement unless asked) edge/WAF rules by user-agent or IP, or a managed control like Cloudflare AI Crawl Control. Keep this out of scope unless the user explicitly asks — the skill's job is the foundational, transparent layer.
