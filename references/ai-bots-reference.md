# AI crawler reference — who's who, and what allowing or blocking each one does

Use this in **Phase 1** to educate the user before they choose a comfort level. Explain it in plain English first, then show the table if they want detail.

## The one distinction that matters

AI crawlers split into two jobs. Conflating them is the most common and most expensive mistake.

- **Retrieval / answer bots** fetch your pages *at answer time* to build a cited, linked response for a user who just asked a question. If you block these, you disappear from that engine's answers. **This is the citation channel.**
- **Training bots** collect content to train or update a foundation model. Allowing them may (indirectly, unprovably) make a model "know" your brand; blocking them protects your content from training. This is a **values/business decision**, not a citation decision — blocking a training bot does **not** remove you from that company's live cited answers (a different bot does that).

Plain-English version for the user: *"Retrieval bots are how ChatGPT, Perplexity and Claude quote you with a link today. Training bots feed the models' long-term memory. You almost always want the first kind. The second kind is a judgement call about whether your content should help train AI."*

## Reference table

| User-agent token | Operator | Job | Type |
|---|---|---|---|
| `OAI-SearchBot` | OpenAI | Indexes for ChatGPT Search / live cited answers | **Retrieval** |
| `ChatGPT-User` | OpenAI | Fetches a page when a user action requires it | **Retrieval** |
| `GPTBot` | OpenAI | Trains GPT models | Training |
| `Claude-SearchBot` | Anthropic | Indexes for Claude's search / cited answers | **Retrieval** |
| `Claude-User` | Anthropic | Fetches a page for a user's Claude request | **Retrieval** |
| `ClaudeBot` | Anthropic | General crawl / trains Claude models | Training |
| `PerplexityBot` | Perplexity | Indexes for the Perplexity answer engine | **Retrieval** |
| `Perplexity-User` | Perplexity | Fetches a page for a user's Perplexity query | **Retrieval** |
| `Amazonbot` | Amazon | Powers Alexa answers / search | **Retrieval** |
| `YouBot` | You.com | Indexes for You.com answers | **Retrieval** |
| `Googlebot` | Google | Traditional search index (also feeds AI Overviews) | Search/Retrieval |
| `Google-Extended` | Google | Opt-in/out token for Gemini training & AI Overviews grounding | Training |
| `Applebot` | Apple | Powers Siri / Spotlight suggestions | **Retrieval** |
| `Applebot-Extended` | Apple | Opt-out token for Apple Intelligence training | Training |
| `CCBot` | Common Crawl | Public dataset many models train on | Training |
| `Bytespider` | ByteDance | Trains TikTok / Doubao AI | Training |
| `Meta-ExternalAgent` | Meta | Trains Meta AI / Llama | Training |
| `FacebookBot` | Meta | Crawls for Meta products | Training |

Notes:
- **Google is special.** `Googlebot` is your normal search crawler and also the gateway to AI Overviews; you almost never block it. `Google-Extended` is a *separate control token* that only governs Gemini training and AI-Overview grounding — it has no effect on normal search ranking.
- **`Applebot` vs `Applebot-Extended`** work the same way: the base bot powers Siri/search; the `-Extended` token is training-only opt-out.
- Use **current** tokens. `anthropic-ai` and `Claude-Web` are legacy/deprecated — prefer `ClaudeBot`, `Claude-SearchBot`, `Claude-User`. Tokens change; treat this table as a snapshot, not gospel, and check the operator's docs when in doubt.

## What each comfort level means (map the user's answer to a robots template)

- **Welcome all good bots** → allow retrieval *and* training. Maximum exposure. → `assets/robots-welcome-all.txt`
- **Welcome retrieval, not training** → allow the Retrieval rows, disallow the Training rows. Get cited without feeding training. → `assets/robots-retrieval-only.txt`
- **Block all AI** → disallow every AI token (accept losing AI citations) while keeping normal search. → `assets/robots-block-all-ai.txt`

## Honest caveat to state out loud

robots.txt is **advisory**. Reputable operators (OpenAI, Anthropic, Google, Perplexity, Apple) honour it; some scrapers ignore it. It is a stated preference, not an access control. For true blocking, use server/CDN/WAF rules — see `references/robots-patterns.md`.
