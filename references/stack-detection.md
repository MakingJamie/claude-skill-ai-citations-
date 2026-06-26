# Stack detection — where each artifact belongs

Use in **Phase 0**. Detect the generator/framework, then use its row to decide where `robots.txt` and `llms.txt` go, how the sitemap is produced, and where `<head>` tags / JSON-LD are injected. When unsure, prefer the **static-site fallback** (root-level files).

## Detection signals

| Stack | Detect by |
|---|---|
| **Astro** | `astro` in `package.json` deps; `astro.config.*` present |
| **Next.js** | `next` in deps; `next.config.*`; `app/` or `pages/` dir |
| **Nuxt** | `nuxt` in deps; `nuxt.config.*` |
| **SvelteKit** | `@sveltejs/kit` in deps; `svelte.config.*` |
| **Hugo** | `config.toml`/`hugo.toml`/`config.yaml`; `archetypes/`, `content/` |
| **Jekyll** | `_config.yml`; `Gemfile` with `jekyll`; `_posts/` |
| **Gatsby** | `gatsby` in deps; `gatsby-config.*` |
| **Eleventy (11ty)** | `@11ty/eleventy` in deps; `.eleventy.js` |
| **Docusaurus** | `@docusaurus/core` in deps |
| **VitePress** | `vitepress` in deps; `.vitepress/` |
| **WordPress** | `wp-config.php`; `wp-content/` |
| **Plain HTML** | `index.html` at root, no framework config |

## Where artifacts go, per stack

| Stack | Static files (`robots.txt`, `llms.txt`) | Sitemap | `<head>` / JSON-LD injection |
|---|---|---|---|
| **Astro** | `public/` → served at root | `@astrojs/sitemap` integration (auto) | shared layout / `<head>` component (e.g. an SEO component) |
| **Next.js** | `public/` → served at root. (Or generate via `app/robots.ts` & `app/sitemap.ts` / route handlers) | `app/sitemap.ts` or `next-sitemap` package | `app/layout.tsx` `metadata` export, or `<Head>` in `pages/` |
| **Nuxt** | `public/` (Nuxt 3) or `static/` (Nuxt 2) | `@nuxtjs/sitemap` module | `app.vue` / `useHead()` / `nuxt.config` `app.head` |
| **SvelteKit** | `static/` → served at root | `src/routes/sitemap.xml/+server.ts` or a package | `app.html` or `<svelte:head>` in layout |
| **Hugo** | `static/` → served at root | built-in (`sitemap.xml` auto) | `layouts/partials/head.html` |
| **Jekyll** | repo root (or `static`/`assets` as configured) | `jekyll-sitemap` plugin | `_includes/head.html` |
| **Gatsby** | `static/` → served at root | `gatsby-plugin-sitemap`; robots via `gatsby-plugin-robots-txt` | `react-helmet` / Head API |
| **Eleventy** | passthrough-copied dir (often root or `public/`) | a plugin or a templated `sitemap.njk` | base layout `<head>` |
| **Docusaurus** | `static/` → served at root | built-in sitemap plugin | `docusaurus.config` head tags / swizzled head |
| **VitePress** | `public/` → served at root | community plugin or manual | `.vitepress/config` `head` |
| **WordPress** | physical files at web root, **but** SEO plugins (Yoast, Rank Math) often **generate** robots.txt & sitemap dynamically — edit via the plugin, not a static file | Yoast/Rank Math/Google XML Sitemaps plugin | theme `header.php` or the SEO plugin |
| **Plain HTML / unknown** | **repo web root** | hand-written `sitemap.xml` with `lastmod` | per-page `<head>` (provide copy-paste snippet) |

## Key rules

- **`public/` and `static/` map to web root.** A file at `public/robots.txt` is served at `{{SITE_URL}}/robots.txt`. Both `robots.txt` and `llms.txt` must resolve at root, so they go in that directory — never in a nested route.
- **Generated vs static.** If a framework or plugin *generates* `robots.txt`/sitemap (Next route handlers, WordPress SEO plugins, `next-sitemap`), **edit the generator/source or plugin settings**, not the build output — static edits get overwritten on next build.
- **Reuse existing SEO infrastructure.** Most of these stacks already have an SEO plugin/component emitting canonical + meta. Detect it and extend it (add JSON-LD, fix the canonical) rather than introducing a parallel mechanism.
- **Sitemap already handled?** If an integration/plugin is present, don't hand-roll a sitemap — just confirm it includes `lastmod` and add the `Sitemap:` directive to robots.txt.
- **Confirm before assuming.** If detection is ambiguous (monorepo, custom build), ask the user where their built site's public root is, then fall back to the static-site row.
