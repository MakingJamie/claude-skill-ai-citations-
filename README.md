# AI Citation Foundations

**Make your website easy for AI to find, quote, and cite — a free Claude Code skill that sets up `llms.txt`, your `robots.txt` AI-crawler policy, sitemaps, and Schema.org structured data.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Claude Code Skill](https://img.shields.io/badge/Claude_Code-Skill-da7756)
![Status: honest, no hype](https://img.shields.io/badge/approach-honest%2C_no_hype-success)

This is the foundational layer of **AI SEO** — also called **GEO** (Generative Engine Optimization) or **AEO** (Answer Engine Optimization): the standard, transparent signals that help AI systems like **ChatGPT, Claude, Perplexity, Gemini, and Google AI Overviews** discover, understand, and correctly attribute your pages.

Point it at your website repo and it will:

1. **Detect your stack** (Astro, Next, Nuxt, SvelteKit, Hugo, Jekyll, WordPress, plain HTML…).
2. **Teach you** the difference between AI bots that *cite you* and AI bots that *train on you* — then let you choose your own comfort level.
3. **Audit & score** what you already have — an honest 0–100% *AI Foundations Score* — and show the real gaps.
4. **Plan**, then (only with your approval) **implement** the foundations: a correct `robots.txt` AI-crawler policy, an `llms.txt`, sitemap wiring, canonical + meta tags, and Schema.org structured data.
5. **Verify** the artifacts resolve and parse, show how far your score moved, and hand you a short post-deploy checklist.

It is deliberately **honest**: it won't promise citations, and it tells you which signals are proven versus merely nice-to-have. It covers only the **standard, transparent** foundations — no cloaking, no serving different content to bots.

## Install

New to Claude Code skills? See the [skills documentation](https://code.claude.com/docs/en/skills) — in short, a skill is a folder with a `SKILL.md` that Claude loads automatically when it's relevant.

This is a standalone skill folder. Clone it into your Claude Code skills directory.
The clone **target folder must be `ai-citation-foundations`** (it must match the skill's
`name`), even though the repo is named `claude-skill-ai-citations` — the commands below
set that target explicitly:

```bash
# User-level (available in every project)
git clone https://github.com/MakingJamie/claude-skill-ai-citations.git \
  ~/.claude/skills/ai-citation-foundations

# …or project-level (this repo only)
git clone https://github.com/MakingJamie/claude-skill-ai-citations.git \
  /path/to/your/site/.claude/skills/ai-citation-foundations
```

## Use

Open Claude Code **in your website's repository**, then say something like:

- "Make my website AI-friendly"
- "Help AI cite my site"
- "Set up llms.txt and fix my robots.txt for AI"
- "Get my site into ChatGPT and Perplexity"

The skill runs a short, gated workflow: it interviews you, audits your repo, proposes a plan, and waits for your approval before writing any files.

## Example run

A typical session on an Astro blog hosted on Netlify:

> **You:** Help AI cite my site
>
> **Claude:** This is an Astro project, so static files belong in `public/`. Quick context first — AI crawlers split into two jobs: *retrieval* bots (OAI-SearchBot, PerplexityBot, Claude-User) fetch your pages to build cited answers, while *training* bots (GPTBot, ClaudeBot, CCBot) collect content to train models. Which would you like to allow — both, retrieval only, or none?
>
> **You:** Retrieval, but not training.
>
> **Claude:** Auditing…
> **AI Foundations Score: `[██████░░░░] 60%` — Solid start 🧭.** Astro already gives you a sitemap, canonical tags, meta descriptions and schema. What's missing: your `robots.txt` allows everything but names no AI bots, and there's no `llms.txt`. Here's the plan: a named-bot `robots.txt` (retrieval allowed, training disallowed) with `Sitemap:` and `llms-txt:` directives, plus an `llms.txt` built from your 8 best posts. This takes you to ~100%. Approve?
>
> **You:** Go ahead.
>
> **Claude:** Done — wrote `public/robots.txt` and `public/llms.txt` and verified both resolve.
> **Your AI Foundations Score: `60% → 100%` — Fully optimised 🎉.** After you deploy, confirm Netlify isn't overriding `robots.txt`.

**Before** — allows every crawler indiscriminately, with no explicit policy:

```
User-agent: *
Allow: /
```

**After** — an intentional policy: retrieval bots welcomed, training bots opted out, sitemap and llms.txt advertised:

```
Sitemap: https://example.com/sitemap.xml
llms-txt: https://example.com/llms.txt

User-agent: OAI-SearchBot
Allow: /
User-agent: PerplexityBot
Allow: /
User-agent: Claude-User
Allow: /

User-agent: GPTBot
Disallow: /
User-agent: ClaudeBot
Disallow: /

User-agent: *
Allow: /
```

## What it sets up

| Foundation | Why | Status |
|---|---|---|
| `robots.txt` AI-crawler policy | Controls whether AI answer engines can cite you. **The load-bearing piece.** | Proven |
| `sitemap.xml` + `Sitemap:` directive | Discovery and freshness (`lastmod`) | Proven |
| Canonical URLs + meta descriptions | Correct attribution, clean snippets | Proven |
| Schema.org JSON-LD (Organization, Article) | Helps AI extract author/publisher/dates | Useful |
| `llms.txt` | A tidy, low-cost map for agents and pasted-URL use | Low-cost signal (not a citation guarantee) |

## Honest caveats

- `robots.txt` is **advisory** — reputable crawlers honour it, but it isn't enforcement.
- A **CDN/host** (Cloudflare, Vercel, Netlify) can override your `robots.txt`. Verify after deploy.
- `llms.txt` is a cheap, sensible signal, but major crawlers don't auto-fetch it yet and it has **no demonstrated citation lift** on its own.
- The AI-discoverability field moves fast; treat bot tokens and conventions as a snapshot.

## What it does NOT do

This skill builds the open, standard foundations every site should have. It does **not** build an "AI mirror" that serves alternate content to bots, and it is not a general SEO audit tool.

## Requirements

- [Claude Code](https://claude.com/claude-code)
- Your website's source repository
- `bash` (and `curl` for live-URL verification) for the optional verify script

## Structure

```
ai-citation-foundations/         # clone target folder (repo: claude-skill-ai-citations)
├── SKILL.md                  # the gated workflow Claude follows
├── README.md
├── CONTRIBUTING.md
├── LICENSE
├── references/               # bot reference, robots patterns, llms.txt spec, schema, stack detection, scoring
├── assets/                   # robots.txt variants, llms.txt + JSON-LD templates
├── scripts/
│   └── verify-foundations.sh
└── .github/
    └── ISSUE_TEMPLATE/       # "AI bot token update" issue form
```

## License

MIT — see [LICENSE](LICENSE). Free to use, share, and adapt.

## Author

Built by [Jamie Murphy](https://jamie-murphy.com) — questions, feedback, or a hello are welcome via the site.

If you'd like a managed, deeper AI-content layer for your site, that's what AI MirrorSight does.
